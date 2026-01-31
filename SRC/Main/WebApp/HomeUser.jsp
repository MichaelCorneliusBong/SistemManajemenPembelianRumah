%<@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  
        .content {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 0 20px;
            
            background:
                linear-gradient(
                    to top,
                    rgba(0, 0, 0, 0.75),
                    rgba(0, 0, 0, 0.2)
                ),
                url('Assets/HomePage.png')
                no-repeat center center / cover;
        }
        
        .tptp {
            display: flex;
            gap: 12px;
        }

        .content h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 0 4px 15px rgba(0,0,0,0.6);
        }

        .content p {
            font-size: 20px;
            font-weight: 300;
            max-width: 700px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.5);
        }

        .main {
            min-height: 10vh;
            background: #F3ECDC;
            justify-content: center;
            align-items: flex-start;
            padding-top: 50px;
        }
        
        .text {
            padding: 10px 40px;
            background: #588157;
            border: none;
            border-radius: 10px;
            color: white;
            max-width: 1000px;
            margin: 0 auto;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .text p {
            text-align: justify;
            line-height: 1.8;
        }
        
        .map {
            max-width: 700px;
            margin-left: 100px;
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
        
        html {
            scroll-behavior: smooth;
        }

        html, body {
        overflow-x: hidden;
        }
        
        button:hover {
            background: #d0d0d0;
        }        
    </style>
</head>
<body>

<div class="header">
        <button class="logo-klik">
            <a href="#home"><img src="Assets/Logo.png" class="logo"></a>
        </button>
        <div class="header-actions">
            <button class="desainrumah" onclick="transaksi()">Histori Transaksi</button>
            <button class="desainrumah" onclick="desainrumah()">Desain Rumah</button>

            <button class="profile-btn" onclick="profile()">
                <c:choose>
                    <c:when test="${not empty profileImage}">
                        <img src="${profileImage}" class="profile-img">
                    </c:when>
                    <c:otherwise>
                        <span class="profile-initial">${initial}</span>
                    </c:otherwise>
                </c:choose>
            </button>
        </div>
    </div>

<div class="content" id="home">
    <h1>Bangun Rumah Impian Anda</h1>
    <p>
        Dari pondasi yang kuat hingga desain modern,
        kami hadir untuk mewujudkan hunian masa depan Anda.
    </p>
    <div class="tptp">
        <a href="#visi">
        <button class="desainrumah">Visi</button>
        </a>
        <a href="#misi">
        <button class="desainrumah">Misi</button>
        </a>
        <a href="#fitur">
        <button class="desainrumah">Fitur</button>
        </a>
        <a href="#lokasi">
        <button class="desainrumah">Lokasi</button>
        </a>
    </div>
</div>

<div class="main" id="visi">
    <div class="text">
        <h2>
        Visi
        </h2>
        <p>
        Berkomitmen untuk menjadi pengembang perumahan terkemuka yang tidak hanya membangun tempat tinggal, tetapi juga menciptakan lingkungan yang memberikan kenyamanan, kualitas hidup yang lebih baik, dan dampak positif. Dengan mengutamakan desain modern dan ramah lingkungan, kami bertujuan untuk menciptakan hunian yang tidak hanya memenuhi kebutuhan akan tempat tinggal, tetapi juga memberikan nilai lebih bagi setiap individu dan keluarga yang memilih untuk tinggal di properti kami.
        </p>
    </div>
</div>
    
<div class="main" id="misi">
    <div class="text">
        <h2>
        Misi
        </h2>
        <p>
        Kami bekerja dengan tekad dan dedikasi yang tinggi. Kami selalu berupaya mengembangkan proyek perumahan yang tidak hanya berkualitas tinggi, tetapi juga mampu memenuhi harapan dan kebutuhan masyarakat modern. Setiap properti yang kami bangun didesain dengan memperhatikan aspek fungsionalitas. Kami percaya bahwa pelayanan yang unggul adalah kunci untuk menciptakan hubungan?baik?dengan pelanggan. Oleh karena itu, kami selalu berfokus pada kepuasan pelanggan, mulai dari proses pembelian, pembangunan, hingga kepemilikan properti. Kami berusaha memastikan setiap pengalaman mereka dengan kami adalah pengalaman yang menyenangkan dan tak terlupakan.
        </p>
    </div>
</div>
    
<div class="main" id="fitur">
    <div class="text">
        <h2>
        Fitur
        </h2>
        <p>
        Perumahan ini dirancang dengan mengutamakan keamanan, kenyamanan, dan kualitas hidup penghuninya melalui pengawasan CCTV 24 jam dan layanan keamanan profesional. Setiap unit dibangun dengan tata ruang modern, pencahayaan alami yang optimal, dan material berkualitas tinggi, dipadukan dengan fitur pintar untuk mendukung gaya hidup yang lebih praktis dan efisien. Lingkungan hunian dilengkapi ruang terbuka hijau, taman bermain, dan fasilitas lain yang menambah kenyamanan dan menciptakan suasana hidup yang sehat. Infrastruktur kawasan dibuat terencana, mulai dari jalan yang lebar, sistem air bersih yang stabil, hingga penerangan lingkungan yang memadai. Selain itu, lokasi yang strategis dekat berbagai fasilitas umum dan dukungan layanan menjadikan perumahan ini pilihan ideal bagi keluarga modern yang menginginkan hunian aman dan nyaman.
        </p>
    </div>
</div>
    
<div class="main" id="lokasi">
    <div class="text">
        <h2>
        Lokasi
        </h2>
        <div class="map">
        <img 
        src="https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s+ff0000(106.8456,-6.2088)/106.8456,-6.2088,12/800x600?access_token=pk.eyJ1Ijoia2lraWhpdHJlayIsImEiOiJjbWwxcWl3NzcwNzJxM2RzZTJsbmpyazJxIn0.-KpfaanNur8hpYBN9MeTUw" 
        alt="Mapbox Static Map" 
        width="800" 
        height="600">
        </div>
        
        <p>
        Kantor Pusat : 
        </p>
        <p>
        Jl. Canary Raya No. 27,
 RT 004 / RW 012, Kel. Cempaka Putih Timur,
 Kec. Cempaka Putih, Jakarta Pusat, 10510
        </p>
    </div>
</div>
    
    <div class="main">
        <div class="footer">
            <p>
            2025 - Company, Inc. All Rights Reserved. Address.
            </p>
            <h1>
            Copyright | Terms & Service |  Contributor
            </h1>
        </div>
    </div>

<script>
    function profile() {
        window.location.href = "user-profile";
    }
    function desainrumah() {
        window.location.href = "desain-rumah";
    }
    function transaksi() {
        window.location.href = "user-transactions";
    }
</script>

</body>
</html>