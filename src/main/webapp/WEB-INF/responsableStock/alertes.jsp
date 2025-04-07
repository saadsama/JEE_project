<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Alertes Stock</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    
    
    <style>
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

        /* Navigation Styles */
        .navbar {
            background-color: #333;
            padding: 0.5rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .nav-list {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 0;
            padding: 0;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.2rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        /* Main Container */
        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            flex-grow: 1;
        }

/* Header spécifique pour les pages d'alerte */
.alert-header {
    background: linear-gradient(135deg, var(--danger-color), var(--warning-color));
    color: white;
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2rem;
}

/* Stats Cards spécifiques */
.alert-stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.alert-stat-card {
    background: linear-gradient(145deg, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.8));
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.alert-stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* Icônes des statistiques */
.stat-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.stat-icon.critical {
    color: var(--danger-color);
}

.stat-icon.warning {
    color: var(--warning-color);
}

.stat-icon.info {
    color: var(--primary-color);
}

/* Table des alertes */
.alerts-table {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.alerts-table th {
    background-color: var(--dark-gray);
    color: white;
    padding: 1rem;
    font-weight: 500;
}

.alerts-table td {
    padding: 1rem;
    vertical-align: middle;
}

/* Status des alertes */
.alert-status {
    padding: 0.5rem 1rem;
    border-radius: 50px;
    font-weight: 500;
    text-align: center;
}

.alert-status.critical {
    background-color: rgba(220, 53, 69, 0.1);
    color: var(--danger-color);
}

.alert-status.warning {
    background-color: rgba(255, 193, 7, 0.1);
    color: var(--warning-color);
}

/* Boutons d'action */
.action-buttons {
    display: flex;
    gap: 0.5rem;
}

.btn-adjust {
    background-color: var(--primary-color);
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.btn-adjust:hover {
    background-color: var(--secondary-color);
    transform: translateY(-2px);
}

.btn-resolve {
    background-color: var(--success-color);
    color: white;
}

/* Empty state */
.empty-state {
    text-align: center;
    padding: 3rem;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    margin: 2rem 0;
}

.empty-state-icon {
    font-size: 4rem;
    color: var(--success-color);
    margin-bottom: 1rem;
}

/* Filtres et recherche */
.filters-section {
    background: rgba(255, 255, 255, 0.9);
    padding: 1rem;
    border-radius: 8px;
    margin-bottom: 1.5rem;
}

.search-box {
    display: flex;
    gap: 1rem;
    align-items: center;
}

.search-input {
    flex: 1;
    padding: 0.5rem 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
}

/* Pagination */
.pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 2rem;
}

.pagination {
    background: rgba(255, 255, 255, 0.9);
    padding: 0.5rem;
    border-radius: 8px;
}

.page-link {
    color: var(--dark-gray);
    padding: 0.5rem 1rem;
    margin: 0 0.25rem;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.page-link:hover {
    background-color: var(--primary-color);
    color: white;
}

/* Responsive Design */
@media (max-width: 768px) {
    .alert-stats-container {
        grid-template-columns: 1fr;
    }

    .action-buttons {
        flex-direction: column;
    }

    .search-box {
        flex-direction: column;
    }

    .alerts-table {
        font-size: 0.9rem;
    }

    .btn-adjust, .btn-resolve {
        width: 100%;
        margin-bottom: 0.5rem;
    }
}

/* Animation pour les cartes */
.alert-stat-card {
    animation: fadeInUp 0.5s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Tooltip styles */
.tooltip {
    position: relative;
    display: inline-block;
}

.tooltip:hover .tooltip-text {
    visibility: visible;
    opacity: 1;
}

.tooltip-text {
    visibility: hidden;
    position: absolute;
    z-index: 1;
    bottom: 125%;
    left: 50%;
    transform: translateX(-50%);
    background-color: var(--dark-gray);
    color: white;
    text-align: center;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    font-size: 0.875rem;
    opacity: 0;
    transition: opacity 0.3s;
}    
    </style>
</head>
<body>
    <!-- Header et Navigation restent les mêmes -->
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
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link active">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link ">factures</a></li>
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
        <!-- Section Statistiques Alertes -->
        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-exclamation-circle card-icon text-danger"></i>
                <div class="stat-value text-danger">${statsAlertes['CRITIQUE']}</div>
                <div class="stat-label">Alertes Critiques</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-exclamation-triangle card-icon text-warning"></i>
                <div class="stat-value text-warning">${statsAlertes['ALERTE']}</div>
                <div class="stat-label">Alertes Modérées</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock card-icon"></i>
                <div class="stat-value">${alertes.size()}</div>
                <div class="stat-label">Total Alertes Actives</div>
            </div>
        </div>

        <!-- Liste des Alertes -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-bell me-2"></i>Alertes Stock</h5>
            </div>
            <div class="card-body">
                <c:if test="${empty alertes}">
                    <div class="text-center p-4">
                        <i class="fas fa-check-circle text-success fa-3x mb-3"></i>
                        <p>Aucune alerte active actuellement</p>
                    </div>
                </c:if>
                
                <c:if test="${not empty alertes}">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Produit</th>
                                    <th>Stock Actuel</th>
                                    <th>Seuil Alerte</th>
                                    <th>Niveau</th>
                                    <th>Date Alerte</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${alertes}" var="alerte">
                                    <tr class="${alerte.niveauAlerte == 'CRITIQUE' ? 'table-danger' : 'table-warning'}">
                                        <td>${alerte.nomProduit}</td>
                                        <td>${alerte.stockActuel}</td>
                                        <td>${alerte.seuilAlerte}</td>
                                        <td>
                                            <span class="badge ${alerte.niveauAlerte == 'CRITIQUE' ? 'bg-danger' : 'bg-warning'}">
                                                ${alerte.niveauAlerte}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${alerte.dateAlerte}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="?action=ajusterStock&idProduit=${alerte.idProduit}" 
                                                   class="btn btn-primary btn-sm">
                                                    <i class="fas fa-edit"></i> Ajuster
                                                </a>
                                                <button onclick="traiterAlerte(${alerte.idAlerte})" 
                                                        class="btn btn-success btn-sm">
                                                    <i class="fas fa-check"></i> Marquer traitée
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script>
        function traiterAlerte(idAlerte) {
            if(confirm('Marquer cette alerte comme traitée ?')) {
                window.location.href = '?action=traiterAlerte&idAlerte=' + idAlerte;
            }
        }
    </script>
</body>
</html>