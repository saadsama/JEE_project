package controller;

import com.supermarche.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Ne pas créer une nouvelle session si elle n'existe pas
        if (session != null) {
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

            if (utilisateur != null) {
                // Redirection basée sur le rôle de l'utilisateur
                switch (utilisateur.getRole()) {
                    case ADMIN:
                        response.sendRedirect("AdminServlet");
                        return;
                    case CAISSIER:
                        response.sendRedirect("CaissierServlet");
                        return;
                    case RESPONSABLECATEGORIE:
                        response.sendRedirect("ProduitServlet");
                        return;
                    default:
                        break; // Laisser tomber à la page d'accueil par défaut
                }
            }
        }

        // Si aucun utilisateur ou rôle non géré, afficher la page d'accueil par défaut
        request.getRequestDispatcher("/WEB-INF/home/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger les requêtes POST vers GET
        doGet(request, response);
    }
}
