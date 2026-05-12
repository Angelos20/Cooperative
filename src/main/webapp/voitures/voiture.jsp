<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Voitures</title>

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

    overflow-x:hidden;

    font-family:"Segoe UI", sans-serif;

    color:#e5e7eb;

    background:
        linear-gradient(
            rgba(5,10,20,0.82),
            rgba(5,10,20,0.92)
        ),
        url("${pageContext.request.contextPath}/assets/img/voiture.jpg");

    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-attachment:fixed;
}

/* espace header/footer */

body{
    padding-top:90px;
    padding-bottom:80px;
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

    padding:15px 20px;

    text-align:center;

    background:rgba(15,23,42,0.72);

    backdrop-filter:blur(14px);

    border-top:1px solid rgba(255,255,255,0.08);

    color:#cbd5e1;

    box-shadow:0 -5px 20px rgba(0,0,0,0.35);
}

/* =======================
   CONTAINER
======================= */

.container{

    width:100%;

    display:grid;

    grid-template-columns:repeat(2,1fr);

    gap:25px;

    padding:30px;
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

    overflow:hidden;

    box-shadow:
        0 10px 35px rgba(0,0,0,0.45),
        0 0 25px rgba(56,189,248,0.08);

    transition:0.3s;
}

.card:hover{

    transform:translateY(-4px);

    box-shadow:
        0 15px 40px rgba(0,0,0,0.55),
        0 0 30px rgba(56,189,248,0.18);
}

.card h3{

    margin-bottom:20px;

    color:#38bdf8;

    font-size:24px;
}

/* =======================
   ACTIONS
======================= */

.actions{

    width:100%;

    display:flex;

    justify-content:center;

    align-items:center;

    gap:25px;

    flex-wrap:nowrap;
}

/* =======================
   BUTTON LINK
======================= */

.btn-link{
	width:240px;

    text-decoration:none;

    color:white;

    background:linear-gradient(135deg,#38bdf8,#0ea5e9);

    padding:10px 10px;

    border-radius:12px;

    font-weight:bold;

    transition:0.3s;
}

.btn-link:hover{

    transform:translateY(-3px);

    box-shadow:0 10px 20px rgba(56,189,248,0.3);
}

/* =======================
   INPUTS
======================= */

input,
select{

    width:100%;

    padding:14px;

    border:none;

    outline:none;

    border-radius:12px;

    background:rgba(15,23,42,0.85);

    border:1px solid rgba(255,255,255,0.08);

    color:white;

    transition:0.3s;
}

#search{

    width:220px;

    max-width:220px;

    padding:12px 14px;

    flex:none;
}

input:focus,
select:focus{

    border-color:#38bdf8;

    box-shadow:
        0 0 0 3px rgba(56,189,248,0.15),
        0 0 15px rgba(56,189,248,0.2);
}

/* =======================
   TABLE
======================= */

table{

    width:100%;

    border-collapse:collapse;

    margin-top:10px;

    overflow:hidden;

    border-radius:16px;
}

thead th{

    background:rgba(30,41,59,0.95);

    color:#38bdf8;

    padding:16px;

    position:sticky;

    top:0;

    z-index:10;
}

th,
td{

    padding:15px;

    text-align:center;

    border-bottom:1px solid rgba(255,255,255,0.08);
}

tbody tr{

    transition:0.3s;
}

tbody tr:hover{

    background:rgba(56,189,248,0.08);
}

/* =======================
   BUTTONS
======================= */

button{

    border:none;

    cursor:pointer;

    border-radius:10px;

    transition:0.3s;
}

.btn_action{

    width:40px;

    height:40px;

    padding:8px;

    display:flex;

    align-items:center;

    justify-content:center;

    border-radius:10px;

    background:rgba(255,255,255,0.05);

    border:1px solid rgba(255,255,255,0.08);

    transition:0.3s;
}

.btn_action:hover{

    transform:scale(1.08);

    background:rgba(56,189,248,0.15);
}

.btn_action img{

    width:18px;
    height:18px;

    object-fit:contain;
}

/* =======================
   TYPE COLORS
======================= */

#type.simple{
    border:2px solid #38bdf8;
    color:#38bdf8;
}

#type.premium{
    border:2px solid #f59e0b;
    color:#f59e0b;
}

#type.VIP{
    border:2px solid #ef4444;
    color:#ef4444;
}

/* =======================
   RESPONSIVE TABLET
======================= */

@media(max-width:992px){

    .container{
        grid-template-columns:1fr;
    }

    header{
        flex-direction:column;
        gap:15px;
    }
}

/* =======================
   RESPONSIVE MOBILE
======================= */

@media(max-width:600px){

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

        border-radius:15px;

        padding:10px;

        background:rgba(17,24,39,0.85);
    }

    td{

        position:relative;

        text-align:right;

        padding-left:50%;

        border:none;
    }

    td::before{

        position:absolute;

        left:10px;

        color:#38bdf8;

        font-weight:bold;
    }

    td:nth-child(1)::before{
        content:"ID";
    }

    td:nth-child(2)::before{
        content:"Désignation";
    }

    td:nth-child(3)::before{
        content:"Type";
    }

    td:nth-child(4)::before{
        content:"Places";
    }

    td:nth-child(5)::before{
        content:"Frais";
    }

    td:nth-child(6)::before{
        content:"Actions";
    }
    
}

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
   ACTIONS TABLE
======================= */

td:last-child{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:10px;

    flex-wrap:nowrap;
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

    <!-- ACTIONS -->

    <div style="grid-column: span 2;">

        <div class="actions">

            <a href="${pageContext.request.contextPath}/voitures/voitureForm.jsp"
               class="btn-link">

                ➕ Ajouter Voiture

            </a>

            <input type="text"
                   id="search"
                   placeholder="🔍 Rechercher voiture...">

        </div>

    </div>

    <!-- TABLE -->

    <div class="card" style="grid-column: span 2;">

        <h3 style="text-align:center;">
            🚗 Liste des voitures
        </h3>

        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>
                        <th>ID</th>
                        <th>Désignation</th>
                        <th>Type</th>
                        <th>Places</th>
                        <th>Frais</th>
                        <th>Actions</th>
                    </tr>

                </thead>

                <tbody id="voitureTable">

                </tbody>

            </table>

        </div>

    </div>

</div>

<footer>

    Cooperative Manager | Gestion intelligente des réservations |
    fifalianaangelos@gmail.com

</footer>

<script src="${pageContext.request.contextPath}/assets/js/voiture.js"></script>

</body>
</html>