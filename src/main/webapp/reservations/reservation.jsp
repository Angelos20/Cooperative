<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Réservations</title>

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
   FOOTER
======================= */

footer{

    position:fixed;
    bottom:0;
    left:0;

    width:100%;

    z-index:1000;

    padding:15px;

    text-align:center;

    background:rgba(15,23,42,0.72);

    backdrop-filter:blur(14px);

    border-top:1px solid rgba(255,255,255,0.08);

    color:#cbd5e1;
}

/* =======================
   PAGE LAYOUT
======================= */

.container{

    width:100%;

    display:grid;

    grid-template-columns:1fr;

    gap:20px;

    padding:30px;
}

/* =======================
   ACTION BAR
======================= */

.container > .container{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:15px;

    flex-wrap:wrap;

    margin-top:10px;
}

/* espace au-dessus bouton principal */
.container > .container a.btn-link:first-child{
    margin-top:20px;
}

/* =======================
   BUTTON LINK
======================= */
#res{
	margin-bottom:20px;
}

.btn-link{

    display:inline-block;

    width:250px;

    text-align:center;

    text-decoration:none;

    color:white;

    font-weight:bold;

    padding:12px;

    border-radius:12px;

    background:linear-gradient(135deg,#38bdf8,#0ea5e9);

    transition:0.3s;
}

.btn-link:hover{

    transform:translateY(-3px);

    box-shadow:0 10px 20px rgba(56,189,248,0.3);
}

/* =======================
   SELECT
======================= */

select{

    padding:12px;

    border-radius:12px;

    background:rgba(15,23,42,0.85);

    border:1px solid rgba(255,255,255,0.08);

    color:white;
}

/* =======================
   CARD
======================= */

.card{

    background:rgba(17,24,39,0.78);

    backdrop-filter:blur(12px);

    border:1px solid rgba(255,255,255,0.08);

    border-radius:22px;

    padding:25px;

    box-shadow:
        0 10px 35px rgba(0,0,0,0.45),
        0 0 25px rgba(56,189,248,0.08);
}

.card h3{

    text-align:center;

    color:#38bdf8;

    font-size:24px;

    margin-bottom:20px;
}

/* =======================
   TABLE SCROLL FIX
======================= */
.table-wrapper{

    max-height:500px;   /* limite la hauteur */
    overflow-y:auto;    /* scroll vertical */
    overflow-x:auto;    /* scroll horizontal si besoin */

    border-radius:16px;
}

.table-wrapper::-webkit-scrollbar{
    width:6px;
}

.table-wrapper::-webkit-scrollbar-thumb{
    background:#38bdf8;
    border-radius:10px;
}


/* =======================
   TABLE
======================= */

table{

    width:100%;

    min-width:1200px; /* scroll horizontal */

    border-collapse:collapse;
}

thead th{

    position:sticky;
    top:0;

    background:rgba(30,41,59,0.95);

    color:#38bdf8;

    padding:14px;
}

th, td{

    padding:14px;

    text-align:center;

    border-bottom:1px solid rgba(255,255,255,0.08);
}

tbody tr:hover{

    background:rgba(56,189,248,0.08);
}

/* =======================
   ACTIONS TABLE
======================= */

td:last-child{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:10px;

    flex-wrap:nowrap;
}

/* =======================
   BUTTON ACTION
======================= */

.btn_action{

    width:40px;
    height:40px;

    display:flex;

    justify-content:center;
    align-items:center;

    background:rgba(255,255,255,0.05);

    border:1px solid rgba(255,255,255,0.08);

    border-radius:10px;

    transition:0.3s;
}

.btn_action:hover{

    transform:scale(1.08);

    background:rgba(56,189,248,0.15);
}

.btn_action img{

    width:18px;
    height:18px;
}

/* =======================
   RESPONSIVE
======================= */

@media(max-width:768px){

    .btn-link{
        width:100%;
    }
     .container{
        padding:15px;
    }

    header h2{
        font-size:20px;
    }

    table,
    thead,
    tbody,
    th,
    td,
    tr{
        display:block;
    }

    thead{
        display:none;
    }

    tr{
        margin-bottom:15px;
        background:rgba(17,24,39,0.85);
        border-radius:12px;
        padding:10px;
    }

    td{
        text-align:right;
        padding-left:50%;
        position:relative;
    }

    td::before{
        position:absolute;
        left:10px;
        color:#38bdf8;
        font-weight:bold;
    }
}

</style>
</head>

<body>

<header>
     <h2> Cooperative Manager</h2>

    <nav>
        <a href="${pageContext.request.contextPath}/client/client.jsp">
            Clients
        </a>

        <a href="${pageContext.request.contextPath}/voitures/voiture.jsp">
            Voitures
        </a>

        <a href="${pageContext.request.contextPath}/reservations/reservation.jsp">
            Réservations
        </a>
    </nav>

</header>

<div class="container">

    <div class="container">

        <a href="${pageContext.request.contextPath}/reservations/reservationForm.jsp"
           class="btn-link" id="res">

            ➕ Nouvelle Réservation

        </a>

        <a href="${pageContext.request.contextPath}/place/place.jsp"
           class="btn-link">

            Place

        </a>

        <select id="paymentFilter">
            <option value="">Tous</option>
            <option value="sans avance">sans avance</option>
            <option value="avec avance">avec avance</option>
            <option value="tout payé">tout payé</option>
        </select>
        <div class="card" id="nbr_reser">
        	<p>0</p>
        </div>

    </div>

    <div class="card">

        <h3>📋 Liste réservations</h3>

        <div id="messageBox"></div>

        <!-- SCROLL TABLE -->
        <div class="table-wrapper">

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Voiture</th>
                        <th>Client</th>
                        <th>Place</th>
                        <th>Date Réservation</th>
                        <th>Date Voyage</th>
                        <th>Payment</th>
                        <th>Avance</th>
                        <th>Reste</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody id="reservationTable"></tbody>
            </table>

        </div>

    </div>

</div>

<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/reservation.js"></script>

</body>
</html>