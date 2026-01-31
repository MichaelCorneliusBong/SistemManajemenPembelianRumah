package System;
import Database.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/admin-profile")
public class AdminProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");

        try (Connection connect = DBConnection.getConnection()) {

            String sql = "SELECT name, email, phone FROM users WHERE email = ?";
            PreparedStatement state = connect.prepareStatement(sql);
            state.setString(1, email);

            ResultSet set = state.executeQuery();

            if (set.next()) {
                request.setAttribute("name", set.getString("name"));
                request.setAttribute("email", set.getString("email"));
                request.setAttribute("phone", set.getString("phone"));
            }

            RequestDispatcher dispatch = request.getRequestDispatcher("ProfileAdmin.jsp");
            dispatch.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home-admin");
        }
    }
}
