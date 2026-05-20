<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Accueil">
    <section class="hero">
        <h1>Bienvenue</h1>
        <p>Application de gestion des questionnaires - etudiants, banque de QCM, examens et classement.</p>
    </section>
    <div class="cards">
        <a class="card" href="${pageContext.request.contextPath}/etudiants">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </div>
            <h3>Etudiants</h3><p>Creer, lister, modifier, supprimer. Recherche LIKE.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/qcm">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/></svg>
            </div>
            <h3>Banque de QCM</h3><p>Gerer la banque de questions et leurs reponses.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/etudiants/niveaux">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3v18h18"/><rect x="7" y="13" width="3" height="5"/><rect x="12" y="9" width="3" height="9"/><rect x="17" y="5" width="3" height="13"/></svg>
            </div>
            <h3>Effectifs par niveau</h3><p>Liste des etudiants par L1 / L2 / L3 / M1 / M2.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/start">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4z"/></svg>
            </div>
            <h3>Passer un examen</h3><p>10 questions tirees au hasard, note /10, email automatique.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/notes">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="9" y1="13" x2="15" y2="13"/><line x1="9" y1="17" x2="15" y2="17"/></svg>
            </div>
            <h3>Notes</h3><p>Historique des notes des etudiants.</p>
        </a>
        <a class="card" href="${pageContext.request.contextPath}/examen/classement">
            <div class="icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/><path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/><path d="M4 22h16"/><path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/><path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/><path d="M18 2H6v7a6 6 0 0 0 12 0V2z"/></svg>
            </div>
            <h3>Classement</h3><p>Etudiants ranges par ordre de merite.</p>
        </a>
    </div>
</t:layout>
