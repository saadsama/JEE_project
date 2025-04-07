package com.supermarche.dao;

import com.supermarche.model.Panier;
import com.supermarche.model.PanierProduit;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PanierDAO {
    private Connection connection;
    private PanierProduitDAO panierProduitDAO;
    
    public PanierDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
            this.panierProduitDAO = new PanierProduitDAO();
        } catch (SQLException e) {
            System.err.println("Erreur de connexion : " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    // Créer un nouveau panier
    public int creerPanier() throws SQLException {
        String sql = "INSERT INTO paniers (statut, dateCreation) VALUES (?, NOW())";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, Panier.Statut.EN_COURS.name());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected == 0) {
                throw new SQLException("Échec de la création du panier");
            }

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        
        throw new SQLException("Échec de la création du panier");
    }
    // Obtenir un panier par ID
    public Panier obtenirPanierParId(int idPanier) throws SQLException {
        String sql = "SELECT * FROM paniers WHERE idPanier = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Panier panier = mapResultSetToPanier(rs);
                    PanierProduitDAO panierProduitDAO = new PanierProduitDAO();
                    panier.setProduits(panierProduitDAO.listerProduitsDuPanier(idPanier));
                    return panier;
                }
            }
        }
        return null;
    }

    // Mettre à jour le statut d'un panier
    public void updateStatut(int idPanier, Panier.Statut newStatut) throws SQLException {
        String sql = "UPDATE paniers SET statut = ? WHERE idPanier = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newStatut.name());
            stmt.setInt(2, idPanier);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Panier non trouvé: " + idPanier);
            }
        }
    }

    // Finaliser un panier
    public void finaliserPanier(int idPanier) throws SQLException {
        Connection conn = null;
        try {
            conn = connection;
            conn.setAutoCommit(false);

            // Vérifier le statut actuel du panier
            Panier panier = obtenirPanierParId(idPanier);
            if (panier == null || panier.getStatut() != Panier.Statut.EN_VALIDATION) {
                throw new SQLException("Le panier ne peut pas être finalisé");
            }

            // Mettre à jour le statut à FINALISE
            updateStatut(idPanier, Panier.Statut.FINALISE);

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
            }
        }
    }
    // Supprimer un panier
    public void supprimerPanier(int idPanier) throws SQLException {
        String sql = "DELETE FROM paniers WHERE idPanier = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Aucun panier avec l'ID " + idPanier + " n'a été trouvé.");
            }
        }
    }

    // Lister tous les paniers avec pagination
    public List<Panier> listerPaniers(int limit, int offset) throws SQLException {
        List<Panier> paniers = new ArrayList<>();
        String sql = "SELECT * FROM paniers ORDER BY dateCreation DESC LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    paniers.add(mapResultSetToPanier(rs));
                }
            }
        }
        return paniers;
    }

    // Lister les paniers par statut
    public List<Panier> listerPaniersParStatut(Panier.Statut statut) throws SQLException {
        List<Panier> paniers = new ArrayList<>();
        String sql = "SELECT * FROM paniers WHERE statut = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, statut.name());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    paniers.add(mapResultSetToPanier(rs));
                }
            }
        }
        return paniers;
    }

    public List<Map<String, Object>> getPaniersWithDetailsPaginated(int offset, int limit) throws SQLException {
        List<Map<String, Object>> paniersDetails = new ArrayList<>();
        String sql = "SELECT p.*, " +
                     "(SELECT SUM(pp.quantite * pr.prix) " +
                     "FROM panierproduit pp " +
                     "JOIN produit pr ON pp.idProduit = pr.idProduit " +
                     "WHERE pp.idPanier = p.idPanier) as total " +
                     "FROM paniers p " +
                     "WHERE p.statut IN (?, ?) " +
                     "HAVING total > 0 " +
                     "ORDER BY p.dateCreation DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Panier.Statut.FINALISE.name());
            stmt.setString(2, Panier.Statut.FACTURE.name());
            stmt.setInt(3, limit);
            stmt.setInt(4, offset);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> detail = new HashMap<>();
                    Panier panier = mapResultSetToPanier(rs);
                    List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(panier.getIdPanier());
                    double total = rs.getDouble("total");
                    
                    detail.put("panier", panier);
                    detail.put("produits", produits);
                    detail.put("total", total);
                    
                    paniersDetails.add(detail);
                }
            }
        }
        return paniersDetails;
    }

    public int getTotalPaniers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM paniers WHERE statut IN (?, ?) AND " +
                     "idPanier IN (SELECT idPanier FROM panierproduit)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Panier.Statut.FINALISE.name());
            stmt.setString(2, Panier.Statut.FACTURE.name());
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
  

    // Lister les paniers validés
    public List<Panier> listerPaniersValides() throws SQLException {
        List<Panier> paniers = new ArrayList<>();
        String sql = "SELECT * FROM paniers WHERE statut = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Panier.Statut.FINALISE.name());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    paniers.add(mapResultSetToPanier(rs));
                }
            }
        }
        return paniers;
    }

    // Obtenir le dernier panier validé
    public Panier getDernierPanierValide() throws SQLException {
        String sql = "SELECT * FROM paniers WHERE statut = ? ORDER BY dateCreation DESC LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Panier.Statut.FINALISE.name());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPanier(rs);
                }
            }
        }
        return null;
    }

    // Rouvrir un panier validé
    public void rouvrirPanierValide(int idPanier) throws SQLException {
        updateStatut(idPanier, Panier.Statut.EN_COURS);
    }

    // Calculer le total d'un panier
    public double calculerTotalPanier(int idPanier) throws SQLException {
        String sql = "SELECT SUM(p.prix * pp.quantite) as total " +
                    "FROM panierproduit pp " +
                    "JOIN produit p ON pp.idProduit = p.idProduit " +
                    "WHERE pp.idPanier = ?";
                    
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        }
        return 0.0;
    }

    private Panier mapResultSetToPanier(ResultSet rs) throws SQLException {
        try {
            String statutDB = rs.getString("statut");
            Panier.Statut statut;
            
            // Gérer la conversion de manière explicite
            switch (statutDB) {
                case "EN_COURS":
                    statut = Panier.Statut.EN_COURS;
                    break;
                case "EN_VALIDATION":
                    statut = Panier.Statut.EN_VALIDATION;
                    break;
                case "FINALISE":
                    statut = Panier.Statut.FINALISE;
                    break;
                case "FACTURE":
                    statut = Panier.Statut.FACTURE;
                    break;
                default:
                    throw new IllegalArgumentException("Statut inconnu: " + statutDB);
            }

            return new Panier(
                rs.getInt("idPanier"),
                rs.getTimestamp("dateCreation"),
                statut
            );
        } catch (Exception e) {
            throw new SQLException("Erreur lors de la conversion du statut: " + 
                                 rs.getString("statut"), e);
        }
    }
 // Ajouter ces méthodes dans votre classe PanierDAO

    public Map<String, Object> getDetailsFacture(int idPanier) throws SQLException {
        // Vérifier si le panier est dans un état valide
        Panier panier = obtenirPanierParId(idPanier);
        if (panier == null || panier.getStatut() != Panier.Statut.FINALISE) {
            throw new SQLException("Panier non valide pour facturation");
        }

        Map<String, Object> factureDetails = new HashMap<>();
        factureDetails.put("panier", panier);
        factureDetails.put("totalHT", calculerTotalPanier(idPanier));
        factureDetails.put("tva", 0.20); // 20% TVA
        factureDetails.put("totalTTC", calculerTotalPanier(idPanier) * 1.20);
        factureDetails.put("dateFacture", new Timestamp(System.currentTimeMillis()));

        return factureDetails;
    }

    public void modifierPanierValide(int idPanier) throws SQLException {
        String sql = "UPDATE paniers SET statut = ? WHERE idPanier = ? AND statut = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Panier.Statut.EN_COURS.name());
            stmt.setInt(2, idPanier);
            stmt.setString(3, Panier.Statut.FINALISE.name());
            stmt.executeUpdate();
        }
    }

    public void updateStatut(int idPanier, String newStatut) throws SQLException {
        // Debug pour le statut
        System.out.println("Debug - Tentative de mise à jour du statut:");
        System.out.println("ID Panier: " + idPanier);
        System.out.println("Nouveau statut: " + newStatut);

        try {
            // Convertir le String en Enum
            Panier.Statut statutEnum = Panier.Statut.valueOf(newStatut);
            updateStatut(idPanier, statutEnum);
        } catch (IllegalArgumentException e) {
            throw new SQLException("Statut invalide : " + newStatut);
        }
    }
}