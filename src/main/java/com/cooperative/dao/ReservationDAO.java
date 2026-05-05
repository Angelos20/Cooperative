package com.cooperative.dao;

import com.cooperative.model.ClientModel;
import com.cooperative.model.ReservationModel;
import com.cooperative.model.VoitureModel;
import com.cooperative.resources.database.DatabaseInitializer;

import java.sql.*;
import java.util.*;

public class ReservationDAO {

    /* =========================
       VOITURES
    ========================= */
    public List<VoitureModel> getAllVoitures() {

        List<VoitureModel> list = new ArrayList<>();

        String sql = """
            SELECT idvoit, design, frais
            FROM voiture
            ORDER BY idvoit
        """;

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VoitureModel v = new VoitureModel();
                v.setIdvoit(rs.getString("idvoit"));
                v.setDesign(rs.getString("design"));
                v.setFrais(rs.getInt("frais"));
                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* =========================
       CLIENTS
    ========================= */
    public List<ClientModel> getAllClients() {

        List<ClientModel> list = new ArrayList<>();

        String sql = "SELECT idcli, nom FROM client ORDER BY idcli";

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClientModel c = new ClientModel();
                c.setIdcli(rs.getInt("idcli"));
                c.setNom(rs.getString("nom"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* =========================
       FRAIS VOITURE
    ========================= */
    public int getFraisVoiture(String idvoit) throws Exception {

        String sql = "SELECT frais FROM voiture WHERE idvoit=?";

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("frais");
            }
        }

        return 0;
    }

    /* =========================
       PLACE LIBRE
    ========================= */
    public boolean isPlaceLibre(Connection cn, String idvoit, int place) throws Exception {

        String sql = """
            SELECT occupation FROM place
            WHERE idvoit=? AND place=?
        """;

        try (PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, idvoit);
            ps.setInt(2, place);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return "non".equalsIgnoreCase(rs.getString("occupation"));
                }
            }
        }

        return false;
    }

    /* =========================
       NORMALISATION PAYMENT
    ========================= */
    private void normalizeMontant(ReservationModel r) throws Exception {

        int frais = getFraisVoiture(r.getIdvoit());

        if ("tout payé".equalsIgnoreCase(r.getPayment())) {
            r.setMontantAvance(frais);
        } else if ("sans avance".equalsIgnoreCase(r.getPayment())) {
            r.setMontantAvance(0);
        } else {
            if (r.getMontantAvance() < 0) r.setMontantAvance(0);
            if (r.getMontantAvance() > frais) r.setMontantAvance(frais);
        }
    }

    /* =========================
       AJOUT
    ========================= */
    public void ajouter(ReservationModel r) throws Exception {

        Connection cn = DatabaseInitializer.getConnection();
        cn.setAutoCommit(false);

        try {
            normalizeMontant(r);

            if (!isPlaceLibre(cn, r.getIdvoit(), r.getPlace())) {
                throw new Exception("Place déjà occupée.");
            }

            String sql = """
                INSERT INTO reserver
                (idreserv, idvoit, idcli, place, date_reserv,
                 date_voyage, payment, montant_avance)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;

            try (PreparedStatement ps = cn.prepareStatement(sql)) {

                ps.setString(1, r.getIdreserv());
                ps.setString(2, r.getIdvoit());
                ps.setInt(3, r.getIdcli());
                ps.setInt(4, r.getPlace());
                ps.setString(5, r.getDateReserv());
                ps.setString(6, r.getDateVoyage());
                ps.setString(7, r.getPayment());
                ps.setInt(8, r.getMontantAvance());

                ps.executeUpdate();
            }

            occuperPlace(cn, r.getIdvoit(), r.getPlace());

            cn.commit();

        } catch (Exception e) {
            cn.rollback();
            throw e;
        } finally {
            cn.close();
        }
    }

    /* =========================
       UPDATE (IMPORTANT)
    ========================= */
    public void update(ReservationModel r) throws Exception {

        Connection cn = DatabaseInitializer.getConnection();
        cn.setAutoCommit(false);

        try {
            normalizeMontant(r);

            // ancien état
            String oldVoit = null;
            int oldPlace = 0;

            String find = "SELECT idvoit, place FROM reserver WHERE idreserv=?";

            try (PreparedStatement ps = cn.prepareStatement(find)) {
                ps.setString(1, r.getIdreserv());

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        oldVoit = rs.getString("idvoit");
                        oldPlace = rs.getInt("place");
                    } else {
                        throw new Exception("Réservation introuvable.");
                    }
                }
            }

            boolean changePlace =
                    !oldVoit.equals(r.getIdvoit()) ||
                    oldPlace != r.getPlace();

            if (changePlace) {

                if (!isPlaceLibre(cn, r.getIdvoit(), r.getPlace())) {
                    throw new Exception("Nouvelle place déjà occupée.");
                }

                libererPlace(cn, oldVoit, oldPlace);
                occuperPlace(cn, r.getIdvoit(), r.getPlace());
            }

            String sql = """
                UPDATE reserver
                SET idvoit=?, idcli=?, place=?,
                    date_voyage=?, payment=?, montant_avance=?
                WHERE idreserv=?
            """;

            try (PreparedStatement ps = cn.prepareStatement(sql)) {

                ps.setString(1, r.getIdvoit());
                ps.setInt(2, r.getIdcli());
                ps.setInt(3, r.getPlace());
                ps.setString(4, r.getDateVoyage());
                ps.setString(5, r.getPayment());
                ps.setInt(6, r.getMontantAvance());
                ps.setString(7, r.getIdreserv());

                ps.executeUpdate();
            }

            cn.commit();

        } catch (Exception e) {
            cn.rollback();
            throw e;
        } finally {
            cn.close();
        }
    }

    /* =========================
       DELETE (IMPORTANT)
    ========================= */
    public void delete(String idreserv) throws Exception {

        Connection cn = DatabaseInitializer.getConnection();
        cn.setAutoCommit(false);

        try {

            String idvoit = null;
            int place = 0;

            String find = "SELECT idvoit, place FROM reserver WHERE idreserv=?";

            try (PreparedStatement ps = cn.prepareStatement(find)) {
                ps.setString(1, idreserv);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        idvoit = rs.getString("idvoit");
                        place = rs.getInt("place");
                    }
                }
            }

            String del = "DELETE FROM reserver WHERE idreserv=?";

            try (PreparedStatement ps = cn.prepareStatement(del)) {
                ps.setString(1, idreserv);
                ps.executeUpdate();
            }

            libererPlace(cn, idvoit, place);

            cn.commit();

        } catch (Exception e) {
            cn.rollback();
            throw e;
        } finally {
            cn.close();
        }
    }

    /* =========================
       LISTE RESERVATIONS
    ========================= */
    public List<ReservationModel> getAll() throws Exception {

        List<ReservationModel> list = new ArrayList<>();

        String sql = "SELECT * FROM reserver ORDER BY date_reserv DESC";

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                String idvoit = rs.getString("idvoit");
                int frais = getFraisVoiture(idvoit);
                int avance = rs.getInt("montant_avance");

                if ("tout payé".equalsIgnoreCase(rs.getString("payment"))) {
                    avance = frais;
                }

                int reste = Math.max(frais - avance, 0);

                ReservationModel r = new ReservationModel(
                        rs.getString("idreserv"),
                        idvoit,
                        rs.getInt("idcli"),
                        rs.getInt("place"),
                        rs.getString("date_reserv"),
                        rs.getString("date_voyage"),
                        rs.getString("payment"),
                        avance
                );

                r.setReste(reste);
                list.add(r);
            }
        }

        return list;
    }

    /* =========================
       PLACES LIBRES
    ========================= */
    public List<Integer> getPlacesLibres(String idvoit) throws Exception {

        List<Integer> list = new ArrayList<>();

        String sql = """
            SELECT place FROM place
            WHERE idvoit=? AND occupation='non'
            ORDER BY place
        """;

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("place"));
                }
            }
        }

        return list;
    }

    /* =========================
       HELPERS PLACE
    ========================= */
    private void occuperPlace(Connection cn, String idvoit, int place) throws Exception {

        String sql = "UPDATE place SET occupation='oui' WHERE idvoit=? AND place=?";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, idvoit);
            ps.setInt(2, place);
            ps.executeUpdate();
        }
    }

    private void libererPlace(Connection cn, String idvoit, int place) throws Exception {

        String sql = "UPDATE place SET occupation='non' WHERE idvoit=? AND place=?";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, idvoit);
            ps.setInt(2, place);
            ps.executeUpdate();
        }
    }

    /* =========================
       DASHBOARD TABLE
    ========================= */
    public List<Map<String, Object>> getPlacesEtat(String idvoit) throws Exception {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql = """
            SELECT idvoit, place, occupation
            FROM place
            WHERE idvoit=?
            ORDER BY place
        """;

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, idvoit);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> m = new HashMap<>();
                    m.put("idvoit", rs.getString("idvoit"));
                    m.put("place", rs.getInt("place"));
                    m.put("occupation", rs.getString("occupation"));

                    list.add(m);
                }
            }
        }

        return list;
    }
    
    /* =========================
    TOUTES LES PLACES TRIÉES
 ========================= */
    public List<Map<String,Object>> getAllPlaces() throws Exception {

        List<Map<String,Object>> list = new ArrayList<>();

        String sql = """
            SELECT
                idvoit AS idvoit,
                place AS place,
                occupation AS occupation
            FROM place
            ORDER BY idvoit, occupation, place
        """;

        try(Connection cn = DatabaseInitializer.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){

                Map<String,Object> row = new HashMap<>();

                row.put("idvoit", rs.getString("idvoit"));
                row.put("place", rs.getInt("place"));
                row.put("occupation", rs.getString("occupation"));

                list.add(row);
            }
        }

        return list;
 }
    
    
    /* =========================
    UNE RESERVATION PAR ID
 ========================= */
    public ReservationModel getById(String idreserv) throws Exception {

        String sql = """
            SELECT r.*, 
                   c.nom AS nomClient,
                   c.numtel AS contact,
                   v.type AS typeVoiture,
                   v.frais
            FROM reserver r
            JOIN client c ON r.idcli = c.idcli
            JOIN voiture v ON r.idvoit = v.idvoit
            WHERE r.idreserv = ?
        """;

        try (Connection cn = DatabaseInitializer.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, idreserv);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    int frais = rs.getInt("frais");
                    int avance = rs.getInt("montant_avance");

                    if ("tout payé".equalsIgnoreCase(rs.getString("payment"))) {
                        avance = frais;
                    }

                    int reste = Math.max(frais - avance, 0);

                    ReservationModel r = new ReservationModel(
                            rs.getString("idreserv"),
                            rs.getString("idvoit"),
                            rs.getInt("idcli"),
                            rs.getInt("place"),
                            rs.getString("date_reserv"),
                            rs.getString("date_voyage"),
                            rs.getString("payment"),
                            avance
                    );

                    // 🔥 NOUVEAUX CHAMPS
                    r.setNomClient(rs.getString("nomClient"));
                    r.setContact(rs.getString("contact"));
                    r.setTypeVoiture(rs.getString("typeVoiture"));
                    r.setFrais(frais);
                    r.setReste(reste);

                    return r;
                }
            }
        }

        return null;
    }
}