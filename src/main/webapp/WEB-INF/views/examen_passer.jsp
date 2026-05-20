<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Examen" active="examen">
    <h1>Examen - ${etudiant.nom} ${etudiant.prenoms}</h1>
    <p class="muted">Annee universitaire : ${annee}</p>
    <form method="post" action="${pageContext.request.contextPath}/examen/soumettre" class="form">
        <c:forEach var="q" items="${questions}" varStatus="s">
            <fieldset class="question">
                <legend>Question ${s.index + 1}</legend>
                <p><strong>${q.question}</strong></p>
                <c:forEach var="i" begin="1" end="4">
                    <label class="choice">
                        <input type="radio" name="q_${q.numQuest}" value="${i}" required/>
                        ${q.getReponseTexte(i)}
                    </label>
                </c:forEach>
            </fieldset>
        </c:forEach>
        <div class="row">
            <button class="btn primary" type="submit">Soumettre</button>
            <a class="btn ghost" href="${pageContext.request.contextPath}/">Abandonner</a>
        </div>
    </form>
</t:layout>
