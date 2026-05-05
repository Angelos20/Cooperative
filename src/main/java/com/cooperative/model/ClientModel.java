package com.cooperative.model;

public class ClientModel {
    private int idcli;
    private String nom;
    private String telephone;

    public ClientModel() {}

    public ClientModel(int idcli, String nom, String telephone) {
        this.idcli = idcli;
        this.nom = nom;
        this.telephone = telephone;
    }

    public ClientModel(String nom, String telephone) {
        this.nom = nom;
        this.telephone = telephone;
    }

    public int getIdcli() { return idcli; }
    public void setIdcli(int idcli) { this.idcli = idcli; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
}