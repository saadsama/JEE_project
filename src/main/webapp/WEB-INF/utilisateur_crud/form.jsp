<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.supermarche.model.Utilisateur" %>
<%@ page import="com.supermarche.model.Role" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("utilisateur") == null ? "Ajouter" : "Modifier" %> un Utilisateur</title>
</head>
<body>
    <h1><%= request.getAttribute("utilisateur") == null ? "Ajouter" : "Modifier" %> un Utilisateur</h1>
    <form action="UtilisateurServlet" method="post">
        <% 
            Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
        %>
        <% if (utilisateur != null) { %>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= utilisateur.getId() %>">
        <% } else { %>
            <input type="hidden" name="action" value="insert">
        <% } %>

        <label>Nom :</label>
        <input type="text" name="nom" value="<%= utilisateur != null ? utilisateur.getNom() : "" %>" required><br>

        <label>Email :</label>
        <input type="email" name="email" value="<%= utilisateur != null ? utilisateur.getEmail() : "" %>" required><br>

        <label>Mot de passe :</label>
        <input type="password" name="password" value="<%= utilisateur != null ? utilisateur.getPassword() : "" %>" required><br>

        <label>Rôle :</label>
        <select name="role" required>
            <% for (Role role : Role.values()) { %>
                <option value="<%= role.name() %>" 
                    <%= utilisateur != null && utilisateur.getRole() == role ? "selected" : "" %>>
                    <%= role.name() %>
                </option>
            <% } %>
        </select><br>

        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
