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
                <td>
                    <c:choose>
                        <c:when test="${s.index == 0}"><span class="rank gold"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="6"/><path d="M15.5 12.5 17 22l-5-3-5 3 1.5-9.5"/></svg> 1</span></c:when>
                        <c:when test="${s.index == 1}"><span class="rank silver"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="6"/><path d="M15.5 12.5 17 22l-5-3-5 3 1.5-9.5"/></svg> 2</span></c:when>
                        <c:when test="${s.index == 2}"><span class="rank bronze"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="6"/><path d="M15.5 12.5 17 22l-5-3-5 3 1.5-9.5"/></svg> 3</span></c:when>
                        <c:otherwise><span class="rank">#${s.index + 1}</span></c:otherwise>
                    </c:choose>
                </td>
                <td>${e.nomEtudiant} ${e.prenomsEtudiant} <span class="muted">(${e.numEtudiant})</span></td>
                <td><span class="badge ${e.niveauEtudiant}">${e.niveauEtudiant}</span></td>
                <td><strong>${e.note}/10</strong></td>
            </tr>
        </c:forEach>
        <c:if test="${empty liste}"><tr><td colspan="4" class="muted">Aucun examen passe.</td></tr></c:if>
        </tbody>
    </table>
</t:layout>
