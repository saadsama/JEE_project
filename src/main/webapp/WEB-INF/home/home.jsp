<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "SuperMarché - Accueil" %></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body & Base Styles */
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

/* Remove the white overlay completely */
body::before {
    display: none; /* This removes the white overlay */
}

/* Or if you want just a slight darkening effect to make text more readable */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.3); /* Slight dark overlay instead of white */
    z-index: -1;
}

/* Adjust card backgrounds for better contrast with the background */


/* Header Styles */
.header {
    background: linear-gradient(135deg, rgba(255, 193, 7, 0.95), rgba(255, 152, 0, 0.95));
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
}

.header-logo {
    font-size: 2rem;
    color: white;
}

.header-title {
    color: white;
    font-size: 1.5rem;
    font-weight: 600;
}

.header-tools {
    display: flex;
    gap: 1rem;
}

.header-tool {
    color: white;
    padding: 0.5rem;
    border-radius: 50%;
    transition: all 0.3s ease;
}

.header-tool:hover {
    background-color: rgba(255,255,255,0.2);
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

.user-info {
    margin-left: auto;
    color: white;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

/* Main Content Styles */
.main-container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1rem;
    flex-grow: 1;
}

/* Dashboard Grid */
.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

/* Card Styles */
.card, .stat-card {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(10px);
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 16px rgba(0,0,0,0.15);
    background: var(--primary-color);
}

.card-icon {
    font-size: 2rem;
    color: var(--primary-color);
    margin-bottom: 1rem;
}

.card:hover .card-icon {
    
    color:  rgba(255, 255, 255, 0.7);
    
}



.card-title {
    font-size: 1.25rem;
    color: var(--dark-gray);
    margin-bottom: 0.5rem;
}

.card-text {
    color: #666;
    line-height: 1.5;
}

/* Stats Container */
.stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
}

.stat-value {
    font-size: 1.5rem;
    font-weight: bold;
    color: var(--secondary-color);
}

.stat-label {
    color: #666;
    font-size: 0.875rem;
}

.section-title{
color: var(--primary-color;
}

/* Footer */
footer {
    background: rgba(34, 34, 34, 0.95);
    color: white;
    text-align: center;
    padding: 1rem 0;
    margin-top: auto;
    position: relative;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

footer p {
    margin: 0;
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Adjust body to ensure footer stays at bottom */
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.main-container {
    flex: 1;
}

@media (max-width: 768px) {
    footer {
        padding: 0.8rem 0;
    }
    
    footer p {
        font-size: 0.8rem;
    }
}
/* Mobile Menu Button */
.mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 0.5rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .mobile-menu-btn {
        display: block;
    }

    .nav-list {
        display: none;
        flex-direction: column;
        width: 100%;
    }

    .nav-list.active {
        display: flex;
    }

    .user-info {
        margin: 1rem 0;
    }

    .dashboard-grid,
    .stats-container {
        grid-template-columns: 1fr;
    }

    .header-container {
        flex-direction: column;
        gap: 1rem;
    }

    .nav-link {
        width: 100%;
        text-align: center;
    }
}
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="header-brand">
                <i class="fas fa-shopping-cart header-logo"></i>
                <h1 class="header-title">SuperMarché</h1>
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

    <nav class="navbar">
        <div class="nav-container">
            <ul class="nav-list" id="navList">
                <li><a href="<%= request.getContextPath()%>/HomeServlet" class="nav-link active">Accueil</a></li>
                <% 
                    com.supermarche.model.Utilisateur utilisateur = (com.supermarche.model.Utilisateur) session.getAttribute("utilisateur");
                    if (utilisateur == null) {
                %>
                    <li style="margin-left: auto;">
                        <a href="<%= request.getContextPath() %>/auth?action=signup" class="nav-link">Inscription</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/auth?action=login" class="nav-link">Connexion</a>
                    </li>
                <% } else { %>
                    <% if (utilisateur.getRole() == com.supermarche.model.Role.CAISSIER) { %>
                        <li><a href="<%= request.getContextPath() %>/PanierServlet?action=list" class="nav-link">Paniers</a></li>
                    <% } else if (utilisateur.getRole() == com.supermarche.model.Role.RESPONSABLECATEGORIE) { %>
                        <li><a href="<%= request.getContextPath() %>/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                        <li><a href="<%= request.getContextPath() %>/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                    <% } else if (utilisateur.getRole() == com.supermarche.model.Role.ADMIN) { %>
                        <li><a href="<%= request.getContextPath() %>/PanierServlet?action=list" class="nav-link">Paniers</a></li>
                        <li><a href="<%= request.getContextPath() %>/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                        <li><a href="<%= request.getContextPath() %>/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                        <li><a href="<%= request.getContextPath() %>/UtilisateurServlet?action=list" class="nav-link">Utilisateurs</a></li>
                    <% } %>
                    <div class="user-info">
                        <i class="fas fa-user"></i>
                        <span><strong><%= utilisateur.getNom() %></strong> (<%= utilisateur.getRole().name() %>)</span>
                        <a href="<%= request.getContextPath() %>/auth?action=logout" class="nav-link">Déconnexion</a>
                    </div>
                <% } %>
            </ul>
        </div>
    </nav>

    <main class="main-container">
        <!-- Stats Section -->
        <% if (utilisateur != null) { %>
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-value">152</div>
                <div class="stat-label">Produits en stock</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">€2,450</div>
                <div class="stat-label">Ventes du jour</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">24</div>
                <div class="stat-label">Commandes en cours</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">98%</div>
                <div class="stat-label">Satisfaction client</div>
            </div>
        </div>
        <% } %>

        <!-- Main Content -->
       
        <div class="dashboard-grid">
            <div class="card">
                <i class="fas fa-box card-icon"></i>
                <h3 class="card-title">Gestion de stock des Produits et des categories</h3>
                <p class="card-text">Ajoutez, modifiez et supprimez des produits facilement gestion de stocks . Gérez votre inventaire en temps réel.</p>
            </div>
            <div class="card">
                <i class="fas fa-shopping-cart card-icon"></i>
                <h3 class="card-title">Gestion des factures et panniers</h3>
                <p class="card-text">Créez et gérez les paniers et les factures des clients efficacement. Suivez les commandes en temps réel.</p>
            </div>
            <div class="card">
                <i class="fas fa-chart-bar card-icon"></i>
                <h3 class="card-title">Rapports et Statistiques des ventes</h3>
                <p class="card-text">Accédez à des rapports détaillés sur les ventes et les stocks. Analysez les tendances.</p>
            </div>
             <div class="card">
                <i class="fas fa-shopping-cart card-icon"></i>
                <h3 class="card-title">System des alerts pour notifier les avancement du stocks</h3>
                <p class="card-text">mise a jours du stock des produits. Suivez les ventes en temps réel.</p>
            </div>
        </div>
    </main>

    <footer>
    <p>© 2024 Mon Application. Tous droits réservés.</p>
</footer>

    <script>
        function toggleMobileMenu() {
            const navList = document.getElementById('navList');
            navList.classList.toggle('active');
        }
    </script>
</body>
</html>