<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Utilisateurs - SuperMarché</title>
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

        .card-header h2 {
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-button {
            background: white;
            color: var(--primary-color);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            transition: all 0.3s;
        }

        .add-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255,255,255,0.3);
        }

        .alert {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-info {
            background-color: rgba(13, 202, 240, 0.1);
            color: #0dcaf0;
            border: none;
        }

        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: none;
        }

        .table {
            margin: 0;
        }

        .table thead th {
            background: #333;
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.9rem;
            padding: 1rem;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-warning {
            background: #ffc107;
            color: white;
            border: none;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
            border: none;
        }

        .btn-warning:hover, .btn-danger:hover {
            transform: translateY(-2px);
            color: white;
        }

        /* Footer Styles */
        .footer {
            background: #333;
            color: white;
            padding: 1rem 0;
            text-align: center;
            margin-top: auto;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .table-responsive {
                overflow-x: auto;
            }
            
            .card-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
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
                <h1 class="header-title">SuperMarché</h1>
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
                <li><a href="${pageContext.request.contextPath}/ProduitServlet" class="nav-link">Produits</a></li>
                <li><a href="${pageContext.request.contextPath}/CategorieServlet" class="nav-link">Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/UtilisateurServlet" class="nav-link">Utilisateurs</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <c:if test="${not empty message}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <div class="content-card">
            <div class="card-header">
                <h2>
                    <i class="fas fa-users me-2"></i>
                    Liste des Utilisateurs
                </h2>
                <a href="UtilisateurServlet?action=add" class="add-button">
                    <i class="fas fa-user-plus"></i>
                    Ajouter un utilisateur
                </a>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Rôle</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="utilisateur" items="${utilisateurs}">
                            <tr>
                                <td>${utilisateur.id}</td>
                                <td>${utilisateur.nom}</td>
                                <td>${utilisateur.email}</td>
                                <td>
                                    <span class="badge bg-primary">
                                        <i class="fas fa-user-tag me-1"></i>
                                        ${utilisateur.role}
                                    </span>
                                </td>
                                <td class="action-buttons">
                                    <a href="UtilisateurServlet?action=edit&id=${utilisateur.id}" 
                                       class="btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                        Modifier
                                    </a>
                                    <a href="UtilisateurServlet?action=delete&id=${utilisateur.id}" 
                                       class="btn-sm btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?');">
                                        <i class="fas fa-trash"></i>
                                        Supprimer
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty utilisateurs}">
                            <tr>
                                <td colspan="5" class="text-center">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Aucun utilisateur trouvé
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 SuperMarché. Tous droits réservés.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>