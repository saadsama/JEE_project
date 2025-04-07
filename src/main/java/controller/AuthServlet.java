package controller;

import com.supermarche.dao.UtilisateurDAO;
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
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO;
    private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    
    @Override
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect("auth?action=login");
        } else if ("login".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/auth/signinPage.jsp").forward(request, response);
        } else if ("signup".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/auth/signupPage.jsp").forward(request, response);
        } else if ("logout".equals(action)) {
            // Gestion de la déconnexion
            HttpSession session = request.getSession(false); // Récupère la session sans en créer une nouvelle
            if (session != null) {
                session.invalidate(); // Invalide la session
            }
            request.getRequestDispatcher("/WEB-INF/home/home.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue.");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action invalide.");
            return;
        }

        try {
            switch (action) {
                case "signup":
                    inscrireUtilisateur(request, response);
                    break;
                case "login":
                    authentifierUtilisateur(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue.");
                    break;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors du traitement de l'action : {0}", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur est survenue.");
        }
    }

    private void inscrireUtilisateur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        if (nom == null || nom.isEmpty() || email == null || email.isEmpty() ||
            password == null || password.isEmpty() || roleParam == null || roleParam.isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires !");
            request.getRequestDispatcher("/WEB-INF/auth/signupPage.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("error", "Adresse email invalide !");
            request.getRequestDispatcher("/WEB-INF/auth/signupPage.jsp").forward(request, response);
            return;
        }

        try {
            Optional<Utilisateur> utilisateurExistant = utilisateurDAO.obtenirUtilisateurParEmail(email);
            if (utilisateurExistant.isPresent()) {
                request.setAttribute("error", "Cet email est déjà utilisé !");
                request.getRequestDispatcher("/WEB-INF/auth/signupPage.jsp").forward(request, response);
                return;
            }

            Role role = Role.fromString(roleParam);
            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setNom(nom);
            utilisateur.setEmail(email);
            utilisateur.setPassword(password); // Mot de passe en clair
            utilisateur.setRole(role);

            utilisateurDAO.inscrireUtilisateur(utilisateur);
            logger.log(Level.INFO, "Utilisateur inscrit avec succès : {0}", email);

            response.sendRedirect("auth?action=login");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de l'inscription de l'utilisateur : {0}", e.getMessage());
            request.setAttribute("error", "Une erreur est survenue. Veuillez réessayer.");
            request.getRequestDispatcher("/WEB-INF/auth/signupPage.jsp").forward(request, response);
        }
    }

    private void authentifierUtilisateur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email et mot de passe sont obligatoires.");
            request.getRequestDispatcher("/WEB-INF/auth/signinPage.jsp").forward(request, response);
            return;
        }

        try {
            Optional<Utilisateur> utilisateurOpt = utilisateurDAO.authentifierUtilisateur(email, password);
            if (utilisateurOpt.isPresent()) {
                Utilisateur utilisateur = utilisateurOpt.get();

                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);

                session.setMaxInactiveInterval(30 * 60);

                logger.log(Level.INFO, "Utilisateur authentifié avec succès : {0}", email);

                response.sendRedirect(getRedirectURL(utilisateur.getRole()));
            } else {
                request.setAttribute("error", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("/WEB-INF/auth/signinPage.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erreur lors de l'authentification de l'utilisateur : {0}", e.getMessage());
            request.setAttribute("error", "Une erreur est survenue. Veuillez réessayer.");
            request.getRequestDispatcher("/WEB-INF/auth/signinPage.jsp").forward(request, response);
        }
    }

    private String getRedirectURL(Role role) {
        switch (role) {
            case ADMIN:
                return "AdminServlet";
            case CAISSIER:
                return "CaissierServlet";
            case RESPONSABLECATEGORIE:
                return "ResponsableStockServlet";
            default:
                return "auth?action=login";
        }
    }
}
