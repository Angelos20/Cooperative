<!-- clientForm.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajouter Client</title>
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

        <h3>➕ Ajouter / Modifier Client</h3>

        <div id="messageBox"></div>

        <form id="clientForm" class="client-form">

            <input type="hidden" id="id">

            <div class="input-group">
                <label>Nom</label>
                <input type="text" id="nom" required>
            </div>

            <div class="input-group">
                <label>Téléphone</label>
                <input type="text" id="telephone" required>
            </div>

            <button type="submit" id="submitBtn">💾 Enregistrer</button>

        </form>

    </div>

</div>

<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>