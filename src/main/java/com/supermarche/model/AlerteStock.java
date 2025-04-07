package com.supermarche.model;

import java.sql.Timestamp; // Changé de java.security.Timestamp à java.sql.Timestamp

public class AlerteStock {
    private int idAlerte;
    private int idProduit;
    private String nomProduit;
    private int stockActuel;
    private int seuilAlerte;
    private String niveauAlerte;
    private Timestamp dateAlerte;
    private String statut;
    private Timestamp dateTraitement;

    // Un seul constructeur
    public AlerteStock(int idProduit, String nomProduit, int stockActuel,
                      int seuilAlerte, String niveauAlerte,
                      Timestamp dateAlerte, String statut) {
        this.idProduit = idProduit;
        this.nomProduit = nomProduit;
        this.stockActuel = stockActuel;
        this.seuilAlerte = seuilAlerte;
        this.niveauAlerte = niveauAlerte;
        this.dateAlerte = dateAlerte;
        this.statut = statut;
    }

    // Getters et Setters
    public int getIdAlerte() { return idAlerte; }
    public void setIdAlerte(int idAlerte) { this.idAlerte = idAlerte; }

    public int getIdProduit() { return idProduit; }
    public void setIdProduit(int idProduit) { this.idProduit = idProduit; }

    public String getNomProduit() { return nomProduit; }
    public void setNomProduit(String nomProduit) { this.nomProduit = nomProduit; }

    public int getStockActuel() { return stockActuel; }
    public void setStockActuel(int stockActuel) { this.stockActuel = stockActuel; }

    public int getSeuilAlerte() { return seuilAlerte; }
    public void setSeuilAlerte(int seuilAlerte) { this.seuilAlerte = seuilAlerte; }

    public String getNiveauAlerte() { return niveauAlerte; }
    public void setNiveauAlerte(String niveauAlerte) { this.niveauAlerte = niveauAlerte; }

    public Timestamp getDateAlerte() { return dateAlerte; }
    public void setDateAlerte(Timestamp dateAlerte) { this.dateAlerte = dateAlerte; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Timestamp getDateTraitement() { return dateTraitement; }
    public void setDateTraitement(Timestamp dateTraitement) { this.dateTraitement = dateTraitement; }

    @Override
    public String toString() {
        return "AlerteStock{" +
               "idAlerte=" + idAlerte +
               ", idProduit=" + idProduit +
               ", nomProduit='" + nomProduit + '\'' +
               ", stockActuel=" + stockActuel +
               ", seuilAlerte=" + seuilAlerte +
               ", niveauAlerte='" + niveauAlerte + '\'' +
               ", dateAlerte=" + dateAlerte +
               ", statut='" + statut + '\'' +
               ", dateTraitement=" + dateTraitement +
               '}';
    }
}