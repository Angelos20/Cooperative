package com.cooperative.dao;

import com.cooperative.model.PlaceModel;
import com.cooperative.resources.database.DatabaseInitializer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaceDAO {

    /* =========================
       GET ALL (TRIÉ PROPREMENT)
    ========================= */
    public List<PlaceModel> getAll() throws Exception {

        List<PlaceModel> list = new ArrayList<>();

        String sql = """
            SELECT * 
            FROM place 
            ORDER BY idvoit ASC, place ASC
        """;

        try (Connection conn = DatabaseInitializer.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {

                list.add(new PlaceModel(
                        rs.getString("idvoit"),
                        rs.getInt("place"),
                        rs.getString("occupation")
                ));
            }
        }

        return list;
    }

    /* =========================
       FILTRE PAR VOITURE
    ========================= */
    public List<PlaceModel> getByVoiture(String idvoit) throws Exception {

        List<PlaceModel> list = new ArrayList<>();

        String sql = """
            SELECT * 
            FROM place 
            WHERE idvoit = ?
            ORDER BY place ASC
        """;

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(new PlaceModel(
                        rs.getString("idvoit"),
                        rs.getInt("place"),
                        rs.getString("occupation")
                ));
            }
        }

        return list;
    }

    /* =========================
       FILTRE OCCUPATION
    ========================= */
    public List<PlaceModel> getByOccupation(String occ) throws Exception {

        List<PlaceModel> list = new ArrayList<>();

        String sql = """
            SELECT * 
            FROM place 
            WHERE LOWER(occupation) = ?
            ORDER BY idvoit, place
        """;

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, occ.toLowerCase());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(new PlaceModel(
                        rs.getString("idvoit"),
                        rs.getInt("place"),
                        rs.getString("occupation")
                ));
            }
        }

        return list;
    }
}