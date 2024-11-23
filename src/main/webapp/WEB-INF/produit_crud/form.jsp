<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarche.model.Categorie" %>
<%@ page import="com.supermarche.model.Produit" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("produit") == null ? "Ajouter" : "Modifier" %> un Produit</title>
</head>
<body>
    <h1><%= request.getAttribute("produit") == null ? "Ajouter" : "Modifier" %> un Produit</h1>
    <form action="ProduitServlet" method="post">
        <% 
            Produit produit = (Produit) request.getAttribute("produit");
            List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
        %>
        <% if (produit != null) { %>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= produit.getIdProduit() %>">
        <% } else { %>
            <input type="hidden" name="action" value="insert">
        <% } %>
        
        <label>Nom :</label>
        <input type="text" name="nom" value="<%= produit != null ? produit.getNom() : "" %>" required><br>

        <label>Description :</label>
        <textarea name="description" required><%= produit != null ? produit.getDescription() : "" %></textarea><br>

        <label>Prix :</label>
        <input type="number" step="0.01" name="prix" value="<%= produit != null ? produit.getPrix() : "" %>" required><br>

        <label>Stock :</label>
        <input type="number" name="stock" value="<%= produit != null ? produit.getStock() : "" %>" required><br>

        <label>Catégorie :</label>
        <select name="idCategorie" required>
            <% for (Categorie categorie : categories) { %>
                <option value="<%= categorie.getId() %>" 
                    <%= produit != null && produit.getCategorie() != null && produit.getCategorie().getId() == categorie.getId() ? "selected" : "" %>>
                    <%= categorie.getNom() %>
                </option>
            <% } %>
        </select><br>

        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
