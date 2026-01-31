<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    String name  = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String photo = (String) session.getAttribute("photo");

    String initial = "A";
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
    <title>Desain Rumah</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background: #F3ECDC;
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
            z-index: 100;
        }

        .logo {
            height: 40px;
        }

        .logo-klik {
            background: none;
            border: none;
            cursor: pointer;
        }

        .search {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .search input {
            padding: 10px 15px;
            width: 300px;
            border-radius: 8px;
            border: none;
            outline: none;
        }

        .search img {
            height: 26px;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 14px;
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
        }

        .profile-btn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .bg {
            margin-top: 70px;
            height: 500px;
            background-image: url('Assets/HomePage.png');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: center;
        }

        .layertrans {
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,0.5);
        }

        .judul {
            max-width: 700px;
            padding-left: 100px;
            z-index: 2;
            color: white;
        }

        .judul h1 {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .judul p {
            font-size: 18px;
            text-align: justify;
        }

        .container {
            display: flex;
            justify-content: center;
            padding: 50px 100px;
        }

        .rumah {
            width: 1300px;
            background: rgba(67,108,68,0.95);
            padding: 40px;
            border-radius: 28px;
            color: white;
            display: flex;
            gap: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            cursor: pointer;
        }

        .rumah img {
            width: 500px;
            height: 300px;
            border-radius: 28px;
            object-fit: cover;
        }

        .desc h1 {
            font-size: 34px;
        }

        .desc p {
            font-size: 15px;
            text-align: justify;
        }

        .footer {
            width: 100%;
            padding: 15px 20px;
            background: #344E41;
            text-align: center;
        }
        
        .footer p {
            font-size: 15px;
            color: white;
        }
        
        .footer h1 {
            font-size: 15px;
            color: #588157;
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

    <div class="search">
        <img src="Assets/Search.png">
        <input type="text" id="searchInput" placeholder="Cari Desain Rumah..." onkeyup="searchRumah()">
    </div>

    <div class="header-actions">
        <button class="profile-btn" onclick="profile()">
            <% if (photo != null && !photo.isEmpty()) { %>
                <img src="<%= photo %>">
            <% } else { %>
                <%= initial %>
            <% } %>
        </button>
    </div>
</div>

<div class="bg">
    <div class="layertrans"></div>
    <div class="judul">
        <h1>Desain Rumah</h1>
        <p>
            Setiap rumah bukan sekadar bangunan, melainkan ruang hidup yang dirancang
            untuk masa depan. Di sini, desain modern berpadu dengan fungsi terbaik.
        </p>
    </div>
</div>
 
<%
    List<Map<String, Object>> rumahList =
        (List<Map<String, Object>>) request.getAttribute("rumahList");
%>        
<%
if (rumahList != null && !rumahList.isEmpty()) {
    for (Map<String, Object> r : rumahList) {
%>

<div class="container rumah-card">
    <div class="rumah"
         "window.location.href='info-rumah-agency?id=<%= r.get("id") %>'">

        <img src="<%= r.get("image") %>" alt="Desain Rumah">

        <div class="desc">
            <h1><%= r.get("nama") %></h1>
            <p><%= r.get("description") %></p>
        </div>
    </div>
</div>

<%
    }
} else {
%>

<div style="text-align:center; padding:50px;">
    <h2>Tidak ada desain rumah</h2>
</div>

<%
}
%>

<div class="main">
        <div class="footer">
            <p>
            © 2025 - Company, Inc. All Rights Reserved. Address.
            </p>
            <h1>
            Copyright | Terms & Service |  Contributor
            </h1>
        </div>
</div>

<script>
    function home() {
        window.location.href = "home-admin";
    }

    function profile() {
        window.location.href = "admin-profile";
    }

    function searchRumah() {
        let input = document.getElementById("searchInput").value.toLowerCase();
        let cards = document.getElementsByClassName("rumah-card");

        for (let i = 0; i < cards.length; i++) {
            let title = cards[i].innerText.toLowerCase();
            cards[i].style.display = title.includes(input) ? "flex" : "none";
        }
    }
</script>

</body>
</html>