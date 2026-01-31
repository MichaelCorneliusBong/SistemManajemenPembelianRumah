package System;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Database.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/desain-rumah")
public class DesainRumah extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String,Object>> list = new ArrayList<>();

        try (Connection connect = DBConnection.getConnection()) {
            String sql = "SELECT * FROM desainrumah";
            PreparedStatement state = connect.prepareStatement(sql);
            ResultSet set = state.executeQuery();

            while (set.next()) {
                Map<String,Object> map = new HashMap<>();
                map.put("id", set.getInt("idrumah"));
                map.put("nama", set.getString("nama"));
                map.put("image", set.getString("image"));
                map.put("description", set.getString("description"));
                list.add(map);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("rumahList", list);
        request.getRequestDispatcher("DesainRumah.jsp").forward(request, response);
    }
}