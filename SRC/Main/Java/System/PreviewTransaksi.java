package System;
import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/preview-transaksi")
public class PreviewTransaksi extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        String id = req.getParameter("id");

        if (id == null || id.isEmpty()) {
            resp.sendRedirect("desain-rumah");
            return;
        }

        Map<String, String> rumah = new HashMap<>();

        try (Connection connect = DBConnection.getConnection()) {
            String sql = "SELECT idrumah, nama, image, harga " + "FROM desainrumah " + "WHERE idrumah = ?";

            PreparedStatement state = connect.prepareStatement(sql);
            state.setInt(1, Integer.parseInt(id));
            ResultSet set = state.executeQuery();

            if (!set.next()) {
                resp.sendRedirect("desain-rumah");
                return;
            }
            
            rumah.put("id", set.getString("idrumah"));
            rumah.put("nama", set.getString("nama"));
            rumah.put("image", set.getString("image"));
            rumah.put("harga", set.getString("harga"));

        } catch (Exception e) {
            throw new ServletException(e);
        }

        req.setAttribute("rumah", rumah);
        req.getRequestDispatcher("PreviewTransaksi.jsp").forward(req, resp);
    }
}
    