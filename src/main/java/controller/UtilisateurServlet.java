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
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/UtilisateurServlet")
public class UtilisateurServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO;
    private static final Logger logger = Logger.getLogger(UtilisateurServlet.class.getName());

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO();
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
                    case "add":
                        ajouterUtilisateur(request, response);
                        break;
                        
                    default:
                        listerUtilisateurs(request, response);
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur dans doGet : {0}", e.getMessage());
            throw new ServletException("Erreur lors du traitement de la requête", e);
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
                    case "add":
                        ajouterUtilisateur(request, response);
                        break;
                    case "update":
                        mettreAJourUtilisateur(request, response);
                        break;
                    default:
                        listerUtilisateurs(request, response);
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur dans doPost : {0}", e.getMessage());
            throw new ServletException("Erreur lors du traitement de la requête", e);
        }
    }

    private void listerUtilisateurs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Utilisateur> utilisateurs = utilisateurDAO.listerUtilisateurs();
            request.setAttribute("utilisateurs", utilisateurs);
            request.getRequestDispatcher("/WEB-INF/utilisateur_crud/index.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de la récupération des utilisateurs : {0}", e.getMessage());
            throw new ServletException("Impossible de récupérer les utilisateurs.", e);
        }
    }

    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Optional<Utilisateur> utilisateur = utilisateurDAO.obtenirUtilisateurParId(id);
                utilisateur.ifPresent(u -> request.setAttribute("utilisateur", u));
            }
            request.getRequestDispatcher("/WEB-INF/utilisateur_crud/form.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de l'affichage du formulaire : {0}", e.getMessage());
            throw new ServletException("Impossible d'afficher le formulaire.", e);
        }
    }

    private void ajouterUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
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
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de l'ajout d'un utilisateur : {0}", e.getMessage());
            throw new ServletException("Impossible d'ajouter l'utilisateur.", e);
        }
    }

    private void mettreAJourUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleParam = request.getParameter("role");

            Role role = Role.fromString(roleParam);
            Utilisateur utilisateur = new Utilisateur(id, nom, email, password, role);

            utilisateurDAO.mettreAJourUtilisateur(utilisateur);
            response.sendRedirect("UtilisateurServlet");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de la mise à jour de l'utilisateur : {0}", e.getMessage());
            throw new ServletException("Impossible de mettre à jour l'utilisateur.", e);
        }
    }

    private void supprimerUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            utilisateurDAO.supprimerUtilisateur(id);
            response.sendRedirect("UtilisateurServlet");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de la suppression de l'utilisateur : {0}", e.getMessage());
            throw new ServletException("Impossible de supprimer l'utilisateur.", e);
        }
    }
}
