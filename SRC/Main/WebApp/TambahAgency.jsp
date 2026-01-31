<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String photo = (String) session.getAttribute("photo");

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
    <title>Tambah Agency</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            min-height: 100vh;
            overflow: hidden;
            background: 
                linear-gradient(
                    to top,
                    rgba(67, 108, 68, 0.75),
                    rgba(67, 108, 68, 0.4),
                    rgba(0, 0, 0, 0)
                ),
                url('Assets/SignPage.png')
                no-repeat center center / cover;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            padding: 15px 30px;
            background: #436c44;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            z-index: 10;
        }
        
        .header-actions {
            display: flex;
            gap: 12px;
        }
        
        .logo {
            height: 40px;
        }

        .logo-klik {
            background-color: transparent;
            cursor: pointer;
            border: none;
            outline: none;
        }

        .container {
            min-height: 100vh;
            display: flex;
            align-items: flex-start;
            padding-top: 150px;
            padding-left: 200px;
        }

        .card {
            width: 520px;
            background: rgba(67, 108, 68, 0.95);
            padding: 35px;
            border-radius: 28px;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }

        .card h2 {
            text-align: left;
            margin-bottom: 30px;
            font-size: 30px;
        }

        label {
            display: block;
            margin-top: 18px;
            font-size: 15px;
            font-weight: 600;
        }

        input[type="text"], input[type="password"] {
            width: 95%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 8px;
            border: none;
            font-size: 14px;
        }

        .password-wrapper {
            position: relative;
            width: 100%;
            margin-top: 8px;
        }
        
        .profile-btn {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: white;
            border: none;
            cursor: pointer;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-initial {
            font-weight: 700;
            font-size: 18px;
            color: #436c44;
        }
        
        .desainrumah {
            padding: 10px 18px;
            background: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
}


        .password-input {
            width: 100%;
            padding-right: 40px;
            box-sizing: border-box;
            -webkit-text-security: disc;
        }

        input.toggle-pwd-checkbox {
            display: none;
        }

        input.toggle-pwd-checkbox:checked ~ .password-input {
            -webkit-text-security: none;
        }

        .eye-icon {
            position: absolute;
            right: 8%;
            top: 25%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 2;
            background: none;
            border: none;
            display: flex;
            align-items: center;
        }

        .eye-icon img {
            width: 24px;
            height: 24px;
            object-fit: contain;
        }

        .img-open {
            display: none;
        }

        .img-closed {
            display: block;
        }

        input.toggle-pwd-checkbox:checked ~ .eye-icon .img-closed {
            display: none;
        }

        input.toggle-pwd-checkbox:checked ~ .eye-icon .img-open {
            display: block;
        }

        button.login-btn {
            margin-top: 20px;
            width: 20%;
            padding: 12px;
            background: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .login{
            color:#6ba4ff;
            background-color: transparent;
            cursor: pointer;
            border: none;
            outline: none;    
            font-size: 15px;
            font-weight: 600;                
        }

        .error {
            color: #d32f2f;
            background: #fdecea; 
            border: 1px solid #f5c2c7;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 14px;
            margin-top: 12px;
            text-align: center;
        }

        button:hover {
            background: #d0d0d0;
        }
    </style>
</head>

<body>

<div class="header">
        <button class="logo-klik">
            <a href="#home"><img src="Assets/Logo.png" class="logo" onclick="home()"></a>
        </button>
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

<div class="container">
    <div class="card">
        <h2>Tambah Akun Agency</h2>

        <form action="signup" method="post">
            <label>Nama</label>
            <input type="text" name="nama" placeholder="Masukkan Nama" required>            
            <label>Nomor HP</label>
            <input type="text" name="hp" placeholder="Masukkan Nomor Handphone" required>
            <label>Email</label>
            <input type="text" name="email" placeholder="Masukkan Email" required>

            <label>Password</label>
            <div class="password-wrapper">
                <input type="checkbox" id="toggle-pwd" class="toggle-pwd-checkbox">
                <label for="toggle-pwd" class="eye-icon">
                    <img src="Assets/ShowPassword.png" class="img-open" alt="Hide Password">
                    <img src="Assets/HidePassword.png" class="img-closed" alt="Show Password">
                </label>
                <input type="text" name="password" class="password-input" placeholder="Masukkan Password" required>
            </div>

            <label>Konfirmasi Password</label>

            <div class="password-wrapper">
                <input type="checkbox" id="toggle-confirm" class="toggle-pwd-checkbox">
                <label for="toggle-confirm" class="eye-icon">
                    <img src="Assets/ShowPassword.png" class="img-open" alt="Hide Password">
                    <img src="Assets/HidePassword.png" class="img-closed" alt="Show Password">
                </label>
                <input type="text" name="confirmPassword" class="password-input" placeholder="Masukkan Ulang Password" required>
            </div>

            <button type="submit" class="login-btn">Daftar</button>
        </form>
        
        <% String error = (String) request.getAttribute("Error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

    </div>
</div>

<script>
    function home() {
        window.location.href = "home-admin";
    }

    function login() {
        window.location.href = "Login.jsp";
    }
    function desainrumah() {
        window.location.href = "desain-rumah-admin";
    }
</script>

</body>
</html>
