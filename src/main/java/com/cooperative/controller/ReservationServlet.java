package com.cooperative.controller;

import com.cooperative.dao.ReservationDAO;
import com.cooperative.model.ReservationModel;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/api/reservation")
public class ReservationServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setCharacterEncoding("UTF-8");
        res.setContentType("application/json");

        String type = req.getParameter("type");

        try {

            /* ================= VOITURES ================= */
            if ("voitures".equalsIgnoreCase(type)) {
                res.getWriter().print(gson.toJson(dao.getAllVoitures()));
                return;
            }

            /* ================= CLIENTS ================= */
            if ("clients".equalsIgnoreCase(type)) {
                res.getWriter().print(gson.toJson(dao.getAllClients()));
                return;
            }
            
            /* ================= ALL PLACES ================= */
            if ("allplaces".equalsIgnoreCase(type)) {
                res.getWriter().print(gson.toJson(dao.getAllPlaces()));
                return;
            }

            /* ================= PLACES LIBRES (COMBOBOX) ================= */
            if ("places".equalsIgnoreCase(type)) {

                String idvoit = safeString(req.getParameter("idvoit"));

                res.getWriter().print(
                        gson.toJson(dao.getPlacesLibres(idvoit))
                );
                return;
            }

            /* ================= TABLE DASHBOARD (ETAT COMPLET) ================= */
            if ("placesEtat".equalsIgnoreCase(type)) {

                String idvoit = req.getParameter("idvoit");

                // IMPORTANT : si null => toutes voitures
                if (idvoit == null || idvoit.trim().isEmpty()) {
                    res.getWriter().print("[]");
                    return;
                }

                res.getWriter().print(
                        gson.toJson(dao.getPlacesEtat(idvoit))
                );
                return;
            }

            /* ================= RESERVATIONS ================= */
            res.getWriter().print(gson.toJson(dao.getAll()));

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().print("[]");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("application/json");

        String action = req.getParameter("action");

        try {

            /* ================= ADD ================= */
            if ("add".equalsIgnoreCase(action)) {

                String payment = safeString(req.getParameter("payment"));

                if (!payment.equals("sans avance") &&
                    !payment.equals("avec avance") &&
                    !payment.equals("tout payé")) {

                    send(res, "error", "Payment invalide");
                    return;
                }

                ReservationModel r = new ReservationModel(
                        safeString(req.getParameter("idreserv")),
                        safeString(req.getParameter("idvoit")),
                        safeInt(req.getParameter("idcli")),
                        safeInt(req.getParameter("place")),
                        safeString(req.getParameter("dateReserv")),
                        safeString(req.getParameter("dateVoyage")),
                        payment,
                        safeInt(req.getParameter("montantAvance"))
                );

                dao.ajouter(r);

                send(res, "ok", "Réservation ajoutée");
            }

            /* ================= UPDATE ================= */
            else if ("update".equalsIgnoreCase(action)) {

                ReservationModel r = new ReservationModel(
                        safeString(req.getParameter("idreserv")),
                        safeString(req.getParameter("idvoit")),
                        safeInt(req.getParameter("idcli")),
                        safeInt(req.getParameter("place")),
                        safeString(req.getParameter("dateReserv")),
                        safeString(req.getParameter("dateVoyage")),
                        safeString(req.getParameter("payment")),
                        safeInt(req.getParameter("montantAvance"))
                );

                dao.update(r);

                send(res, "updated", "Réservation modifiée");
            }

            /* ================= DELETE ================= */
            else if ("delete".equalsIgnoreCase(action)) {

                String idreserv = safeString(req.getParameter("idreserv"));

                if (idreserv.isEmpty()) {
                    send(res, "error", "ID manquant");
                    return;
                }

                dao.delete(idreserv);

                send(res, "deleted", "Réservation supprimée");
            }

            else {
                send(res, "error", "Action inconnue");
            }

        } catch (Exception e) {
            e.printStackTrace();
            send(res, "error", e.getMessage());
        }
    }

    /* ================= UTIL ================= */
    private void send(HttpServletResponse res, String status, String message)
            throws IOException {

        res.getWriter().print(
                gson.toJson(Map.of(
                        "status", status,
                        "message", message
                ))
        );
    }

    private int safeInt(String v) {
        try {
            return (v == null || v.isEmpty()) ? 0 : Integer.parseInt(v.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    private String safeString(String v) {
        return (v == null) ? "" : v.trim();
    }
}