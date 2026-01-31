package System;
import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/info-rumah")
public class InfoRumah extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

    if (role == null || !"USER".equals(role)) {
        response.sendRedirect("/login");
        return;
    }

    String id = request.getParameter("id");

    if (id == null || id.isEmpty()) {
        response.sendRedirect("desain-rumah");
        return;
    }

    Map<String, Object> rumah = new HashMap<>();
    Map<String, Object> lingkungan = new HashMap<>();
    Map<String, Map<String, Object>> ruangan = new HashMap<>();

    try (Connection connect = DBConnection.getConnection()) {
        String sql =
            "SELECT d.nama, d.description, " +
            "i.infolingkungan, i.infokamartidur, i.infokamarmandi, i.inforuangtamu, i.infodapur, i.infogarasi, " +
            "g.cover, g.lingkungan, g.kamartidur, g.kamarmandi, " +
            "g.ruangtamu, g.dapur, g.garasi " +
            "FROM desainrumah d " +
            "JOIN inforumah i ON d.idrumah = i.idrumah " +
            "JOIN imageinfo g ON d.idrumah = g.idrumah " +
            "WHERE d.idrumah = ?";

        PreparedStatement state = connect.prepareStatement(sql);
        state.setInt(1, Integer.parseInt(id));

        ResultSet set = state.executeQuery();

        if (!set.next()) {
            response.sendRedirect("desainrumah");
            return;
        }

        rumah.put("nama", set.getString("nama"));
        rumah.put("description", set.getString("description"));
        rumah.put("cover", set.getString("cover"));

        lingkungan.put("text", set.getString("infolingkungan"));
        lingkungan.put("image", set.getString("lingkungan"));

        ruangan.put("infokamartidur", Map.of(
            "text", set.getString("infokamartidur"),
            "image", set.getString("kamartidur")
        ));

        ruangan.put("infokamarmandi", Map.of(
            "text", set.getString("infokamarmandi"),
            "image", set.getString("kamarmandi")
        ));

        ruangan.put("inforuangtamu", Map.of(
            "text", set.getString("inforuangtamu"),
            "image", set.getString("ruangtamu")
        ));

        ruangan.put("infodapur", Map.of(
            "text", set.getString("infodapur"),
            "image", set.getString("dapur")
        ));

        ruangan.put("infogarasi", Map.of(
            "text", set.getString("infogarasi"),
            "image", set.getString("garasi")
        ));

    } catch (Exception e) {
        throw new ServletException(e);
    }

    request.setAttribute("rumah", rumah);
    request.setAttribute("lingkungan", lingkungan);
    request.setAttribute("ruangan", ruangan);

    request.getRequestDispatcher("InfoRumah.jsp").forward(request, response);
}
}