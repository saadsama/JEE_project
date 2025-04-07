<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Factures - SuperMarché</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
		  .nav-link.active {
            background: var(--primary-color);
            color: black;
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

        .header-tools {
            display: flex;
            gap: 1rem;
        }

        .header-tool {
            color: white;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s;
        }

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
            transition: all 0.3s;
        }

        .main-container {
            flex: 1;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-badge {
            padding: 0.5rem 1rem;
            border-radius: 50rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #333;
            color: white;
            padding: 1rem;
        }

        .btn-group {
            display: flex;
            gap: 0.5rem;
        }

        .btn-custom {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }
        
        .content-card {
    background: rgba(255, 255, 255, 0.7);  /* Make the card semi-transparent */
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    overflow: hidden;
}

.table {
    margin-bottom: 0;
    background: transparent;
}

.table tbody {
    background: transparent;
}

.table tbody tr {
    background: transparent;
}

.table tbody td {
    background: transparent;
    color: #000;  /* Ensure text remains visible */
}

        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
        }

        .page-link {
            color: var(--text-color);
            background: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .page-link:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .footer {
            background: #333;
            color: white;
            padding: 1rem 0;
            text-align: center;
            margin-top: auto;
        }

        .alert {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                gap: 1rem;
            }

            .btn-group {
                flex-direction: column;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/HomeServlet" class="header-brand">
                <i class="fas fa-shopping-cart header-logo"></i>
                <h1>SuperMarché</h1>
            </a>
            <div class="header-tools">
                <a href="#" class="header-tool" title="Notifications">
                    <i class="fas fa-bell"></i>
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
                <li><a href="${pageContext.request.contextPath}/CaissierServlet" class="nav-link ">Creer Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listePaniers" class="nav-link ">Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listerFactures" class="nav-link active">Factures</a></li>
                
                <li style="margin-left: auto;">
                    <span class="nav-link">
                        <i class="fas fa-user me-2"></i>
                        ${sessionScope.utilisateur.nom}
                    </span>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-link">
                        <i class="fas fa-sign-out-alt me-2"></i>
                        Déconnexion
                    </a>
                </li>  
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Messages -->
        <c:if test="${not empty sessionScope.messageErreur}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                ${sessionScope.messageErreur}
            </div>
            <c:remove var="messageErreur" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.messageSucces}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${sessionScope.messageSucces}
            </div>
            <c:remove var="messageSucces" scope="session"/>
        </c:if>

        <!-- Factures Card -->
        <div class="content-card">
            <div class="card-header">
                <h2>
                    <i class="fas fa-file-invoice me-2"></i>
                    Liste des Factures
                </h2>
                <div class="btn-group">
                    <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class="fas fa-filter me-2"></i>
                        Filtrer par statut
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="?filter=all">Toutes</a></li>
                        <li><a class="dropdown-item" href="?filter=emise">Émises</a></li>
                        <li><a class="dropdown-item" href="?filter=payee">Payées</a></li>
                        <li><a class="dropdown-item" href="?filter=annulee">Annulées</a></li>
                    </ul>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>N° Facture</th>
                            <th>Date</th>
                            <th>Total HT</th>
                            <th>Total TTC</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="facture" items="${factures}">
                            <tr>
                                <td>${facture.numeroFacture}</td>
                                <td>
                                    <fmt:formatDate value="${facture.dateFacture}" 
                                                  pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${facture.totalHT}" 
                                                    type="number" maxFractionDigits="2"/> MAD
                                </td>
                                <td>
                                    <fmt:formatNumber value="${facture.totalTTC}" 
                                                    type="number" maxFractionDigits="2"/> MAD
                                </td>
                                <td>
                                    <span class="stat-badge ${facture.statut == 'EMISE' ? 'bg-warning' : 
                                                           facture.statut == 'PAYEE' ? 'bg-success' : 
                                                           'bg-danger'}">
                                        <i class="fas ${facture.statut == 'EMISE' ? 'fa-clock' : 
                                                    facture.statut == 'PAYEE' ? 'fa-check-circle' : 
                                                    'fa-times-circle'}"></i>
                                        ${facture.statut}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="CaissierServlet?action=detailsFacture&idFacture=${facture.idFacture}" 
                                           class="btn btn-info btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <button class="btn btn-secondary btn-sm dropdown-toggle" 
                                                type="button" 
                                                data-bs-toggle="dropdown">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <form action="CaissierServlet" method="post">
                                                    <input type="hidden" name="action" value="modifierStatutFacture">
                                                    <input type="hidden" name="idFacture" value="${facture.idFacture}">
                                                    <input type="hidden" name="nouveauStatut" value="EMISE">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="fas fa-circle text-warning me-2"></i>Émise
                                                    </button>
                                                </form>
                                            </li>
                                            <li>
                                                <form action="CaissierServlet" method="post">
                                                    <input type="hidden" name="action" value="modifierStatutFacture">
                                                    <input type="hidden" name="idFacture" value="${facture.idFacture}">
                                                    <input type="hidden" name="nouveauStatut" value="PAYEE">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="fas fa-circle text-success me-2"></i>Payée
                                                    </button>
                                                </form>
                                            </li>
                                            <li>
                                                <form action="CaissierServlet" method="post">
                                                    <input type="hidden" name="action" value="modifierStatutFacture">
                                                    <input type="hidden" name="idFacture" value="${facture.idFacture}">
                                                    <input type="hidden" name="nouveauStatut" value="ANNULEE">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="fas fa-circle text-danger me-2"></i>Annulée
                                                    </button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
     			<nav aria-label="Navigation des pages" class="mt-4 mb-3">
    <ul class="pagination">
        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="CaissierServlet?action=listerFactures&page=${currentPage - 1}">
                <i class="fas fa-chevron-left"></i>
            </a>
        </li>
        
        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="CaissierServlet?action=listerFactures&page=${i}">${i}</a>
            </li>
        </c:forEach>
        
        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link" href="CaissierServlet?action=listerFactures&page=${currentPage + 1}">
                <i class="fas fa-chevron-right"></i>
            </a>
        </li>
    </ul>
</nav>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    
    </body>
</html>