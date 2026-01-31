package System;
import java.io.IOException;
import Database.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

@WebServlet("/user-transactions")
public class UserTransactions extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp)throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            resp.sendRedirect("/login");
            return;
        }

        String email = (String) session.getAttribute("email");
        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection connect = DBConnection.getConnection()) {

            String sql = """
            SELECT * FROM transactions WHERE email = ? ORDER BY updatedtime DESC """;

            PreparedStatement state = connect.prepareStatement(sql);
            state.setString(1, email);

            ResultSet set = state.executeQuery();

            while (set.next()) {
                Map<String, Object> array = new HashMap<>();
                array.put("id", set.getInt("transactionsid"));
                array.put("email", set.getString("email"));
                array.put("house", set.getString("house"));
                array.put("payment", set.getString("payment"));
                array.put("installment", set.getInt("installment"));
                BigDecimal installmentPerMonth = set.getBigDecimal("installmentpermonth");
                String paymentType = set.getString("payment");
                
                if ("Cash".equalsIgnoreCase(paymentType)) {
                    installmentPerMonth = new BigDecimal(set.getInt("installment"));
                    }

                array.put("installmentpermonth", installmentPerMonth);
                array.put("status", set.getString("status"));
                array.put("updated", set.getTimestamp("updatedtime"));
                list.add(array);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("transactions", list);
        request.getRequestDispatcher("TransaksiUser.jsp").forward(request, resp);
    }
}

