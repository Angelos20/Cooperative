<!-- client.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Clients</title>
<style>

@charset "UTF-8";

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
        linear-gradient(rgba(5,10,20,0.82), rgba(5,10,20,0.92)),
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

    background:rgba(255,255,255,0.04);

    transition:0.3s;
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
   CONTAINER GRID
======================= */
.container{

    width:100%;

    display:grid;
    grid-template-columns:repeat(2,1fr);

    gap:25px;

    padding:30px;
}

/* =======================
   TOP BAR (AJOUT + SEARCH)
======================= */
.top-bar{

    grid-column:span 2;

    display:flex;
    justify-content:center;
    align-items:center;

    gap:15px;

    margin-bottom:20px;

    flex-wrap:wrap;
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

    box-shadow:0 10px 35px rgba(0,0,0,0.45);
}

/* =======================
   BUTTON
======================= */
.btn-link{

    width:240px;

    text-align:center;
    text-decoration:none;

    color:white;

    background:linear-gradient(135deg,#38bdf8,#0ea5e9);

    padding:10px;

    border-radius:12px;

    font-weight:bold;

    transition:0.3s;
}

.btn-link:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 20px rgba(56,189,248,0.3);
}

/* =======================
   INPUT SEARCH
======================= */
#search{

    width:220px;

    padding:12px 14px;

    border-radius:12px;

    border:1px solid rgba(255,255,255,0.08);

    background:rgba(15,23,42,0.85);
    color:white;

    outline:none;
}

#search:focus{
    border-color:#38bdf8;
    box-shadow:0 0 10px rgba(56,189,248,0.25);
}

/* =======================
   TABLE
======================= */
table{

    width:100%;
    border-collapse:collapse;

    margin-top:10px;
    border-radius:16px;
    overflow:hidden;
}

thead th{

    background:rgba(30,41,59,0.95);
    color:#38bdf8;

    padding:16px;
}

th, td{

    padding:15px;
    text-align:center;

    border-bottom:1px solid rgba(255,255,255,0.08);
}

tbody tr:hover{
    background:rgba(56,189,248,0.08);
}

/* =======================
   ACTION BUTTON
======================= */
.btn_action{

    width:40px;
    height:40px;

    display:flex;
    justify-content:center;
    align-items:center;

    border-radius:10px;

    background:rgba(255,255,255,0.05);
    border:1px solid rgba(255,255,255,0.08);

    transition:0.3s;
}

.btn_action:hover{
    transform:scale(1.08);
    background:rgba(56,189,248,0.15);
}

/* =======================
   RESPONSIVE
======================= */
@media(max-width:992px){

    .container{
        grid-template-columns:1fr;
    }

    .top-bar{
        grid-column:span 1;
    }

    header{
        flex-direction:column;
        gap:10px;
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

td:last-child{

    display:flex;
    flex-direction:row;
    justify-content:center;
    align-items:center;

    gap:10px;

    flex-wrap:nowrap; /* IMPORTANT : empêche le passage en colonne */

    white-space:nowrap;
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

<div class="container">

    <div class="top-bar">

	    <a href="${pageContext.request.contextPath}/client/clientForm.jsp"
	       class="btn-link">
	        ➕ Ajouter Client
	    </a>
	
	    <input type="text" id="search" placeholder="🔍 Rechercher client...">
	
	</div>
		
    <div class="card" style="grid-column: span 2;">
        <h3 style="text-align: center">📋 Liste des clients</h3>
		
		<div class="table-wrapper">
			<table>
	            <thead>
	                <tr>
	                    <th>ID</th>
	                    <th>Nom</th>
	                    <th>Téléphone</th>
	                    <th>Actions</th>
	                </tr>
	            </thead>
	
	            <tbody id="clientTable"></tbody>
	        </table>
        </div>
        
    </div>

</div>
<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>