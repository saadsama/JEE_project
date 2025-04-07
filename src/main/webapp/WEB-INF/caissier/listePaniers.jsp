<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Paniers - SuperMarché</title>
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
        .nav-link.active {
            background: var(--primary-color);
            color: black;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: white;
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
            transition: all 0.3s;
        }

        .nav-link:hover {
            background: rgba(255,255,255,0.1);
        }

        /* Main Content */
        .main-container {
            flex: 1;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            background: rgba(0,0,0,0);
        }

        .content-card {
            background: rgba(0,0,0,0.5);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .btn-custom {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255,193,7,0.4);
            color: white;
        }

        .table thead th {
            background: rgba(0,0,0,0.1);
            color: white;
            font-weight: 500;
            padding: 1rem;
        }
        
         .table tbody tr  {
            background-color: rgba(0,0,0,0.2);
            color: white;
            font-weight: 500;
            padding: 1rem;
        }
        

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 50rem;
            font-weight: 500;
        }

        /* Status badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-badge i {
            font-size: 0.875rem;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
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

        .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        /* Footer */
        .footer {
            background: #333;
            color: white;
            padding: 1rem 0;
            text-align: center;
            margin-top: auto;
        }

        /* Action buttons */
        .btn-group {
            display: flex;
            gap: 0.5rem;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            border-radius: 6px;
            transition: all 0.3s;
        }

        .btn-sm:hover {
            transform: translateY(-2px);
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

            .btn-sm {
                width: 100%;
                justify-content: center;
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
                <li><a href="${pageContext.request.contextPath}//CaissierServlet" class="nav-link ">Creer Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}//CaissierServlet?action=listePaniers" class="nav-link active">Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listerFactures" class="nav-link">Factures</a></li>
                
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
        <div class="content-card">
            <div class="card-header">
                <h2 style="color : orange">
                    <i class="fas fa-shopping-basket me-2"></i>
                    Liste des Paniers
                </h2>
                <a href="CaissierServlet" class="btn-custom">
                    <i class="fas fa-plus"></i>
                    Nouveau Panier
                </a>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>N° Panier</th>
                            <th>Date</th>
                            <th>Nombre de produits</th>
                            <th>Total</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody >
                        <c:forEach var="detail" items="${paniersDetails}">
                            <tr style="background: rgba(0,0,0,0.4)">
                                <td style="background: rgba(0,0,0,0.4) ; color:orange">#${detail.panier.idPanier}</td>
                                <td style="background: rgba(0,0,0,0.4) ; color:orange">
                                    <fmt:formatDate value="${detail.panier.dateCreation}" 
                                                  pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td style="background: rgba(0,0,0,0.4) ; color:orange">${detail.produits.size()}</td>
                                <td style="background: rgba(0,0,0,0.4) ; color:orange"><strong>${detail.total} MAD</strong></td>
                                <td style="background: rgba(0,0,0,0.4) ; color:orange">
                                    <c:choose>
                                        <c:when test="${detail.panier.statut == 'FACTURE'}">
                                            <span class="status-badge bg-info">
                                                <i class="fas fa-file-invoice"></i>
                                                FACTURÉ
                                            </span>
                                        </c:when>
                                        <c:when test="${detail.panier.statut == 'FINALISE'}">
                                            <span class="status-badge bg-success">
                                                <i class="fas fa-check-circle"></i>
                                                FINALISÉ
                                            </span>
                                        </c:when>
                                        <c:when test="${detail.panier.statut == 'EN_COURS'}">
                                            <span class="status-badge bg-warning">
                                                <i class="fas fa-clock"></i>
                                                EN COURS
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td style="background: rgba(0,0,0,0.4) ; color:orange">
                                    <div class="btn-group">
                                        <c:if test="${detail.panier.statut == 'EN_COURS'}">
                                            <form action="CaissierServlet" method="post">
                                                <input type="hidden" name="action" value="rouvrirDernierPanier">
                                                <input type="hidden" name="idPanier" value="${detail.panier.idPanier}">
                                                <button type="submit" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                    Modifier
                                                </button>
                                            </form>
                                            <form action="CaissierServlet" method="post">
                                                <input type="hidden" name="action" value="validate">
                                                <input type="hidden" name="idPanier" value="${detail.panier.idPanier}">
                                                <button type="submit" class="btn btn-success btn-sm">
                                                    <i class="fas fa-check"></i>
                                                    Finaliser
                                                </button>
                                            </form>
                                        </c:if>

                                        <c:if test="${detail.panier.statut == 'FINALISE'}">
                                            <form action="CaissierServlet" method="post">
                                                <input type="hidden" name="action" value="creerEtSauvegarderFacture">
                                                <input type="hidden" name="idPanier" value="${detail.panier.idPanier}">
                                                <button type="submit" class="btn btn-success btn-sm">
                                                    <i class="fas fa-file-invoice"></i>
                                                    Créer Facture
                                                </button>
                                            </form>
                                        </c:if>

                                        <c:if test="${detail.panier.statut == 'FACTURE'}">
                                            <form action="CaissierServlet" method="post">
                                                <input type="hidden" name="action" value="voirFacture">
                                                <input type="hidden" name="idPanier" value="${detail.panier.idPanier}">
                                                <button type="submit" class="btn btn-info btn-sm">
                                                    <i class="fas fa-print"></i>
                                                    Imprimer
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            		<nav aria-label="Navigation des pages">
    <ul class="pagination">
        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="CaissierServlet?action=listePaniers&page=${currentPage - 1}">
                <i class="fas fa-chevron-left"></i>
            </a>
        </li>
        
        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="CaissierServlet?action=listePaniers&page=${i}">${i}</a>
            </li>
        </c:forEach>
        
        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link" href="CaissierServlet?action=listePaniers&page=${currentPage + 1}">
                <i class="fas fa-chevron-right"></i>
            </a>
        </li>
    </ul>
</nav>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>