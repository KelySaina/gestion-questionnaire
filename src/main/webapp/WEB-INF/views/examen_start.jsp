<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Passer un examen" active="examen">
    <div class="page-form">
        <h1>Passer un examen</h1>
        <p class="subtitle">Choisissez un etudiant et l'annee universitaire pour commencer.</p>
        <c:if test="${not empty erreur}"><div class="alert error">${erreur}</div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/examen/passer" class="form">
        <label>Etudiant
            <select name="num_etudiant" required>
                <option value="">-- Choisir --</option>
                <c:forEach var="e" items="${etudiants}">
                    <option value="${e.numEtudiant}">${e.numEtudiant} - ${e.nom} ${e.prenoms} (${e.niveau})</option>
                </c:forEach>
            </select>
        </label>
        <label>Annee universitaire
            <input name="annee_univ" value="${anneeUniv}" pattern="\d{4}-\d{4}" required/>
        </label>
        <div class="row">
            <button class="btn primary" type="submit">Commencer</button>
        </div>
    </form>
    </div>
</t:layout>
