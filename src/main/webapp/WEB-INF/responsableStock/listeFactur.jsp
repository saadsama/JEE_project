<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Consultation des Factures</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
    
    	:root {
    --primary-color: #ffc107;
    --secondary-color: #ff9800;
    --text-color: #2c3e50;
    --bg-color: #f8f9fa;
}

/* Body styles */
		body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    max-height: 100vh;
    background-image: url('${pageContext.request.contextPath}/images/Background.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    position: relative;
    overflow-x: hidden;
	}
	
	.main-container {
	    flex: 1;
	    padding: 1rem;
	    margin: 0 auto;
	    width: 100%;
	    max-width: 1200px;
	    overflow-y: auto;
	    height: calc(100vh - 160px); /* Adjust based on header + footer height */
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
    		
        .facture-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }

        .facture-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .statut-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
        }

        .statut-badge.emise {
            background-color: var(--warning-color);
            color: var(--dark-gray);
        }

        .statut-badge.payee {
            background-color: var(--success-color);
            color: white;
        }

        .statut-badge.annulee {
            background-color: var(--danger-color);
            color: white;
        }

        .filters-section {
            background: rgba(255, 255, 255, 0.9);
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
       	.card {
    background: transparent !important;
    border: none;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.card-body {
    background: transparent !important;
    backdrop-filter: blur(5px);
    overflow-y: auto;
    flex: 1;
}
.card-header {
    background: rgba(51, 51, 51, 0.8) !important;
    color: white;
    border-top-left-radius: 10px !important;
    border-top-right-radius: 10px !important;
    padding: 1rem 1.5rem;
}


        
       .content-card {
    background: transparent !important;
    box-shadow: none !important;
}

.content-card {
    background: transparent !important;
    backdrop-filter: blur(5px);
}

/* Make table background transparent */
.table-responsive {
    max-height: calc(100vh - 300px); /* Adjust based on other elements */
    overflow-y: auto;
}

.table {
    margin-bottom: 0;
}

.table thead {
    position: sticky;
    top: 0;
    z-index: 1;
}

.table thead th {
    background-color: rgba(51, 51, 51, 0.8) !important;
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.2);
    padding: 1rem;
}

.table tbody tr {
    background-color: transparent !important;
}

.table tbody td {
    background-color: transparent !important;
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: white;
    padding: 1rem;
}

.pagination-container {
    position: sticky;
    bottom: 0;
    background: rgba(255, 255, 255, 0.1);
    padding: 1rem;
    backdrop-filter: blur(5px);
}

/* Status badge styles */
.statut-badge {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}
			
			statut-badge.emise {
    background: rgba(255, 193, 7, 0.9);
    color: #000;
}

.statut-badge.payee {
    background: rgba(40, 167, 69, 0.9);
    color: white;
}

.statut-badge.annulee {
    background: rgba(220, 53, 69, 0.9);
    color: white;
}
.btn-primary {
    background: rgba(13, 110, 253, 0.9);
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    transition: all 0.3s;
}

.btn-primary:hover {
    background: rgba(13, 110, 253, 1);
    transform: translateY(-2px);
}

/* Pagination styles */
.pagination {
    margin-top: 1.5rem;
}

.page-link {
    background-color: rgba(255, 255, 255, 0.9);
    border: none;
    color: var(--text-color);
    padding: 0.5rem 1rem;
    margin: 0 0.25rem;
    border-radius: 8px;
    transition: all 0.3s;
}

.page-link:hover {
    background-color: var(--primary-color);
    color: white;
    transform: translateY(-2px);
}

.page-item.active .page-link {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

/* Footer styles */
.footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 1rem 0;
    width: 100%;
    position: sticky;
    bottom: 0;
}
    </style>
</head>
<body>
    <!-- Header et Navigation -->
     <header class="header">
        <div class="header-container">
            <div class="header-brand " >
                <i class="fas fa-facture header-logo"></i>
                <h1 class="header-title">La liste des factures</h1>
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
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link active">factures</a></li>
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
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-file-invoice me-2"></i>Liste des Factures
            </h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
			        <tr>
			            <th>N° Facture</th>
			            <th>Date</th>
			            <th>Montant TTC</th>
			            <th>Statut</th>
			            <th>Action</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${factures}" var="facture">
			            <tr>
			                <td>${facture.numeroFacture}</td>
			                <td>
			                    <fmt:formatDate value="${facture.dateFacture}"
			                        pattern="dd/MM/yyyy HH:mm"/>
			                </td>
			                <td>
			                    <fmt:formatNumber value="${facture.totalTTC}"
			                        type="currency" currencySymbol="€"/>
			                </td>
			                <td>
			                    <span class="statut-badge ${facture.statut.toLowerCase()}">
			                        <i class="fas ${facture.statut == 'EMISE' ? 'fa-clock' : 
			                                    facture.statut == 'PAYEE' ? 'fa-check-circle' : 
			                                    'fa-times-circle'}"></i>
			                        ${facture.statut}
			                    </span>
			                </td>
			                <td>
			                    <a href="?action=voirFacture&id=${facture.idFacture}"
			                        class="btn btn-primary btn-sm">
			                        <i class="fas fa-eye"></i> Voir détails
			                    </a>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
                </table>
            </div>
            
            <!-- Pagination with container -->
            <div class="pagination-container">
                <div class="d-flex justify-content-center">
                    <ul class="pagination mb-0">
                        
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?action=factures&page=${currentPage - 1}">Précédent</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <li class="page-item ${currentPage == page ? 'active' : ''}">
                                <a class="page-link" href="?action=factures&page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?action=factures&page=${currentPage + 1}">Suivant</a>
                        </li>
                    
                    </ul>
                </div>
            </div>
        </div>
    </div>
</main>
		 <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>