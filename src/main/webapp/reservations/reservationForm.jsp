<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réservations</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
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
   CARD FORM
======================= */

.card {

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

        <form id="reservForm" class="client-form" method="post">
        
        	<!-- ID VOITURE -->
            <input type="text" id="idreserv" name="idreserv"
                   placeholder="Identité de la reservation" required>

            <!-- ID VOITURE -->
            <input type="text" id="idvoit" name="idvoit"
                   placeholder="Identité de la Voiture" required>

            <!-- ID CLIENT -->
            <input type="text" id="idcli" name="idcli"
                   placeholder="Identité du Client" required>

            <!-- PLACE -->
            <input type="number" id="place" name="place"
                   placeholder="Place" required>

            <!-- DATE -->
            <label>Date du départ</label>
            <input type="date" id="dateVoyage" name="dateVoyage" required>

            <!-- PAYMENT -->
            <select id="payment" name="payment">
                <option value="sans avance">sans avance</option>
                <option value="avec avance">avec avance</option>
                <option value="tout payé">tout payé</option>
            </select>

            <!-- AVANCE -->
            <input type="number" id="montantAvance" name="montantAvance"
                   placeholder="Montant avance">

            <button type="submit">Enregistrer</button>

        </form>

    </div>

</div>

<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/reservation.js"></script>

</body>
</html>