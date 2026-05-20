<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Effectifs" active="niveaux">
    <h1>Effectifs par niveau</h1>
    <p class="subtitle">Cliquez sur un niveau pour voir la liste des etudiants.</p>
    <div class="split">
        <table class="small" style="width:100%;">
            <thead><tr><th>Niveau</th><th>Effectif</th><th></th></tr></thead>
            <tbody>
            <c:forEach var="entry" items="${counts}">
                <tr>
                    <td><span class="badge ${entry.key}">${entry.key}</span></td>
                    <td><strong>${entry.value}</strong></td>
                    <td><a href="${pageContext.request.contextPath}/etudiants/niveaux?niveau=${entry.key}">Voir</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div>
            <c:choose>
                <c:when test="${not empty niveau}">
                    <h2 style="margin-top:0;">Etudiants en <span class="badge ${niveau}">${niveau}</span> <span class="muted">(${fn:length(liste)})</span></h2>
                    <table>
                        <thead><tr><th>Numero</th><th>Nom</th><th>Prenoms</th><th>Email</th></tr></thead>
                        <tbody>
                        <c:forEach var="e" items="${liste}">
                            <tr>
                                <td>${e.numEtudiant}</td><td>${e.nom}</td><td>${e.prenoms}</td><td>${e.adrEmail}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty liste}"><tr><td colspan="4" class="muted">Aucun etudiant.</td></tr></c:if>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div style="background:var(--surface);border:1px dashed var(--border);border-radius:var(--radius);padding:40px;text-align:center;color:var(--muted);">
                        Selectionnez un niveau a gauche pour afficher les etudiants.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</t:layout>
