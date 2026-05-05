<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Places - Cooperative Manager</title>

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

    <!-- =======================
         VOITURES + PLACES
    ======================= -->
    <div class="card">

        <h3 style="text-align: center;">🪑 Places libres par voiture</h3>
        
        <div id="placeLibreBox" style="margin-top:15px;">
            Filtrer par identification de voiture
        </div>

        <select id="voitureSelect">
            <option value="">Choisir voiture</option>
        </select>

        <div id="placeLibreBox" style="margin-top:15px;">
            Filtrer par occupation
        </div>
         <select id="occupationSelect">
            <option value="tous">Tous</option>
            <option value="oui">Place occupée</option>
            <option value="non">Place libre</option>
        </select>

    </div>

    <!-- =======================
         RECETTE
    ======================= -->
    <div class="card" style="text-align: center;">

        <h3>💰 Recette Totale</h3>

        <div id="recetteBox"
             style="font-size:26px;
                    font-weight:bold;
                    color:#22c55e;">
            Chargement...
        </div></br>
        <h3>🪑 Totale des places occupées</h3>

        <div id="occupiedBox"
             style="font-size:26px;
                    font-weight:bold;
                    color:#22c55e;">
            Chargement...
        </div></br>
        <h3>🪑 Totale des places libres</h3>

        <div id="freeBox"
             style="font-size:26px;
                    font-weight:bold;
                    color:#22c55e;">
            Chargement...
        </div>

    </div>

    <!-- =======================
         TABLE
    ======================= -->
    <div class="card" style="grid-column: span 2;">

        <h3 style="text-align: center;">📊 Etat des Places</h3>

        <table>
            <thead>
                <tr>
                    <th>Voiture</th>
                    <th>Place</th>
                    <th>Occupation</th>
                </tr>
            </thead>

            <tbody id="statTable"></tbody>
        </table>

    </div>

</div>
<footer>
    Cooperative Manager | Gestion intelligente des réservations | fifalianaangelos@gmail.com
</footer>

<script>
    window.API_BASE = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/assets/js/place.js"></script>
</body>
</html>