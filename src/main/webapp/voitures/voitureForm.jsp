<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajout de voiture</title>

<style>

@charset "UTF-8";

/* =======================
   RESET
======================= */

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

/* =======================
   BODY + BACKGROUND
======================= */

html, body{

    width:100%;
    min-height:100vh;

    font-family:"Segoe UI", sans-serif;

    color:#e5e7eb;

    background:
        linear-gradient(
            rgba(5,10,20,0.78),
            rgba(5,10,20,0.92)
        ),
        url("${pageContext.request.contextPath}/assets/img/voiture.jpg");

    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-attachment:fixed;
}

/* =======================
   HEADER
======================= */

header{

    position:fixed;

    top:0;
    left:0;

    width:100%;

    z-index:1000;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:15px 30px;

    background:rgba(15,23,42,0.72);

    backdrop-filter:blur(14px);

    border-bottom:1px solid rgba(255,255,255,0.08);

    box-shadow:0 5px 20px rgba(0,0,0,0.35);
}

header h2{

    color:#38bdf8;

    font-size:26px;

    font-weight:bold;
}

header nav{

    display:flex;

    gap:12px;

    flex-wrap:wrap;
}

header nav a{

    text-decoration:none;

    color:#e2e8f0;

    padding:10px 14px;

    border-radius:10px;

    transition:0.3s;

    background:rgba(255,255,255,0.04);
}

header nav a:hover{

    background:#38bdf8;

    color:#000;

    transform:translateY(-2px);
}


/* =======================
   PAGE CENTER
======================= */

.single-page{

    min-height:100vh;

    display:flex;

    justify-content:center;
    align-items:center;

    padding:30px;
}

/* =======================
   CARD FORM
======================= */

.card{

    width:100%;
    max-width:600px;

    padding:40px;

    border-radius:25px;

    background:rgba(17,24,39,0.78);

    backdrop-filter:blur(15px);

    border:1px solid rgba(255,255,255,0.08);

    box-shadow:
        0 15px 40px rgba(0,0,0,0.5),
        0 0 25px rgba(56,189,248,0.08);

    animation:fadeIn 0.8s ease;
}

.card h3{

    text-align:center;

    font-size:28px;

    margin-bottom:25px;

    color:#38bdf8;
}

/* =======================
   INPUT GROUP
======================= */

.input-group{

    display:flex;

    flex-direction:column;

    gap:6px;

    margin-bottom:15px;
}

label{

    font-size:14px;

    color:#cbd5e1;
}

/* =======================
   INPUTS
======================= */

input,
select{

    width:100%;

    padding:12px;

    border-radius:12px;

    border:1px solid rgba(255,255,255,0.08);

    background:rgba(15,23,42,0.85);

    color:white;

    outline:none;

    transition:0.3s;
}

input:focus,
select:focus{

    border-color:#38bdf8;

    box-shadow:0 0 10px rgba(56,189,248,0.25);
}

/* =======================
   BUTTON
======================= */

button{

    width:100%;

    margin-top:10px;

    padding:14px;

    border:none;

    border-radius:12px;

    font-size:16px;

    font-weight:bold;

    cursor:pointer;

    color:black;

    background:linear-gradient(135deg,#38bdf8,#0ea5e9);

    transition:0.3s;
}

button:hover{

    transform:translateY(-3px);

    box-shadow:0 10px 25px rgba(56,189,248,0.3);
}

/* =======================
   ANIMATION
======================= */

@keyframes fadeIn{

    from{
        opacity:0;
        transform:translateY(30px);
    }

    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* =======================
   RESPONSIVE
======================= */

@media(max-width:600px){

    .card{

        padding:25px;
    }

    header h2{

        font-size:20px;
    }
}

</style>

</head>

<body>

<header>
    <h2>Cooperative Manager</h2>
    <nav>
        <a href="${pageContext.request.contextPath}/client/client.jsp">Clients</a>
        <a href="${pageContext.request.contextPath}/voitures/voiture.jsp">Voitures</a>
        <a href="${pageContext.request.contextPath}/reservations/reservation.jsp">Réservations</a>
    </nav>
</header>

<div class="single-page">

    <div class="card form-card">

        <div id="messageBox"></div>

        <form id="voitureForm" class="client-form">

            <div class="input-group">
                <label>Identification</label>
                <input type="text" id="idvoit" required>
            </div>

            <div class="input-group">
                <label>Désignation</label>
                <input type="text" id="design" required>
            </div>

            <div class="input-group">
                <label>Type</label>
                <select id="type" required>
                    <option value="simple">Simple</option>
                    <option value="premium">Premium</option>
                    <option value="VIP">VIP</option>
                </select>
            </div>

            <div class="input-group">
                <label>Nombre de places</label>
                <input type="number" id="nbrplace" required>
            </div>

            <div class="input-group">
                <label>Frais</label>
                <input type="number" id="frais" required>
            </div>

            <button type="submit" id="submitBtn">💾 Enregistrer</button>

        </form>

    </div>

</div>

<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/voiture.js"></script>

</body>
</html>