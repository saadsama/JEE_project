package com.supermarche.model;

import java.sql.Timestamp;
import java.util.List;

public class Panier {
    // Enum pour les statuts
    public static enum Statut {
        EN_COURS,
        EN_VALIDATION,
        FINALISE,
        FACTURE;
        
        // Méthode pour convertir une chaîne en Statut
        public static Statut fromString(String text) {
            for (Statut b : Statut.values()) {
                if (b.name().equalsIgnoreCase(text)) {
                    return b;
                }
            }
            throw new IllegalArgumentException("Statut inconnu: " + text);
        }
    }

    private int idPanier;
    private Timestamp dateCreation;
    private Statut statut;
    private List<PanierProduit> produits;

    // Constructeur par défaut
    public Panier() {}

    // Constructeur avec tous les champs
    public Panier(int idPanier, Timestamp dateCreation, Statut statut) {
        this.idPanier = idPanier;
        this.dateCreation = dateCreation;
        this.statut = statut;
    }

    // Getters et Setters
    public int getIdPanier() {
        return idPanier;
    }

    public void setIdPanier(int idPanier) {
        this.idPanier = idPanier;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Statut getStatut() {
        return statut;
    }

    public void setStatut(Statut statut) {
        this.statut = statut;
    }

    public List<PanierProduit> getProduits() {
        return produits;
    }

    public void setProduits(List<PanierProduit> produits) {
        this.produits = produits;
    }

    // Méthode pour convertir le statut en String
    public String getStatutAsString() {
        return statut != null ? statut.name() : null;
    }
}