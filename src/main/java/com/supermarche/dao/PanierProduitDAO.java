package com.supermarche.dao;
import com.supermarche.model.PanierProduit;
import com.supermarche.model.Produit;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PanierProduitDAO {
	public void ajouterProduitAuPanier(int idPanier, int idProduit, int quantite) throws SQLException {
	    Connection conn = null;
	    try {
	        conn = DatabaseConnection.getConnection();
	        conn.setAutoCommit(false);

	        // Vérifier la quantité
	        if (quantite <= 0) {
	            throw new IllegalArgumentException("La quantité doit être supérieure à 0.");
	        }

	        // Vérifier le stock disponible avec un verrou
	        String stockQuery = "SELECT stock FROM produit WHERE idProduit = ? FOR UPDATE";
	        int stockDisponible;
	        try (PreparedStatement stockStmt = conn.prepareStatement(stockQuery)) {
	            stockStmt.setInt(1, idProduit);
	            try (ResultSet rs = stockStmt.executeQuery()) {
	                if (rs.next()) {
	                    stockDisponible = rs.getInt("stock");
	                } else {
	                    throw new SQLException("Produit introuvable");
	                }
	            }
	        }

	        // Vérifier si le produit est déjà dans le panier
	        PanierProduit produitExistant = obtenirProduitDansPanier(idPanier, idProduit);
	        int quantiteTotale = quantite + (produitExistant != null ? produitExistant.getQuantite() : 0);

	        // Vérifier si le stock est suffisant
	        if (stockDisponible < quantiteTotale) {
	            throw new SQLException(String.format(
	                "Stock insuffisant pour le produit. Stock disponible : %d, Quantité demandée : %d", 
	                stockDisponible, quantiteTotale
	            ));
	        }

	        // Mettre à jour le stock
	        String updateStockQuery = "UPDATE produit SET stock = stock - ? WHERE idProduit = ?";
	        try (PreparedStatement updateStockStmt = conn.prepareStatement(updateStockQuery)) {
	            updateStockStmt.setInt(1, quantite);
	            updateStockStmt.setInt(2, idProduit);
	            updateStockStmt.executeUpdate();
	        }

	        // Ajouter ou mettre à jour dans le panier
	        String panierQuery = "INSERT INTO panierproduit (idPanier, idProduit, quantite) " +
	                             "VALUES (?, ?, ?) " +
	                             "ON DUPLICATE KEY UPDATE quantite = quantite + ?";
	        try (PreparedStatement stmt = conn.prepareStatement(panierQuery)) {
	            stmt.setInt(1, idPanier);
	            stmt.setInt(2, idProduit);
	            stmt.setInt(3, quantite);
	            stmt.setInt(4, quantite);
	            stmt.executeUpdate();
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
	        // Restaurer l'auto-commit
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


    // Mettre à jour la quantité d'un produit dans le panier
    public void mettreAJourQuantite(int idPanierProduit, int quantite) throws SQLException {
        String sql = "UPDATE panierproduit SET quantite = ? WHERE idPanierProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantite);
            stmt.setInt(2, idPanierProduit);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la mise à jour de la quantité : " + e.getMessage(), e);
        }
    }

    // Supprimer un produit spécifique du panier
    public void supprimerProduitDuPanier(int idPanierProduit) throws SQLException {
        String sql = "DELETE FROM panierproduit WHERE idPanierProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
        		PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPanierProduit);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la suppression du produit du panier : " + e.getMessage(), e);
        }
    }

    // Récupérer les produits du panier pour un ID de panier donné
    public List<PanierProduit> listerProduitsDuPanier(int idPanier) throws SQLException {
        List<PanierProduit> produits = new ArrayList<>();
        String sql = "SELECT pp.*, p.nom, p.prix FROM panierproduit pp " +
                     "JOIN produit p ON pp.idProduit = p.idProduit " +
                     "WHERE pp.idPanier = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PanierProduit pp = new PanierProduit();
                    pp.setIdPanierProduit(rs.getInt("idPanierProduit"));

                    Integer quantite = rs.getInt("quantite");
                    pp.setQuantite(rs.wasNull() ? 0 : quantite);

                    Produit produit = new Produit();
                    produit.setIdProduit(rs.getInt("idProduit"));
                    produit.setNom(rs.getString("nom") != null ? rs.getString("nom") : "Produit inconnu");

                    Double prix = rs.getDouble("prix");
                    produit.setPrix(rs.wasNull() ? 0.0 : prix);

                    pp.setProduit(produit);
                    produits.add(pp);
                }
            }
        }
        return produits;
    }

    public void viderPanier(int idPanier) throws SQLException {
        String sql = "DELETE FROM panierproduit WHERE idPanier = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erreur lors du vidage du panier : " + e.getMessage(), e);
        }
    }

    public PanierProduit obtenirPanierProduitParId(int idPanierProduit) throws SQLException {
        String sql = "SELECT pp.idPanierProduit, pp.quantite, pr.idProduit, pr.nom, pr.description, pr.prix, pr.stock " +
                     "FROM panierproduit pp " +
                     "JOIN produit pr ON pp.idProduit = pr.idProduit " +
                     "WHERE pp.idPanierProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPanierProduit);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Produit produit = new Produit();
                    produit.setIdProduit(rs.getInt("idProduit"));
                    produit.setNom(rs.getString("nom"));
                    produit.setDescription(rs.getString("description"));
                    produit.setPrix(rs.getDouble("prix"));
                    produit.setStock(rs.getInt("stock"));

                    PanierProduit panierProduit = new PanierProduit();
                    panierProduit.setIdPanierProduit(rs.getInt("idPanierProduit"));
                    panierProduit.setProduit(produit);
                    panierProduit.setQuantite(rs.getInt("quantite"));

                    return panierProduit;
                }
            }
        }
        return null;
    }
    public PanierProduit obtenirProduitDansPanier(int idPanier, int idProduit) {
        String sql = "SELECT pp.idPanierProduit, pp.quantite, pr.idProduit, pr.nom, pr.description, pr.prix, pr.stock " +
                     "FROM panierproduit pp " +
                     "JOIN produit pr ON pp.idProduit = pr.idProduit " +
                     "WHERE pp.idPanier = ? AND pp.idProduit = ?";
        try (Connection conn = DatabaseConnection.getConnection();
        		PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPanier);
            stmt.setInt(2, idProduit);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Produit produit = new Produit();
                    produit.setIdProduit(rs.getInt("idProduit"));
                    produit.setNom(rs.getString("nom"));
                    produit.setDescription(rs.getString("description"));
                    produit.setPrix(rs.getDouble("prix"));
                    produit.setStock(rs.getInt("stock"));

                    PanierProduit panierProduit = new PanierProduit();
                    panierProduit.setIdPanierProduit(rs.getInt("idPanierProduit"));
                    panierProduit.setProduit(produit);
                    panierProduit.setQuantite(rs.getInt("quantite"));

                    return panierProduit;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du produit dans le panier : " + e.getMessage());
        }
        return null; // Retourne null si le produit n'est pas trouvé
    }

}
