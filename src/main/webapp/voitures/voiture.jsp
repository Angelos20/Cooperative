<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Voitures</title>
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

<div class="container">

    <!-- ACTIONS -->
    <div>
        <a href="${pageContext.request.contextPath}/voitures/voitureForm.jsp" class="btn-link">
            ➕ Ajouter Voiture
        </a>
        <input type="text" id="search" placeholder="🔍 Rechercher voiture...">

	</div>

    <!-- TABLE -->
    <div class="card" style="grid-column: span 2;">
        <h3 style="text-align: center;">🚗 Liste des voitures</h3>

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

            <tbody id="voitureTable"></tbody>
        </table>
    </div>

</div>
<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/voiture.js"></script>

</body>
</html>