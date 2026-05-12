<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fr">

<head>

<meta charset="UTF-8">

<title>Dashboard Cooperative Manager</title>

<style>

@charset "UTF-8";

/* =========================
   RESET
========================= */

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

/* =========================
   BODY + BACKGROUND
========================= */

html,
body{

    width:100%;
    min-height:100vh;

    overflow:hidden;

    font-family:"Segoe UI", sans-serif;

    color:white;

    background:
        linear-gradient(
            rgba(5,10,20,0.78),
            rgba(5,10,20,0.92)
        ),
		url("${pageContext.request.contextPath}/assets/img/backgroud_index.jpg");

    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-attachment:fixed;
}

/* =========================
   HEADER
========================= */

header{

    position:fixed;

    top:0;
    left:0;

    width:100%;

    z-index:1000;

    display:flex;

    justify-content:center;

    align-items:center;

    padding:20px;

    background:rgba(15,23,42,0.72);

    backdrop-filter:blur(14px);

    border-bottom:1px solid rgba(255,255,255,0.08);

    box-shadow:0 5px 20px rgba(0,0,0,0.35);
}

header h2{

    color:#38bdf8;

    font-size:32px;

    letter-spacing:1px;
}

/* =========================
   MAIN CENTER
========================= */

.single-page{

    width:100%;
    min-height:100vh;

    display:flex;

    justify-content:center;

    align-items:center;

    padding:30px;
}

/* =========================
   DASHBOARD CARD
========================= */

.form-card{

    width:100%;
    max-width:850px;

    padding:50px 40px;

    border-radius:30px;

    background:rgba(17,24,39,0.72);

    backdrop-filter:blur(15px);

    border:1px solid rgba(255,255,255,0.08);

    box-shadow:
        0 15px 40px rgba(0,0,0,0.45),
        0 0 25px rgba(56,189,248,0.08);

    text-align:center;

    animation:fadeIn 1s ease;
}

/* =========================
   TITLE
========================= */

.form-card h3{

    font-size:56px;

    line-height:1.2;

    margin-bottom:25px;

    color:#38bdf8;

    text-shadow:0 0 20px rgba(56,189,248,0.25);
}

/* =========================
   BUTTON
========================= */

.btn-link{

    display:inline-block;

    text-decoration:none;

    background:linear-gradient(
        135deg,
        #38bdf8,
        #0ea5e9
    );

    color:white;

    padding:16px 45px;

    border-radius:15px;

    font-size:18px;

    font-weight:bold;

    transition:0.3s;

    box-shadow:
        0 10px 25px rgba(56,189,248,0.25);
}

.btn-link:hover{

    transform:translateY(-4px) scale(1.03);

    box-shadow:
        0 15px 35px rgba(56,189,248,0.4);
}

/* =========================
   ANIMATION
========================= */

@keyframes fadeIn{

    from{

        opacity:0;

        transform:translateY(40px);
    }

    to{

        opacity:1;

        transform:translateY(0);
    }
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width:768px){

    .form-card{

        padding:35px 25px;
    }

    .form-card h3{

        font-size:34px;
    }

   
    .btn-link{

        width:100%;
    }
}

</style>

</head>

<body>

<header>

    <h2>
        fifalianaangelos@gmail.com
    </h2>

</header>

<div class="single-page">

    <div class="form-card">

        <h3>
            Bienvenue dans Cooperative Manager
        </h3>

        <a href="reservations/reservation.jsp"
           class="btn-link">

            Ouvrir maintenant

        </a>

    </div>

</div>

</body>

</html>