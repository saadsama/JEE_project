<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Paniers - SuperMarché</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Styles personnalisés */
        .header {
            background-color: #ffc107;
            color: white;
            padding: 20px 0;
        }
        .nav-custom {
            background-color: #0056b3;
        }
        .nav-custom .nav-link {
            color: white;
        }
        .nav-custom .nav-link:hover {
            background-color: #003d7a;
        }
        footer {
            background-color: #333;
            color: white;
            padding: 10px 0;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1><i class="fas fa-shopping-cart"></i> SuperMarché</h1>
                </div>
                <div class="col text-end">
                    <a href="#" class="btn btn-outline-light" title="Notifications">
                        <i class="fas fa-bell"></i>
                    </a>
                    <a href="#" class="btn btn-outline-light" title="Paramètres">
                        <i class="fas fa-cog"></i>
                    </a>
                    <a href="#" class="btn btn-outline-light" title="Profil">
                        <i class="fas fa-user"></i>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <nav class="navbar navbar-expand-lg nav-custom">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath()%>/HomeServlet">Accueil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/PanierServlet?action=list">Paniers</a>
                    </li>
                    <!-- Ajoutez d'autres liens de navigation selon les rôles -->
                </ul>
                <ul class="navbar-nav ms-auto">
                    <c:if test="${empty sessionScope.utilisateur}">
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/auth?action=login">Connexion</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.utilisateur}">
                        <li class="nav-item">
                            <span class="nav-link">
                                <strong>${sessionScope.utilisateur.nom}</strong> (${sessionScope.utilisateur.role})
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/auth?action=logout">Déconnexion</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center mb-4">Gestion des Paniers</h2>

        <!-- Messages d'erreur ou succès -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <!-- Liste des produits -->
        <h3>Produits Disponibles</h3>
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Nom</th>
                        <th>Prix</th>
                        <th>Stock</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="produit" items="${produits}">
                        <tr>
                            <td>${produit.nom}</td>
                            <td>${produit.prix}</td>
                            <td>${produit.stock}</td>
                            <td>
                                <form action="PanierServlet" method="post" class="d-flex">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="idProduit" value="${produit.idProduit}">
                                    <input type="number" name="quantite" min="1" max="${produit.stock}" required class="form-control form-control-sm me-2" style="width: 70px;">
                                    <button type="submit" class="btn btn-success btn-sm">Ajouter</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Liste des articles dans le panier -->
        <h3 class="mt-5">Articles dans le Panier</h3>
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Nom</th>
                        <th>Prix Unitaire</th>
                        <th>Quantité</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="article" items="${panierProduits}">
                        <tr>
                            <td>${article.produit.nom}</td>
                            <td>${article.produit.prix}</td>
                            <td>${article.quantite}</td>
                            <td>
                                <a href="PanierServlet?action=remove&idPanierProduit=${article.idPanierProduit}" class="btn btn-danger btn-sm">Retirer</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Bouton pour finaliser -->
        <div class="text-end mt-3">
            <a href="PanierServlet?action=finalize" class="btn btn-primary">Finaliser le Panier</a>
        </div>
    </div>

    <footer class="text-center">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>