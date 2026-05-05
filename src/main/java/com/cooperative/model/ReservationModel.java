package com.cooperative.model;

public class ReservationModel {

    private String idreserv;
    private String idvoit;
    private int idcli;
    private int place;

    private String dateReserv;
    private String dateVoyage;

    private String payment;
    private int montantAvance;

    private int reste;
    
 // 🔹 infos client
    private String nomClient;
    private String contact;

    // 🔹 infos voiture
    private String typeVoiture;
    private int frais;

    public ReservationModel() {
    }

    public ReservationModel(String idreserv, String idvoit, int idcli, int place,
                            String dateReserv, String dateVoyage,
                            String payment, int montantAvance) {

        this.idreserv = idreserv;
        this.idvoit = idvoit;
        this.idcli = idcli;
        this.place = place;
        this.dateReserv = dateReserv;
        this.dateVoyage = dateVoyage;
        this.payment = payment;
        this.montantAvance = montantAvance;
    }

    public String getIdreserv() {
        return idreserv;
    }

    public void setIdreserv(String idreserv) {
        this.idreserv = idreserv;
    }

    public String getIdvoit() {
        return idvoit;
    }

    public void setIdvoit(String idvoit) {
        this.idvoit = idvoit;
    }

    public int getIdcli() {
        return idcli;
    }

    public void setIdcli(int idcli) {
        this.idcli = idcli;
    }

    public int getPlace() {
        return place;
    }

    public void setPlace(int place) {
        this.place = place;
    }

    public String getDateReserv() {
        return dateReserv;
    }

    public void setDateReserv(String dateReserv) {
        this.dateReserv = dateReserv;
    }

    public String getDateVoyage() {
        return dateVoyage;
    }

    public void setDateVoyage(String dateVoyage) {
        this.dateVoyage = dateVoyage;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public int getMontantAvance() {
        return montantAvance;
    }

    public void setMontantAvance(int montantAvance) {
        this.montantAvance = montantAvance;
    }

    public int getReste() {
        return reste;
    }

    public void setReste(int reste) {
        this.reste = reste;
    }
    
    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getTypeVoiture() { return typeVoiture; }
    public void setTypeVoiture(String typeVoiture) { this.typeVoiture = typeVoiture; }

    public int getFrais() { return frais; }
    public void setFrais(int frais) { this.frais = frais; }
}