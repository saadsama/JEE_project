<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Produits en Stock Critique</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsableStock.css">
    <style>
     :root {
            --primary-color: #ffc107;
            --secondary-color: #ff9800;
            --text-color: #2c3e50;
            --bg-color: #f8f9fa;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		    line-height: 1.6;
		    display: flex;
		    flex-direction: column;
		    min-height: 100vh;
		    background-image: url('${pageContext.request.contextPath}/images/Background.jpg');
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		    background-attachment: fixed;
		    position: relative;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: white;
            text-decoration: none;
        }

        .header-logo {
            font-size: 2rem;
        }

        .header-title {
            margin: 0;
            font-size: 1.5rem;
        }

        .header-tools {
            display: flex;
            gap: 1rem;
        }

        .header-tool {
            color: white;
            text-decoration: none;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s;
        }

        .header-tool:hover {
            background: rgba(255,255,255,0.2);
        }

        /* Navbar Styles */
        .navbar {
            background: #333;
            padding: 0;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .nav-list {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 1rem 1.5rem;
            display: block;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background:  orange;
        }

        .nav-link.active {
            background: var(--primary-color);
            color: black;
        }

        /* Main Content Styles */
        .main-container {
            flex: 1;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .content-title {
            margin: 0;
            font-size: 1.8rem;
            color: var(--text-color);
        }
    
    
    
        .critical-warning {
            background: linear-gradient(135deg, var(--danger-color), var(--warning-color));
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            text-align: center;
        }

        .stock-level {
            width: 100px;
            height: 10px;
            background-color: #e9ecef;
            border-radius: 5px;
            overflow: hidden;
            margin: 0 auto;
        }

        .stock-bar {
            height: 100%;
            background-color: var(--danger-color);
            transition: width 0.3s ease;
        }

        .product-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            transition: transform 0.3s ease;
            border: none;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .btn-group-vertical > .btn {
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="header-brand " >
                <i class="fas fa-exclamation-triangle header-logo"></i>
                <h1 class="header-title">Produits en Stock Critique</h1>
            </div>
            <div class="header-tools">
                <a href="?action=alertes" class="header-tool" title="Alertes">
                    <i class="fas fa-bell"></i>
                    <span class="badge bg-danger">${produits.size()}</span>
                </a>
                <a href="?action=dashboard" class="header-tool" title="Dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                </a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
             <ul class="nav-list">
             	<li><a href="${pageContext.request.contextPath}/ResponsableStockServlet" class="nav-link ">Home</a></li>     
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link ">factures</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=alertes" class="nav-link ">Alertes</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=stockCritique" class="nav-link active">stockCritique</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=statistiquesVentes" class="nav-link">statistique des ventes</a></li>
                <li style="margin-left: auto;">
                    <span class="nav-link">
                        <i class="fas fa-user me-2" style="color: orange"></i>
                        ${sessionScope.utilisateur.nom}
                    </span>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-link">
                        <i class="fas fa-sign-out-alt me-2"></i>
                        Deconnexion
                    </a>
                </li> 
            </ul>
        </div>
    </nav>

    <main class="main-container">
        <!-- Warning Banner -->
        <div class="critical-warning" style="color : orange ; background-color: white" >
            <i class="fas fa-exclamation-circle fa-2x mb-2"></i>
            <h3>Attention : ${produits.size()} produits en stock critique</h3>
            <p class="mb-0">Ces produits nécessitent une attention immédiate</p>
        </div>

        <!-- Produits Critiques -->
        <div class="row">
            <c:forEach items="${produits}" var="produit">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card product-card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h5 class="card-title">${produit.nom}</h5>
                                <span class="badge bg-danger">Stock: ${produit.stock}</span>
                            </div>
                            
                            <div class="mb-3">
                                <small class="text-muted">Niveau de stock</small>
                                <div class="stock-level">
                                    <div class="stock-bar" style="width: ${(produit.stock/10)*100}%"></div>
                                </div>
                            </div>
                            
                            <p class="card-text">
                                <small class="text-muted">Prix: </small>
                                <strong><fmt:formatNumber value="${produit.prix}" type="currency" currencySymbol="€"/></strong>
                            </p>

                            <div class="btn-group-vertical w-100">
                                <a href="?action=ajusterStock&idProduit=${produit.idProduit}" 
                                   class="btn btn-warning">
                                    <i class="fas fa-edit me-2"></i>Ajuster le stock
                                </a>
                                <button type="button" 
                                        class="btn btn-outline-primary"
                                        onclick="commanderProduit(${produit.idProduit})">
                                    <i class="fas fa-shopping-cart me-2"></i>Commander
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State -->
        <c:if test="${empty produits}">
            <div class="text-center p-5">
                <i class="fas fa-check-circle text-success fa-3x mb-3"></i>
                <h4>Aucun produit en stock critique</h4>
                <p class="text-muted">Tous les stocks sont à des niveaux acceptables</p>
                <a href="?action=dashboard" class="btn btn-primary mt-3">
                    Retour au tableau de bord
                </a>
            </div>
        </c:if>
    </main>

    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function commanderProduit(idProduit) {
            // À implémenter: Logique pour commander le produit
            alert('Fonctionnalité de commande à implémenter pour le produit ' + idProduit);
        }
    </script>
</body>
</html>