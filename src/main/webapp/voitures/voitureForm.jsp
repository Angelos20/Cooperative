<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voiture Form</title>
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

        <h3>🚗 Ajouter / Modifier Voiture</h3>

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

<script src="${pageContext.request.contextPath}/assets/js/voiture.js"></script>

</body>
</html>