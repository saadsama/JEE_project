<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarche.model.Utilisateur" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Utilisateurs</title>
</head>
<body>
    <h1>Liste des Utilisateurs</h1>
    <a href="UtilisateurServlet?action=add">Ajouter un utilisateur</a>
    <table border="1">
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
            <% List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs"); %>
            <% if (utilisateurs != null) {
                for (Utilisateur utilisateur : utilisateurs) { %>
                    <tr>
                        <td><%= utilisateur.getId() %></td>
                        <td><%= utilisateur.getNom() %></td>
                        <td><%= utilisateur.getEmail() %></td>
                        <td><%= utilisateur.getRole() %></td>
                        <td>
                            <a href="UtilisateurServlet?action=edit&id=<%= utilisateur.getId() %>">Modifier</a>
                            <a href="UtilisateurServlet?action=delete&id=<%= utilisateur.getId() %>">Supprimer</a>
                        </td>
                    </tr>
            <%  } } %>
        </tbody>
    </table>
</body>
</html>
