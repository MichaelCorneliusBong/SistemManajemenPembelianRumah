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

<%
    Map<String, Object> rumah =
        (Map<String, Object>) request.getAttribute("rumah");

    Map<String, Object> lingkungan =
        (Map<String, Object>) request.getAttribute("lingkungan");

    Map<String, Map<String, Object>> ruangan =
        (Map<String, Map<String, Object>>) request.getAttribute("ruangan");

    if (rumah == null) {
        response.sendRedirect("desainrumah");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title><%= rumah.get("nama") %></title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            width: 100%;
            min-height: 300px;
            background: #F3ECDC;
            overflow-x: hidden;
        }

        .bg {
            width: 100%;
            height: 100vh;
            background-image: url('<%= rumah.get("cover") %>');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
        }

        .layertrans {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .judul {
            max-width: 700px;
            padding-left: 100px;
            z-index: 2;
            color: white;
        }

        .judul h1 {
            font-size: 50px;
            font-weight: bold;
        }

        .judul p {
            font-size: 20px;
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
        
        .header-actions {
            display: flex;
            gap: 12px;
        }

        .logo {
            height: 40px;
        }

        .logo-klik {
            background: none;
            border: none;
            cursor: pointer;
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
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-btn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .container {
            min-height: 10vh;
            background: #F3ECDC;
            display: flex;
            justify-content: center;
            padding: 50px 100px;
        }

        .rumah {
            width: 1300px;
            height: 1000px;
            background: rgba(67, 108, 68, 0.95);
            padding: 40px;
            border-radius: 28px;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }

        .rumah img {
            width: 900px;
            height: 500px;
            border-radius: 28px;
        }

        .desc h1 {
            font-size: 34px;
            font-weight: 700;
        }

        .desc p {
            font-size: 15px;
            margin-top: 30px;
        }

        .sidescroll {
            min-height: 10vh;
            background: #F3ECDC;
            display: flex;
            padding: 50px 100px;
            overflow-x: auto;
            gap: 50px;
        }

        .interior {
            min-width: 420px;
            height: 500px;
            background: rgba(67, 108, 68, 0.95);
            padding: 40px;
            border-radius: 28px;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }

        .interior img {
            width: 420px;
            height: 300px;
            border-radius: 28px;
        }

        .interior_text h1 {
            font-size: 25px;
            font-weight: 700;
        }

        .interior_text p {
            font-size: 15px;
            margin-top: 30px;
        }

        .beli {
            background: #436c44;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 40px;
            font-weight: bold;
            position: fixed;
            bottom: 30px;
            right: 40px;
            width: 230px;
            height: 90px;
            color: white;
            z-index: 10;
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

    <div class="header-actions">
        <button class="desainrumah" onclick="desainrumah()">
        Desain Rumah
        </button>

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
        <h1><%= rumah.get("nama") %></h1>
        <p style="text-align: justify;"><%= rumah.get("description") %></p>
    </div>
</div>

<button class="beli" onclick="beli()">Beli</button>

<div class="container">
    <div class="rumah">
        <img src="<%= lingkungan.get("image") %>">
        <div class="desc">
            <h1>Lingkungan</h1>
            <p style="text-align:justify"><%= lingkungan.get("text") %></p>
        </div>
    </div>
</div>

        
<%
    Map<String, Object> kt = ruangan.get("infokamartidur");
    Map<String, Object> km = ruangan.get("infokamarmandi");
    Map<String, Object> rt = ruangan.get("inforuangtamu");
    Map<String, Object> dp = ruangan.get("infodapur");
    Map<String, Object> gr = ruangan.get("infogarasi");
%>        
        
<div class="sidescroll">
    <div class="interior">
        <img src="<%= kt.get("image") %>">
        <div class="interior_text">
            <h1>Kamar Tidur</h1>
            <p style="text-align:justify"><%= kt.get("text") %></p>
        </div>
    </div>

    <div class="interior">
        <img src="<%= km.get("image") %>">
        <div class="interior_text">
            <h1>Kamar Mandi</h1>
            <p style="text-align:justify"><%= km.get("text") %></p>
        </div>
    </div>

    <div class="interior">
        <img src="<%= rt.get("image") %>">
        <div class="interior_text">
            <h1>Ruang Tamu</h1>
            <p style="text-align:justify"><%= rt.get("text") %></p>
        </div>
    </div>

    <div class="interior">
       <img src="<%= dp.get("image") %>">
        <div class="interior_text">
            <h1>Dapur</h1>
            <p style="text-align:justify"><%= dp.get("text") %></p>
        </div>
    </div>

    <div class="interior">
        <img src="<%= gr.get("image") %>">
        <div class="interior_text">
            <h1>Garasi</h1>
            <p style="text-align:justify"><%= gr.get("text") %></p>
        </div>
    </div>
</div>

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
        window.location.href = "home-user";
    }

    function profile() {
        window.location.href = "user-profile";
    }

    function beli() {
        window.location.href = "preview-transaksi?id=<%= request.getParameter("id") %>";
    }
    function desainrumah() {
        window.location.href = "desain-rumah";
    }
</script>

</body>
</html>

