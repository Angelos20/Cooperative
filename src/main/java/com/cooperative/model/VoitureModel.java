package com.cooperative.model;

import java.io.Serializable;

public class VoitureModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private String idvoit;
    private String design;
    private String type;
    private int nbrplace;
    private int frais;

    public VoitureModel() {}

    public VoitureModel(String idvoit, String design, String type, int nbrplace, int frais) {
        this.idvoit = idvoit;
        this.design = design;
        this.type = type;
        this.nbrplace = nbrplace;
        this.frais = frais;
    }

    public String getIdvoit() {
        return idvoit;
    }

    public void setIdvoit(String idvoit) {
        this.idvoit = idvoit;
    }

    public String getDesign() {
        return design;
    }

    public void setDesign(String design) {
        this.design = design;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getNbrplace() {
        return nbrplace;
    }

    public void setNbrplace(int nbrplace) {
        if (nbrplace <= 0) {
            throw new IllegalArgumentException("nbrplace doit être > 0");
        }
        this.nbrplace = nbrplace;
    }

    public int getFrais() {
        return frais;
    }

    public void setFrais(int frais) {
        if (frais < 0) {
            throw new IllegalArgumentException("frais invalide");
        }
        this.frais = frais;
    }

    @Override
    public String toString() {
        return "VoitureModel{" +
                "idvoit='" + idvoit + '\'' +
                ", design='" + design + '\'' +
                ", type='" + type + '\'' +
                ", nbrplace=" + nbrplace +
                ", frais=" + frais +
                '}';
    }
}