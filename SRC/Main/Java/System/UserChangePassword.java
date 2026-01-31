package System;
import Database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/user-change-password")
public class UserChangePassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.html");
            return;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.html");
            return;
        }

        String email = (String) session.getAttribute("email");
        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            response.sendRedirect("UbahPasswordUser.jsp");
            return;
        }

        try (Connection connect = DBConnection.getConnection()) {
            PreparedStatement check = connect.prepareStatement(
                "SELECT password FROM users WHERE email=?"
            );
            check.setString(1, email);
            ResultSet set = check.executeQuery();

            if (!set.next() || !set.getString("password").equals(oldPass)) {
                response.sendRedirect("UbahPasswordUser.jsp");
                return;
            }
            
            PreparedStatement update = connect.prepareStatement(
                "UPDATE users SET password=? WHERE email=?"
            );
            update.setString(1, newPass);
            update.setString(2, email);
            update.executeUpdate();

            response.sendRedirect("user-profile");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UbahPasswordUser.jsp");
        }
    }
}