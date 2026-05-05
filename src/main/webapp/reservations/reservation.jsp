<!-- reservation.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réservations</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
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
		<a href="${pageContext.request.contextPath}/reservations/reservationForm.jsp" class="btn-link">            
		➕ Nouvelle Réservation
        </a>
        <a href="${pageContext.request.contextPath}/place/place.jsp" class="btn-link">
            Place
        </a>
        <p>Trier par payment</p>
        <select id="paymentFilter">
		    <option value="">Tous</option>
		    <option value="sans avance">sans avance</option>
		    <option value="avec avance">avec avance</option>
		    <option value="tout payé">tout payé</option>
		</select>
    </div>

    <div class="card" style="grid-column: span 2;">

        <h3 style="text-align: center;">📋 Liste réservations</h3>

        <div id="messageBox"></div>

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
                    <th>Montant Avance</th>
                    <th>Reste</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody id="reservationTable"></tbody>
        </table>

    </div>

</div>
<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script src="${pageContext.request.contextPath}/assets/js/reservation.js"></script>

</body>
</html>