package com.supermarche.model;

public class PanierProduit {
    private int idPanierProduit;
    private int idPanier;
    private Produit produit;
    private int quantite;

    public PanierProduit() {}

    public PanierProduit(int idPanierProduit, int idPanier, Produit produit, int quantite) {
        this.idPanierProduit = idPanierProduit;
        this.idPanier = idPanier;
        this.produit = produit;
        this.quantite = quantite;
    }

    public int getIdPanierProduit() {
        return idPanierProduit;
    }

    public void setIdPanierProduit(int idPanierProduit) {
        this.idPanierProduit = idPanierProduit;
    }

    public int getIdPanier() {
        return idPanier;
    }

    public void setIdPanier(int idPanier) {
        this.idPanier = idPanier;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
}
