package com.supermarche.model;

import java.sql.Timestamp;
import java.util.List;

public class Facture {
    // Constantes pour les statuts
    public static final String STATUT_EMISE = "EMISE";
    public static final String STATUT_PAYEE = "PAYEE";
    public static final String STATUT_ANNULEE = "ANNULEE";

    // Attributs
    private String panierStatut;
    private int idFacture;
    private int idPanier;
    private String numeroFacture;
    private Timestamp dateFacture;
    private double totalHT;
    private double totalTTC;
    private double tva;
    private List<PanierProduit> produits;
    private String statut;
    
    // Constructeurs
    public Facture() {}
    
    public Facture(int idPanier, String numeroFacture, Timestamp dateFacture, 
                  double totalHT, double totalTTC, double tva, String statut) {
        this.setIdPanier(idPanier);
        this.setNumeroFacture(numeroFacture);
        this.setDateFacture(dateFacture);
        this.setTotalHT(totalHT);
        this.setTotalTTC(totalTTC);
        this.setTva(tva);
        this.setStatut(statut);
    }
    
    // Getters et Setters avec validations
    public int getIdFacture() { 
        return idFacture; 
    }
    
    public void setIdFacture(int idFacture) { 
        if (idFacture <= 0) {
            throw new IllegalArgumentException("ID facture invalide");
        }
        this.idFacture = idFacture; 
    }
    
    public int getIdPanier() { 
        return idPanier; 
    }
    
    public void setIdPanier(int idPanier) { 
        if (idPanier <= 0) {
            throw new IllegalArgumentException("ID panier invalide");
        }
        this.idPanier = idPanier; 
    }
    
    public String getNumeroFacture() { 
        return numeroFacture; 
    }
    
    public void setNumeroFacture(String numeroFacture) {
        if (numeroFacture == null || numeroFacture.trim().isEmpty()) {
            throw new IllegalArgumentException("Numéro de facture invalide");
        }
        this.numeroFacture = numeroFacture;
    }
    
    public Timestamp getDateFacture() { 
        return dateFacture; 
    }
    
    public void setDateFacture(Timestamp dateFacture) {
        if (dateFacture == null) {
            throw new IllegalArgumentException("Date de facture invalide");
        }
        this.dateFacture = dateFacture;
    }
    
    public double getTotalHT() { 
        return totalHT; 
    }
    
    public void setTotalHT(double totalHT) {
        if (totalHT < 0) {
            throw new IllegalArgumentException("Total HT ne peut pas être négatif");
        }
        this.totalHT = totalHT;
    }
    
    public double getTotalTTC() { 
        return totalTTC; 
    }
    
    public void setTotalTTC(double totalTTC) {
        if (totalTTC < 0) {
            throw new IllegalArgumentException("Total TTC ne peut pas être négatif");
        }
        this.totalTTC = totalTTC;
    }
    
    public double getTva() { 
        return tva; 
    }
    
    public void setTva(double tva) {
        if (tva < 0 || tva > 1) {
            throw new IllegalArgumentException("TVA doit être entre 0 et 1");
        }
        this.tva = tva;
    }
    
    public List<PanierProduit> getProduits() { 
        return produits; 
    }
    
    public void setProduits(List<PanierProduit> produits) {
        this.produits = produits;
    }
    
    public String getStatut() { 
        return statut; 
    }
    
    public void setStatut(String statut) {
        if (statut == null || statut.trim().isEmpty()) {
            throw new IllegalArgumentException("Statut invalide");
        }
        if (!statut.equals(STATUT_EMISE) && 
            !statut.equals(STATUT_PAYEE) && 
            !statut.equals(STATUT_ANNULEE)) {
            throw new IllegalArgumentException("Statut non reconnu");
        }
        this.statut = statut;
    }

    // Méthodes métier
    public void calculerTotaux() {
        if (this.produits == null || this.produits.isEmpty()) {
            throw new IllegalStateException("Impossible de calculer les totaux sans produits");
        }
        this.totalHT = this.produits.stream()
                           .mapToDouble(p -> p.getQuantite() * p.getProduit().getPrix())
                           .sum();
        this.totalTTC = this.totalHT * (1 + this.tva);
    }

    public boolean estModifiable() {
        return STATUT_EMISE.equals(this.statut);
    }

    // Méthode toString pour le débogage
    @Override
    public String toString() {
        return "Facture{" +
               "id=" + idFacture +
               ", numero='" + numeroFacture + '\'' +
               ", date=" + dateFacture +
               ", totalTTC=" + totalTTC +
               ", statut='" + statut + '\'' +
               '}';
    }

	public String getPanierStatut() {
		return panierStatut;
	}

	public void setPanierStatut(String panierStatut) {
		this.panierStatut = panierStatut;
	}
}