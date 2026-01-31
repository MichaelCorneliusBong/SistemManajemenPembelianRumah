<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Ubah Foto Profile</title>

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
            width: 600px;
        }

        .input-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            gap: 15px;
        }

        .preview-img {
            width: 250px;
            height: 250px;
            object-fit: cover;
            border: 2px solid #333;
            display: none;
        }
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
                <img src="<%= photo %>" style="width:100%;height:100%;object-fit:cover;border-radius: 50%">
            <% } else { %>
                <%= initial %>
            <% } %>
        </button>
    </div>
</div>

<div class="content">
    <div class="text">
        <h2>Ubah Foto Profile</h2>

        <form action="agency-change-profile"
              method="post"
              enctype="multipart/form-data">

            <div class="input-row">
                <div>Upload Foto :</div>
                <input type="file"
                       name="photo"
                       accept="image/*"
                       onchange="preview(event)"
                       required>
            </div>

            <div class="input-row">
                <div>Preview :</div>
                <img id="preview" class="preview-img">
            </div>

            <div style="text-align:center; margin-top:20px;">
                <button type="button" class="desainrumah" onclick="profile()">Kembali</button>
                <button type="submit" class="desainrumah">Ubah Foto Profile</button>
            </div>
        </form>
    </div>
</div>

<script>
    function preview(e) {
        const img = document.getElementById("preview");
        img.src = URL.createObjectURL(e.target.files[0]);
        img.style.display = "block";
    }
    function profile() { window.location.href = "user-profile"; }

    function home() { window.location.href = "home-user"; }

    function desainrumah() { window.location.href = "desain-rumah"; }
    
</script>

</body>
</html>
