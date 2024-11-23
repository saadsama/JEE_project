package com.supermarche.dao;

import com.supermarche.model.Produit;
import com.supermarche.model.Categorie;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProduitDAO {

    private Connection connection;

    // Constructeur pour initialiser la connexion à la base de données
    public ProduitDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // **1. Ajouter un produit**
    public void ajouterProduit(Produit produit) {
        String sql = "INSERT INTO produit (nom, description, prix, stock, idCategorie) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setDouble(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());
            if (produit.getCategorie() != null) {
                stmt.setInt(5, produit.getCategorie().getId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            stmt.executeUpdate();
            System.out.println("Produit ajouté avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout du produit !");
            e.printStackTrace();
        }
    }

    // **2. Obtenir un produit par ID**
    public Produit obtenirProduitParId(int idProduit) {
        String sql = "SELECT p.*, c.nom AS categorie_nom FROM produit p " +
                     "LEFT JOIN categorie c ON p.idCategorie = c.id WHERE p.idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Categorie categorie = new Categorie(rs.getInt("idCategorie"), rs.getString("categorie_nom"));
                return new Produit(
                        rs.getInt("idProduit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("stock"),
                        categorie
                );
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du produit !");
            e.printStackTrace();
        }
        return null;
    }

    // **3. Mettre à jour un produit**
    public void mettreAJourProduit(Produit produit) {
        String sql = "UPDATE produit SET nom = ?, description = ?, prix = ?, stock = ?, idCategorie = ? WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setDouble(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());
            if (produit.getCategorie() != null) {
                stmt.setInt(5, produit.getCategorie().getId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            stmt.setInt(6, produit.getIdProduit());
            stmt.executeUpdate();
            System.out.println("Produit mis à jour avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du produit !");
            e.printStackTrace();
        }
    }

    // **4. Supprimer un produit**
    public void supprimerProduit(int idProduit) {
        String sql = "DELETE FROM produit WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            stmt.executeUpdate();
            System.out.println("Produit supprimé avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du produit !");
            e.printStackTrace();
        }
    }

    // **5. Lister tous les produits**
    public List<Produit> listerProduits() {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT p.*, c.nom AS categorie_nom FROM produit p " +
                     "LEFT JOIN categorie c ON p.idCategorie = c.id";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categorie categorie = new Categorie(rs.getInt("idCategorie"), rs.getString("categorie_nom"));
                Produit produit = new Produit(
                        rs.getInt("idProduit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("stock"),
                        categorie
                );
                produits.add(produit);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des produits !");
            e.printStackTrace();
        }
        return produits;
    }

    // product by name
    public List<Produit> rechercherProduitsParNom(String nom) {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT p.*, c.nom AS categorie_nom FROM produit p " +
                     "LEFT JOIN categorie c ON p.idCategorie = c.id WHERE p.nom LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + nom + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Categorie categorie = new Categorie(rs.getInt("idCategorie"), rs.getString("categorie_nom"));
                Produit produit = new Produit(
                        rs.getInt("idProduit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("stock"),
                        categorie
                );
                produits.add(produit);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche des produits !");
            e.printStackTrace();
        }
        return produits;
    }

    // **7. Mettre à jour le stock d'un produit**
    public void mettreAJourStock(int idProduit, int nouveauStock) {
        String sql = "UPDATE produit SET stock = ? WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, nouveauStock);
            stmt.setInt(2, idProduit);
            stmt.executeUpdate();
            System.out.println("Stock mis à jour avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du stock !");
            e.printStackTrace();
        }
    }
}

