package System;
import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/create-transaction")
public class BuatTransaksi extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String house = request.getParameter("house");
        String payment = request.getParameter("payment");
        String installmentStr = request.getParameter("installment");
        Integer installment = null;
        Long monthlyInstallment = null;
        Integer idRumah = null;
        
        try (Connection connect = DBConnection.getConnection()) {

        String price = "SELECT harga, idrumah FROM desainrumah WHERE nama=?";
        PreparedStatement statePrice = connect.prepareStatement(price);
        statePrice.setString(1, house);

        ResultSet set = statePrice.executeQuery();

        if (!set.next()) {
            response.sendRedirect("PreviewTransaksi.jsp");
            return;
        }

        long hargaRumah = set.getLong("harga");
        idRumah = set.getInt("idrumah");

        if ("BANK".equals(payment)) {
            installment = Integer.parseInt(installmentStr);
            monthlyInstallment = hargaRumah / installment; 
        }
        
        String getUserIdSql = "SELECT id FROM users WHERE email = ?";
        PreparedStatement stateUser = connect.prepareStatement(getUserIdSql);
        stateUser.setString(1, email);

        ResultSet rsUser = stateUser.executeQuery();

        if (!rsUser.next()) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = rsUser.getInt("id");

        String insertSql = "INSERT INTO transactions " + "(userid, email, house, payment, installment, installmentPerMonth, status, updatedtime, transactionsid, idrumah) " + "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)";

        PreparedStatement state = connect.prepareStatement(insertSql);
        
        state.setInt(1, userId);
        state.setString(2, email);
        state.setString(3, house);
        state.setString(4, payment);

        if (installment == null) {
            state.setNull(5, Types.INTEGER);
            state.setNull(6, Types.BIGINT);
        } else {
            state.setInt(5, installment);
            state.setLong(6, monthlyInstallment);
        }

        int min = 10000;
        int max = 99999;

        int randomNumber = (int) (Math.random() * (max - min + 1)) + min;

        state.setString(7, "WAITING");
        state.setInt(8, randomNumber);
        state.setInt(9,idRumah );
        state.executeUpdate();
        
        String uniqueMonthlySQL = "UPDATE transactions SET installmentPerMonth = floor(installmentPerMonth)::numeric + (random() * 0.5)::numeric WHERE transactionsid = ?";
        
        PreparedStatement stateUnique = connect.prepareStatement(uniqueMonthlySQL);
        stateUnique.setInt(1, randomNumber);
        stateUnique.executeUpdate();

    } catch (Exception e) {
        throw new ServletException(e);
    }

    if ("CASH".equals(payment)) {

    if (idRumah == 1) {
        response.sendRedirect("TransaksiCash.jsp");
    } else if (idRumah == 2) {
        response.sendRedirect("TransaksiCashLiebe.jsp");
    } else {
        response.sendRedirect("TransaksiCash.jsp"); 
    }

} else if ("BANK".equals(payment)) {

    if (idRumah == 1) {
        response.sendRedirect("TransaksiBank.jsp");
    } else if (idRumah == 2) {
        response.sendRedirect("TransaksiBankLiebe.jsp");
    } else {
        response.sendRedirect("TransaksiBank.jsp");
    }
}
}
}