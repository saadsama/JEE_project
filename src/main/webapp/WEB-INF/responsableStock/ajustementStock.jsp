<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Ajustement Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #ffc107;
            --secondary-color: #0056b3;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --light-gray: #f8f9fa;
            --dark-gray: #343a40;
        }

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
    
    

        /* Main Content */
        .main-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .adjustment-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .product-info {
            background: var(--light-gray);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .product-info h3 {
            color: var(--dark-gray);
            margin-bottom: 1rem;
        }

        .stock-indicator {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .stock-level {
            flex-grow: 1;
            height: 10px;
            background-color: #e9ecef;
            border-radius: 5px;
            overflow: hidden;
        }

        .stock-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--danger-color), var(--warning-color));
            transition: width 0.3s ease;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1rem 0;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background-color: var(--light-gray);
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quantity-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .quantity-input {
            width: 100px;
            text-align: center;
            font-size: 1.2rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
     <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="header-brand">
                <i class="fas fa-shopping-cart header-logo"></i>
                <h1 class="header-title">SuperMarché - Espace Responsable Stock</h1>
            </div>
            <div class="header-tools">
                <a href="?action=alertes" class="header-tool" title="Alertes">
                    <i class="fas fa-bell"></i>
                    <c:if test="${alertes.size() > 0}">
                        <span class="badge bg-danger">${alertes.size()}</span>
                    </c:if>
                </a>
                <a href="#" class="header-tool" title="Paramètres">
                    <i class="fas fa-cog"></i>
                </a>
                <a href="#" class="header-tool" title="Profil">
                    <i class="fas fa-user"></i>
                </a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/HomeServlet" class="nav-link">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link">Factures</a></li>
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
        <div class="adjustment-card">
            <h2 class="text-center mb-4">
                <i class="fas fa-box me-2"></i>
                Ajustement du Stock
            </h2>

            <!-- Product Info -->
            <div class="product-info">
                <h3>${produit.nom}</h3>
                <div class="stock-indicator">
                    <span>Stock actuel:</span>
                    <div class="stock-level">
                        <div class="stock-bar" style="width: ${(produit.stock/100)*100}%"></div>
                    </div>
                    <strong>${produit.stock} unités</strong>
                </div>
                <p class="mb-0">
                    <small class="text-muted">Prix unitaire:</small>
                    <strong><fmt:formatNumber value="${produit.prix}" type="currency" currencySymbol="€"/></strong>
                </p>
            </div>

            <!-- Adjustment Form -->
            <form action="?action=ajusterStock" method="POST" id="ajustementForm">
                <input type="hidden" name="idProduit" value="${produit.idProduit}">
                
                <div class="mb-4">
                    <label class="form-label">Type d'ajustement</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="typeAjustement" 
                               id="ajouter" value="ajouter" checked>
                        <label class="form-check-label" for="ajouter">
                            <i class="fas fa-plus-circle text-success me-2"></i>Ajouter au stock
                        </label>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Quantité à ajuster</label>
                    <div class="quantity-control">
                        <button type="button" class="quantity-btn" onclick="adjustQuantity(-1)">-</button>
                        <input type="number" name="quantite" id="quantite" 
                               class="quantity-input" value="1" min="1">
                        <button type="button" class="quantity-btn" onclick="adjustQuantity(1)">+</button>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Valider l'ajustement
                    </button>
                    <a href="?action=stockCritique" class="btn btn-outline-secondary">
                        <i class="fas fa-times me-2"></i>Annuler
                    </a>
                </div>
            </form>
        </div>
    </main>

     <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script>
        function adjustQuantity(amount) {
            const input = document.getElementById('quantite');
            const newValue = parseInt(input.value) + amount;
            if (newValue >= 1) {
                input.value = newValue;
            }
        }

        document.getElementById('ajustementForm').onsubmit = function(e) {
            const quantite = document.getElementById('quantite').value;
            const typeAjustement = document.querySelector('input[name="typeAjustement"]:checked').value;
            const stockActuel = ${produit.stock};

            if (typeAjustement === 'retirer' && quantite > stockActuel) {
                e.preventDefault();
                alert('La quantité à retirer ne peut pas être supérieure au stock actuel.');
                return false;
            }
        };
    </script>
</body>
</html>