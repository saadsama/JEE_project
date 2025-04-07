package com.supermarche.dao;

import com.supermarche.model.Utilisateur;
import com.supermarche.model.Role;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UtilisateurDAO {

    private final Connection connection;

    private static final String SQL_INSERT_UTILISATEUR =
            "INSERT INTO utilisateur (nom, email, password, role) VALUES (?, ?, ?, ?)";
    private static final String SQL_SELECT_UTILISATEUR_PAR_ID =
            "SELECT * FROM utilisateur WHERE id = ?";
    private static final String SQL_SELECT_UTILISATEUR_PAR_EMAIL =
            "SELECT * FROM utilisateur WHERE email = ?";
    private static final String SQL_SELECT_UTILISATEURS =
            "SELECT * FROM utilisateur";
    private static final String SQL_UPDATE_UTILISATEUR =
            "UPDATE utilisateur SET nom = ?, email = ?, password = ?, role = ? WHERE id = ?";
    private static final String SQL_DELETE_UTILISATEUR =
            "DELETE FROM utilisateur WHERE id = ?";
    private static final String SQL_CHECK_EMAIL_UNIQUE =
            "SELECT COUNT(*) AS count FROM utilisateur WHERE email = ?";
    private static final String SQL_AUTHENTIFIER_UTILISATEUR =
            "SELECT * FROM utilisateur WHERE email = ? AND password = ?";

    public UtilisateurDAO() {
    	 try {
             this.connection = DatabaseConnection.getConnection();
             
         } catch (SQLException e) {
             System.err.println("Erreur de connexion : " + e.getMessage());
             throw new RuntimeException(e);
         }
     }

    // **1. Inscrire un utilisateur (vérifie l'unicité avant d'ajouter)**
    public void inscrireUtilisateur(Utilisateur utilisateur) throws SQLException {
        if (!isEmailUnique(utilisateur.getEmail())) {
            throw new SQLException("L'email est déjà utilisé : " + utilisateur.getEmail());
        }
        ajouterUtilisateur(utilisateur);
    }

    // **2. Ajouter un utilisateur**
    public void ajouterUtilisateur(Utilisateur utilisateur) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_INSERT_UTILISATEUR)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPassword()); // Mot de passe stocké en clair
            stmt.setString(4, utilisateur.getRole().name());
            stmt.executeUpdate();
        }
    }

    // **3. Obtenir un utilisateur par ID**
    public Optional<Utilisateur> obtenirUtilisateurParId(int id) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_SELECT_UTILISATEUR_PAR_ID)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToUtilisateur(rs));
                }
            }
        }
        return Optional.empty();
    }

    // **4. Obtenir un utilisateur par email**
    public Optional<Utilisateur> obtenirUtilisateurParEmail(String email) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_SELECT_UTILISATEUR_PAR_EMAIL)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToUtilisateur(rs));
                }
            }
        }
        return Optional.empty();
    }

    // **5. Authentifier un utilisateur**
    public Optional<Utilisateur> authentifierUtilisateur(String email, String password) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_AUTHENTIFIER_UTILISATEUR)) {
            stmt.setString(1, email);
            stmt.setString(2, password); // Vérification du mot de passe en clair
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToUtilisateur(rs));
                }
            }
        }
        return Optional.empty();
    }

    // **6. Lister tous les utilisateurs**
    public List<Utilisateur> listerUtilisateurs() throws SQLException {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(SQL_SELECT_UTILISATEURS);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                utilisateurs.add(mapResultSetToUtilisateur(rs));
            }
        }
        return utilisateurs;
    }

    // **7. Mettre à jour un utilisateur**
    public void mettreAJourUtilisateur(Utilisateur utilisateur) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_UPDATE_UTILISATEUR)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPassword()); // Mot de passe en clair
            stmt.setString(4, utilisateur.getRole().name());
            stmt.setInt(5, utilisateur.getId());
            stmt.executeUpdate();
        }
    }

    // **8. Supprimer un utilisateur**
    public void supprimerUtilisateur(int id) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_DELETE_UTILISATEUR)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // **9. Vérifier si un email est unique**
    public boolean isEmailUnique(String email) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(SQL_CHECK_EMAIL_UNIQUE)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") == 0;
                }
            }
        }
        return false;
    }

    // **10. Mapper un ResultSet vers un objet Utilisateur**
    private Utilisateur mapResultSetToUtilisateur(ResultSet rs) throws SQLException {
        return new Utilisateur(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("email"),
                rs.getString("password"),
                Role.fromString(rs.getString("role"))
        );
    }
}
