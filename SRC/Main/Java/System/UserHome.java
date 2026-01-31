package System;
import Database.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.sql.*;

@WebServlet("/home-user")
public class UserHome extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("Login.html");
            return;
        }

        String email = (String) session.getAttribute("email");
        String role  = (String) session.getAttribute("role");

        if (email == null || !"USER".equals(role)) {
            response.sendRedirect("Login.html");
            return;
        }

        try (Connection connect = DBConnection.getConnection()) {

            String sql = "SELECT name, profileImage FROM users WHERE email=?";
            PreparedStatement state = connect.prepareStatement(sql);
            state.setString(1, email);

            ResultSet set = state.executeQuery();

            if (set.next()) {
                String name = set.getString("name");
                String profileImage = set.getString("profileImage");
                session.setAttribute("photo", profileImage);
                session.setAttribute("name", name);

                if (profileImage != null && !profileImage.isEmpty()) {
                    request.setAttribute("profileImage", profileImage);
                } else {
                    String initial = name.substring(0, 1).toUpperCase();
                    request.setAttribute("initial", initial);
                }
            }

            request.getRequestDispatcher("/HomeUser.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
