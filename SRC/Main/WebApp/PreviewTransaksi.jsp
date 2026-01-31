<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
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
    <title>Preview Transaksi</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            width: 100%;
            min-height: 300px;
            overflow: hidden;
            background: #F3ECDC;
        }

        .header {
            position: fixed;
            height: 50px;
            top: 0;
            left: 0;
            right: 0;
            padding: 15px 40px;
            background: #436c44;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
        }

        .logo {
            height: 40px;
        }

        .logo-klik {
            background: none;
            border: none;
            cursor: pointer;
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
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-btn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .bg {
            width: 100%;
            height: 100vh;
            background: #F3ECDC;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            align-items: center;
            justify-content: left;
        } 

        .container {
            width: 700px;
            padding-left: 100px;
            padding-top: 100px;
            z-index: 2;
        }

        .transaksi {
            width: 1200px;
            height: 500px;
            background: rgba(67, 108, 68, 0.95);
            padding: 40px;
            border-radius: 28px;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            display: flex;
            gap: 80px;
            position: relative;
        }

        .transaksi img {
            width: 500px;
            height: 300px;
            border-radius: 28px;
            margin-top: 90px;
        }

        .transaksi h1 {
            font-size: 30px;
            margin-bottom: 25px;
        }

        .row {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 18px;
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

        .row button {
            width: 80px;
            padding: 12px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }

        .bayar {
            width: 150px;
            padding: 12px;
            border-radius: 8px;
            border: none;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            bottom: 50px;
            right: 50px;
        }

        .gambaran {
            position: absolute;
            top: 80px;
            right: 390px;
            font-size: 15px;
        }

        button {
            padding: 12px 20px;
            border-radius: 10px;
            border: none;
            margin: 6px;
            cursor: pointer;
            font-weight: 600;
            background: #e0e0e0;
            transition: 0.2s;
        }

        button:hover {
            background: #d0d0d0;
        }

        .active {
            background: #556357;
            color: white;
        }

        #bayarBtn {
            margin-top: 20px;
            padding: 15px 40px;
            font-size: 18px;
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

<%
    Map<String, String> r =
        (Map<String, String>) request.getAttribute("rumah");

    if (r == null) {
        response.sendRedirect("desainrumah");
        return;
    }
%>     
    
<div class="bg">
    <div class="container">
        <form class="transaksi" method="post" action="create-transaction">

            <div>
                <h1>Preview Transaksi</h1>
                
                <input type="hidden" name="payment" id="paymentInput">
                <input type="hidden" name="installment" id="installmentInput">
                <input type="hidden" name="house" value="<%= r.get("nama") %>">
                <input type="hidden" name="email" value="<%= email %>">                

                <div class="row">
                    <p>ID Rumah :</p>
                    <input type="text" value="<%= r.get("nama") %>" readonly>
                </div>

                <div class="row">
                    <p>Estimasi Harga :</p>
                    <input type="text" value="Rp <%= r.get("harga") %>" readonly>
                </div>

                <div class="row">
                    <p>Metode Pembayaran :</p>
                    
                    <div class="payment">
                        <button type="button" id="cashBtn" onclick="pilihCash()">Cash</button>
                        <button type="button" id="bankBtn" onclick="pilihBank()">Bank</button>
                    </div>                   
                </div>
                
                <div class="container2">
                    <div id="tenor" style="display:none">
                        <button type="button" onclick="pilihInstallment(this, 6)">6 Bulan</button>
                        <button type="button" onclick="pilihInstallment(this, 12)">1 Tahun</button>
                        <button type="button" onclick="pilihInstallment(this, 24)">2 Tahun</button>
                        <button type="button" onclick="pilihInstallment(this, 48)">4 Tahun</button>
                        <button type="button" onclick="pilihInstallment(this, 96)">8 Tahun</button>
                        <button type="button" onclick="pilihInstallment(this, 144)">12 Tahun</button>
                                               
                    </div>                     
                </div>
                
                <button class="bayar" id="bayarBtn" type="submit" disabled>Bayar</button>

                <div class="gambaran">Gambaran Rumah :</div>
            </div>
            
            <img src="<%= r.get("image") %>">    
        </form>
    </div>
</div>

<script>
    function home() {
        window.location.href = "home-user";
    }

    function profile() {
        window.location.href = "user-profile";
    }
    
    let metode = null;
    let tenor = null;

    function clearActive(selector) {
        document.querySelectorAll(selector).forEach(b => {
            b.classList.remove("active");
        });
    }

    function pilihCash() {
        metode = "CASH";
        tenor = null;

        document.getElementById("paymentInput").value = "CASH";
        document.getElementById("installmentInput").value = "";

        clearActive(".payment button");
        clearActive("#tenor button");

        document.getElementById("cashBtn").classList.add("active");
        document.getElementById("tenor").style.display = "none";

        document.getElementById("bayarBtn").disabled = false;
    }

    function pilihBank() {
        metode = "BANK";
        tenor = null;

        document.getElementById("paymentInput").value = "BANK";
        document.getElementById("installmentInput").value = "";

        clearActive(".payment button");
        clearActive("#tenor button");

        document.getElementById("bankBtn").classList.add("active");
        document.getElementById("tenor").style.display = "block";

        document.getElementById("bayarBtn").disabled = true;
    }

    function pilihInstallment(btn, bulan) {
        tenor = bulan; 

        document.getElementById("installmentInput").value = tenor;

        clearActive("#tenor button");
        btn.classList.add("active");

        document.getElementById("bayarBtn").disabled = false;
    }

</script>
</body>
</html>