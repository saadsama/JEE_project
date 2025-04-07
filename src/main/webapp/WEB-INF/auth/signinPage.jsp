<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Connexion");
    request.setAttribute("content", "/WEB-INF/auth/login.jsp"); // Fichier contenant uniquement le formulaire
%>
<jsp:include page="/WEB-INF/layouts/layout.jsp" />
