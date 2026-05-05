<!-- client.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Clients</title>
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

    <div>
        <a href="${pageContext.request.contextPath}/client/clientForm.jsp" class="btn-link">➕ Ajouter Client</a> 
    	<input type="text" id="search" placeholder="🔍 Rechercher client...">
    </div>
		
    <div class="card" style="grid-column: span 2;">
        <h3 style="text-align: center">📋 Liste des clients</h3>

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
<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>