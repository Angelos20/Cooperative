// app.js
// Gestion CLIENTS
// idcli = AUTO_INCREMENT -> ne jamais envoyer idcli en ADD

const API = "/Cooperative-Manager/api/client";

document.addEventListener("DOMContentLoaded", () => {

    loadClients();

    const form = document.getElementById("clientForm");
    const search = document.getElementById("search");

    // charger client si mode modification
    loadClientToForm();

    /* =============================
       SAVE / UPDATE
    ============================== */
    if (form) {

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const idcli = new URLSearchParams(window.location.search).get("id");
            const nom = document.getElementById("nom").value.trim();
            const telephone = document.getElementById("telephone").value.trim();

            const action = idcli ? "update" : "add";

            let data = new URLSearchParams();
            data.append("action", action);

            // seulement en mode UPDATE
            if (idcli) {
                data.append("idcli", idcli);
            }

            data.append("nom", nom);
            data.append("telephone", telephone);

            fetch(API, {
                method: "POST",
                body: data
            })
            .then(res => res.json())
            .then(result => {

                if (result.status === "ok") {

                    showMessage(
                        action === "update"
                            ? "✅ Client modifié avec succès"
                            : "✅ Client ajouté avec succès",
                        "success"
                    );

                    setTimeout(() => {
                        window.location.href = "client.jsp";
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
            loadClients(this.value);
        });
    }

});


/* =============================
   LOAD CLIENTS
============================= */
function loadClients(keyword = "") {

    const table = document.getElementById("clientTable");
    if (!table) return;

    let url = API;

    if (keyword.trim() !== "") {
        url += "?search=" + encodeURIComponent(keyword);
    }

    fetch(url)
        .then(res => res.json())
        .then(data => {

            table.innerHTML = "";

            data.forEach(c => {

                table.innerHTML += `
                <tr>
                    <td>${c.idcli}</td>
                    <td>${c.nom}</td>
                    <td>${c.telephone}</td>
                    <td>
                        <button class="btn_edit" onclick="editClient('${c.idcli}')">✏️</button>
                        <button class="btn_delete" onclick="deleteClient('${c.idcli}')">S🗑️</button>
                    </td>
                </tr>
                `;
            });

        });
}


/* =============================
   EDIT CLIENT
============================= */
function editClient(id) {
    window.location.href = "clientForm.jsp?id=" + id;
}


/* =============================
   LOAD FORM DATA (EDIT MODE)
============================= */
function loadClientToForm() {

    const id = new URLSearchParams(window.location.search).get("id");

    const nomInput = document.getElementById("nom");
    if (!nomInput) return;

    if (!id) return;

    fetch(API)
        .then(res => res.json())
        .then(data => {

            const c = data.find(x => x.idcli == id);

            if (c) {
                document.getElementById("nom").value = c.nom;
                document.getElementById("telephone").value = c.telephone;
            }

        });
}


/* =============================
   DELETE CLIENT
============================= */
function deleteClient(id) {

    if (!confirm("Supprimer ce client ?")) return;

    let data = new URLSearchParams();
    data.append("action", "delete");
    data.append("idcli", id);

    fetch(API, {
        method: "POST",
        body: data
    })
    .then(res => res.json())
    .then(result => {

        if (result.status === "ok") {
            showMessage("✅ Client supprimé", "success");
            loadClients();
        } else {
            showMessage("❌ Suppression échouée", "error");
        }

    })
    .catch(() => {
        showMessage("❌ Erreur serveur", "error");
    });
}


/* =============================
   MESSAGE SYSTEM
============================= */
function showMessage(msg, type) {

    const box = document.getElementById("messageBox");
    if (!box) return;

    box.innerHTML = msg;
    box.className = type;
}