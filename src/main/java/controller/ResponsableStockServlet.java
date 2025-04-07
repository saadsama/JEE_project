package controller;

import com.supermarche.dao.FactureDAO;
import com.supermarche.dao.ProduitDAO;
import com.supermarche.model.AlerteStock;
import com.supermarche.model.Facture;
import com.supermarche.model.Produit;
import com.supermarche.model.Utilisateur;
import com.supermarche.model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;


@WebServlet("/ResponsableStockServlet")
public class ResponsableStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;
    private FactureDAO factureDAO;

    public void init() throws ServletException {
        produitDAO = new ProduitDAO();
        
        try {
            factureDAO  = new FactureDAO();
        } catch (SQLException e) {
            throw new ServletException("Erreur d'initialisation de FactureDAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur == null || utilisateur.getRole() != Role.RESPONSABLECATEGORIE) {
            response.sendRedirect("auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                afficherHome(request, response);
                return;
            }

            switch (action) {
                case "home":
                    afficherHome(request, response);
                    break;
                case "alertes":
                    afficherAlertes(request, response);
                    break;
                case "stockCritique":
                    listerProduitsSousStockCritique(request, response);
                    break;
                case "ajusterStock":
                    afficherFormulaireAjustementStock(request, response);
                    break;
                case "factures":
                    listerFactures(request, response);
                    break;
                case "voirFacture":
                    voirFacture(request, response);
                    break;    
                default:
                    afficherHome(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("messageErreur", "Une erreur s'est produite : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
        }
    }

    private void afficherHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Récupérer les statistiques de stock
        int totalProduits = produitDAO.compterProduits();
        int produitsSousCritique = produitDAO.compterProduitsSousStockCritique(10);
        List<AlerteStock> alertes = produitDAO.getAlertesActives();
        
        // Statistiques des alertes
        Map<String, Object> statsAlertes = produitDAO.getStatistiquesAlertes();

        // Définir les attributs
        request.setAttribute("totalProduits", totalProduits);
        request.setAttribute("produitsSousCritique", produitsSousCritique);
        request.setAttribute("alertes", alertes);
        request.setAttribute("statsAlertes", statsAlertes);
        request.setAttribute("lastUpdate", new java.util.Date());

        request.getRequestDispatcher("/WEB-INF/responsableStock/home.jsp").forward(request, response);
    }

    private void afficherAlertes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<AlerteStock> alertes = produitDAO.getAlertesActives();
        Map<String, Object> statsAlertes = produitDAO.getStatistiquesAlertes();
        
        request.setAttribute("alertes", alertes);
        request.setAttribute("statsAlertes", statsAlertes);
        request.getRequestDispatcher("/WEB-INF/responsableStock/alertes.jsp").forward(request, response);
    }

    private void listerProduitsSousStockCritique(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Produit> produitsSousCritique = produitDAO.listerProduitsSousStockCritique(10);
        request.setAttribute("produits", produitsSousCritique);
        request.setAttribute("stockCritique", true);
        request.getRequestDispatcher("/WEB-INF/responsableStock/listeProduitsCritiques.jsp").forward(request, response);
    }

    private void afficherFormulaireAjustementStock(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        Produit produit = produitDAO.obtenirProduitParId(idProduit);
        
        request.setAttribute("produit", produit);
        request.getRequestDispatcher("/WEB-INF/responsableStock/ajustementStock.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur == null || utilisateur.getRole() != Role.RESPONSABLECATEGORIE) {
            response.sendRedirect("auth?action=login");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "ajusterStock":
                    ajusterStock(request, response);
                    break;
                case "traiterAlerte":
                    traiterAlerte(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("messageErreur", "Une erreur s'est produite : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
        }
    }

    private void ajusterStock(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String typeAjustement = request.getParameter("typeAjustement");

        Produit produit = produitDAO.obtenirProduitParId(idProduit);
        
        if ("ajouter".equals(typeAjustement)) {
            produit.setStock(produit.getStock() + quantite);
        } else if ("retirer".equals(typeAjustement)) {
            if (produit.getStock() < quantite) {
                request.getSession().setAttribute("messageErreur", "Stock insuffisant");
                response.sendRedirect("ResponsableStockServlet?action=alertes");
                return;
            }
            produit.setStock(produit.getStock() - quantite);
        }

        produitDAO.mettreAJourStock(idProduit, produit.getStock());
        produitDAO.verifierEtCreerAlerte(idProduit);

        request.getSession().setAttribute("messageSucces", "Stock ajusté avec succès");
        response.sendRedirect("ResponsableStockServlet?action=alertes");
    }

    private void traiterAlerte(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int idAlerte = Integer.parseInt(request.getParameter("idAlerte"));
        produitDAO.marquerAlerteCommeTraitee(idAlerte);
        response.sendRedirect("ResponsableStockServlet?action=alertes");
    }
    
    private void listerFactures(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int page = 1;
            int itemsParPage = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            int offset = (page - 1) * itemsParPage;
            List<Facture> factures = factureDAO.getFacturesWithPagination(offset, itemsParPage);
            int totalFactures = factureDAO.getTotalFactures();
            int totalPages = (int) Math.ceil((double) totalFactures / itemsParPage);

            request.setAttribute("factures", factures);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/WEB-INF/responsableStock/listeFactures.jsp")
                .forward(request, response);

        } catch (SQLException e) {
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de la récupération des factures : " + e.getMessage());
            response.sendRedirect("ResponsableStockServlet");
        }
    }

    private void voirFacture(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int idFacture = Integer.parseInt(request.getParameter("id"));
            Facture facture = factureDAO.getFactureById(idFacture);
            
            if (facture == null) {
                throw new Exception("Facture non trouvée");
            }

            request.setAttribute("facture", facture);
            request.getRequestDispatcher("/WEB-INF/responsableStock/detailsFacture.jsp")
                .forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("messageErreur", 
                "Erreur lors de l'affichage de la facture : " + e.getMessage());
            response.sendRedirect("ResponsableStockServlet?action=factures");
        }
    }
}