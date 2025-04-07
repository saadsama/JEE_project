package com.supermarche.dao;

import com.supermarche.model.AlerteStock;
import com.supermarche.model.Facture;
import com.supermarche.model.Produit;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ProduitDAO {

    private Connection connection;

    public ProduitDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            System.err.println("Erreur de connexion : " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    
    private static final int SEUIL_CRITIQUE = 5;
    private static final int SEUIL_ALERTE = 10;

    // Méthode pour vérifier et créer une alerte si nécessaire
    public void verifierEtCreerAlerte(int idProduit) throws SQLException {
        String sql = "SELECT stock FROM produit WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int stockActuel = rs.getInt("stock");
                String niveauAlerte = determinerNiveauAlerte(stockActuel);
                
                if (!niveauAlerte.equals("NORMAL")) {
                    creerAlerte(idProduit, stockActuel, niveauAlerte);
                }
            }
        }
    }

    // Déterminer le niveau d'alerte en fonction du stock
    private String determinerNiveauAlerte(int stock) {
        if (stock <= SEUIL_CRITIQUE) return "CRITIQUE";
        if (stock <= SEUIL_ALERTE) return "ALERTE";
        return "NORMAL";
    }

    // Créer une alerte dans la base de données
    private void creerAlerte(int idProduit, int stockActuel, String niveauAlerte) throws SQLException {
        String sql = "INSERT INTO alertes_stock (id_produit, stock_actuel, niveau_alerte, date_alerte, statut) " +
                    "VALUES (?, ?, ?, NOW(), 'ACTIVE')";
                    
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            stmt.setInt(2, stockActuel);
            stmt.setString(3, niveauAlerte);
            stmt.executeUpdate();
        }
    }

    // Récupérer les alertes actives
    public List<AlerteStock> getAlertesActives() throws SQLException {
        List<AlerteStock> alertes = new ArrayList<>();
        String sql = "SELECT a.*, p.nom as nom_produit, p.seuil_critique, p.seuil_alerte " +
                    "FROM alertes_stock a " +
                    "JOIN produit p ON a.id_produit = p.idProduit " +
                    "WHERE a.statut = 'ACTIVE' " +
                    "ORDER BY CASE a.niveau_alerte " +
                    "    WHEN 'CRITIQUE' THEN 1 " +
                    "    WHEN 'ALERTE' THEN 2 " +
                    "    ELSE 3 END, " +
                    "a.date_alerte DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                AlerteStock alerte = new AlerteStock(
                    rs.getInt("id_produit"),
                    rs.getString("nom_produit"),
                    rs.getInt("stock_actuel"),
                    rs.getString("niveau_alerte").equals("CRITIQUE") ? 
                        rs.getInt("seuil_critique") : rs.getInt("seuil_alerte"),
                    rs.getString("niveau_alerte"),
                    rs.getTimestamp("date_alerte"),
                    rs.getString("statut")
                );
                // Définir d'autres propriétés si nécessaire
                alerte.setIdAlerte(rs.getInt("id"));
                alerte.setDateTraitement(rs.getTimestamp("date_traitement"));
                alertes.add(alerte);
            }
        }
        return alertes;
    }

    // Marquer une alerte comme traitée
    public void marquerAlerteCommeTraitee(int idAlerte) throws SQLException {
        String sql = "UPDATE alertes_stock SET statut = 'TRAITEE', date_traitement = NOW() WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idAlerte);
            stmt.executeUpdate();
        }
    }

    // Obtenir les statistiques des alertes
    public Map<String, Object> getStatistiquesAlertes() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT niveau_alerte, COUNT(*) as nombre " +
                    "FROM alertes_stock " +
                    "WHERE statut = 'ACTIVE' " +
                    "GROUP BY niveau_alerte";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString("niveau_alerte"), rs.getInt("nombre"));
            }
        }
        return stats;
    }


    public void ajouterProduit(Produit produit) {
        String sql = "INSERT INTO produit (nom, description, prix, stock) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setDouble(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());
            stmt.executeUpdate();
            System.out.println("Produit ajouté avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout du produit !");
            e.printStackTrace();
        }
    }

    public Produit obtenirProduitParId(int idProduit) {
        String sql = "SELECT * FROM produit WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Produit(
                    rs.getInt("idProduit"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getInt("stock")
                );
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du produit !");
            e.printStackTrace();
        }
        return null;
    }

    public void mettreAJourProduit(Produit produit) {
        String sql = "UPDATE produit SET nom = ?, description = ?, prix = ?, stock = ? WHERE idProduit = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setDouble(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());
            stmt.setInt(5, produit.getIdProduit());
            stmt.executeUpdate();
            System.out.println("Produit mis à jour avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du produit !");
            e.printStackTrace();
        }
    }

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

    public List<Produit> listerProduits() {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT * FROM produit";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Produit produit = new Produit(
                    rs.getInt("idProduit"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getInt("stock")
                );
                produits.add(produit);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des produits !");
            e.printStackTrace();
        }
        return produits;
    }

    public List<Produit> rechercherProduitsParNom(String nom) {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT * FROM produit WHERE nom LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + nom + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Produit produit = new Produit(
                    rs.getInt("idProduit"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getInt("stock")
                );
                produits.add(produit);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche des produits !");
            e.printStackTrace();
        }
        return produits;
    }

    public void mettreAJourStock(int idProduit, int nouveauStock) throws SQLException {
        String sql = "UPDATE produit SET stock = ? WHERE idProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, nouveauStock);
            stmt.setInt(2, idProduit);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Produit non trouvé ou stock non modifié");
            }
        }
    }
    
    public int getStockActuel(int idProduit) throws SQLException {
        String sql = "SELECT stock FROM produit WHERE idProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idProduit);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("stock");
                }
                throw new SQLException("Produit non trouvé");
            }
        }
    }
    
    public int compterProduitsSousStockCritique(int seuilCritique) throws SQLException {
        String sql = "SELECT COUNT(*) FROM produit WHERE stock <= ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seuilCritique);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            return 0;
        }
    }

    public List<Produit> listerProduitsSousStockCritique(int seuilCritique) throws SQLException {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT * FROM produit WHERE stock <= ? ORDER BY stock ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seuilCritique);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Produit produit = new Produit();
                    produit.setIdProduit(rs.getInt("idProduit"));
                    produit.setNom(rs.getString("nom"));
                    produit.setStock(rs.getInt("stock"));
                    produit.setPrix(rs.getDouble("prix"));
                    produits.add(produit);
                }
            }
            return produits;
        }
    }
 // Ajouter cette méthode dans la classe ProduitDAO
    public int compterProduits() throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM produit";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des produits : " + e.getMessage());
            throw e;
        }
    }
    
   
     
}