<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarche.model.Produit" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Produits</title>
</head>
<body>
    <h1>Liste des Produits</h1>
    <a href="ProduitServlet?action=add">Ajouter un produit</a>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Description</th>
                <th>Prix</th>
                <th>Stock</th>
                <th>Catégorie</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Produit> produits = (List<Produit>) request.getAttribute("produits");
                if (produits != null && !produits.isEmpty()) {
                    for (Produit produit : produits) { 
            %>
                        <tr>
                            <td><%= produit.getIdProduit() %></td>
                            <td><%= produit.getNom() %></td>
                            <td><%= produit.getDescription() %></td>
                            <td><%= produit.getPrix() %></td>
                            <td><%= produit.getStock() %></td>
                            <td><%= produit.getCategorie() != null ? produit.getCategorie().getNom() : "Non spécifiée" %></td>
                            <td>
                                <a href="ProduitServlet?action=edit&id=<%= produit.getIdProduit() %>">Modifier</a>
                                <a href="ProduitServlet?action=delete&id=<%= produit.getIdProduit() %>" onclick="return confirm('Êtes-vous sûr ?');">Supprimer</a>
                            </td>
                        </tr>
            <% 
                    }
                } else { 
            %>
                <tr>
                    <td colspan="7">Aucun produit trouvé</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
