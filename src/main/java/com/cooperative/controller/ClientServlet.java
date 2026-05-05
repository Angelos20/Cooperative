package com.cooperative.controller;

import com.cooperative.dao.ClientDAO;
import com.cooperative.model.ClientModel;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/client")
public class ClientServlet extends HttpServlet {

    private final ClientDAO dao = new ClientDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("application/json");

        try {
            String search = req.getParameter("search");

            List<ClientModel> clients;

            if (search != null && !search.trim().isEmpty()) {
                clients = dao.searchClients(search);
            } else {
                clients = dao.getAllClients();
            }

            res.getWriter().print(gson.toJson(clients));

        } catch (Exception e) {
            res.setStatus(500);
            res.getWriter().print("{\"error\":\"server error\"}");
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
            switch (action) {

                case "add":
                    dao.ajouterClient(new ClientModel(
                        req.getParameter("nom"),
                        req.getParameter("telephone")
                    ));
                    break;

                case "update":
                    dao.updateClient(new ClientModel(
                        Integer.parseInt(req.getParameter("idcli")),
                        req.getParameter("nom"),
                        req.getParameter("telephone")
                    ));
                    break;

                case "delete":
                    dao.deleteClient(Integer.parseInt(req.getParameter("idcli")));
                    break;
            }

            res.getWriter().print("{\"status\":\"ok\"}");

        } catch (Exception e) {
            res.setStatus(500);
            res.getWriter().print("{\"status\":\"error\"}");
        }
    }
}