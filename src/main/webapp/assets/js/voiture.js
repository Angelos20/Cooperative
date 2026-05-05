//voiture.js
const API = "/Cooperative-Manager/api/voiture";

document.addEventListener("DOMContentLoaded", () => {

    loadVoitures();

    const form = document.getElementById("voitureForm");
    const search = document.getElementById("search");

    // charger voiture si mode EDIT
    loadVoitureToForm();

    /* =============================
       SAVE / UPDATE
    ============================== */
    if (form) {

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            let idvoit = document.getElementById("idvoit").value;
            let design = document.getElementById("design").value;
            let type = document.getElementById("type").value;
            let nbrplace = document.getElementById("nbrplace").value;
            let frais = document.getElementById("frais").value;

            let action = idvoit && new URLSearchParams(window.location.search).get("id") 
                         ? "update" 
                         : "add";

            let data = new URLSearchParams();
            data.append("action", action);
            data.append("idvoit", idvoit);
            data.append("design", design);
            data.append("type", type);
            data.append("nbrplace", nbrplace);
            data.append("frais", frais);

            fetch(API, {
                method: "POST",
                body: data
            })
            .then(res => res.json())
            .then(result => {

                if (result.status === "ok") {

                    showMessage(
                        action === "update"
                            ? "✅ Voiture modifiée avec succès"
                            : "✅ Voiture ajoutée avec succès",
                        "success"
                    );

                    setTimeout(() => {
                        window.location.href = "voiture.jsp";
                    }, 1200);

                } else {
                    showMessage("❌ Erreur lors de l'enregistrement", "error");
                }

            })
            .catch(() => {
                showMessage("❌ Erreur serveur", "error");
            });

        });
    }

    /* =============================
       SEARCH
    ============================== */
    if (search) {
        search.addEventListener("keyup", function () {
            loadVoitures(this.value);
        });
    }

});


/* =============================
   LOAD VOITURES
============================= */
function loadVoitures(keyword = "") {

    let table = document.getElementById("voitureTable");
    if (!table) return;

    let url = API;

    if (keyword.trim() !== "") {
        url += "?search=" + encodeURIComponent(keyword);
    }

    fetch(url)
        .then(res => res.json())
        .then(data => {

            table.innerHTML = "";

            data.forEach(v => {

                table.innerHTML += `
                <tr>
                    <td>${v.idvoit}</td>
                    <td>${v.design}</td>
                    <td>${v.type}</td>
                    <td>${v.nbrplace}</td>
                    <td>${v.frais}</td>
                    <td>
                        <button onclick="editVoiture('${v.idvoit}')">✏️</button>
                        <button onclick="deleteVoiture('${v.idvoit}')">🗑️</button>
                    </td>
                </tr>
                `;
            });

        });
}


/* =============================
   EDIT VOITURE
============================= */
function editVoiture(id) {
    window.location.href = "voitureForm.jsp?id=" + id;
}


/* =============================
   LOAD FORM DATA (EDIT MODE)
============================= */
function loadVoitureToForm() {

    const id = new URLSearchParams(window.location.search).get("id");

    const idInput = document.getElementById("idvoit");
    if (!idInput) return;

    if (!id) return;

    fetch(API)
        .then(res => res.json())
        .then(data => {

            const v = data.find(x => x.idvoit == id);

            if (v) {
                document.getElementById("idvoit").value = v.idvoit;
                document.getElementById("design").value = v.design;
                document.getElementById("type").value = v.type;
                document.getElementById("nbrplace").value = v.nbrplace;
                document.getElementById("frais").value = v.frais;
            }

        });
}


/* =============================
   DELETE VOITURE
============================= */
function deleteVoiture(id) {

    if (!confirm("Supprimer cette voiture ?")) return;

    let data = new URLSearchParams();
    data.append("action", "delete");
    data.append("idvoit", id);

    fetch(API, {
        method: "POST",
        body: data
    })
    .then(() => loadVoitures());
}


/* =============================
   MESSAGE SYSTEM
============================= */
function showMessage(msg, type) {

    let box = document.getElementById("messageBox");
    if (!box) return;

    box.innerHTML = msg;
    box.className = type;
}