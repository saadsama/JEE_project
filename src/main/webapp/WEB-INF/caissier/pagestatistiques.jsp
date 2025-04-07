<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Statistiques de Ventes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style >
    /* Variables et styles de base */
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

.container {
    margin-top: 2rem !important;
    margin-bottom: 2rem !important;
}

/* Card principale */
.card {
    background: rgba(255, 255, 255, 0.95);
    border: none;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    margin-bottom: 1.5rem;
}

.card-header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
    color: white !important;
    padding: 1.5rem !important;
    border: none;
}

.card-header h2 {
    margin: 0;
    font-size: 1.8rem;
    font-weight: 600;
}

.card-header p {
    margin: 0.5rem 0 0;
    opacity: 0.9;
}

/* Cards des statistiques */
.stats-card {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    padding: 1.5rem;
    transition: transform 0.3s ease;
    height: 100%;
}

.stats-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.stats-card h5 {
    color: var(--text-color);
    font-size: 1.1rem;
    margin-bottom: 1rem;
}

.stats-card .h3 {
    color: var(--primary-color);
    font-weight: bold;
    font-size: 2rem;
    margin: 0;
}

/* Tableau des ventes */
.table-container {
    background: rgba(255, 255, 255, 0.8);
    border-radius: 10px;
    padding: 1rem;
    margin: 1.5rem 0;
}

.table {
    margin: 0;
}

.table thead th {
    background: rgba(51, 51, 51, 0.8);
    color: white;
    font-weight: 500;
    padding: 1rem;
    border: none;
}

.table tbody tr {
    background: transparent;
    transition: background-color 0.3s;
}

.table tbody tr:hover {
    background: rgba(255, 193, 7, 0.1);
}

.table td {
    padding: 1rem;
    vertical-align: middle;
}

/* Graphique */
.chart-container {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 10px;
    padding: 1.5rem;
    margin: 1.5rem 0;
}

/* Formulaire de période */
.form-container {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 10px;
    padding: 1.5rem;
}

.form-label {
    color: var(--text-color);
    font-weight: 500;
}

.form-control {
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    padding: 0.8rem;
    transition: all 0.3s;
}

.form-control:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.25);
}

.btn-primary {
    background: var(--primary-color);
    border: none;
    color: #333;
    padding: 0.8rem 2rem;
    border-radius: 8px;
    transition: all 0.3s;
}

.btn-primary:hover {
    background: var(--secondary-color);
    transform: translateY(-2px);
}

/* Titres de section */
h3 {
    color: var(--text-color);
    font-size: 1.5rem;
    margin: 2rem 0 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid var(--primary-color);
}

options: {
    responsive: true,
    plugins: {
        title: {
            display: true,
            text: 'Ventes par Produit',
            font: {
                size: 18,
                family: "'Segoe UI', sans-serif"
            },
            padding: 20
        },
        legend: {
            position: 'bottom'
        }
    },
    scales: {
        y: {
            beginAtZero: true,
            grid: {
                color: 'rgba(0, 0, 0, 0.1)'
            }
        },
        x: {
            grid: {
                display: false
            }
        }
    }
}
    </style>
</head>


<body class="bg-light">

     <header>
       <div class="header-container">
            <div class="header-brand " >
                <i class="fas fa-facture header-logo"></i>
                <h1 class="header-title">statistique des ventes</h1>
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
                <li><a href="${pageContext.request.contextPath}/CategorieServlet?action=list" class="nav-link">Categories</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=factures" class="nav-link ">factures</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=alertes" class="nav-link">Alertes</a></li>
                <li><a href="${pageContext.request.contextPath}/ResponsableStockServlet?action=stockCritique" class="nav-link">stockCritique</a></li>
                <li><a href="${pageContext.request.contextPath}/CaissierServlet?action=statistiquesVentes" class="nav-link active">statistique des ventes</a></li>
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
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h2>Statistiques de Ventes</h2>
                <p>Du ${dateDebut} au ${dateFin}</p>
            </div>
            <div class="card-body">
                <!-- Statistiques Générales -->
               <div class="row mb-4">
    <div class="col-md-4">
        <div class="stats-card text-center">
            <h5><i class="fas fa-file-invoice me-2"></i>Nombre de Factures</h5>
            <p class="h3">${statistiquesGenerales.nombreFactures}</p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stats-card text-center">
            <h5><i class="fas fa-chart-line me-2"></i>Chiffre d'Affaires</h5>
            <p class="h3">
                 77256.12 MAD
            </p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stats-card text-center">
            <h5><i class="fas fa-shopping-cart me-2"></i>Panier Moyen</h5>
            <p class="h3">
              3578.22 MAD
            </p>
        </div>
    </div>
</div>

                <!-- Tableau des Produits Vendus -->
                <h3>Détail des Ventes par Produit</h3>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Produit</th>
                            <th>Quantité Vendue</th>
                            <th>Montant Total</th>
                            <th>Prix Moyen</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="produit" items="${statistiquesProduits}">
                            <tr>
                                <td>${produit.nomProduit}</td>
                                <td>${produit.quantiteVendue}</td>
                                <td>
                                    <fmt:formatNumber value="${produit.montantTotal}" 
                                                     type="number" maxFractionDigits="2"/> MAD
                                </td>
                                <td>
                                    <fmt:formatNumber value="${produit.prixMoyen}" 
                                                     type="number" maxFractionDigits="2"/> MAD
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Graphique des Ventes -->
                <div class="row mt-4">
                    <div class="col-12">
                        <canvas id="ventesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Formulaire de Sélection de Période -->
        <div class="card mt-3">
            <div class="card-body">
                <form action="CaissierServlet?action=statistiquesVentes" method="post">
                    <div class="row">
                        <div class="col-md-5">
                            <label class="form-label">Date Début</label>
                            <input type="date" name="dateDebut" class="form-control" 
                                   value="${dateDebut}">
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">Date Fin</label>
                            <input type="date" name="dateFin" class="form-control" 
                                   value="${dateFin}">
                        </div>
                        <div class="col-md-2 align-self-end">
                            <button type="submit" class="btn btn-primary">Générer</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Graphique des ventes
        var ctx = document.getElementById('ventesChart').getContext('2d');
        var chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [
                    <c:forEach var="produit" items="${statistiquesProduits}">
                        '${produit.nomProduit}',
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Quantité Vendue',
                    data: [
                        <c:forEach var="produit" items="${statistiquesProduits}">
                            ${produit.quantiteVendue},
                        </c:forEach>
                    ],
                    backgroundColor: 'rgba(75, 192, 192, 0.6)'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Ventes par Produit'
                    }
                }
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>