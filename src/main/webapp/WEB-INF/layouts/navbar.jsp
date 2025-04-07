 <nav class="navbar">
        <div class="nav-container">
            <ul class="nav-list" id="navList">
                <li><a href="<%= request.getContextPath()%>/HomeServlet" class="nav-link ">Accueil</a></li>
                <% 
                    com.supermarche.model.Utilisateur utilisateur = (com.supermarche.model.Utilisateur) session.getAttribute("utilisateur");
                    if (utilisateur == null) {
                %>
                    <li style="margin-left: auto;">
                        <a href="<%= request.getContextPath() %>/auth?action=signup" class="nav-link">Inscription</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/auth?action=login" class="nav-link">Connexion</a>
                    </li>
                <% } else { %>
                    <% if (utilisateur.getRole() == com.supermarche.model.Role.CAISSIER) { %>
                        <li><a href="<%= request.getContextPath() %>/PanierServlet?action=list" class="nav-link">Paniers</a></li>
                    <% } else if (utilisateur.getRole() == com.supermarche.model.Role.RESPONSABLECATEGORIE) { %>
                        <li><a href="<%= request.getContextPath() %>/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                        <li><a href="<%= request.getContextPath() %>/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                    <% } else if (utilisateur.getRole() == com.supermarche.model.Role.ADMIN) { %>
                        <li><a href="<%= request.getContextPath() %>/PanierServlet?action=list" class="nav-link">Paniers</a></li>
                        <li><a href="<%= request.getContextPath() %>/ProduitServlet?action=list" class="nav-link">Produits</a></li>
                        <li><a href="<%= request.getContextPath() %>/CategorieServlet?action=list" class="nav-link">Catégories</a></li>
                        <li><a href="<%= request.getContextPath() %>/UtilisateurServlet?action=list" class="nav-link">Utilisateurs</a></li>
                    <% } %>
                    <div class="user-info">
                        <i class="fas fa-user"></i>
                        <span><strong><%= utilisateur.getNom() %></strong> (<%= utilisateur.getRole().name() %>)</span>
                        <a href="<%= request.getContextPath() %>/auth?action=logout" class="nav-link">Déconnexion</a>
                    </div>
                <% } %>
            </ul>
        </div>
    </nav>