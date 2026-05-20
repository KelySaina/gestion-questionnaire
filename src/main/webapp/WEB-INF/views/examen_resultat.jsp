<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Resultat" active="examen">
    <h1>Resultat de l'examen</h1>
    <div class="score">
        <p><strong>${etudiant.nom} ${etudiant.prenoms}</strong> (${etudiant.niveau})</p>
        <p>Annee universitaire : ${annee}</p>
        <p class="big">Note : <strong>${note} / 10</strong></p>
        <p class="muted">Statut envoi email a ${etudiant.adrEmail} : ${emailStatut}</p>
    </div>
    <div class="row">
        <a class="btn" href="${pageContext.request.contextPath}/examen/notes">Voir toutes les notes</a>
        <a class="btn" href="${pageContext.request.contextPath}/examen/classement">Voir le classement</a>
        <a class="btn ghost" href="${pageContext.request.contextPath}/">Accueil</a>
    </div>
</t:layout>
