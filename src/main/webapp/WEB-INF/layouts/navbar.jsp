<nav>
    <ul style="list-style: none; padding: 0; margin: 0; background-color: #333; overflow: hidden;">
        <li style="display: inline;">
            <a href="<%= request.getContextPath() %>/" style="color: white; text-decoration: none; padding: 14px 20px; display: inline-block;">Accueil</a>
        </li>
        <li style="display: inline;">
            <a href="<%= request.getContextPath() %>/ProduitServlet?action=list" style="color: white; text-decoration: none; padding: 14px 20px; display: inline-block;">Produits</a>
        </li>
        <li style="display: inline;">
            <a href="<%= request.getContextPath() %>/CategorieServlet?action=list" style="color: white; text-decoration: none; padding: 14px 20px; display: inline-block;">Catégories</a>
        </li>
        <li style="display: inline;">
            <a href="<%= request.getContextPath() %>/UtilisateurServlet?action=list" style="color: white; text-decoration: none; padding: 14px 20px; display: inline-block;">Utilisateurs</a>
        </li>
    </ul>
</nav>
