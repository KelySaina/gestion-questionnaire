<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Accueil">
    <h1>Bienvenue</h1>
    <p>Application de gestion des questionnaires.</p>
    <div class="cards">
        <a class="card" href="${pageContext.request.contextPath}/etudiants">
            <h3>Etudiants</h3><p>Creer, lister, modifier, supprimer. Recherche LIKE.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/qcm">
            <h3>QCM</h3><p>Gerer la banque de questions.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/etudiants/niveaux">
            <h3>Effectifs par niveau</h3><p>Liste des etudiants par L1/L2/L3/M1/M2.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/start">
            <h3>Passer un examen</h3><p>10 questions tirees au hasard, note /10, email automatique.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/notes">
            <h3>Notes</h3><p>Liste des notes des etudiants.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/classement">
            <h3>Classement</h3><p>Etudiants par ordre de merite.</p>
        </a>
    </div>
</t:layout>
