<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("email") == null) {
        response.sendRedirect("Login.html");
        return;
    }

    String email = (String) sess.getAttribute("email");
    String photo = (String) sess.getAttribute("photo");
    String initial = email.substring(0,1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Transaksi Agency</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: linear-gradient(to top, rgba(0,0,0,0.75), rgba(0,0,0,0.2));
        }
        .header {
            position: fixed;
            top: 0; left: 0; right: 0;
            padding: 15px 40px;
            background: #436c44;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
        }
        .logo { height: 40px; }

        .logo-klik { background:none;border:none;cursor:pointer; }

        .header-actions { display: flex; gap: 12px; }

        .desainrumah {
            padding: 10px 18px;
            background: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }

        .profile-btn {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: white;
            color: #436c44;
            font-weight: 700;
            border: none;
            cursor: pointer;
            display:flex;
            align-items:center;
            justify-content:center;
            overflow:hidden;
        }
        
        button:hover {
            background: #d0d0d0;
        }
        
        .content {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .text {
            background: #588157;
            color: white;
            padding: 25px 40px;
            border-radius: 10px;
            width: 900px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background: white;
            color: #333;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 14px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }

        th {
            background: #436c44;
            color: white;
        }

        tr:last-child td { border-bottom: none; }
    </style>
</head>

<body>

<div class="header">
    <button class="logo-klik" onclick="home()">
        <img src="Assets/Logo.png" class="logo">
    </button>

    <div class="header-actions">
        <button class="desainrumah" onclick="desainrumah()">Desain Rumah</button>

        <button class="profile-btn" onclick="profile()">
            <% if (photo != null && !photo.isEmpty()) { %>
                <img src="<%= photo %>" style="width:100%;height:100%;object-fit:cover;border-radius:50%">
            <% } else { %>
                <%= initial %>
            <% } %>
        </button>
    </div>
</div>

<div class="content">
    <div class="text">
        <h2>Riwayat Transaksi</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Klien</th>
                    <th>Tipe Rumah</th>
                    <th>Tipe Pembayaran</th>
                    <th>Cicilan</th>
                    <th>Cicilan Per Bulan</th>
                    <th>Status</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Map<String,Object>> transaksi =
                        (List<Map<String,Object>>) request.getAttribute("transactions");

                if (transaksi != null && !transaksi.isEmpty()) {
                    for (Map<String,Object> t : transaksi) {
            %>
                <tr>
                <td><%= t.get("id") %></td>
                <td><%= t.get("email") %></td>
                <td><%= t.get("house") %></td>
                <td><%= t.get("payment") %></td>
                <td><%= t.get("installment") %></td>
                <td><%= "Rp" + t.get("installmentpermonth") %></td>
                <td><%= t.get("status") %></td>
                <td>
                <% if (!"Completed".equals(t.get("status"))) { %>
                    <form action="agency-complete" method="post">
                        <input type="hidden" name="id" value="<%= t.get("id") %>">
                        <button type="submit" class="desainrumah">Konfirmasi</button>
                    </form>
                <% } else { %>
                    Selesai
                <% } %>
                </td>

            </tr>

            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5"></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function profile() { window.location.href = "agency-profile"; }

    function home() { window.location.href = "home-agency"; }

    function desainrumah() { window.location.href = "desain-rumah-agency"; }

    function transaksi() { window.location.href = "agency-transactions"; }
</script>

</body>
</html>