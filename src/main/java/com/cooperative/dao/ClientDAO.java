package com.cooperative.dao;

import com.cooperative.model.ClientModel;
import com.cooperative.resources.database.DatabaseInitializer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientDAO {

    // =========================
    // CREATE
    // =========================
	public void ajouterClient(ClientModel c) throws Exception {
	    System.out.println("INSERT CLIENT EXECUTED");

	    String sql = "INSERT INTO client(idcli, nom, numtel) VALUES(?,?,?)";

	    try (Connection conn = DatabaseInitializer.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, c.getIdcli());
	        ps.setString(2, c.getNom());
	        ps.setString(3, c.getTelephone());

	        int rows = ps.executeUpdate();
	        System.out.println("ROWS INSERTED = " + rows);
	    }
	}
	public boolean exists(int idcli) throws Exception {

	    String sql = "SELECT idcli FROM client WHERE idcli=?";

	    try (Connection conn = DatabaseInitializer.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, idcli);
	        ResultSet rs = ps.executeQuery();

	        return rs.next();
	    }
	}

    // =========================
    // READ ALL
    // =========================
    public List<ClientModel> getAllClients() throws Exception {

        List<ClientModel> list = new ArrayList<>();

        String sql = "SELECT * FROM client";

        try (Connection conn = DatabaseInitializer.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new ClientModel(
                        rs.getInt("idcli"),
                        rs.getString("nom"),
                        rs.getString("numtel")
                ));
            }
        }

        return list;
    }

    // =========================
    // SEARCH (LIKE) ✅ IMPORTANT
    // =========================
    public List<ClientModel> searchClients(String keyword) throws Exception {

        List<ClientModel> list = new ArrayList<>();

        String sql = "SELECT * FROM client WHERE nom LIKE ? OR numtel LIKE ?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ClientModel(
                        rs.getInt("idcli"),
                        rs.getString("nom"),
                        rs.getString("numtel")
                ));
            }
        }

        return list;
    }

    // =========================
    // UPDATE
    // =========================
    public void updateClient(ClientModel c) throws Exception {

        String sql = "UPDATE client SET nom=?, numtel=? WHERE idcli=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getNom());
            ps.setString(2, c.getTelephone());
            ps.setInt(3, c.getIdcli());
            ps.executeUpdate();
        }
    }

    // =========================
    // DELETE
    // =========================
    public void deleteClient(int id) throws Exception {

        String sql = "DELETE FROM client WHERE idcli=?";

        try (Connection conn = DatabaseInitializer.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}