<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${utilisateur != null ? "Modifier un utilisateur" : "Créer un compte"} - SuperMarché</title>
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
            background: linear-gradient(135deg, #f6f9fc 0%, #e9ecef 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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

        .header-title {
            font-size: 1.5rem;
            margin: 0;
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
            background: rgba(255,255,255,0.1);
        }

        /* Form Styles */
        .main-container {
            flex: 1;
            padding: 2rem;
            max-width: 600px;
            margin: 0 auto;
            width: 100%;
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

        .form-header i {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .form-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .form-body {
            padding: 2rem;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.8rem;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(255,193,7,0.25);
        }

        .submit-btn {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255,193,7,0.4);
        }

        .back-link {
            color: var(--primary-color);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
            transition: all 0.3s;
        }

        .back-link:hover {
            color: var(--secondary-color);
        }

        /* Footer Styles */
        .footer {
            background: #333;
            color: white;
            padding: 1rem 0;
            text-align: center;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
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
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-user-${utilisateur != null ? 'edit' : 'plus'}"></i>
                <h2>${utilisateur != null ? "Modifier un utilisateur" : "Créer un compte"}</h2>
            </div>
            
            <div class="form-body">
                <form action="UtilisateurServlet" method="post">
                    <input type="hidden" name="action" value="${utilisateur != null ? 'update' : 'insert'}">
                    <c:if test="${utilisateur != null}">
                        <input type="hidden" name="id" value="${utilisateur.id}">
                    </c:if>

                    <div class="mb-3">
                        <label for="nom" class="form-label">
                            <i class="fas fa-user me-2"></i>Nom
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="nom" 
                               name="nom" 
                               value="${utilisateur != null ? utilisateur.nom : ''}" 
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope me-2"></i>Email
                        </label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               value="${utilisateur != null ? utilisateur.email : ''}" 
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">
                            <i class="fas fa-lock me-2"></i>Mot de passe
                        </label>
                        <input type="password" 
                               class="form-control" 
                               id="password" 
                               name="password" 
                               ${utilisateur != null ? "" : "required"}>
                        <c:if test="${utilisateur != null}">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Laissez vide pour conserver le mot de passe actuel.
                            </small>
                        </c:if>
                    </div>

                    <div class="mb-4">
                        <label for="role" class="form-label">
                            <i class="fas fa-user-tag me-2"></i>Rôle
                        </label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="CAISSIER" ${utilisateur != null && utilisateur.role == "CAISSIER" ? "selected" : ""}>
                                <i class="fas fa-cash-register me-2"></i>Caissier
                            </option>
                            <option value="ADMIN" ${utilisateur != null && utilisateur.role == "ADMIN" ? "selected" : ""}>
                                <i class="fas fa-user-shield me-2"></i>Admin
                            </option>
                            <option value="RESPONSABLECATEGORIE" ${utilisateur != null && utilisateur.role == "RESPONSABLECATEGORIE" ? "selected" : ""}>
                                <i class="fas fa-tasks me-2"></i>Responsable Catégorie
                            </option>
                        </select>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-${utilisateur != null ? 'save' : 'user-plus'} me-2"></i>
                        ${utilisateur != null ? "Mettre à jour" : "Créer le compte"}
                    </button>

                    <div class="text-center mt-3">
                        <a href="UtilisateurServlet" class="back-link">
                            <i class="fas fa-arrow-left"></i>
                            Retour à la liste des utilisateurs
                        </a>
                    </div>
                </form>
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