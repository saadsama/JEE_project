package com.supermarche.dao;

import com.supermarche.model.Utilisateur;
import com.supermarche.model.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO {

    private Connection connection;

    // construt de cnx a bd
    public UtilisateurDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }
    public void inscrireUtilisateur(Utilisateur utilisateur) {
        String sql = "INSERT INTO utilisateur (nom, email, password, role) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPassword()); // Vous pouvez appliquer un hash ici
            stmt.setString(4, utilisateur.getRole().name());
            stmt.executeUpdate();
            System.out.println("Utilisateur inscrit avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'inscription de l'utilisateur !");
            e.printStackTrace();
        }
    }
    
    public Utilisateur authentifierUtilisateur(String email, String password) {
        String sql = "SELECT * FROM utilisateur WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password); // Assurez-vous que le mot de passe est haché de manière cohérente
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Utilisateur(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("email"),
                    rs.getString("password"),
                    Role.fromString(rs.getString("role"))
                );
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'authentification !");
            e.printStackTrace();
        }
        return null;
    }



   
    public void ajouterUtilisateur(Utilisateur utilisateur) {
        String sql = "INSERT INTO utilisateur (nom, email, password, role) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPassword());
            stmt.setString(4, utilisateur.getRole().name()); // Stringuify role
            stmt.executeUpdate();
            System.out.println("Utilisateur ajouté avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout de l'utilisateur !");
            e.printStackTrace();
        }
    }

    // get user by ID
    public Utilisateur obtenirUtilisateurParId(int id) {
        String sql = "SELECT * FROM utilisateur WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.fromString(rs.getString("role")) 
                );
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de l'utilisateur !");
            e.printStackTrace();
        }
        return null;
    }

    // update user
    public void mettreAJourUtilisateur(Utilisateur utilisateur) {
        String sql = "UPDATE utilisateur SET nom = ?, email = ?, password = ?, role = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPassword());
            stmt.setString(4, utilisateur.getRole().name()); 
            stmt.setInt(5, utilisateur.getId());
            stmt.executeUpdate();
            System.out.println("Utilisateur mis à jour avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de l'utilisateur !");
            e.printStackTrace();
        }
    }

    // m7ih
    public void supprimerUtilisateur(int id) {
        String sql = "DELETE FROM utilisateur WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Utilisateur supprimé avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'utilisateur !");
            e.printStackTrace();
        }
    }

    // liste dial users
    public List<Utilisateur> listerUtilisateurs() {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String sql = "SELECT * FROM utilisateur";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Utilisateur utilisateur = new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.fromString(rs.getString("role")) 
                );
                utilisateurs.add(utilisateur);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la liste des utilisateurs !");
            e.printStackTrace();
        }
        return utilisateurs;
    }
}
