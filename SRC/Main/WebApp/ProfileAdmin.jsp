<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("email") == null) {
        response.sendRedirect("Login.html");
        return;
    }

    String name  = (String) sess.getAttribute("name");
    String email = (String) sess.getAttribute("email");
    String photo = (String) sess.getAttribute("photo");

    String initial = "A";
    if (name != null && !name.isEmpty()) {
        initial = name.substring(0,1).toUpperCase();
    } else if (email != null && !email.isEmpty()) {
        initial = email.substring(0,1).toUpperCase();
    }
%>

<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Halaman Utama</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background:
                linear-gradient(
                    to top,
                    rgba(0, 0, 0, 0.75),
                    rgba(0, 0, 0, 0.2)
                );
        }

        .header {
            position: fixed;
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

        .header-actions {
            display: flex;
            gap: 12px;
        }

        button {
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }

        .sign-in, .desainrumah {
            padding: 10px 18px;
            background: white;
            border: none;
            border-radius: 8px;
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .content {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #F3ECDC;
            padding: 0 20px;
            background:
                linear-gradient(
                    to top,
                    rgba(67, 108, 68, 0.75),
                    rgba(67, 108, 68, 0.4),
                    rgba(0, 0, 0, 0)
                );
        }

        .text {
            padding: 20px 48px;
            background: #588157;
            border-radius: 10px;
            color: white;
            max-width: 800px;
            margin: 0 auto;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: left;
        }

        .input-row {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            gap: 15px;
        }

        .input-label {
            min-width: 120px;
            font-size: 18px;
        }

        .inp {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
    </style>
</head>

<body>

<div class="header">
    <button class="logo-klik" onclick="home()">
        <img src="Assets/Logo.png" alt="Logo" class="logo">
    </button>

    <div class="header-actions">
        <button class="desainrumah" onclick="tambahagency()">Tambahkan Akun Agency</button>
        <button class="desainrumah" onclick="desainrumah()">Desain Rumah</button>
        <button class="profile-btn" onclick="profile()">
        <% if (photo != null && !photo.isEmpty()) { %>
            <img src="<%= photo %>"
                style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
        <% } else { %>
            <%= initial %>
        <% } %>
        </button>
    </div>
</div>

<div class="content">
    <div class="text">
        <h2>Profile</h2>

        <div class="input-row">
            <div class="input-label">Nama :</div>
            <div><%= request.getAttribute("name") %></div>
        </div>

        <div class="input-row">
            <div class="input-label">Email :</div>
            <div><%= request.getAttribute("email") %></div>
        </div>

        <div class="input-row">
            <div class="input-label">No Telepon :</div>
            <div><%="0" + request.getAttribute("phone") %></div>
        </div>

        <div class="inp">
            <button class="desainrumah" onclick="signout()">Sign Out</button>
            <button class="desainrumah" onclick="ubahpw()">Ubah Password</button>
            <button class="desainrumah" onclick="ubahfp()">Ubah Foto Profile</button>
        </div>
    </div>
</div>

<script>
    function signout() {
        window.location.href = "Home.jsp";
    }
    function ubahpw() {
        window.location.href = "UbahPasswordAdmin.jsp";
    }
    function ubahfp() {
        window.location.href = "UbahFotoProfileAdmin.jsp";
    }
    function home() {
        window.location.href = "home-admin";
    }
    function desainrumah() {
        window.location.href = "desain-rumah-admin";
    }
    function tambahagency() {
        window.location.href = "TambahAgency.jsp";
    }
</script>

</body>
</html>