<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion du Panier - SuperMarché</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
    
    html {
    scroll-behavior: smooth;
		}
		
		#paniersEnCours {
		    scroll-margin-top: 2rem;
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

        /* Card Styles */
        .card-container {
            background: rgba(0,0,0,0.5);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        /* Table Styles */
        .table-responsive {
            margin-bottom: 1.5rem;
        }

        .table {
            margin-bottom: 0;
            font-size : 1.2 rem ;
            
        }

        .table thead th {
            background: rgba(255, 165, 0, 0.5);
            color: white;
            font-weight: 500;
            padding: 1rem;
        }

        .table tbody td {
        	font-size : 1.2 rem ;
            vertical-align: middle;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.5);
        }

        /* Form Controls */
        .quantity-input {
            width: 80px !important;
            text-align: center;
            padding: 0.375rem 0.75rem;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            transition: border-color 0.15s ease-in-out;
        }

        .quantity-input:focus {
            border-color: var(--primary-color);
            outline: 0;
            box-shadow: 0 0 0 0.25rem rgba(255, 193, 7, 0.25);
        }

        /* Search Bar */
        .search-container {
            position: relative;
            max-width: 300px;
            margin-bottom: 1rem;
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .search-input {
            padding-left: 2.5rem;
            border-radius: 8px;
            border: 1px solid #ced4da;
        }

        /* Button Styles */
        .btn-custom {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        /* Status Badges */
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 50rem;
            font-weight: 500;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #6c757d;
        }

        .empty-state-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-list {
                flex-direction: column;
            }

            .content-header {
                flex-direction: column;
                gap: 1rem;
            }

            .search-container {
                width: 100%;
                max-width: none;
            }

            .card-header {
                flex-direction: column;
                gap: 1rem;
            }

            .btn-group {
                flex-direction: column;
                width: 100%;
            }

            .btn-custom {
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
            <div class="header-brand">
                <i class="fas fa-shopping-cart header-logo"></i>
                <h1 class="header-title">SuperMarche</h1>
            </div>
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
                <li><a href="${pageContext.request.contextPath}/CaissierServlet" class="nav-link active">Creer Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listePaniers" class="nav-link ">Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listerFactures" class="nav-link">Factures</a></li>
                
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

    <!-- Main Content -->
    <main class="main-container">
        <!-- Page Header -->
        <div class="content-header">
   			 <h2 class="content-title" style="color: orange">
		        <i class="fas fa-shopping-basket me-2"></i>
		      
		    </h2>
		    <a href="#paniersEnCours" class="btn btn-custom btn-primary" style="background-color: orange ; border:none">
		        <i class="fas fa-clock me-2"></i>
		        Paniers en cours
		    </a>
		</div>

        <!-- Alerts -->
        <c:if test="${not empty sessionScope.messageErreur}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${sessionScope.messageErreur}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="messageErreur" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.messageSucces}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${sessionScope.messageSucces}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="messageSucces" scope="session"/>
        </c:if>

        <!-- Products Section -->
        <div class="card-container">
            <div class="card-header">
                <h3 style="color: orange">
                    <i class="fas fa-box me-2" style="color: orange"></i>
                    Produits Disponibles
                </h3>
                <div class="search-container">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" id="searchProduit" class="form-control search-input" placeholder="Rechercher un produit...">
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Description</th>
                            <th>Prix</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="produitsList">
                        <c:forEach var="produit" items="${produits}">
                            <tr class="produit-row" data-nom="${produit.nom}" data-description="${produit.description}">
                                <td>${produit.nom}</td>
                                <td>${produit.description}</td>
                                <td>${produit.prix} MAD</td>
                                <td>
                                    <span class="badge ${produit.stock > 10 ? 'bg-success' : 'bg-warning'}">
                                        ${produit.stock}
                                    </span>
                                </td>
                                <td>
                                    <form action="CaissierServlet" method="post" class="d-flex gap-2 align-items-center">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="idProduit" value="${produit.idProduit}">
                                        <input type="number" 
                                               name="quantite" 
                                               min="1" 
                                               max="${produit.stock}" 
                                               class="form-control form-control-sm quantity-input" 
                                               required>
                                        <button type="submit" class="btn btn-primary btn-sm">
                                            <i class="fas fa-cart-plus"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Current Cart -->
        <c:if test="${not empty panierProduits}">
            <c:set var="total" value="0"/>
            <c:forEach var="item" items="${panierProduits}">
               <c:set var="total" value="${total + (item.quantite * item.produit.prix)}"/>
            </c:forEach>
            
            <c:if test="${total > 0}">
                <div class="card-container">
                    <div class="card-header" style="color: orange">
                        <h3>
                            <i class="fas fa-shopping-cart me-2"></i>
                            Panier Actuel
                        </h3>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Produit</th>
                                    <th>Prix unitaire</th>
                                    <th>Quantité</th>
                                    <th>Total</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${panierProduits}">
                                    <tr>
                                        <td>${item.produit.nom}</td>
                                        <td>${item.produit.prix} MAD</td>
                                        <td>
                                            <form action="CaissierServlet" method="post" class="d-flex align-items-center">
                                                <input type="hidden" name="action" value="editQuantite">
                                                <input type="hidden" name="idPanierProduit" value="${item.idPanierProduit}">
                                                <input type="number" 
                                                       name="nouvelleQuantite" 
                                                       value="${item.quantite}" 
                                                       min="1" 
                                                       max="${item.produit.stock + item.quantite}"
                                                       class="form-control form-control-sm quantity-input"
                                                       onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td>${item.quantite * item.produit.prix} MAD</td>
                                        <td>
                                            <form action="CaissierServlet" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="idPanierProduit" value="${item.idPanierProduit}">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr class="table-info">
                                    <td colspan="3" class="text-end"><strong>Total du panier:</strong></td>
                                    <td colspan="2"><strong>${total} MAD</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-3">
                        <form action="CaissierServlet" method="post" class="d-inline">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-warning btn-custom">
                                <i class="fas fa-trash-alt"></i>
                                Vider le panier
                            </button>
                        </form>
                        <form action="CaissierServlet" method="post" class="d-inline">
                            <input type="hidden" name="action" value="validate">
                            <button type="submit" class="btn btn-success btn-custom">
                                <i class="fas fa-check"></i>
                                Valider le panier
                            </button>
                        </form>
                    </div>
                </div>
            </c:if>
        </c:if>

        <!-- Empty Cart State -->
        <c:if test="${empty panierProduits || total == 0}">
            <div class="card-container">
                <div class="empty-state " style="color: orange">
                    <i class="fas fa-shopping-cart empty-state-icon"></i>
                    <h3 >Votre panier est vide</h3>
                    <p>Ajoutez des produits à votre panier pour commencer.</p>
                </div>
            </div>
        </c:if>

        <!-- Pending Carts -->
        <div class="card-container" id="paniersEnCours">
            <div class="card-header" style="color: orange">
                <h3>
                    <i class="fas fa-clock me-2"></i>
                    Paniers en cours
                </h3>
            </div>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>N° Panier</th>
                            <th>Date</th>
                            <th>Nombre de produits</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="panierNonFinalise" items="${paniersNonFinalises}">
                            <c:set var="totalPanier" value="0"/>
                            <c:forEach var="produit" items="${panierNonFinalise.produits}">
                                <c:set var="totalPanier" value="${totalPanier + (produit.quantite * produit.produit.prix)}"/>
                            </c:forEach>
                            <c:if test="${totalPanier > 0}">
                                <tr>
                                    <td>#${panierNonFinalise.idPanier}</td>
                                    <td>
                                        <fmt:formatDate value="${panierNonFinalise.dateCreation}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${panierNonFinalise.produits.size()}</td>
                                    <td>${totalPanier} MAD</td>
                                    <td>
                                        <div class="btn-group">
                                            <form action="CaissierServlet" method="post" class="me-2">
                                                <input type="hidden" name="action" value="reprendrePanier">
                                                <input type="hidden" name="idPanier" value="${panierNonFinalise.idPanier}">
                                                <button type="submit" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit me-1"></i>
                                                    Modifier
                                                </button>
                                            </form>
                                            <form action="CaissierServlet" method="post">
                                                <input type="hidden" name="action" value="finaliserPanier">
                                                <input type="hidden" name="idPanier" value="${panierNonFinalise.idPanier}">
                                                <button type="submit" class="btn btn-success btn-sm">
                                                    <i class="fas fa-check-double me-1"></i>
                                                    Finaliser
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <nav aria-label="Navigation des pages">
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Précédent">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Suivant">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Search functionality
            const searchInput = document.getElementById('searchProduit');
            const produitRows = document.querySelectorAll('.produit-row');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                produitRows.forEach(row => {
                    const nom = row.getAttribute('data-nom').toLowerCase();
                    const description = row.getAttribute('data-description').toLowerCase();
                    
                    if (nom.includes(searchTerm) || description.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });

            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.classList.remove('show');
                    setTimeout(() => alert.remove(), 150);
                }, 5000);
            });
        });
     // Add this to your existing script section
        document.querySelector('a[href="#paniersEnCours"]').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('#paniersEnCours').scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        });
    </script>
</body>
</html>