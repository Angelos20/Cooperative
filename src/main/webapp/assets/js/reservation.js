const API = "/Cooperative-Manager/api/reservation";

let fraisVoiture = 0;

/* ================= INIT ================= */
document.addEventListener("DOMContentLoaded", () => {

    const table = document.getElementById("reservationTable");
    const form = document.getElementById("reservForm");

    if (table) loadReservation();

    if (form) {

        form.addEventListener("submit", addOrUpdateReservation);

        const payment = document.getElementById("payment"); // ✅ FORM
        const idvoit = document.getElementById("idvoit");

        if (payment) payment.addEventListener("change", handlePayment);
        if (idvoit) idvoit.addEventListener("change", loadVoitureFrais);

        const params = new URLSearchParams(window.location.search);
        const id = params.get("idreserv");

        if (id) loadReservationForEdit(id);
    }

    const filter = document.getElementById("paymentFilter");
    if (filter) filter.addEventListener("change", loadReservation);
});

/* ================= MESSAGE ================= */
function showMessage(msg, type) {
    const box = document.getElementById("messageBox");
    if (!box) return;

    box.innerHTML = msg;
    box.className = type;
}

/* ================= LIST ================= */
function loadReservation() {

    fetch(API)
        .then(r => r.json())
        .then(data => {

            const filterEl = document.getElementById("paymentFilter");
            const filtre = filterEl ? filterEl.value : "";

            // 🔥 filtrage
            if (filtre !== "") {
                data = data.filter(x => x.payment === filtre);
            }

            // 🔥 compteur
            const counter = document.querySelector("#nbr_reser p");
            if (counter) {
                counter.textContent = data.length;
            }

            // 🔥 tableau
            const table = document.getElementById("reservationTable");
            if (!table) return;

            table.innerHTML = data.map(x => `
                <tr>
                    <td>${x.idreserv ?? ""}</td>
                    <td>${x.idvoit ?? ""}</td>
                    <td>${x.idcli ?? ""}</td>
                    <td>${x.place ?? 0}</td>
                    <td>${x.dateReserv ?? x.date_reserv ?? ""}</td>
                    <td>${x.dateVoyage ?? x.date_voyage ?? ""}</td>
                    <td>${x.payment ?? ""}</td>
                    <td>${x.montantAvance ?? x.montant_avance ?? 0}</td>
                    <td>${x.reste ?? 0}</td>
                    <td>
                        <button class="btn_action" onclick="editReservation('${x.idreserv}')">✏️</button>
                        <button class="btn_action" onclick="deleteReservation('${x.idreserv}')">🗑️</button>
                        <button class="btn_action" onclick="generatePDF('${x.idreserv}')">📄</button>
                    </td>
                </tr>
            `).join("");

        })
        .catch(err => {
            console.error(err);
            showMessage("❌ Erreur chargement", "error");
        });
}

/* ================= ADD / UPDATE ================= */
function addOrUpdateReservation(e) {

    e.preventDefault();

    const params = new URLSearchParams(window.location.search);
    const isEdit = params.get("idreserv") != null;

    const payment = getVal("payment");

    const validPayments = ["sans avance", "avec avance", "tout payé"];

    if (!validPayments.includes(payment)) {
        showMessage("❌ Payment invalide", "error");
        return;
    }

    let data = new URLSearchParams();

    data.append("action", isEdit ? "update" : "add");
    data.append("idreserv", getVal("idreserv"));
    data.append("idvoit", getVal("idvoit"));
    data.append("idcli", getVal("idcli"));
    data.append("place", getVal("place"));

    data.append(
        "dateReserv",
        new Date().toISOString().slice(0, 19).replace("T", " ")
    );

    data.append("dateVoyage", getVal("dateVoyage"));
    data.append("payment", payment);
    data.append("montantAvance", getVal("montantAvance") || 0);

    fetch(API, {
        method: "POST",
        body: data
    })
        .then(r => r.json())
        .then(res => {

            console.log(res);

			if (res.status === "ok" || res.status === "updated") {

			    showMessage("✅ Opération réussie", "success");

			    const idreserv = getVal("idreserv");

			    setTimeout(() => {
			        window.location.href =
			            "/Cooperative-Manager/reservations/reservation.jsp";
			    }, 1200);

			} else {
                showMessage("❌ " + (res.message || "Erreur"), "error");
            }
        })
        .catch(err => {
            console.error(err);
            showMessage("❌ Erreur serveur", "error");
        });
}

/* ================= EDIT ================= */
function loadReservationForEdit(id) {

    fetch(API)
        .then(r => r.json())
        .then(data => {

            const x = data.find(i => i.idreserv == id);
            if (!x) return;

            set("idreserv", x.idreserv);
            set("idvoit", x.idvoit);
            set("idcli", x.idcli);
            set("place", x.place);
            set("dateVoyage", x.dateVoyage || x.date_voyage);
            set("payment", x.payment);
            set("montantAvance", x.montantAvance || x.montant_avance);

            document.getElementById("idreserv").readOnly = true;

            loadVoitureFrais();
            handlePayment();
        });
}

/* ================= DELETE ================= */
function deleteReservation(id) {

    if (!confirm("Supprimer cette réservation ?")) return;

    let data = new URLSearchParams();
    data.append("action", "delete");
    data.append("idreserv", id);

    fetch(API, { method: "POST", body: data })
        .then(r => r.json())
        .then(res => {

            if (res.status === "deleted") {
                loadReservation();
            } else {
                alert("❌ Erreur suppression");
            }
        });
}

/* ================= VOITURE FRAIS ================= */
function loadVoitureFrais() {

    const el = document.getElementById("idvoit");
    if (!el || !el.value) return;

    fetch(API + "?type=voitures")
        .then(r => r.json())
        .then(data => {

            const v = data.find(x => x.idvoit === el.value);

            if (v && v.frais) {
                fraisVoiture = Number(v.frais);
                handlePayment();
            }
        })
        .catch(err => console.error(err));
}

/* ================= PAYMENT ================= */
function handlePayment() {

    const paymentEl = document.getElementById("payment"); // ✅ FORM CORRECT
    const montant = document.getElementById("montantAvance");

    if (!paymentEl || !montant) return;

    const payment = paymentEl.value;

    if (payment === "tout payé") {

        montant.value = fraisVoiture;
        montant.disabled = true;

    } else if (payment === "sans avance") {

        montant.value = 0;
        montant.disabled = true;

    } else {

        montant.disabled = false;
    }
}

/* ================= UTIL ================= */
function getVal(id) {
    const el = document.getElementById(id);
    return el ? el.value : "";
}

function set(id, val) {
    const el = document.getElementById(id);
    if (el) el.value = val;
}

/* ================= NAV ================= */
function editReservation(id) {
    window.location.href =
        "/Cooperative-Manager/reservations/reservationForm.jsp?idreserv=" + id;
}
function generatePDF(id) {

    if (!id) {
        alert("ID invalide");
        return;
    }

    const url =
        "/Cooperative-Manager/pdf/recu?id=" + encodeURIComponent(id);

    window.open(url, "_blank");
}