<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${exam.examName} <spring:message code="etms.exams.leaderboard.leaderboard" text="Leaderboard"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/contests/leaderboard.css?v=${version}"/>
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>

</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!-- Content -->
<div id="content" class="container">
    <div class="row-fluid" style="margin-top: 10px">
        <div class="span12">
            <div class="leaderboard">
                <div class="header">
                    ${exam.examName} <spring:message code="etms.exams.leaderboard.leaderboard"
                                                           text="Leaderboard"/>
                </div> <!-- .header -->
                <div class="body">
                    <table class="table table-striped">
                        <thead>
                        <th class="participant"><spring:message code="etms.exams.leaderboard.participant"
                                                               text="Participant"/></th>
                        <c:forEach var="problem" items="${problems}">
                            <th class="submission problem-${problem.problemId}"><a
                                    href="<c:url value="/exam/${exam.examId}/p/${problem.problemId}" />"
                                    target="_blank">P${problem.problemId}</a></th>
                        </c:forEach>
                        </thead>
                        <tbody>
                        <c:forEach var="participant" items="${participants}">
                            <tr>
                                <td class="participant"><a
                                        href="<c:url value="/accounts/user/${participant.user.uid}" />"
                                        target="_blank">${participant.user.username}</a></td>
                                <c:forEach var="problem" items="${problems}">
                                    <td class="submission problem-${problem.problemId}">
                                        <c:set var="submission"
                                               value="${submissions[participant.user.uid][problem.problemId]}"/>
                                        <c:choose>
                                            <c:when test="${submission == null}">-</c:when>
                                            <c:otherwise>
                                                <a href="<c:url value="/submission/${submission.submissionId}" />"
                                                   target="_blank">${submission.judgeScore}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div> <!-- .body -->
            </div> <!-- .leaderboard -->
        </div> <!-- .span12 -->
    </div> <!-- .row-fluid -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<script type="text/javascript">
    $(window).scroll(function () {
        var offset = $('table').offset().top - $('thead').outerHeight() - $(window).scrollTop();

        if (offset <= 0) {
            $('thead').css('position', 'fixed');
            <c:forEach var="problem" items="${problems}">
            $('th.problem-${problem.problemId}').width($('td.problem-${problem.problemId}').width());
            </c:forEach>
        } else {
            $('thead').css('position', 'relative');
        }
    });
</script>

</body>
</html>
