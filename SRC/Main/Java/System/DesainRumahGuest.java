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

@WebServlet("/desain-rumah-guest")
public class DesainRumahGuest extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        req.setAttribute("rumahList", list);
        req.getRequestDispatcher("DesainRumahGuest.jsp").forward(req, resp);
    }
}
