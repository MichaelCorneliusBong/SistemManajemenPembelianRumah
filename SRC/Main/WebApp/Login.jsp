<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

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
            margin-top: 0;
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

        input {
            width: 95%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 8px;
            border: none;
            font-size: 14px;
        }
        
        .password-wrapper {
            position: relative;
            width: 95%;
            margin-top: 8px;
        }

        .password-input {
            width: 100%;
            padding-right: 40px;
            box-sizing: border-box;
            -webkit-text-security: disc;
        }

        #toggle-pwd {
            display: none;
        }

        #toggle-pwd:checked ~ .password-input {
            -webkit-text-security: none;
        }

        .eye-icon {
            position: absolute;
            right: 15px;
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
        
        #toggle-pwd:checked ~ .eye-icon .img-closed {
            display: none;
        }
        #toggle-pwd:checked ~ .eye-icon .img-open {
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
        
        button.loginUA-btn {
            margin-top: 20px;
            width: 20%;
            padding: 12px;
            background: #B5A88C;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .daftar{
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
    <button class="logo-klik" onclick="home()">
    <img src="Assets/Logo.png" alt="Perumahan Canary" class="logo">
    </button>
</div>

<div class="container">
    <div class="card">
        <h2>Sign In</h2>

        <form action="login" method="post">

            <label>Email</label>
            <input type="text" name="email" placeholder="Masukkan Email" required>

            <label>Password</label>
            
            <div class="password-wrapper">
            <input type="checkbox" id="toggle-pwd">

            <label for="toggle-pwd" class="eye-icon">
                <img src="Assets/ShowPassword.png" class="img-open" alt="Hide Password">

                <img src="Assets/HidePassword.png" class="img-closed" alt="Show Password">
            </label>

            <input type="text" name="password" class="password-input" placeholder="Masukkan Password" required>
            </div>

            <label>Belum Mempunyai Akun ?
                <button type="button" class="daftar" onclick="daftar()">Daftar</button>
            </label>

            <button type="submit" class="login-btn">Masuk</button>

        </form>
        
        <% String error = (String) request.getAttribute("Error"); %>

        <% if (error != null) { %>
            <div class="error">
                <%= error %>
            </div>
        <% } %>

    </div>
</div>

<script>
    function home() {
        window.location.href = "Home.jsp";
    }

    function daftar() {
        window.location.href = "SignUp.jsp";
    }    
</script>

</body>
</html>
