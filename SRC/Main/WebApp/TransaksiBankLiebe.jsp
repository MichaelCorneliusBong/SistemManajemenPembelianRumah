<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%
    String name  = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String photo = (String) session.getAttribute("photo");

    String initial = "U";
    if (name != null && !name.isEmpty()) {
        initial = name.substring(0,1).toUpperCase();
    } else if (email != null && !email.isEmpty()) {
        initial = email.substring(0,1).toUpperCase();
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Transaksi Bank - Astra</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: #F3ECDC;
            overflow: hidden;
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

        .profile-btn {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: white;
            color: #436c44;
            font-weight: 700;
            border: none;
            cursor: pointer;
            overflow: hidden;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .profile-btn img {
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .bg {
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
        }

        .container {
            padding-left: 150px;
            padding-top: 60px;
        }

        .transaksi {
            width: 1200px;
            height: 550px;
            background: rgba(67,108,68,0.95);
            padding: 35px;
            border-radius: 28px;
            color: white;
            display: flex;
            gap: 80px;
            position: relative;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }

        .transaksi img {
            width: 500px;
            height: 300px;
            border-radius: 28px;
            margin-top: 100px;
        }

        h1 { font-size: 30px; }

        .row {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            width: 650px;
        }

        .row p {
            width: 200px;
            font-size: 15px;
        }

        .row input {
            width: 400px;
            padding: 12px;
            border-radius: 8px;
            border: none;
        }

        .row input[type="file"] {
            background: white;
        }

        .status {
            position: absolute;
            bottom: 50px;
            left: 50px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .status input {
            width: 250px;
            height: 45px;
            border-radius: 8px;
            border: none;
            font-weight: bold;
            text-align: center;
        }
        
        button:hover {
            background: #d0d0d0;
        }        
    </style>
</head>

<body>

<div class="header">
    <button class="logo-klik" onclick="home()">
        <img src="Assets/Logo.png" class="logo">
    </button>

    <button class="profile-btn" onclick="profile()">
        <% if (photo != null && !photo.isEmpty()) { %>
            <img src="<%= photo %>">
        <% } else { %>
            <%= initial %>
        <% } %>
    </button>
</div>

<div class="bg">
    <div class="container">
        <div class="transaksi">

            <form action="astra-bank-upload" method="post" enctype="multipart/form-data">
                <h1>Transaksi</h1>

                <div class="row">
                    <p>Nomor VA :</p>
                    <input type="text" value="0858-1667-02388" readonly>
                </div>
                
            <div class="row">
                    <p>Total Pembayaran :</p>
                    <input type="text" value="Rp 1.550.000.000" readonly>
                </div>


                <div class="row">
                    <p>Screenshot Transfer :</p>
                    <input type="file" name="bukti" accept="image/*" required>
                </div>

                <div class="status">
                    <p>Status :</p>
                    <input type="text" value="Waiting..." readonly>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function home(){ window.location.href="home-user"; }
    function profile(){ window.location.href="user-profile"; }
</script>

</body>
</html>
