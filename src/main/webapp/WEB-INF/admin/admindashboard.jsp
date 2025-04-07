<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/layouts/header.jsp"/>


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
   
    .dashboard-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem 1rem;
    }
    
    

    .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: var(--shadow);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
    }

    .stat-info h3 {
        font-size: 1.5rem;
        margin: 0;
        color: var(--text-color);
    }

    .stat-info p {
        margin: 0;
        color: #666;
        font-size: 0.9rem;
    }

    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }

    .dashboard-card {
        background: var(--card-bg);
        border-radius: 12px;
        overflow: hidden;
        box-shadow: var(--shadow);
        transition: all 0.3s ease;
    }

    .dashboard-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--hover-shadow);
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        padding: 1.5rem;
        text-align: center;
    }

    .card-header i {
        font-size: 2.5rem;
        margin-bottom: 0.5rem;
    }

    .card-content {
        padding: 1.5rem;
        text-align: center;
    }

    .card-title {
        font-size: 1.25rem;
        color: var(--text-color);
        margin-bottom: 1rem;
    }

    .card-text {
        color: #666;
        margin-bottom: 1.5rem;
        line-height: 1.5;
    }

    .dashboard-btn {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        text-decoration: none;
        padding: 0.8rem 1.5rem;
        border-radius: 8px;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .dashboard-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 193, 7, 0.4);
        color: white;
    }

    .section-title {
        font-size: 1.5rem;
        color: var(--text-color);
        margin-bottom: 1.5rem;
        position: relative;
        padding-bottom: 0.5rem;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 3px;
        background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        border-radius: 3px;
    }
    

    @media (max-width: 768px) {
        .stats-row {
            grid-template-columns: 1fr;
        }
        
        .dashboard-grid {
            grid-template-columns: 1fr;
        }
    }
    
</style>
 <nav class="navbar">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/HomeServlet" class="nav-link"></a> Admine home</li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet" class="nav-link active">Creer Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listePaniers" class="nav-link ">Paniers</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=listerFactures" class="nav-link">Factures</a></li>
                
                <li style="margin-left: auto;">
                    <span class="nav-link">
                        <i class="fas fa-user me-2" style="color: orange"></i>
                        ${sessionScope.utilisateur.nom}
                    </span>
                </li>
                <li style="margin-left: auto;">
                    Administrateur
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
<div class="dashboard-container">
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-info">
                <h3>1</h3>
                <p>Utilisateurs actifs</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-info">
                <h3>45.678</h3>
                <p>Ventes du jour</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-box"></i>
            </div>
            <div class="stat-info">
                <h3>25</h3>
                <p>Produits en stock</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
                <h3>24%</h3>
                <p>Croissance mensuelle</p>
            </div>
        </div>
    </div>

    <h2 class="section-title">Gestion du système</h2>
    
    <div class="dashboard-grid">
        <div class="dashboard-card">
            <div class="card-header">
                <i class="fas fa-users"></i>
                <h3>Utilisateurs</h3>
            </div>
            <div class="card-content">
                <p class="card-text">Gérez les comptes utilisateurs, les rôles et les permissions.</p>
                <a href="<%= request.getContextPath() %>/UtilisateurServlet?action=list" class="dashboard-btn">
                    <i class="fas fa-user-cog"></i>
                    Gérer les utilisateurs
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <i class="fas fa-box-open"></i>
                <h3>Produits</h3>
            </div>
            <div class="card-content">
                <p class="card-text">Gérez l'inventaire, les prix et les descriptions des produits.</p>
                <a href="<%= request.getContextPath() %>/ProduitServlet?action=list" class="dashboard-btn">
                    <i class="fas fa-tasks"></i>
                    Gérer les produits
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <i class="fas fa-tags"></i>
                <h3>Catégories</h3>
            </div>
            <div class="card-content">
                <p class="card-text">Organisez vos produits par catégories et sous-catégories.</p>
                <a href="<%= request.getContextPath() %>/CategorieServlet?action=list" class="dashboard-btn">
                    <i class="fas fa-folder-open"></i>
                    Gérer les catégories
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <i class="fas fa-file-invoice-dollar"></i>
                <h3>Factures</h3>
            </div>
            <div class="card-content">
                <p class="card-text">Consultez et gérez toutes les factures et transactions.</p>
                <a href="<%= request.getContextPath() %>/CaisserServlet?action=listerFactures" class="dashboard-btn">
                    <i class="fas fa-receipt"></i>
                    Voir les factures
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <i class="fas fa-shopping-cart"></i>
                <h3>Paniers</h3>
            </div>
            <div class="card-content">
                <p class="card-text">Gérer les paniers actifs et l'historique des commandes.</p>
                <a href="<%= request.getContextPath() %>/CaissierServlet?action=listePaniers" class="dashboard-btn">
                    <i class="fas fa-shopping-basket"></i>
                    Gérer les paniers
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/layouts/footer.jsp"/>