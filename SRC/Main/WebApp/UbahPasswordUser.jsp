<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = (String) session.getAttribute("name");
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
    <title>Ubah Password</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to top, rgba(0,0,0,0.75), rgba(0,0,0,0.2));
            min-height: 100vh;
        }

        .header {
            position: fixed;
            top: 0; left: 0; right: 0;
            padding: 15px 40px;
            background: #436c44;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            height: 40px;
            cursor: pointer;
        }

        .header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .desainrumah {
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

        .content {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .text {
            background: #588157;
            color: white;
            padding: 30px 40px;
            border-radius: 10px;
            width: 500px;
        }

        .input-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            margin-bottom: 15px;
        }

        .input-field {
            padding: 10px;
            border-radius: 8px;
            border: none;
        }
    </style>
</head>

<body>

<div class="header">
    <img src="Assets/Logo.png" class="logo" onclick="home()">

    <div class="header-actions">
        <button class="desainrumah" onclick="desainrumah()">Desain Rumah</button>

        <button class="profile-btn" onclick="profile()">
            <% if (photo != null && !photo.isEmpty()) { %>
                <img src="<%= photo %>" style="width:100%;height:100%;object-fit:cover;border-radius: 50%">
            <% } else { %>
                <%= initial %>
            <% } %>
        </button>
    </div>
</div>

<div class="content">
    <div class="text">
        <h2>Ubah Password</h2>

        <form action="user-change-password" method="post">

            <div class="input-row">
                <div>Password Lama</div>
                <input type="password" name="oldPassword" class="input-field" required>
            </div>

            <div class="input-row">
                <div>Password Baru</div>
                <input type="password" name="newPassword" class="input-field" required>
            </div>

            <div class="input-row">
                <div>Konfirmasi Password</div>
                <input type="password" name="confirmPassword" class="input-field" required>
            </div>

            <div style="text-align:center; margin-top:20px;">
                <button type="button" class="desainrumah" onclick="profile()">Kembali</button>
                <button type="submit" class="desainrumah">Ubah Password</button>
            </div>
        </form>
    </div>
</div>

<script>
    function profile() {
        window.location.href = "user-profile";
    }
    function home() {
        window.location.href = "home-user";
    }
    function desainrumah() {
        window.location.href = "desain-rumah";
    }
</script>

</body>
</html>
