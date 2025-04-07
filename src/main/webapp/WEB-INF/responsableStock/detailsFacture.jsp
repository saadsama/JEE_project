<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de la Facture</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Variables et styles de base */
:root {
    --primary-color: #ffc107;
    --secondary-color: #ff9800;
    --text-color: #2c3e50;
    --bg-color: #f8f9fa;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-image: url('${pageContext.request.contextPath}/images/Background.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    min-height: 100vh;
}

.container {
    margin-top: 2rem !important;
    margin-bottom: 2rem !important;
}

/* Card styles */
.card {
    background: rgba(255, 255, 255, 0.95);
    border: none;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.card-header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
    color: white !important;
    padding: 1.5rem !important;
    border: none;
}

.card-header h2 {
    margin: 0;
    font-size: 1.5rem;
    font-weight: 600;
}

.card-body {
    padding: 2rem;
}

/* Button styles */
.btn-primary {
    background: var(--primary-color);
    border: none;
    color: #333;
    padding: 0.5rem 1.5rem;
    transition: all 0.3s;
}

.btn-primary:hover {
    background: var(--secondary-color);
    transform: translateY(-2px);
}

.btn-light {
    background: rgba(255, 255, 255, 0.9);
    border: none;
    transition: all 0.3s;
}

.btn-light:hover {
    background: rgba(255, 255, 255, 1);
    transform: translateY(-2px);
}

/* Table styles */
.table {
    background: transparent;
    margin-bottom: 0;
}

.table th {
    background: rgba(255, 193, 7, 0.1);
    color: var(--text-color);
    font-weight: 600;
    border-bottom: 2px solid var(--primary-color);
}

.table td {
    color: var(--text-color);
    vertical-align: middle;
}

.table-striped tbody tr:nth-of-type(odd) {
    background: rgba(255, 255, 255, 0.5);
}

.table-striped tbody tr:nth-of-type(even) {
    background: rgba(255, 255, 255, 0.3);
}

.table-striped tbody tr:hover {
    background: rgba(255, 193, 7, 0.1);
}

/* Badge styles */
.badge {
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
    border-radius: 20px;
}

.bg-warning {
    background: var(--primary-color) !important;
    color: #333;
}

.bg-success {
    background: #28a745 !important;
}

.bg-danger {
    background: #dc3545 !important;
}

/* Section titles */
h4 {
    color: var(--text-color);
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid var(--primary-color);
}

/* Print styles */
@media print {
    body {
        background: none;
    }
    
    .card {
        box-shadow: none;
    }
    
    .btn {
        display: none;
    }
    
    .table th {
        background: #f8f9fa !important;
        color: #333 !important;
        -webkit-print-color-adjust: exact;
    }
    
    .badge {
        border: 1px solid #ddd;
    }
}
    </style>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h2>Détails de la Facture</h2>
                <div>
 				
            		<button onclick="window.print()" class="btn btn-primary">
		                <i class="fas fa-print"></i> Imprimer
		            </button>
                    <a href="ResponsableStockServlet?action=listerFactures" class="btn btn-light">
                        <i class="fas fa-arrow-left"></i> Retour
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4>Informations de la Facture</h4>
                        <table class="table">
                            <tr>
                                <th>Numéro de Facture</th>
                                <td>${facture.numeroFacture}</td>
                            </tr>
                            <tr>
                                <th>Date</th>
                                <td>
                                    <fmt:formatDate value="${facture.dateFacture}" 
                                                  pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                            </tr>
                            <tr>
                                <th>Statut</th>
                                <td>
                                    <span class="badge 
                                        ${facture.statut == 'EMISE' ? 'bg-warning' : 
                                          facture.statut == 'PAYEE' ? 'bg-success' : 
                                          facture.statut == 'ANNULEE' ? 'bg-danger' : 'bg-secondary'}">
                                        ${facture.statut}
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h4>Totaux</h4>
                        <table class="table">
                            <tr>
                                <th>Total HT</th>
                                <td>${facture.totalHT} MAD</td>
                            </tr>
                            <tr>
                                <th>TVA (${facture.tva * 100}%)</th>
                                <td>${facture.totalTTC - facture.totalHT} MAD</td>
                            </tr>
                            <tr>
                                <th>Total TTC</th>
                                <td>${facture.totalTTC} MAD</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <h4 class="mt-4">Produits</h4>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Produit</th>
                            <th>Prix Unitaire</th>
                            <th>Quantité</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pp" items="${produitsPanier}">
                            <tr>
                                <td>${pp.produit.nom}</td>
                                <td>${pp.produit.prix} MAD</td>
                                <td>${pp.quantite}</td>
                                <td>${pp.quantite * pp.produit.prix} MAD</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>