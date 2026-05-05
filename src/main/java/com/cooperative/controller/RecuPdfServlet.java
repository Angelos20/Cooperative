package com.cooperative.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.cooperative.dao.ReservationDAO;
import com.cooperative.model.ReservationModel;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/pdf/recu")
public class RecuPdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/pdf");

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.getWriter().println("ID manquant");
            return;
        }

        try {

            ReservationDAO dao = new ReservationDAO();
            ReservationModel r = dao.getById(id);

            if (r == null) {
                response.getWriter().println("Réservation introuvable");
                return;
            }

            // 🔥 NOM FICHIER SÉCURISÉ
            String safeName = r.getNomClient()
                    .replaceAll("[^a-zA-Z0-9]", "_");

            String filename = "recu_" + safeName + "_" + r.getIdreserv() + ".pdf";

            response.setHeader("Content-Disposition",
                    "inline; filename=\"" + filename + "\"");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Font normal = new Font(Font.FontFamily.HELVETICA, 12);

            Paragraph title = new Paragraph("Reçu N°" + r.getIdreserv(), titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            document.add(new Paragraph(" "));

            document.add(new Paragraph("Date réservation : " + r.getDateReserv(), normal));
            document.add(new Paragraph("Date voyage : " + r.getDateVoyage(), normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                "Client : " + r.getNomClient() + " / Contact : " + r.getContact(), normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                "Voiture N°" + r.getIdvoit() +
                " / Type : " + r.getTypeVoiture() +
                " / Place : " + r.getPlace(), normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph("Frais : " + r.getFrais() + " Ar", normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph("Paiement : " + r.getPayment(), normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                "Avance : " + r.getMontantAvance() +
                " Ar / Reste : " + r.getReste() + " Ar", normal));

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}