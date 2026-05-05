package com.cooperative.dao;

import com.cooperative.model.VoitureModel;
import com.cooperative.resources.database.DatabaseInitializer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoitureDAO {

    /* =========================
       CREATE VOITURE
    ========================= */
    public void addVoiture(VoitureModel v) throws Exception {

        String sql = "INSERT INTO voiture(idvoit, design, type, nbrplace, frais) VALUES(?,?,?,?,?)";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, v.getIdvoit());
            ps.setString(2, v.getDesign());
            ps.setString(3, v.getType());
            ps.setInt(4, v.getNbrplace());
            ps.setInt(5, v.getFrais());

            ps.executeUpdate();
        }
    }

    /* =========================
       READ ALL
    ========================= */
    public List<VoitureModel> getAllVoitures() throws Exception {

        List<VoitureModel> list = new ArrayList<>();

        String sql = "SELECT * FROM voiture";

        try (Connection conn = DatabaseInitializer.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new VoitureModel(
                        rs.getString("idvoit"),
                        rs.getString("design"),
                        rs.getString("type"),
                        rs.getInt("nbrplace"),
                        rs.getInt("frais")
                ));
            }
        }

        return list;
    }

    /* =========================
       SEARCH
    ========================= */
    public List<VoitureModel> searchVoitures(String keyword) throws Exception {

        List<VoitureModel> list = new ArrayList<>();

        String sql = "SELECT * FROM voiture WHERE design LIKE ? OR type LIKE ?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new VoitureModel(
                        rs.getString("idvoit"),
                        rs.getString("design"),
                        rs.getString("type"),
                        rs.getInt("nbrplace"),
                        rs.getInt("frais")
                ));
            }
        }

        return list;
    }

    /* =========================
       UPDATE VOITURE
    ========================= */
    public void updateVoiture(VoitureModel v) throws Exception {

        String sql = "UPDATE voiture SET design=?, type=?, nbrplace=?, frais=? WHERE idvoit=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, v.getDesign());
            ps.setString(2, v.getType());
            ps.setInt(3, v.getNbrplace());
            ps.setInt(4, v.getFrais());
            ps.setString(5, v.getIdvoit());

            ps.executeUpdate();
        }
    }

    /* =========================
       DELETE VOITURE
    ========================= */
    public void deleteVoiture(String idvoit) throws Exception {

        String sql = "DELETE FROM voiture WHERE idvoit=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idvoit);
            ps.executeUpdate();
        }
    }

    /* =========================
       GET BY ID
    ========================= */
    public VoitureModel getById(String idvoit) throws Exception {

        String sql = "SELECT * FROM voiture WHERE idvoit=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new VoitureModel(
                        rs.getString("idvoit"),
                        rs.getString("design"),
                        rs.getString("type"),
                        rs.getInt("nbrplace"),
                        rs.getInt("frais")
                );
            }
        }

        return null;
    }

    /* ======================================================
       🔥 PARTIE OBLIGATOIRE POUR TON PROJET (PLACE)
    ====================================================== */

    /* =========================
       CREATE PLACES AUTOMATIQUES
    ========================= */
    public void createPlaces(String idvoit, int nbrplace) throws Exception {

        String sql = "INSERT INTO place(idvoit, place, occupation) VALUES(?,?,?)";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 1; i <= nbrplace; i++) {
                ps.setString(1, idvoit);
                ps.setInt(2, i);
                ps.setString(3, "non"); // libre
                ps.executeUpdate();
            }
        }
    }

    /* =========================
       RESET PLACES (UPDATE VOITURE)
    ========================= */
    public void resetPlaces(String idvoit, int nbrplace) throws Exception {

        deletePlacesByVoiture(idvoit);
        createPlaces(idvoit, nbrplace);
    }

    /* =========================
       DELETE PLACES
    ========================= */
    public void deletePlacesByVoiture(String idvoit) throws Exception {

        String sql = "DELETE FROM place WHERE idvoit=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idvoit);
            ps.executeUpdate();
        }
    }

    /* =========================
       GET PLACES LIBRES
    ========================= */
    public List<Integer> getPlacesLibres(String idvoit) throws Exception {

        List<Integer> list = new ArrayList<>();

        String sql = "SELECT place FROM place WHERE idvoit=? AND occupation='non'";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("place"));
            }
        }

        return list;
    }
}