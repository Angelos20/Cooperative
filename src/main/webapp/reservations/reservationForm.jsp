<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réservations</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

<header>
    <h2>🚀 Cooperative Manager</h2>
    <nav>
        <a href="${pageContext.request.contextPath}/client/client.jsp">Clients</a>
        <a href="${pageContext.request.contextPath}/voitures/voiture.jsp">Voitures</a>
        <a href="${pageContext.request.contextPath}/reservations/reservation.jsp">Réservations</a>
    </nav>
</header>

<div class="single-page">

    <div class="card form-card">

        <h3>➕ Nouvelle réservation</h3>
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

<script src="${pageContext.request.contextPath}/assets/js/reservation.js"></script>

</body>
</html>