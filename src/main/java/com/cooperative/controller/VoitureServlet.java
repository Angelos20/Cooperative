package com.cooperative.controller;

import com.cooperative.dao.VoitureDAO;
import com.cooperative.model.VoitureModel;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/voiture")
public class VoitureServlet extends HttpServlet {

    private final VoitureDAO dao = new VoitureDAO();
    private final Gson gson = new Gson();

    /* =========================
       GET : LIST + SEARCH
    ========================= */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        try {

            String search = req.getParameter("search");

            List<VoitureModel> list;

            if (search != null && !search.trim().isEmpty()) {
                list = dao.searchVoitures(search);
            } else {
                list = dao.getAllVoitures();
            }

            res.getWriter().print(gson.toJson(list));

        } catch (Exception e) {
            res.setStatus(500);
            res.getWriter().print("{\"error\":\"server error\"}");
        }
    }

    /* =========================
       POST : CRUD
    ========================= */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        try {

            /* =========================
               ADD VOITURE + PLACES
            ========================= */
            if ("add".equals(action)) {

                VoitureModel v = new VoitureModel(
                        req.getParameter("idvoit"),
                        req.getParameter("design"),
                        req.getParameter("type"),
                        Integer.parseInt(req.getParameter("nbrplace")),
                        Integer.parseInt(req.getParameter("frais"))
                );

                dao.addVoiture(v);

                // 🔥 création automatique des places
                dao.createPlaces(v.getIdvoit(), v.getNbrplace());
            }

            /* =========================
               UPDATE VOITURE + PLACES
            ========================= */
            else if ("update".equals(action)) {

                VoitureModel v = new VoitureModel(
                        req.getParameter("idvoit"),
                        req.getParameter("design"),
                        req.getParameter("type"),
                        Integer.parseInt(req.getParameter("nbrplace")),
                        Integer.parseInt(req.getParameter("frais"))
                );

                dao.updateVoiture(v);

                // 🔥 recalcul des places
                dao.resetPlaces(v.getIdvoit(), v.getNbrplace());
            }

            /* =========================
               DELETE VOITURE + PLACES
            ========================= */
            else if ("delete".equals(action)) {

                String idvoit = req.getParameter("idvoit");

                // 🔥 supprimer places
                dao.deletePlacesByVoiture(idvoit);

                // supprimer voiture
                dao.deleteVoiture(idvoit);
            }

            res.getWriter().print("{\"status\":\"ok\"}");

        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(500);
            res.getWriter().print("{\"status\":\"error\"}");
        }
    }
}