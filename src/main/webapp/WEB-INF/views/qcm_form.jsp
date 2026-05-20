<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="Question" active="qcm">
    <h1>${mode == 'edit' ? 'Modifier' : 'Nouvelle'} question</h1>
    <form method="post" action="${pageContext.request.contextPath}/qcm" class="form">
        <input type="hidden" name="mode" value="${mode}"/>
        <c:if test="${mode=='edit'}">
            <input type="hidden" name="num_quest" value="${qcm.numQuest}"/>
        </c:if>
        <label>Question <input name="question" value="${qcm.question}" required/></label>
        <label>Reponse 1 <input name="reponse1" value="${qcm.reponse1}" required/></label>
        <label>Reponse 2 <input name="reponse2" value="${qcm.reponse2}" required/></label>
        <label>Reponse 3 <input name="reponse3" value="${qcm.reponse3}" required/></label>
        <label>Reponse 4 <input name="reponse4" value="${qcm.reponse4}" required/></label>
        <label>Bonne reponse
            <select name="bonne_reponse" required>
                <c:forEach var="i" begin="1" end="4">
                    <option value="${i}" ${qcm.bonneReponse == i ? 'selected' : ''}>Reponse ${i}</option>
                </c:forEach>
            </select>
        </label>
        <div class="row">
            <button class="btn primary" type="submit">Enregistrer</button>
            <a class="btn ghost" href="${pageContext.request.contextPath}/qcm">Annuler</a>
        </div>
    </form>
</t:layout>
