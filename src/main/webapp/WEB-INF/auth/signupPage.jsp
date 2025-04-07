<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Définir dynamiquement le titre et le contenu pour le layout
    request.setAttribute("pageTitle", "Inscription");
    request.setAttribute("content", "/WEB-INF/auth/signup.jsp"); // Chemin vers signup.jsp
%>
<jsp:include page="/WEB-INF/layouts/layout.jsp" />
