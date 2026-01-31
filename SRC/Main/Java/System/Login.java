package System;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Database.DBConnection;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login") 
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

        try (Connection connect = DBConnection.getConnection()) {

            String sql = "SELECT password, role FROM users WHERE email=?";
            PreparedStatement state = connect.prepareStatement(sql);
            state.setString(1, email);

            ResultSet set = state.executeQuery();

            if (set.next()) {
                String role = set.getString("role");
                String encryptedPassword = set.getString("password");
                String decryptedPassword = EncryptionFunction.decrypt(encryptedPassword);

                if (password.equals(decryptedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("role", role);

                    if ("ADMIN".equalsIgnoreCase(role)) {
                        response.sendRedirect(request.getContextPath() + "/home-admin");
                    } else if ("AGENCY".equalsIgnoreCase(role)){
                        response.sendRedirect(request.getContextPath() + "/home-agency");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home-user");
                    }
                    return;
                }
            }

            request.setAttribute("Error", "Email Atau Password Yang Dimasukkan Salah!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);

        } 

        catch (Exception e) {
            throw new ServletException(e);
            }
    }
}
