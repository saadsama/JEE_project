package controller;

import com.supermarche.dao.UtilisateurDAO;
import com.supermarche.model.Utilisateur;
import com.supermarche.model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/UtilisateurServlet")
public class UtilisateurServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO(); // Initialise le DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listerUtilisateurs(request, response);
            } else {
                switch (action) {
                    case "edit":
                        afficherFormulaireEdition(request, response);
                        break;
                    case "delete":
                        supprimerUtilisateur(request, response);
                        break;
                    default:
                        listerUtilisateurs(request, response);
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
                listerUtilisateurs(request, response);
            } else {
                switch (action) {
                    case "insert":
                        ajouterUtilisateur(request, response);
                        break;
                    case "update":
                        mettreAJourUtilisateur(request, response);
                        break;
                    default:
                        listerUtilisateurs(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // **1. Lister les utilisateurs**
    private void listerUtilisateurs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Utilisateur> utilisateurs = utilisateurDAO.listerUtilisateurs();
        request.setAttribute("utilisateurs", utilisateurs);
        request.getRequestDispatcher("/WEB-INF/utilisateur_crud/index.jsp").forward(request, response);
    }

    // **2. Afficher le formulaire pour ajouter ou éditer**
    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            Utilisateur utilisateur = utilisateurDAO.obtenirUtilisateurParId(id);
            request.setAttribute("utilisateur", utilisateur);
        }
        request.getRequestDispatcher("/WEB-INF/utilisateur_crud/form.jsp").forward(request, response);
    }

    // **3. Ajouter un utilisateur**
    private void ajouterUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        Role role = Role.fromString(roleParam);

        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(nom);
        utilisateur.setEmail(email);
        utilisateur.setPassword(password);
        utilisateur.setRole(role);

        utilisateurDAO.ajouterUtilisateur(utilisateur);
        response.sendRedirect("UtilisateurServlet");
    }

    // **4. Mettre à jour un utilisateur**
    private void mettreAJourUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        Role role = Role.fromString(roleParam);

        Utilisateur utilisateur = new Utilisateur(id, nom, email, password, role);
        utilisateurDAO.mettreAJourUtilisateur(utilisateur);
        response.sendRedirect("UtilisateurServlet");
    }

    // **5. Supprimer un utilisateur**
    private void supprimerUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        utilisateurDAO.supprimerUtilisateur(id);
        response.sendRedirect("UtilisateurServlet");
    }
}
