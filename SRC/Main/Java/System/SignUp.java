package System;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Database.DBConnection;
import java.io.IOException;
import java.sql.*;


@WebServlet("/signup")
public class SignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
        String nama = request.getParameter("nama");
        String hp = request.getParameter("hp");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        long convertHP;
        
        try {
            convertHP = Long.parseLong(hp);
        } catch (NumberFormatException e) {
            request.setAttribute("Error", "Nomor HP Harus Berupa Angka !");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirm)) {
            request.setAttribute("Error", "Password Dan Konfirmasi Password Tidak Sama !");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT id FROM users WHERE email=?";
            PreparedStatement state = conn.prepareStatement(checkSql);
            state.setString(1, email);
            ResultSet set = state.executeQuery();

            if (set.next()) {
                request.setAttribute("Error", "Email Sudah Terdaftar !");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }
            
            String encryptedPassword = EncryptionFunction.encrypt(password);
            String sql = "INSERT INTO users(name, phone, email, password, role) VALUES (?, ?, ?, ?, 'USER')";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, nama);
            statement.setLong(2, convertHP);
            statement.setString(3, email);
            statement.setString(4, encryptedPassword);
            statement.executeUpdate();

            response.sendRedirect("Login.jsp");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

