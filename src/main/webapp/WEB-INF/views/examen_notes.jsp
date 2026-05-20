<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Notes" active="notes">
    <h1>Liste des notes</h1>
    <table>
        <thead><tr><th>#</th><th>Etudiant</th><th>Niveau</th><th>Annee</th><th>Note</th><th>Date</th></tr></thead>
        <tbody>
        <c:forEach var="e" items="${liste}">
            <tr>
                <td>${e.numExam}</td>
                <td>${e.nomEtudiant} ${e.prenomsEtudiant} <span class="muted">(${e.numEtudiant})</span></td>
                <td><span class="badge ${e.niveauEtudiant}">${e.niveauEtudiant}</span></td>
                <td>${e.anneeUniv}</td>
                <td><strong>${e.note}/10</strong></td>
                <td>${e.dateExam}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty liste}"><tr><td colspan="6" class="muted">Aucun examen passe.</td></tr></c:if>
        </tbody>
    </table>
</t:layout>
