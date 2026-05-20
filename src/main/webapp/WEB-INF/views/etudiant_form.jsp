<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Etudiant" active="etudiants">
    <div class="page-form">
        <h1>${mode == 'edit' ? 'Modifier' : 'Nouvel'} etudiant</h1>
    <form method="post" action="${pageContext.request.contextPath}/etudiants" class="form">
        <input type="hidden" name="mode" value="${mode}"/>
        <label>Numero
            <input name="num_etudiant" value="${etudiant.numEtudiant}" required
                   <c:if test="${mode=='edit'}">readonly</c:if> />
        </label>
        <label>Nom <input name="nom" value="${etudiant.nom}" required/></label>
        <label>Prenoms <input name="prenoms" value="${etudiant.prenoms}" required/></label>
        <label>Niveau
            <select name="niveau" required>
                <c:forEach var="n" items="${['L1','L2','L3','M1','M2']}">
                    <option value="${n}" ${etudiant.niveau == n ? 'selected' : ''}>${n}</option>
                </c:forEach>
            </select>
        </label>
        <label>Email <input type="email" name="adr_email" value="${etudiant.adrEmail}" required/></label>
        <div class="row">
            <button class="btn primary" type="submit">Enregistrer</button>
            <a class="btn ghost" href="${pageContext.request.contextPath}/etudiants">Annuler</a>
        </div>
    </form>
    </div>
</t:layout>
