package com.cooperative.model;

public class PlaceModel {

    private String idvoit;
    private int place;
    private String occupation;

    public PlaceModel() {}

    public PlaceModel(String idvoit, int place, String occupation) {
        this.idvoit = idvoit;
        this.place = place;
        this.occupation = occupation;
    }

    public String getIdvoit() {
        return idvoit;
    }

    public void setIdvoit(String idvoit) {
        this.idvoit = idvoit;
    }

    public int getPlace() {
        return place;
    }

    public void setPlace(int place) {
        this.place = place;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    // 🔥 LOGIQUE PROPRE (IMPORTANT)
    public boolean isOccupe() {
        return occupation != null && occupation.equalsIgnoreCase("oui");
    }
}
