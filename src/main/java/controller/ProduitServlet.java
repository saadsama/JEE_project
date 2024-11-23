package controller;

import com.supermarche.dao.ProduitDAO;
import com.supermarche.dao.CategorieDAO;
import com.supermarche.model.Produit;
import com.supermarche.model.Categorie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProduitServlet")
public class ProduitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;
    private CategorieDAO categorieDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAO();
        categorieDAO = new CategorieDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listerProduits(request, response);
            } else {
                switch (action) {
                    case "add":
                        afficherFormulaireAjout(request, response);
                        break;
                    case "edit":
                        afficherFormulaireEdition(request, response);
                        break;
                    case "delete":
                        supprimerProduit(request, response);
                        break;
                    default:
                        listerProduits(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listerProduits(request, response);
            } else {
                switch (action) {
                    case "insert":
                        ajouterProduit(request, response);
                        break;
                    case "update":
                        mettreAJourProduit(request, response);
                        break;
                    default:
                        listerProduits(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listerProduits(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Produit> produits = produitDAO.listerProduits();
        request.setAttribute("produits", produits);
        request.getRequestDispatcher("/WEB-INF/produit_crud/index.jsp").forward(request, response);
    }

    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Categorie> categories = categorieDAO.listerCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/produit_crud/form.jsp").forward(request, response);
    }

    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProduit = Integer.parseInt(request.getParameter("id"));
        Produit produit = produitDAO.obtenirProduitParId(idProduit);
        List<Categorie> categories = categorieDAO.listerCategories();
        request.setAttribute("produit", produit);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/produit_crud/form.jsp").forward(request, response);
    }

    private void ajouterProduit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        double prix = Double.parseDouble(request.getParameter("prix"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));

        Categorie categorie = categorieDAO.obtenirCategorieParId(idCategorie);
        Produit produit = new Produit(0, nom, description, prix, stock, categorie);
        produitDAO.ajouterProduit(produit);

        response.sendRedirect("ProduitServlet");
    }

    private void mettreAJourProduit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idProduit = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        double prix = Double.parseDouble(request.getParameter("prix"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));

        Categorie categorie = categorieDAO.obtenirCategorieParId(idCategorie);
        Produit produit = new Produit(idProduit, nom, description, prix, stock, categorie);
        produitDAO.mettreAJourProduit(produit);

        response.sendRedirect("ProduitServlet");
    }

    private void supprimerProduit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idProduit = Integer.parseInt(request.getParameter("id"));
        produitDAO.supprimerProduit(idProduit);
        response.sendRedirect("ProduitServlet");
    }
}

