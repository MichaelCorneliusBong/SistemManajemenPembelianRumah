package System;
import java.io.IOException;
import Database.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.sql.*;

@WebServlet("/agency-complete")
public class AgencyTransactionsComplete extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse response)throws ServletException, IOException {
        String idParam = req.getParameter("id");
        int id = Integer.parseInt(idParam);

        try (Connection connect = DBConnection.getConnection()) {

            String sql = """
                UPDATE transactions SET status = 'Completed', updatedtime = CURRENT_TIMESTAMP WHERE transactionsid = ?""";

            PreparedStatement state = connect.prepareStatement(sql);
            state.setInt(1, id);
            state.executeUpdate();

        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect("agency-transactions");
    }
}