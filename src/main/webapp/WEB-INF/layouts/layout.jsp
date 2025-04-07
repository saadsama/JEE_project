<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Default Title" %></title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/WEB-INF/layouts/header.jsp" />

    <!-- Include Navbar -->
    <jsp:include page="/WEB-INF/layouts/navbar.jsp" />

    <!-- Main Content -->
    <main>
        <jsp:include page="${content}" />
    </main>

    <!-- Include Footer -->
    <jsp:include page="/WEB-INF/layouts/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
