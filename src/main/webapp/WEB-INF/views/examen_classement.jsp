<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Classement" active="classement">
    <h1>Classement par ordre de merite</h1>
    <p class="muted">Moyenne sur tous les examens passes.</p>
    <table>
        <thead><tr><th>Rang</th><th>Etudiant</th><th>Niveau</th><th>Moyenne</th></tr></thead>
        <tbody>
        <c:forEach var="e" items="${liste}" varStatus="s">
            <tr class="${s.index < 3 ? 'top' : ''}">
                <td>#${s.index + 1}</td>
                <td>${e.nomEtudiant} ${e.prenomsEtudiant} <span class="muted">(${e.numEtudiant})</span></td>
                <td>${e.niveauEtudiant}</td>
                <td><strong>${e.note}/10</strong></td>
            </tr>
        </c:forEach>
        <c:if test="${empty liste}"><tr><td colspan="4" class="muted">Aucun examen passe.</td></tr></c:if>
        </tbody>
    </table>
</t:layout>
