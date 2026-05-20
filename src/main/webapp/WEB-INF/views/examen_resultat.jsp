<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Resultat" active="examen">
    <h1>Resultat de l'examen</h1>
    <div class="score">
        <div class="score-ring" style="--pct: ${note * 10};">
            <div class="val">${note}<small>/ 10</small></div>
        </div>
        <div class="info">
            <p class="name">${etudiant.nom} ${etudiant.prenoms} <span class="badge ${etudiant.niveau}">${etudiant.niveau}</span></p>
            <p class="meta">Annee universitaire : <strong>${annee}</strong></p>
            <p class="meta email-row"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg> Email envoye a <strong>${etudiant.adrEmail}</strong> : ${emailStatut}</p>
        </div>
    </div>
    <div class="row">
        <a class="btn" href="${pageContext.request.contextPath}/examen/notes">Voir toutes les notes</a>
        <a class="btn" href="${pageContext.request.contextPath}/examen/classement">Voir le classement</a>
        <a class="btn ghost" href="${pageContext.request.contextPath}/">Accueil</a>
    </div>
</t:layout>
