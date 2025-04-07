package controller;

import com.supermarche.dao.DatabaseConnection;
import com.supermarche.dao.FactureDAO;
import com.supermarche.dao.PanierDAO;
import com.supermarche.dao.PanierProduitDAO;
import com.supermarche.dao.ProduitDAO;
import com.supermarche.model.Facture;
import com.supermarche.model.Panier;
import com.supermarche.model.PanierProduit;
import com.supermarche.model.Produit;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@WebServlet("/CaissierServlet")
public class CaissierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;
    private PanierDAO panierDAO;
    private PanierProduitDAO panierProduitDAO ;
    

    @Override
    public void init() throws ServletException {
        produitDAO = new ProduitDAO();
        panierDAO = new PanierDAO();
        panierProduitDAO = new PanierProduitDAO();
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            // Gestion de l'action spécifique
            if (action != null) {
                switch (action) {
                    case "listePaniers":
                        afficherListePaniers(request, response);
                        return;
                    case "voirfacture":
                        voirFacture(request, response);
                        return;
                    case "detailsFacture":
                        voirDetailsFacture(request, response);
                        return;
                    case "listerFactures":
                        listerFactures(request, response);
                        return;
                    case "statistiquesVentes":
                        genererStatistiquesVentes(request, response);
                        break;
                    // Ajoutez d'autres cas si nécessaire
                }
            }
            
            // Action par défaut si aucune action spécifiée
            afficherProduitsEtPaniers(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Une erreur s'est produite : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch(action) {
            case "add":
                ajouterProduitAuPanier(request, response);
                break;
            case "remove":
                supprimerProduitDuPanier(request, response);
                break;
            case "addMultiple":
                ajouterMultipleProduits(request, response);
                break; 
            case "validate":
                validerPanier(request, response);
                break;
            case "clear":
                viderPanier(request, response);
                break;
            case "editQuantite":
                modifierQuantitePanier(request, response);
                break;
            case "reprendrePanier":
                reprendrePanier(request, response);
                break;
            case "modifierDernierPanier":
                modifierDernierPanierValide(request, response);
                break;
            case "rouvrirDernierPanier":
                rouvrirDernierPanier(request, response);
                break;
            case "finaliserPanier":
                finaliserPanier(request, response);
                break;
            case "genererFacture" :
                genererFacture(request, response);
                break;
            case "creerEtSauvegarderFacture":
                System.out.println("Appel de creerEtSauvegarderFacture");
                creerEtSauvegarderFacture(request, response);
                break;
            case "voirFacture":
                voirFacture(request, response);
                break; 
            case "modifierStatutFacture":
                modifierStatutFacture(request, response);
                break;
            case "statistiquesVentes":
                genererStatistiquesVentes(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
        }
    }

    private void rouvrirDernierPanier(HttpServletRequest request, HttpServletResponse response)   throws IOException {
        try {
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));
            HttpSession session = request.getSession();
            
            // Réouvrir le panier
            panierDAO.rouvrirPanierValide(idPanier);
            
            // Mettre à jour la session avec le panier rouvert
            session.setAttribute("idPanier", idPanier);
            session.setAttribute("messageSucces", "Le panier a été rouvert pour modification.");
            
            response.sendRedirect("CaissierServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la réouverture du panier : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }

	private void modifierDernierPanierValide(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            Panier dernierPanier = panierDAO.getDernierPanierValide();
            
            if (dernierPanier != null) {
                // Remettre le panier en cours
                panierDAO.modifierPanierValide(dernierPanier.getIdPanier());
                
                // Mettre à jour la session avec l'ID du panier
                session.setAttribute("idPanier", dernierPanier.getIdPanier());
                session.setAttribute("messageSucces", "Le dernier panier validé a été rouvert pour modification.");
            } else {
                session.setAttribute("messageErreur", "Aucun panier validé n'est disponible pour modification.");
            }
            
            response.sendRedirect("CaissierServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la modification du dernier panier.");
        }
    }

	
    
	private void ajouterProduitAuPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    HttpSession session = request.getSession();
	    try {
	        // Récupérer les paramètres
	        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
	        int quantite = Integer.parseInt(request.getParameter("quantite"));

	        // Vérifier la quantité
	        if (quantite <= 0) {
	            session.setAttribute("messageErreur", "La quantité doit être supérieure à 0");
	            response.sendRedirect("CaissierServlet");
	            return;
	        }

	        // Vérifier si un panier existe, sinon en créer un nouveau
	        Integer idPanier = (Integer) session.getAttribute("idPanier");
	        if (idPanier == null) {
	            idPanier = panierDAO.creerPanier();
	            session.setAttribute("idPanier", idPanier);
	        }

	        // Vérifier le stock
	        Produit produit = produitDAO.obtenirProduitParId(idProduit);
	        if (produit == null) {
	            session.setAttribute("messageErreur", "Produit introuvable");
	            response.sendRedirect("CaissierServlet");
	            return;
	        }

	        if (produit.getStock() < quantite) {
	            session.setAttribute("messageErreur", "Stock insuffisant. Disponible: " + produit.getStock());
	            response.sendRedirect("CaissierServlet");
	            return;
	        }

	        // Ajouter ou mettre à jour le produit dans le panier
	        PanierProduit existant = panierProduitDAO.obtenirProduitDansPanier(idPanier, idProduit);
	        if (existant != null) {
	            int nouvelleQuantite = existant.getQuantite() + quantite;
	            if (produit.getStock() >= nouvelleQuantite) {
	                panierProduitDAO.mettreAJourQuantite(existant.getIdPanierProduit(), nouvelleQuantite);
	                produitDAO.mettreAJourStock(idProduit, produit.getStock() - quantite);
	                session.setAttribute("messageSucces", "Quantité mise à jour avec succès");
	            } else {
	                session.setAttribute("messageErreur", "Stock insuffisant pour cette quantité totale");
	            }
	        } else {
	            panierProduitDAO.ajouterProduitAuPanier(idPanier, idProduit, quantite);
	            produitDAO.mettreAJourStock(idProduit, produit.getStock() - quantite);
	            session.setAttribute("messageSucces", "Produit ajouté au panier avec succès");
	        }
	        
	        response.sendRedirect("CaissierServlet");
	        
	    } catch (NumberFormatException e) {
	        session.setAttribute("messageErreur", "Paramètres invalides");
	        response.sendRedirect("CaissierServlet");
	    } catch (Exception e) {
	        session.setAttribute("messageErreur", "Erreur lors de l'ajout au panier: " + e.getMessage());
	        e.printStackTrace();
	        response.sendRedirect("CaissierServlet");
	    }
	}
    private void supprimerProduitDuPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idPanierProduit = Integer.parseInt(request.getParameter("idPanierProduit"));

            PanierProduit panierProduit = panierProduitDAO.obtenirPanierProduitParId(idPanierProduit);
            if (panierProduit != null) {
                Produit produit = panierProduit.getProduit();
                int stockARestaurer = panierProduit.getQuantite();

                panierProduitDAO.supprimerProduitDuPanier(idPanierProduit);
                produitDAO.mettreAJourStock(produit.getIdProduit(), produit.getStock() + stockARestaurer);
            }
            response.sendRedirect("CaissierServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erreur lors de la suppression du produit.");
        }
    }

    private void validerPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;
        HttpSession session = request.getSession();
        
        try {
            Integer idPanier = (Integer) session.getAttribute("idPanier");

            if (idPanier == null) {
                session.setAttribute("messageErreur", "Aucun panier actif pour validation");
                response.sendRedirect("CaissierServlet");
                return;
            }

            // Obtenir une connexion et désactiver l'auto-commit
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Récupérer les produits du panier
            List<PanierProduit> panierProduits = panierProduitDAO.listerProduitsDuPanier(idPanier);

            if (panierProduits.isEmpty()) {
                session.setAttribute("messageErreur", "Le panier est vide. Impossible de valider.");
                response.sendRedirect("CaissierServlet");
                return;
            }

            // Vérification détaillée du stock avec verrouillage
            for (PanierProduit pp : panierProduits) {
                Produit produit = pp.getProduit();
                
                // Requête avec verrou pour éviter les conflits
                String stockQuery = "SELECT stock FROM produit WHERE idProduit = ? FOR UPDATE";
                try (PreparedStatement stockStmt = conn.prepareStatement(stockQuery)) {
                    stockStmt.setInt(1, produit.getIdProduit());
                    try (ResultSet rs = stockStmt.executeQuery()) {
                        if (rs.next()) {
                            int stockDisponible = rs.getInt("stock");
                            
                            // Vérification détaillée du stock
                            if (stockDisponible < pp.getQuantite()) {
                                throw new Exception("Stock insuffisant pour le produit : " + produit.getNom() + 
                                                   " (Stock: " + stockDisponible + ", Demandé: " + pp.getQuantite() + ")");
                            }
                            
                            // Mise à jour du stock
                            String updateStockQuery = "UPDATE produit SET stock = stock - ? WHERE idProduit = ?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateStockQuery)) {
                                updateStmt.setInt(1, pp.getQuantite());
                                updateStmt.setInt(2, produit.getIdProduit());
                                updateStmt.executeUpdate();
                            }
                        } else {
                            throw new Exception("Produit introuvable : " + produit.getNom());
                        }
                    }
                }
            }

            // Mettre à jour le statut à "EN_VALIDATION"
            panierDAO.updateStatut(idPanier, Panier.Statut.EN_VALIDATION);

            // Commit de la transaction
            conn.commit();

            // Nettoyer la session
            session.setAttribute("messageSucces", "Le panier a été validé et mis en attente de finalisation.");
            response.sendRedirect("CaissierServlet");

        } catch (Exception e) {
            // Rollback en cas d'erreur
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }

            e.printStackTrace();
            session.setAttribute("messageErreur", 
                "Erreur lors de la validation du panier : " + e.getMessage());
            response.sendRedirect("CaissierServlet");

        } finally {
            // Restaurer l'auto-commit et fermer la connexion
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
    // Méthode pour afficher les produits et paniers
    private void afficherProduitsEtPaniers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer idPanier = (Integer) session.getAttribute("idPanier");
            
            // Récupérer les paniers en cours et en validation
            List<Panier> paniersNonFinalises = new ArrayList<>();
            paniersNonFinalises.addAll(panierDAO.listerPaniersParStatut(Panier.Statut.EN_COURS));
            paniersNonFinalises.addAll(panierDAO.listerPaniersParStatut(Panier.Statut.EN_VALIDATION));

            // Charger les produits pour chaque panier
            for (Panier panier : paniersNonFinalises) {
                List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(panier.getIdPanier());
                panier.setProduits(produits);
            }

            // Trier par date de création décroissante
            paniersNonFinalises.sort((p1, p2) -> p2.getDateCreation().compareTo(p1.getDateCreation()));

            request.setAttribute("paniersNonFinalises", paniersNonFinalises);

            // Gérer le panier actuel
            if (idPanier != null) {
                Panier panier = panierDAO.obtenirPanierParId(idPanier);
                if (panier != null && panier.getStatut() == Panier.Statut.EN_COURS) {
                    List<PanierProduit> panierProduits = panierProduitDAO.listerProduitsDuPanier(idPanier);
                    request.setAttribute("panierProduits", panierProduits);
                } else {
                    // Si le panier n'est plus en cours, le retirer de la session
                    session.removeAttribute("idPanier");
                }
            }

            // Liste des produits disponibles
            List<Produit> produits = produitDAO.listerProduits();
            request.setAttribute("produits", produits);

            request.getRequestDispatcher("/WEB-INF/caissier/caissier.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    private void ajouterMultipleProduits(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        try {
            // Récupérer l'ID du panier actuel
            Integer idPanier = (Integer) session.getAttribute("idPanier");
            if (idPanier == null) {
                idPanier = panierDAO.creerPanier();
                session.setAttribute("idPanier", idPanier);
            }

            // Récupérer les produits sélectionnés
            String[] selectedProduits = request.getParameterValues("selectedProduits");
            if (selectedProduits == null || selectedProduits.length == 0) {
                session.setAttribute("messageErreur", "Aucun produit sélectionné");
                response.sendRedirect("CaissierServlet");
                return;
            }

            // Ajouter chaque produit
            for (String idProduitStr : selectedProduits) {
                int idProduit = Integer.parseInt(idProduitStr);
                String quantiteParam = "quantite_" + idProduit;
                int quantite = Integer.parseInt(request.getParameter(quantiteParam));

                // Logique d'ajout similaire à ajouterProduitAuPanier
                Produit produit = produitDAO.obtenirProduitParId(idProduit);
                if (produit.getStock() >= quantite) {
                    panierProduitDAO.ajouterProduitAuPanier(idPanier, idProduit, quantite);
                    produitDAO.mettreAJourStock(idProduit, produit.getStock() - quantite);
                } else {
                    session.setAttribute("messageErreur", 
                        "Stock insuffisant pour le produit : " + produit.getNom());
                }
            }

            session.setAttribute("messageSucces", "Produits ajoutés au panier avec succès");
            response.sendRedirect("CaissierServlet");

        } catch (Exception e) {
            session.setAttribute("messageErreur", 
                "Erreur lors de l'ajout des produits : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }

    private void viderPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;
        try {
            HttpSession session = request.getSession();
            Integer idPanier = (Integer) session.getAttribute("idPanier");

            if (idPanier == null) {
                response.sendRedirect("CaissierServlet");
                return;
            }

            // Obtenir une connexion et désactiver l'auto-commit
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Récupérer les produits du panier
            List<PanierProduit> panierProduits = panierProduitDAO.listerProduitsDuPanier(idPanier);
            
            // Restaurer le stock pour chaque produit
            for (PanierProduit panierProduit : panierProduits) {
                Produit produit = panierProduit.getProduit();
                
                // Méthode de mise à jour du stock plus précise
                String updateStockSql = "UPDATE produit SET stock = stock + ? WHERE idProduit = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateStockSql)) {
                    stmt.setInt(1, panierProduit.getQuantite());
                    stmt.setInt(2, produit.getIdProduit());
                    stmt.executeUpdate();
                }
            }

            // Vider le panier
            panierProduitDAO.viderPanier(idPanier);

            // Commit de la transaction
            conn.commit();

            // Supprimer l'ID du panier de la session
            session.removeAttribute("idPanier");

            // Message de succès
            session.setAttribute("messageSucces", "Le panier a été vidé et le stock a été restauré.");
            response.sendRedirect("CaissierServlet");

        } catch (Exception e) {
            // Rollback en cas d'erreur
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }

            e.printStackTrace();
            ServletRequest session = null;
			session.setAttribute("messageErreur", "Erreur lors du vidage du panier : " + e.getMessage());
            response.sendRedirect("CaissierServlet");

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

    private void reprendrePanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));
            HttpSession session = request.getSession();

            // Vérifier que le panier est dans l'état EN_VALIDATION
            Panier panier = panierDAO.obtenirPanierParId(idPanier);
            if (panier == null || panier.getStatut() != Panier.Statut.EN_VALIDATION) {
                session.setAttribute("messageErreur", 
                    "Ce panier ne peut pas être modifié.");
                response.sendRedirect("CaissierServlet");
                return;
            }

            // Mettre à jour le statut à EN_COURS
            panierDAO.updateStatut(idPanier, Panier.Statut.EN_COURS);
            
            // Définir le panier actif en session
            session.setAttribute("idPanier", idPanier);
            session.setAttribute("messageSucces", "Le panier est à nouveau modifiable.");
            
            response.sendRedirect("CaissierServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la reprise du panier : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
    private void modifierQuantitePanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idPanierProduit = Integer.parseInt(request.getParameter("idPanierProduit"));
            int nouvelleQuantite = Integer.parseInt(request.getParameter("nouvelleQuantite"));
            
            PanierProduit panierProduit = panierProduitDAO.obtenirPanierProduitParId(idPanierProduit);
            if (panierProduit != null) {
                Produit produit = panierProduit.getProduit();
                int differenceQuantite = nouvelleQuantite - panierProduit.getQuantite();
                
                // Vérifier si le stock est suffisant pour l'augmentation
                if (differenceQuantite > 0 && produit.getStock() < differenceQuantite) {
                    request.getSession().setAttribute("messageErreur", "Stock insuffisant pour ce produit.");
                } else {
                    // Mettre à jour le stock
                    produitDAO.mettreAJourStock(produit.getIdProduit(), produit.getStock() - differenceQuantite);
                    // Mettre à jour la quantité dans le panier
                    panierProduitDAO.mettreAJourQuantite(idPanierProduit, nouvelleQuantite);
                    request.getSession().setAttribute("messageSucces", "Quantité mise à jour avec succès.");
                }
            }
            response.sendRedirect("CaissierServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la modification de la quantité.");
        }
    }
    private void genererFacture(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));
            
            // Récupérer le panier et ses produits
            Panier panier = panierDAO.obtenirPanierParId(idPanier);
            List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(idPanier);
            
            if (panier == null) {
                throw new Exception("Panier non trouvé");
            }

            // Calculer les totaux
            double totalHT = 0;
            for (PanierProduit pp : produits) {
                totalHT += pp.getQuantite() * pp.getProduit().getPrix();
            }
            
            // Créer l'objet Facture
            Facture facture = new Facture();
            facture.setIdPanier(idPanier);
            facture.setDateFacture(new Timestamp(System.currentTimeMillis()));
            facture.setNumeroFacture("FACT-" + idPanier + "-" + System.currentTimeMillis());
            facture.setTotalHT(totalHT);
            facture.setTva(0.20); // 20%
            facture.setTotalTTC(totalHT * 1.20);
            facture.setProduits(produits);
            facture.setStatut("EMISE");

            // Définir les attributs pour la JSP
            request.setAttribute("facture", facture);
            request.setAttribute("panier", panier);
            request.setAttribute("produitsPanier", produits);

            // Debug - vérifier les valeurs
            System.out.println("Facture générée : " + facture.getNumeroFacture());
            System.out.println("Nombre de produits : " + produits.size());
            System.out.println("Total HT : " + totalHT);

            // Forward vers la page facture
            request.getRequestDispatcher("/WEB-INF/caissier/facture.jsp")
                  .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la génération de la facture : " + e.getMessage());
            response.sendRedirect("CaissierServlet?action=listePaniers");
        }
    }
    private void finaliserPanier(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));
            panierDAO.finaliserPanier(idPanier);
            
            request.getSession().setAttribute("messageSucces", "Le panier a été finalisé avec succès.");
            response.sendRedirect("CaissierServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la finalisation du panier : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
    private void creerFacture(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));
            List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(idPanier);
            
            // Calculer les totaux
            double totalHT = 0;
            for (PanierProduit pp : produits) {
                totalHT += pp.getQuantite() * pp.getProduit().getPrix();
            }
            
            double tva = 0.20; // 20% TVA
            double totalTTC = totalHT * (1 + tva);
            
            // Créer la facture
            Facture facture = new Facture();
            facture.setIdPanier(idPanier);
            facture.setTotalHT(totalHT);
            facture.setTotalTTC(totalTTC);
            facture.setTva(tva);
            facture.setProduits(produits);
            
            // Sauvegarder la facture
            FactureDAO factureDAO = new FactureDAO();
            int idFacture = factureDAO.creerFacture(facture);
            
            // Rediriger vers la page de facture
            response.sendRedirect("FactureServlet?action=voir&idFacture=" + idFacture);
            
        } catch (Exception e) {
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la création de la facture : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
    private void afficherListePaniers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int itemsPerPage = 5;
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            // Get total count
            int totalItems = panierDAO.getTotalPaniers();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int offset = (page - 1) * itemsPerPage;

            // Get paginated data
            List<Map<String, Object>> paniersDetails = panierDAO.getPaniersWithDetailsPaginated(offset, itemsPerPage);

            request.setAttribute("paniersDetails", paniersDetails);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/WEB-INF/caissier/listePaniers.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la récupération des paniers : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
    private void creerEtSauvegarderFacture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Déclarez idFacture en dehors du bloc try
        int idFacture = 0;

        try {
            // Récupérer et valider l'ID du panier
            int idPanier = Integer.parseInt(request.getParameter("idPanier"));

            // Vérifier le montant total avant tout
            double total = panierDAO.calculerTotalPanier(idPanier);
            if (total <= 0) {
                request.getSession().setAttribute("messageErreur",
                    "Impossible de créer une facture pour un panier vide ou avec un montant nul");
                response.sendRedirect("CaissierServlet?action=listePaniers");
                return;
            }

            // Vérifier l'existence d'une facture
            FactureDAO factureDAO = new FactureDAO();
            List<Facture> existingFactures = factureDAO.getFacturesByPanier(idPanier);
            if (!existingFactures.isEmpty()) {
                request.getSession().setAttribute("messageErreur",
                    "Une facture existe déjà pour ce panier");
                response.sendRedirect("CaissierServlet?action=listePaniers");
                return;
            }

            // Récupérer et valider le panier
            Panier panier = panierDAO.obtenirPanierParId(idPanier);
            if (panier == null) {
                throw new Exception("Panier non trouvé");
            }

            // Vérifier le statut du panier
            if (panier.getStatut() != Panier.Statut.FINALISE) {
                throw new Exception("Le panier doit être finalisé avant de créer une facture");
            }

            // Récupérer et valider les produits
            List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(idPanier);
            if (produits.isEmpty()) {
                throw new Exception("Le panier est vide");
            }

            // Calculer les montants
            double totalHT = produits.stream()
                                   .mapToDouble(pp -> pp.getQuantite() * pp.getProduit().getPrix())
                                   .sum();
            double tva = 0.20;
            double totalTTC = totalHT * (1 + tva);

            // Créer l'objet facture
            Facture facture = new Facture();
            facture.setIdPanier(idPanier);
            facture.setTotalHT(totalHT);
            facture.setTva(tva);
            facture.setTotalTTC(totalTTC);
            facture.setNumeroFacture("FACT-" + idPanier + "-" + System.currentTimeMillis());
            facture.setDateFacture(new Timestamp(System.currentTimeMillis()));
            facture.setStatut("EMISE");

            // Créer la facture
            idFacture = factureDAO.creerFacture(facture);

            // Mettre à jour le statut du panier
            panierDAO.updateStatut(idPanier, Panier.Statut.FACTURE);

            // Message de succès et redirection
            request.getSession().setAttribute("messageSucces",
                "Facture créée avec succès. Numéro : " + idFacture);
            response.sendRedirect("CaissierServlet?action=listePaniers" );

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", e.getMessage());
            response.sendRedirect("CaissierServlet?action=listePaniers");
        }
    }
    private void voirFacture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer l'identifiant de la facture
            String idFactureStr = request.getParameter("idFacture");
            String idPanierStr = request.getParameter("idPanier");

            System.out.println("DEBUG - ID Facture reçu : " + idFactureStr);
            System.out.println("DEBUG - ID Panier reçu : " + idPanierStr);

            FactureDAO factureDAO = new FactureDAO();
            Facture facture = null;

            // Essayer de récupérer par ID de facture
            if (idFactureStr != null && !idFactureStr.isEmpty()) {
                int idFacture = Integer.parseInt(idFactureStr);
                facture = factureDAO.getFactureById(idFacture);
            }

            // Si pas trouvé, essayer par ID de panier
            if (facture == null && idPanierStr != null && !idPanierStr.isEmpty()) {
                int idPanier = Integer.parseInt(idPanierStr);
                List<Facture> factures = factureDAO.getFacturesByPanier(idPanier);
                if (!factures.isEmpty()) {
                    facture = factures.get(0);
                }
            }

            // Vérification
            if (facture == null) {
                throw new Exception("Aucune facture trouvée");
            }

            // Récupérer les produits
            PanierProduitDAO panierProduitDAO = new PanierProduitDAO();
            List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(facture.getIdPanier());
            
            // Ajouter les produits directement à la facture
            facture.setProduits(produits);

            request.setAttribute("facture", facture);

            request.getRequestDispatcher("/WEB-INF/caissier/facture.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de l'affichage de la facture : " + e.getMessage());
            response.sendRedirect("CaissierServlet?action=listerFactures");
        }
    }
    private void listerFactures(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            int itemsPerPage = 5;
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            FactureDAO factureDAO = new FactureDAO();
            int offset = (currentPage - 1) * itemsPerPage;
            
            List<Facture> factures = factureDAO.getFacturesWithPagination(offset, itemsPerPage);
            int totalFactures = factureDAO.getTotalFactures();
            int totalPages = (int) Math.ceil((double) totalFactures / itemsPerPage);

            request.setAttribute("factures", factures);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            String messageErreur = (String) request.getSession().getAttribute("messageErreur");
            if (messageErreur != null) {
                request.setAttribute("messageErreur", messageErreur);
                request.getSession().removeAttribute("messageErreur");
            }

            request.getRequestDispatcher("/WEB-INF/caissier/listeFactures.jsp").forward(request, response);
        } catch (SQLException | IllegalArgumentException e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la récupération des factures : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
    private void voirDetailsFacture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer l'identifiant de la facture
            String idFactureStr = request.getParameter("idFacture");
            String idPanierStr = request.getParameter("idPanier");

            System.out.println("ID Facture reçu (détails) : " + idFactureStr);
            System.out.println("ID Panier reçu (détails) : " + idPanierStr);

            FactureDAO factureDAO = new FactureDAO();
            Facture facture = null;

            // Essayer de récupérer par ID de facture
            if (idFactureStr != null && !idFactureStr.isEmpty()) {
                int idFacture = Integer.parseInt(idFactureStr);
                facture = factureDAO.getFactureById(idFacture);
            }

            // Si pas trouvé, essayer par ID de panier
            if (facture == null && idPanierStr != null && !idPanierStr.isEmpty()) {
                int idPanier = Integer.parseInt(idPanierStr);
                List<Facture> factures = factureDAO.getFacturesByPanier(idPanier);
                if (!factures.isEmpty()) {
                    facture = factures.get(0);
                }
            }

            // Vérification
            if (facture == null) {
                throw new Exception("Aucune facture trouvée");
            }

            // Récupérer les produits
            PanierProduitDAO panierProduitDAO = new PanierProduitDAO();
            List<PanierProduit> produits = panierProduitDAO.listerProduitsDuPanier(facture.getIdPanier());

            request.setAttribute("facture", facture);
            request.setAttribute("produitsPanier", produits);

            // Utiliser une nouvelle page de détails
            request.getRequestDispatcher("/WEB-INF/caissier/detailsFacture.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de l'affichage des détails de la facture : " + e.getMessage());
            response.sendRedirect("CaissierServlet?action=listerFactures");
        }
    }
    private void modifierStatutFacture(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int idFacture = Integer.parseInt(request.getParameter("idFacture"));
            String nouveauStatut = request.getParameter("nouveauStatut");

            // Vérifier que le statut est valide
            if (!nouveauStatut.equals(Facture.STATUT_EMISE) && 
                !nouveauStatut.equals(Facture.STATUT_PAYEE) && 
                !nouveauStatut.equals(Facture.STATUT_ANNULEE)) {
                throw new IllegalArgumentException("Statut invalide");
            }

            FactureDAO factureDAO = new FactureDAO();
            
            // Récupérer la facture avant modification
            Facture facture = factureDAO.getFactureById(idFacture);
            
            // Mise à jour du statut
            factureDAO.mettreAJourStatut(idFacture, nouveauStatut);

            // Message personnalisé selon le statut
            String message;
            switch (nouveauStatut) {
                case Facture.STATUT_ANNULEE:
                    message = "La facture a été annulée et le stock a été restauré.";
                    break;
                case Facture.STATUT_PAYEE:
                    message = "La facture a été marquée comme payée.";
                    break;
                default:
                    message = "Statut de la facture mis à jour avec succès.";
            }

            request.getSession().setAttribute("messageSucces", message);
            response.sendRedirect("CaissierServlet?action=listerFactures");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la modification du statut : " + e.getMessage());
            response.sendRedirect("CaissierServlet?action=listerFactures");
        }
    }
    private void genererStatistiquesVentes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Récupérer les dates
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");

            // Formatter de date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            // Dates par défaut (dernier mois si non spécifiées)
            Date dateFin = new Date();
            Date dateDebut;
            
            if (dateDebutStr != null && !dateDebutStr.isEmpty() && 
                dateFinStr != null && !dateFinStr.isEmpty()) {
                dateDebut = sdf.parse(dateDebutStr);
                dateFin = sdf.parse(dateFinStr);
            } else {
                // Dernier mois par défaut
                Calendar cal = Calendar.getInstance();
                cal.setTime(dateFin);
                cal.add(Calendar.MONTH, -1);
                dateDebut = cal.getTime();
            }

            // Conversion en java.sql.Date
            java.sql.Date sqlDateDebut = new java.sql.Date(dateDebut.getTime());
            java.sql.Date sqlDateFin = new java.sql.Date(dateFin.getTime());

            // Récupérer les statistiques
            FactureDAO factureDAO = new FactureDAO();
            List<Map<String, Object>> statistiquesProduits = factureDAO.getStatistiqueVentes(sqlDateDebut, sqlDateFin);
            Map<String, Object> statistiquesGenerales = factureDAO.getStatistiquesGenerales(sqlDateDebut, sqlDateFin);

            // Attributs pour la vue
            request.setAttribute("statistiquesProduits", statistiquesProduits);
            request.setAttribute("statistiquesGenerales", statistiquesGenerales);
            request.setAttribute("dateDebut", sdf.format(dateDebut));
            request.setAttribute("dateFin", sdf.format(dateFin));

            // Forwarding vers la page de statistiques
            request.getRequestDispatcher("/WEB-INF/caissier/pagestatistiques.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la génération des statistiques : " + e.getMessage());
            response.sendRedirect("CaissierServlet");
        }
    }
}
