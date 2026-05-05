document.addEventListener("DOMContentLoaded", function () {

    const API = window.API_BASE + "/api/place";
    const API_RES = window.API_BASE + "/api/reservation";

    let allPlaces = [];
    let allReservations = [];

    // =======================
    // CHARGEMENT SYNCHRONE
    // =======================
    Promise.all([
        fetch(API + "?type=all").then(r => r.json()),
        fetch(API_RES).then(r => r.json())
    ])
    .then(([places, reservations]) => {

        allPlaces = Array.isArray(places) ? places : [];
        allReservations = Array.isArray(reservations) ? reservations : [];

        loadVoitures(allPlaces);
        renderTable(allPlaces);
        updateDashboard();

    })
    .catch(err => {
        console.error("Erreur chargement :", err);
    });


    // =======================
    // LOAD VOITURES
    // =======================
    function loadVoitures(data) {

        let unique = [...new Set(data.map(p => p.idvoit))];

        let html = `<option value="">Toutes les voitures</option>`;

        unique.forEach(v => {
            html += `<option value="${v}">${v}</option>`;
        });

        document.getElementById("voitureSelect").innerHTML = html;

        document.getElementById("occupationSelect").innerHTML = `
            <option value="">Tous</option>
            <option value="oui">Place occupée</option>
            <option value="non">Place libre</option>
        `;
    }


    // =======================
    // TABLE
    // =======================
    function renderTable(data) {

        let html = "";

        data.forEach(p => {

            let occ = (p.occupation || "").toLowerCase();
            let isOcc = occ === "oui";

            html += `
                <tr>
                    <td>${p.idvoit || ""}</td>
                    <td>${p.place || ""}</td>
                    <td>
                        <span style="
                            background:${isOcc ? '#ef4444' : '#22c55e'};
                            color:white;
                            padding:5px 10px;
                            border-radius:6px;">
                            ${p.occupation || ""}
                        </span>
                    </td>
                </tr>
            `;
        });

        document.getElementById("statTable").innerHTML = html;
    }


    // =======================
    // FILTRE TABLE
    // =======================
    function filterData() {

        let voiture = document.getElementById("voitureSelect").value;
        let occ = document.getElementById("occupationSelect").value;

        let filtered = [...allPlaces];

        if (voiture) {
            filtered = filtered.filter(p =>
                String(p.idvoit).trim() === String(voiture).trim()
            );
        }

        if (occ) {
            filtered = filtered.filter(p =>
                (p.occupation || "").toLowerCase() === occ
            );
        }

        renderTable(filtered);
        updateDashboard();
    }


    // =======================
    // DASHBOARD
    // =======================
    function updateDashboard() {

        let voiture = document.getElementById("voitureSelect").value.trim();

        let filteredPlaces = [...allPlaces];
        let filteredRes = [...allReservations];

        if (voiture !== "") {

            filteredPlaces = filteredPlaces.filter(p =>
                String(p.idvoit).trim() === voiture
            );

            filteredRes = filteredRes.filter(r => {

                let idv =
                    r.idvoit ??
                    r.idVoit ??
                    r.id_voit ??
                    r.voiture ??
                    "";

                return String(idv).trim() === voiture;
            });
        }

        // =======================
        // PLACES
        // =======================
        let occupied = filteredPlaces.filter(p =>
            (p.occupation || "").toLowerCase() === "oui"
        ).length;

        let free = filteredPlaces.filter(p =>
            (p.occupation || "").toLowerCase() === "non"
        ).length;

        document.getElementById("occupiedBox").innerHTML = occupied;
        document.getElementById("freeBox").innerHTML = free;

        // =======================
        // RECETTE
        // =======================
        let total = filteredRes.reduce((sum, r) => {

            return sum + Number(
                r.montantAvance ??
                r.montant_avance ??
                0
            );

        }, 0);

        document.getElementById("recetteBox").innerHTML =
            total.toLocaleString() + " Ar";
    }


    // =======================
    // EVENTS
    // =======================
    document.getElementById("voitureSelect")
        .addEventListener("change", filterData);

    document.getElementById("occupationSelect")
        .addEventListener("change", filterData);

});