<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout title="QCM" active="qcm">
    <div class="row between">
        <h1>Banque de questions</h1>
        <a class="btn primary" href="${pageContext.request.contextPath}/qcm/new">+ Nouvelle question</a>
    </div>
    <table>
        <thead><tr><th>#</th><th>Question</th><th>Bonne</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="q" items="${liste}">
            <tr>
                <td>${q.numQuest}</td>
                <td>${q.question}</td>
                <td>${q.bonneReponse}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/qcm/edit?id=${q.numQuest}">Modifier</a>
                    <a class="danger" href="${pageContext.request.contextPath}/qcm/delete?id=${q.numQuest}"
                       onclick="return confirm('Supprimer cette question ?');">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty liste}"><tr><td colspan="4" class="muted">Aucune question.</td></tr></c:if>
        </tbody>
    </table>
</t:layout>
