package com.supermarche.dao;

import com.supermarche.model.Facture;
import com.supermarche.model.PanierProduit;
import com.supermarche.model.Produit;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FactureDAO {
    private Connection connection;
    
    public static final String STATUT_EMISE = "EMISE";
    public static final String STATUT_PAYEE = "PAYEE";
    public static final String STATUT_ANNULEE = "ANNULEE";

    public FactureDAO() throws SQLException {
    	 this.connection = DatabaseConnection.getConnection();
    }

    public int creerFacture(Facture facture) throws SQLException {
        String sql = "INSERT INTO factures (idPanier, numeroFacture, dateFacture, totalHT, totalTTC, tva, statut) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, facture.getIdPanier());
            stmt.setString(2, genererNumeroFacture());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setDouble(4, facture.getTotalHT());
            stmt.setDouble(5, facture.getTotalTTC());
            stmt.setDouble(6, facture.getTva());
            stmt.setString(7, STATUT_EMISE);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("La création de la facture a échoué");
            }

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int idFacture = rs.getInt(1);
                    facture.setIdFacture(idFacture);
                    return idFacture;
                }
            }
        }
        
        throw new SQLException("Erreur lors de la création de la facture");
    }
    
    private String genererNumeroFacture() throws SQLException {
        String sql = "SELECT COUNT(*) + 1 as next_num FROM factures";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int nextNum = rs.getInt("next_num");
                return String.format("FACT-%d-%tY%<tm%<td", nextNum, new java.util.Date());
            }
        }
        throw new SQLException("Erreur lors de la génération du numéro de facture");
    }

    public Facture getFactureById(int idFacture) throws SQLException {
        String sql = "SELECT * FROM factures WHERE idFacture = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idFacture);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFacture(rs);
                }
            }
        }
        return null;
    }

    public List<Facture> getFacturesByPanier(int idPanier) throws SQLException {
        List<Facture> factures = new ArrayList<>();
        String sql = "SELECT * FROM factures WHERE idPanier = ? ORDER BY dateFacture DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idPanier);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Log pour débogage
                    System.out.println("Facture trouvée pour panier " + idPanier);
                    factures.add(mapResultSetToFacture(rs));
                }
                
                // Log si aucune facture
                if (factures.isEmpty()) {
                    System.out.println("Aucune facture trouvée pour le panier " + idPanier);
                }
            }
        }
        
        return factures;
    }


    public void supprimerFacture(int idFacture) throws SQLException {
        String sql = "DELETE FROM factures WHERE idFacture = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idFacture);
            stmt.executeUpdate();
        }
    }

    private Facture mapResultSetToFacture(ResultSet rs) throws SQLException {
        Facture facture = new Facture();
        facture.setIdFacture(rs.getInt("idFacture"));
        facture.setIdPanier(rs.getInt("idPanier"));
        facture.setNumeroFacture(rs.getString("numeroFacture"));
        facture.setDateFacture(rs.getTimestamp("dateFacture"));
        facture.setTotalHT(rs.getDouble("totalHT"));
        facture.setTotalTTC(rs.getDouble("totalTTC"));
        facture.setTva(rs.getDouble("tva"));
        
        // Gestion sécurisée du statut
        String statut = rs.getString("statut");
        try {
            facture.setStatut(statut);
        } catch (IllegalArgumentException e) {
            // En cas de statut invalide, utiliser le statut par défaut
            facture.setStatut(Facture.STATUT_EMISE);
        }
        
        return facture;
    }
    public List<Facture> getFacturesWithPagination(int offset, int limit) throws SQLException {
    	   List<Facture> factures = new ArrayList<>();
    	   String sql = "SELECT f.*, p.statut as panierStatut " +
    	                "FROM factures f " +
    	                "JOIN paniers p ON f.idPanier = p.idPanier " +
    	                "ORDER BY f.dateFacture DESC " + 
    	                "LIMIT ? OFFSET ?";

    	   try (Connection conn = DatabaseConnection.getConnection();
    	        PreparedStatement stmt = conn.prepareStatement(sql)) {
    	       
    	       stmt.setInt(1, limit);
    	       stmt.setInt(2, offset);

    	       try (ResultSet rs = stmt.executeQuery()) {
    	           while (rs.next()) {
    	               Facture facture = mapResultSetToFacture(rs);
    	               facture.setPanierStatut(rs.getString("panierStatut"));
    	               factures.add(facture);
    	           }
    	       }
    	   }
    	   return factures;
    	}

    	public int getTotalFactures() throws SQLException {
    	   String sql = "SELECT COUNT(*) FROM factures";
    	   try (Connection conn = DatabaseConnection.getConnection();
    	        PreparedStatement stmt = conn.prepareStatement(sql);
    	        ResultSet rs = stmt.executeQuery()) {
    	       return rs.next() ? rs.getInt(1) : 0;
    	   }
    	}

    public void mettreAJourStatut(int idFacture, String nouveauStatut) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Récupérer la facture
            Facture facture = getFactureById(idFacture);
            if (facture == null) {
                throw new SQLException("Facture non trouvée");
            }

            // Vérifier si le statut change à ANNULEE
            if (nouveauStatut.equals(STATUT_ANNULEE)) {
                // Récupérer les produits du panier associé
                PanierProduitDAO panierProduitDAO = new PanierProduitDAO();
                ProduitDAO produitDAO = new ProduitDAO();

                List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(facture.getIdPanier());
                
                // Restaurer le stock pour chaque produit
                for (PanierProduit pp : produits) {
                    Produit produit = pp.getProduit();
                    int quantiteARestaurer = pp.getQuantite();
                    
                    // Mise à jour du stock avec une requête SQL directe
                    String updateStockQuery = "UPDATE produit SET stock = stock + ? WHERE idProduit = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateStockQuery)) {
                        updateStmt.setInt(1, quantiteARestaurer);
                        updateStmt.setInt(2, produit.getIdProduit());
                        updateStmt.executeUpdate();
                    }
                }
            }

            // Mise à jour du statut de la facture
            String sql = "UPDATE factures SET statut = ? WHERE idFacture = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nouveauStatut);
                stmt.setInt(2, idFacture);
                
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("Aucune facture trouvée avec l'ID : " + idFacture);
                }
            }

            // Commit de la transaction
            conn.commit();

        } catch (SQLException e) {
            // Rollback en cas d'erreur
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw e;
        } finally {
            // Restaurer le mode de commit automatique
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public List<Map<String, Object>> getStatistiqueVentes(java.util.Date dateDebut, java.util.Date dateFin) throws SQLException {
        List<Map<String, Object>> statistiques = new ArrayList<>();
        String sql = "SELECT " +
                     "p.idProduit, " +
                     "p.nom AS nomProduit, " +
                     "SUM(pp.quantite) AS quantiteVendue, " +
                     "SUM(pp.quantite * p.prix) AS montantTotal, " +
                     "AVG(p.prix) AS prixMoyen " +
                     "FROM factures f " +
                     "JOIN panierproduit pp ON f.idPanier = pp.idPanier " +
                     "JOIN produit p ON pp.idProduit = p.idProduit " +
                     "WHERE f.statut = ? " +
                     "AND f.dateFacture BETWEEN ? AND ? " +
                     "GROUP BY p.idProduit, p.nom " +
                     "ORDER BY quantiteVendue DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, Facture.STATUT_PAYEE);
            stmt.setDate(2, new java.sql.Date(dateDebut.getTime()));
            stmt.setDate(3, new java.sql.Date(dateFin.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> stat = new HashMap<>();
                    stat.put("idProduit", rs.getInt("idProduit"));
                    stat.put("nomProduit", rs.getString("nomProduit"));
                    stat.put("quantiteVendue", rs.getInt("quantiteVendue"));
                    stat.put("montantTotal", rs.getDouble("montantTotal"));
                    stat.put("prixMoyen", rs.getDouble("prixMoyen"));
                    
                    statistiques.add(stat);
                }
            }
        }
        return statistiques;
    }

    public Map<String, Object> getStatistiquesGenerales(Date dateDebut, Date dateFin) throws SQLException {
        Map<String, Object> statsGenerales = new HashMap<>();
        String sql = "SELECT " +
                     "COUNT(DISTINCT f.idFacture) AS nombreFactures, " +
                     "SUM(f.totalTTC) AS chiffreAffaires, " +
                     "AVG(f.totalTTC) AS panierMoyen " +
                     "FROM factures f " +
                     "WHERE f.statut = ? " +
                     "AND f.dateFacture BETWEEN ? AND ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, Facture.STATUT_PAYEE);
            stmt.setDate(2, new java.sql.Date(dateDebut.getTime()));
            stmt.setDate(3, new java.sql.Date(dateFin.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    statsGenerales.put("nombreFactures", rs.getInt("nombreFactures"));
                    statsGenerales.put("chiffreAffaires", rs.getDouble("chiffreAffaires"));
                    statsGenerales.put("panierMoyen", rs.getDouble("panierMoyen"));
                }
            }
        }
        return statsGenerales;
    }
}