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

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            // Redirige par défaut vers la page signup si aucune action n'est spécifiée
            request.getRequestDispatcher("/WEB-INF/auth/signup.jsp").forward(request, response);
        } else if ("signup".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/auth/signup.jsp").forward(request, response);
        } else if ("login".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("signup".equals(action)) {
            inscrireUtilisateur(request, response);
        } else if ("login".equals(action)) {
            authentifierUtilisateur(request, response);
        }
    }

    private void inscrireUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        if (nom == null || email == null || password == null || roleParam == null) {
            request.setAttribute("error", "Tous les champs sont obligatoires !");
            request.getRequestDispatcher("/WEB-INF/auth/signup.jsp").forward(request, response);
            return;
        }

        Role role = Role.fromString(roleParam);

        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(nom);
        utilisateur.setEmail(email);
        utilisateur.setPassword(password); // Vous pouvez appliquer un hash ici
        utilisateur.setRole(role);

        utilisateurDAO.inscrireUtilisateur(utilisateur);
        response.sendRedirect("auth?action=login"); // Redirige vers la page de connexion après inscription
    }

    private void authentifierUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null) {
            request.setAttribute("error", "Email et mot de passe sont obligatoires.");
            request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
            return;
        }

        Utilisateur utilisateur = utilisateurDAO.authentifierUtilisateur(email, password);
        if (utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);

            // Redirige vers home.jsp (situé dans /WEB-INF/home/)
            request.getRequestDispatcher("/WEB-INF/home/home.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
        }
    }

}
