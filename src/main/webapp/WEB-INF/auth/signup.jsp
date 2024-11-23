<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inscription</title>
</head>
<body>
    <h1>Créer un compte</h1>
    <form action="auth" method="post">
        <input type="hidden" name="action" value="signup">
        <label>Nom :</label>
        <input type="text" name="nom" required><br>
        <label>Email :</label>
        <input type="email" name="email" required><br>
        <label>Mot de passe :</label>
        <input type="password" name="password" required><br>
        <label>Rôle :</label>
        <select name="role" required>
            <option value="CAISSIER">Caissier</option>
            <option value="ADMIN">Admin</option>
            <option value="RESPONSABLE_CATEGORIE">Responsable Catégorie</option>
        </select><br>
        <button type="submit">S'inscrire</button>
    </form>
    <p><a href="/WEB-INF/auth/login.jsp">Retour à la connexion</a></p>
</body>
</html>
