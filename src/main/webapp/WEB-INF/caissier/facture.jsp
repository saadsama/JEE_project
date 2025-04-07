<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facture #${facture.numeroFacture}</title>
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
    background-image: url('${pageContext.request.contextPath}/images/Background.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    line-height: 1.6;
}

/* Container principal */
.container {
    background: rgba(255, 255, 255, 0.95) !important;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    padding: 2rem !important;
    margin-top: 2rem !important;
    margin-bottom: 2rem !important;
}

/* Boutons d'action */
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

.btn-secondary {
    background: #6c757d;
    border: none;
    transition: all 0.3s;
}

.btn-secondary:hover {
    background: #5a6268;
    transform: translateY(-2px);
}

/* En-tête de la facture */
.facture-header {
    border-bottom: 3px solid var(--primary-color);
    margin-bottom: 2rem;
    padding-bottom: 1.5rem;
}

.facture-header h2 {
    color: var(--text-color);
    font-weight: 600;
    margin-top: 1rem;
}

/* Informations de la facture */
.facture-info {
    background: rgba(255, 255, 255, 0.9);
    padding: 1.5rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    border: 1px solid rgba(255, 193, 7, 0.2);
}

.badge.bg-success {
    background: var(--primary-color) !important;
    color: #333;
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
}

/* Table des produits */
.facture-table {
    margin: 2rem 0;
}

.table {
    background: transparent;
}

.table thead th {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border: none;
    padding: 1rem;
}

.table tbody tr:nth-child(odd) {
    background: rgba(255, 255, 255, 0.5);
}

.table tbody tr:nth-child(even) {
    background: rgba(255, 255, 255, 0.3);
}

.table tbody tr:hover {
    background: rgba(255, 193, 7, 0.1);
}

/* Totaux */
.facture-total {
    border-top: 3px solid var(--primary-color);
    padding-top: 1.5rem;
    margin-top: 2rem;
}

.facture-total .table {
    background: transparent;
}

.facture-total .table td {
    padding: 0.5rem;
    border: none;
}

/* Pied de page */
.text-center.mt-5 {
    color: var(--text-color);
    background: rgba(255, 193, 7, 0.1);
    padding: 1.5rem;
    border-radius: 10px;
    margin-top: 2rem !important;
}

/* Styles d'impression */
@media print {
    body {
        background: none;
    }
    
    .container {
        box-shadow: none;
        padding: 0 !important;
        margin: 0 !important;
    }
    
    .no-print {
        display: none !important;
    }
    
    .facture-header,
    .facture-total {
        border-color: #333;
    }
    
    .table thead th {
        background: #f8f9fa !important;
        color: #333 !important;
        -webkit-print-color-adjust: exact;
    }
}
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4 bg-white p-4 shadow">
        <!-- Boutons d'action -->
        <div class="mb-4 no-print">
            <button onclick="window.print()" class="btn btn-primary">
                <i class="fas fa-print"></i> Imprimer
            </button>
            <a href="CaissierServlet" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>

        <!-- En-tête de la facture -->
        <div class="facture-header text-center">
            <img src="path_to_your_logo.png" alt="Logo" class="logo">
            <h2>SUPERMARCHÉ souk sebt</h2>
            <p>123 Rue du Commerce<br>
               Rabt, maroc<br>
               Tél: +212 638326840<br>
               Email: contact@supermarche.com</p>
        </div>

        <!-- Informations de la facture -->
        <div class="facture-info row">
            <div class="col-md-6">
                <h4>Facture N° ${facture.numeroFacture}</h4>
                <p>Date: <fmt:formatDate value="${facture.dateFacture}" 
                                       pattern="dd/MM/yyyy HH:mm"/></p>
                <p>Panier N°: ${facture.idPanier}</p>
            </div>
            <div class="col-md-6 text-end">
                <p>Statut: <span class="badge bg-success">${facture.statut}</span></p>
            </div>
        </div>

        <!-- Détails des produits -->
        <div class="facture-table">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Produit</th>
                        <th class="text-center">Quantité</th>
                        <th class="text-end">Prix unitaire</th>
                        <th class="text-end">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="produit" items="${facture.produits}">
                        <tr>
                            <td>${produit.produit.nom}</td>
                            <td class="text-center">${produit.quantite}</td>
                            <td class="text-end">${produit.produit.prix} MAD</td>
                            <td class="text-end">
                                ${produit.quantite * produit.produit.prix} MAD
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Totaux -->
        <div class="facture-total">
            <div class="row">
                <div class="col-md-6"></div>
                <div class="col-md-6">
                    <table class="table table-borderless">
                        <tr>
                            <td><strong>Total HT:</strong></td>
                            <td class="text-end">${facture.totalHT} MAD</td>
                        </tr>
                        <tr>
                            <td><strong>TVA (${facture.tva * 100}%):</strong></td>
                            <td class="text-end">
                                ${facture.totalTTC - facture.totalHT} MAD
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Total TTC:</strong></td>
                            <td class="text-end"><strong>${facture.totalTTC} MAD</strong></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Pied de page -->
        <div class="text-center mt-5">
            <p>Merci de votre confiance !</p>
            <p class="small">
                Cette facture a été générée automatiquement.<br>
                Pour toute question, contactez-nous au numéro indiqué ci-dessus.
            </p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>