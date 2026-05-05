package com.cooperative.controller;

import com.cooperative.dao.PlaceDAO;
import com.cooperative.model.PlaceModel;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/place")
public class PlaceServlet extends HttpServlet {

    private PlaceDAO dao;
    private final Gson gson = new Gson();

    @Override
    public void init() {
        dao = new PlaceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");

        try {

            List<PlaceModel> list;

            /* =========================
               ALL PLACES (trié)
            ========================= */
            if (type == null || type.equals("all")) {

                list = dao.getAll();

            }

            /* =========================
               FILTRE PAR VOITURE
            ========================= */
            else if ("byVoiture".equals(type)) {

                String idvoit = req.getParameter("idvoit");

                list = dao.getByVoiture(idvoit);

            }

            /* =========================
               FILTRE OCCUPATION
            ========================= */
            else if ("byOccupation".equals(type)) {

                String occ = req.getParameter("occupation");

                list = dao.getByOccupation(occ);

            }

            /* =========================
               FALLBACK
            ========================= */
            else {
                list = List.of(); // vide propre
            }

            /* =========================
               JSON RESPONSE UNIQUE
            ========================= */
            resp.getWriter().print(gson.toJson(list));

        } catch (Exception e) {
            e.printStackTrace();

            resp.setStatus(500);
            resp.getWriter().print("[]");
        }
    }
}