package com.supermarche.dao;

import com.supermarche.model.Categorie;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategorieDAO {

    private Connection connection;

    
    public CategorieDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }


    public void ajouterCategorie(Categorie categorie) {
        String sql = "INSERT INTO categorie (nom) VALUES (?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, categorie.getNom());
            stmt.executeUpdate();
            System.out.println("Catégorie ajoutée avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout de la catégorie !");
            e.printStackTrace();
        }
    }

  
    public Categorie obtenirCategorieParId(int id) {
        String sql = "SELECT * FROM categorie WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Categorie(rs.getInt("id"), rs.getString("nom"));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la catégorie !");
            e.printStackTrace();
        }
        return null;
    }

   
    public List<Categorie> listerCategories() {
        List<Categorie> categories = new ArrayList<>();
        String sql = "SELECT * FROM categorie";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categorie categorie = new Categorie(rs.getInt("id"), rs.getString("nom"));
                categories.add(categorie);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des catégories !");
            e.printStackTrace();
        }
        return categories;
    }


    public void mettreAJourCategorie(Categorie categorie) {
        String sql = "UPDATE categorie SET nom = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, categorie.getNom());
            stmt.setInt(2, categorie.getId());
            stmt.executeUpdate();
            System.out.println("Catégorie mise à jour avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de la catégorie !");
            e.printStackTrace();
        }
    }

 
    public void supprimerCategorie(int id) {
        String sql = "DELETE FROM categorie WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Catégorie supprimée avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de la catégorie !");
            e.printStackTrace();
        }
    }
}
