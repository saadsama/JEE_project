<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Espace Responsable Stock</title>
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

/* Base Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
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
       

/* Main Content */
.main-container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1rem;
    flex-grow: 1;
}

/* Card Styles */
.stat-card {
    background: rgba(255, 255, 255, 0.9);
    padding: 1.5rem;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.stat-value {
    font-size: 2rem;
    font-weight: bold;
    color: var(--primary-color);
    margin-bottom: 0.5rem;
}

.stat-label {
    color: var(--dark-gray);
    font-size: 1rem;
}

.dashboard-card {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 8px;
    transition: all 0.3s ease;
    border: none;
    height: 100%;
}

.dashboard-card:hover {
    transform: translateY(-5px);
    background: var(--primary-color);
}

.card-body {
    padding: 2rem;
    text-align: center;
}

.card-icon {
    font-size: 2.5rem;
    color: var(--primary-color);
    margin-bottom: 1rem;
}

.dashboard-card:hover .card-icon {
    color: white;
}

.card-title {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: var(--dark-gray);
}

.dashboard-card:hover .card-title,
.dashboard-card:hover .card-text {
    color: white;
}

.card-text {
    color: #666;
    margin-bottom: 0;
}

/* Table Styles */
.table {
    background: white;
    border-radius: 8px;
    overflow: hidden;
}

.table th {
    background-color: var(--primary-color);
    color: white;
}

.table-danger {
    background-color: rgba(220, 53, 69, 0.1);
}

.table-warning {
    background-color: rgba(255, 193, 7, 0.1);
}

/* Alert Styles */
.alert {
    border-radius: 8px;
    margin-bottom: 1rem;
}

/* Badge Styles */
.badge {
    padding: 0.5rem 0.8rem;
    font-size: 0.9rem;
    border-radius: 50px;
}

/* Footer */
.footer {
    background-color: rgba(52, 58, 64, 0.95);
    color: white;
    text-align: center;
    padding: 1rem 0;
    margin-top: auto;
}

/* Grid Layout */
.stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.dashboard-grid {
    display: grid;
    gap: 1.5rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
        gap: 1rem;
    }

    .nav-list {
        flex-direction: column;
    }

    .nav-link {
        width: 100%;
        text-align: center;
    }

    .stats-container {
        grid-template-columns: 1fr;
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }
}
    </style>
</head>
<body>
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
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet" class="nav-link active">Home</a></li>                
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link">factures</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=alertes" class="nav-link">Alertes</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=stockCritique" class="nav-link">stockCritique</a></li>
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
        <!-- Messages de succès/erreur -->
        <c:if test="${not empty sessionScope.messageSucces}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.messageSucces}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="messageSucces" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.messageErreur}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.messageErreur}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="messageErreur" scope="session" />
        </c:if>

        <!-- Stats Section -->
        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-boxes card-icon mb-3"></i>
                <div class="stat-value">${totalProduits}</div>
                <div class="stat-label">Total Produits</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-exclamation-triangle card-icon mb-3"></i>
                <div class="stat-value text-danger">${produitsSousCritique}</div>
                <div class="stat-label">Produits en Alerte</div>
            </div>
        </div>

        <!-- Menu Cards -->
        <div class="dashboard-grid">
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card dashboard-card">
                        <a href="?action=stockCritique" class="card-link">
                            <div class="card-body">
                                <i class="fas fa-exclamation-triangle card-icon"></i>
                                <h3 class="card-title">Stock Critique</h3>
                                <p class="card-text">Produits en niveau critique</p>
                                <c:if test="${produitsSousCritique > 0}">
                                    <span class="badge bg-danger">${produitsSousCritique}</span>
                                </c:if>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card dashboard-card">
                        <a href="?action=alertes" class="card-link">
                            <div class="card-body">
                                <i class="fas fa-bell card-icon"></i>
                                <h3 class="card-title">Alertes Stock</h3>
                                <p class="card-text">Gestion des alertes</p>
                                <c:if test="${alertes.size() > 0}">
                                    <span class="badge bg-danger">${alertes.size()}</span>
                                </c:if>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dernières Alertes -->
        <div class="card mt-4">
            <div class="card-header">
                <i class="fas fa-bell me-2"></i>Dernières Alertes
            </div>
            <div class="card-body">
                <c:if test="${empty alertes}">
                    <p class="text-center">Aucune alerte active</p>
                </c:if>
                <c:if test="${not empty alertes}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Produit</th>
                                <th>Stock Actuel</th>
                                <th>Niveau</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${alertes}" var="alerte" end="4">
                                <tr>
                                    <td>${alerte.nomProduit}</td>
                                    <td>${alerte.stockActuel}</td>
                                    <td>
                                        <span class="badge ${alerte.niveauAlerte == 'CRITIQUE' ? 'bg-danger' : 'bg-warning'}">
                                            ${alerte.niveauAlerte}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${alerte.dateAlerte}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <a href="?action=ajusterStock&idProduit=${alerte.idProduit}" 
                                           class="btn btn-primary btn-sm">
                                            <i class="fas fa-edit"></i> Ajuster
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${alertes.size() > 5}">
                        <div class="text-center mt-3">
                            <a href="?action=alertes" class="btn btn-link">Voir toutes les alertes</a>
                        </div>
                    </c:if>
                </c:if>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>