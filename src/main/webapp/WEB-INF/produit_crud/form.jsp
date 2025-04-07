<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.supermarche.model.Produit"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${produit != null ? 'Modifier' : 'Ajouter'} un produit - SuperMarché</title>
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

        .header-brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: white;
        }

        .header-brand i {
            font-size: 2rem;
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
            background: rgba(255,255,255,0.1);
        }

        /* Main Content Styles */
        .main-container {
            background: rgba(0,0,0,0.1);
            flex: 1;
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
            width: 100%;
        }
        .form-label{
           color : orange
        }

        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .form-body {
            padding: 2rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.8rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(255,193,7,0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255,193,7,0.4);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108,117,125,0.4);
        }

        /* Footer Styles */
        .footer {
            background: #333;
            color: white;
            padding: 1rem 0;
            text-align: center;
            margin-top: auto;
        }

        /* Pagination Styles */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .page-link {
            background: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            color: var(--text-color);
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

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .header-container {
                flex-direction: column;
                text-align: center;
            }

            .header-tools {
                margin-top: 1rem;
            }

            .nav-list {
                flex-direction: column;
            }

            .nav-link {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/HomeServlet" class="header-brand">
                <i class="fas fa-shopping-cart"></i>
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
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet" class="nav-link ">Home</a></li>   
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link active"> Creer Produits</a></li>  
                <li><a href="${pageContext.request.contextPath}/ProduitServlet?action=list" class="nav-link active">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link ">factures</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=alertes" class="nav-link">Alertes</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=stockCritique" class="nav-link">stockCritique</a></li>
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
    <div class="main-container">
        <div class="form-card" style="background: rgba(0,0,0,0.5);">
            <div class="form-header">
                <h2><i class="fas fa-box-open me-2"></i>${produit != null ? 'Modifier' : 'Ajouter'} un produit</h2>
            </div>
            
            <div class="form-body" >
                <% 
                    Produit produit = (Produit) request.getAttribute("produit");
                    String action = (produit != null) ? "update" : "insert";
                %>

                <form action="ProduitServlet" method="post">
                    <input type="hidden" name="action" value="<%= action %>">
                    <% if (produit != null) { %>
                        <input type="hidden" name="id" value="<%= produit.getIdProduit() %>">
                    <% } %>

                    <div class="mb-3" >
                        <label for="nom" class="form-label">Nom :</label>
                        <input type="text" class="form-control" id="nom" name="nom" 
                               value="<%= (produit != null) ? produit.getNom() : "" %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description :</label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="3" required><%= (produit != null) ? produit.getDescription() : "" %></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="prix" class="form-label">Prix :</label>
                        <input type="number" class="form-control" id="prix" name="prix" 
                               step="0.01" value="<%= (produit != null) ? produit.getPrix() : "" %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock :</label>
                        <input type="number" class="form-control" id="stock" name="stock" 
                               value="<%= (produit != null) ? produit.getStock() : "" %>" required>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas <%= (produit != null) ? "fa-save" : "fa-plus" %> me-2"></i>
                            <%= (produit != null) ? "Modifier" : "Ajouter" %>
                        </button>
                        <a href="ProduitServlet" class="btn btn-secondary">
                            <i class="fas fa-times me-2"></i>
                            Annuler
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Pagination Example -->
       
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>