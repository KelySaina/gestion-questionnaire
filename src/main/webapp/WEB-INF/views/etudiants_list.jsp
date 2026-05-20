<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Etudiants" active="etudiants">
    <div class="row between">
        <h1>Etudiants</h1>
        <a class="btn primary" href="${pageContext.request.contextPath}/etudiants/new">+ Nouvel etudiant</a>
    </div>
    <form method="get" action="${pageContext.request.contextPath}/etudiants" class="search">
        <input name="q" value="${q}" placeholder="Rechercher par numero ou nom (LIKE)"/>
        <button class="btn">Rechercher</button>
        <c:if test="${not empty q}">
            <a class="btn ghost" href="${pageContext.request.contextPath}/etudiants">Effacer</a>
        </c:if>
    </form>
    <table>
        <thead><tr><th>Numero</th><th>Nom</th><th>Prenoms</th><th>Niveau</th><th>Email</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="e" items="${liste}">
            <tr>
                <td>${e.numEtudiant}</td>
                <td>${e.nom}</td>
                <td>${e.prenoms}</td>
                <td>${e.niveau}</td>
                <td>${e.adrEmail}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/etudiants/edit?id=${e.numEtudiant}">Modifier</a>
                    <a class="danger" href="${pageContext.request.contextPath}/etudiants/delete?id=${e.numEtudiant}"
                       onclick="return confirm('Supprimer cet etudiant ?');">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty liste}"><tr><td colspan="6" class="muted">Aucun etudiant.</td></tr></c:if>
        </tbody>
    </table>
</t:layout>
