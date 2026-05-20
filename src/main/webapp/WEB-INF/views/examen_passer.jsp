<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Examen" active="examen">
    <div class="row between" style="max-width:820px;margin:0 auto 18px;">
        <div>
            <h1 style="margin:0;">Examen</h1>
            <p class="subtitle" style="margin:4px 0 0;">${etudiant.nom} ${etudiant.prenoms} <span class="badge ${etudiant.niveau}">${etudiant.niveau}</span> &middot; ${annee}</p>
        </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/examen/soumettre" class="stepper-wrap" id="examForm">
        <div class="stepper-head">
            <div class="count">Question <strong id="curIdx">1</strong> / <c:out value="${fn:length(questions)}" default="10"/></div>
            <div class="count" id="answeredCount">0 repondue(s)</div>
        </div>
        <div class="progress"><span id="progressBar"></span></div>
        <div class="dots" id="dots">
            <c:forEach var="q" items="${questions}" varStatus="s">
                <span class="dot ${s.index == 0 ? 'active' : ''}" data-idx="${s.index}">${s.index + 1}</span>
            </c:forEach>
        </div>

        <c:forEach var="q" items="${questions}" varStatus="s">
            <fieldset class="question step ${s.index == 0 ? 'active' : ''}" data-step="${s.index}">
                <legend>Question ${s.index + 1}</legend>
                <p>${q.question}</p>
                <c:forEach var="i" begin="1" end="4">
                    <label class="choice">
                        <input type="radio" name="q_${q.numQuest}" value="${i}"/>
                        <span>${q.getReponseTexte(i)}</span>
                    </label>
                </c:forEach>
            </fieldset>
        </c:forEach>

        <div class="stepper-nav">
            <button type="button" class="btn" id="prevBtn" disabled>
                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
                Precedent
            </button>
            <div class="row" style="gap:8px;">
                <a class="btn ghost" href="${pageContext.request.contextPath}/">Abandonner</a>
                <button type="button" class="btn primary" id="nextBtn">
                    Suivant
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
                </button>
                <button type="submit" class="btn primary" id="submitBtn" style="display:none;">
                    Soumettre
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
                </button>
            </div>
        </div>
    </form>

    <script>
    (function(){
        var form = document.getElementById('examForm');
        var steps = form.querySelectorAll('.step');
        var dots = form.querySelectorAll('.dot');
        var prev = document.getElementById('prevBtn');
        var next = document.getElementById('nextBtn');
        var submit = document.getElementById('submitBtn');
        var bar = document.getElementById('progressBar');
        var curIdx = document.getElementById('curIdx');
        var answered = document.getElementById('answeredCount');
        var i = 0, n = steps.length;

        function show(k){
            i = Math.max(0, Math.min(n - 1, k));
            steps.forEach(function(s, j){ s.classList.toggle('active', j === i); });
            dots.forEach(function(d, j){ d.classList.toggle('active', j === i); });
            curIdx.textContent = (i + 1);
            bar.style.width = ((i + 1) / n * 100) + '%';
            prev.disabled = (i === 0);
            var last = (i === n - 1);
            next.style.display = last ? 'none' : '';
            submit.style.display = last ? '' : 'none';
        }
        function refreshAnswered(){
            var c = 0;
            steps.forEach(function(s){
                if (s.querySelector('input[type=radio]:checked')) c++;
            });
            answered.textContent = c + ' repondue(s)';
            dots.forEach(function(d, j){
                d.classList.toggle('answered', !!steps[j].querySelector('input[type=radio]:checked'));
            });
        }
        prev.addEventListener('click', function(){ show(i - 1); });
        next.addEventListener('click', function(){ show(i + 1); });
        dots.forEach(function(d){
            d.addEventListener('click', function(){ show(parseInt(d.dataset.idx, 10)); });
        });
        form.addEventListener('change', refreshAnswered);
        form.addEventListener('submit', function(ev){
            var missing = [];
            steps.forEach(function(s, j){
                if (!s.querySelector('input[type=radio]:checked')) missing.push(j + 1);
            });
            if (missing.length){
                ev.preventDefault();
                alert('Veuillez repondre aux questions : ' + missing.join(', '));
                show(missing[0] - 1);
            }
        });
        show(0); refreshAnswered();
    })();
    </script>
</t:layout>
