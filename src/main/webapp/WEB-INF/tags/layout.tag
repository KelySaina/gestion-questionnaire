<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="active" required="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>${empty title ? 'Gestion des Questionnaires' : title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<header class="topbar">
    <div class="brand"><a href="${pageContext.request.contextPath}/">Gestion des Questionnaires</a></div>
    <nav>
        <a class="${active=='etudiants'?'on':''}" href="${pageContext.request.contextPath}/etudiants">Etudiants</a>
        <a class="${active=='qcm'?'on':''}" href="${pageContext.request.contextPath}/qcm">QCM</a>
        <a class="${active=='niveaux'?'on':''}" href="${pageContext.request.contextPath}/etudiants/niveaux">Effectifs</a>
        <a class="${active=='examen'?'on':''}" href="${pageContext.request.contextPath}/examen/start">Passer un examen</a>
        <a class="${active=='notes'?'on':''}" href="${pageContext.request.contextPath}/examen/notes">Notes</a>
        <a class="${active=='classement'?'on':''}" href="${pageContext.request.contextPath}/examen/classement">Classement</a>
    </nav>
</header>
<main class="container">
    <jsp:doBody/>
</main>
<footer class="footer">Projet 1 - Gestion des Questionnaires</footer>
</body>
</html>
