<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${exam.examName}</title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/contests/contest.css?v=${version}"/>
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!-- Content -->
<c:choose>
    <c:when test="${currentTime.before(exam.startTime)}">
        <c:set var="examStatus" value="Ready"/>
    </c:when>
    <c:when test="${currentTime.after(exam.endTime)}">
        <c:set var="examStatus" value="Done"/>
    </c:when>
    <c:when test="${currentTime.after(exam.startTime) and currentTime.before(exam.endTime)}">
        <c:set var="examStatus" value="Live"/>
    </c:when>
</c:choose>
<div id="content" class="container">
    <div class="row-fluid">
        <div id="main-content" class="span8">
            <div class="exam">
                <div class="header">
                        <span class="pull-right">
                        <c:if test="${isLogin}">
                            <c:choose>
                                <c:when test="${isAttended}"><spring:message code="etms.exams.exam.attended"
                                                                             text="Attended"/></c:when>
                                <c:otherwise><spring:message code="etms.exams.exam.not-attended"
                                                             text="Not attended"/></c:otherwise>
                            </c:choose>
                        </c:if>
                        </span>
                    <span class="name">${exam.examName}</span>
                </div> <!-- .header -->
                <div class="body">
                    <div class="section">
                        <h4><spring:message code="etms.exams.exam.instruction" text="Instruction"/></h4>
                        <c:choose>
                            <c:when test="${exam.examNotes == ''}"><p><spring:message
                                    code="etms.exams.exam.no-instruction" text="No instruction available."/></p>
                            </c:when>
                            <c:otherwise>
                                <div class="markdown">${exam.examNotes}</div>
                                <!-- .markdown --></c:otherwise>
                        </c:choose>
                    </div> <!-- .section -->
                    <c:if test="${(currentTime.after(exam.startTime) and isAttended) or currentTime.after(exam.endTime)}">
                        <div class="section">
                            <h4><spring:message code="etms.exams.exam.problems" text="Problems"/></h4>
                            <table id="problems" class="table table-striped">
                                <c:if test="${isLogin}">
                                    <thead>
                                    <tr>
                                            <%--                                        <th><spring:message code="etms.exams.exam.status" text="Status"/></th>--%>
                                        <th><spring:message code="etms.exams.exam.problem" text="Problem"/></th>
                                    </tr>
                                    </thead>
                                </c:if>
                                <tbody>
                                <c:forEach var="problem" items="${problems}">
                                    <tr>
                                            <%--                                        <c:if test="${isLogin}">--%>
                                            <%--                                            <c:set var="submission" value="${submissions[problem.problemId]}"/>--%>
                                            <%--                                            <c:choose>--%>
                                            <%--                                                <c:when test="${submission != null}">--%>
                                            <%--                                                    <td class="flag-${submission.submission.judgeResult.judgeResultSlug}">--%>
                                            <%--                                                        <a href="<c:url value="/submission/${submission.submission.submissionId}" />">${submission.submission.judgeResult.judgeResultName}</a>--%>
                                            <%--                                                    </td>--%>
                                            <%--                                                </c:when>--%>
                                            <%--                                                <c:otherwise>--%>
                                            <%--                                                    <td><spring:message code="etms.exams.exam.no-submissions"--%>
                                            <%--                                                                        text="No submissions"/></td>--%>
                                            <%--                                                </c:otherwise>--%>
                                            <%--                                            </c:choose>--%>
                                            <%--                                        </c:if>--%>
                                        <td>
                                            <a href="<c:url value="/exam/${exam.examId}/p/${problem.problemId}" />">P${problem.problemId} ${problem.problemName}</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- .section -->
                    </c:if>
                </div> <!-- .body -->
            </div> <!-- .exam -->
        </div> <!-- #main-content -->
        <div id="sidebar" class="span4">
            <div class="section">
                <h5><spring:message code="etms.exams.exam.basic-information" text="Basic Information"/></h5>
                <div id="basic-info">
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.status" text="Status"/></div>
                        <!-- .span5 -->
                        <div class="span7 ${examStatus}">${examStatus}</div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.start-time"
                                                           text="Start Time"/></div> <!-- .span5 -->
                        <div class="span7"><fmt:formatDate value="${exam.startTime}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/></div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.end-time" text="End Time"/></div>
                        <!-- .span5 -->
                        <div class="span7"><fmt:formatDate value="${exam.endTime}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/></div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.rule" text="Rule"/></div>
                        <!-- .span5 -->
                        <div class="span7">${exam.examMode}</div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.number-of-problems"
                                                           text="# Problems"/></div> <!-- .span5 -->
                        <div class="span7">${problems.size()}</div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                    <div class="row-fluid">
                        <div class="span5"><spring:message code="etms.exams.exam.number-of-participants"
                                                           text="# Contestants"/></div> <!-- .span5 -->
                        <div id="number-of-participants" class="span7">${numberOfContestants}</div> <!-- .span7 -->
                    </div> <!-- .row-fluid -->
                </div> <!-- #basic-info -->
            </div> <!-- .section -->
            <div class="section">
                <h5><spring:message code="etms.exams.exam.actions" text="Actions"/></h5>
                <ul>
                    <c:if test="${not isAttended and examStatus != 'Done'}">
                        <li><a id="attend-exam-button" href="javascript:attendContest();"><spring:message
                                code="etms.exams.exam.attend-exam" text="Attend the exam"/></a></li>
                    </c:if>
                    <c:if test="${examStatus != 'Ready'}">
                        <li><a href="<c:url value="/exam/${exam.examId}/leaderboard" />"><spring:message
                                code="etms.exams.exam.view-leaderboard" text="View leaderboard"/></a></li>
                    </c:if>
                    <c:if test="${isAttended and examStatus == 'Ready'}">
                        <li><spring:message code="etms.exams.exam.already-attended"
                                            text="You have already attended the exam."/></li>
                        <li><spring:message code="etms.exams.exam.no-actions"
                                            text="No actions are available."/></li>
                    </c:if>
                </ul>
            </div> <!-- .section -->
        </div> <!-- #sidebar -->
    </div> <!-- .row-fluid -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
        });

</script>
<script type="text/javascript" async
        src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript">
    $.getScript('${cdnUrl}/js/markdown.min.js?v=${version}', function () {
        converter = Markdown.getSanitizingConverter();

        $('.markdown').each(function () {
            var plainContent = $(this).text(),
                markdownContent = converter.makeHtml(plainContent.replace(/\\\n/g, '\\n'));

            $(this).html(markdownContent);
        });
    });
</script>
<c:if test="${not isAttended and examStatus != 'Done'}">
    <c:choose>
        <c:when test="${isLogin}">
            <script type="text/javascript">
                function attendContest() {
                    var postData = {
                        'csrfToken': '${csrfToken}'
                    };

                    $.ajax({
                        type: 'POST',
                        url: '<c:url value="/exam/${exam.examId}/attend.action" />',
                        data: postData,
                        dataType: 'JSON',
                        success: function (result) {
                            if (result['isSuccessful']) {
                                $('#attend-exam-button').removeAttr('href');
                                setContestAttended();
                            } else {
                                if (!result['isCsrfTokenValid']) {
                                    alert('<spring:message code="etms.exams.exam.invalid-token" text="Invalid Token." />');
                                } else if (!result['isContestExists']) {
                                    alert('<spring:message code="etms.exams.exam.exam-not-exists" text="The exam doesn&acute;t exist." />');
                                } else if (!result['isContestReady']) {
                                    alert('<spring:message code="etms.exams.exam.exam-not-ready" text="The exam is started or finished." />');
                                } else if (!result['isUserLogin']) {
                                    alert('<spring:message code="etms.exams.exam.user-not-login" text="You are not logged in." />');
                                } else if (result['isAttendedContest']) {
                                    alert('<spring:message code="etms.exams.exam.already-attended" text="You have already attended the exam." />');
                                    setContestAttended();
                                }
                            }
                        }
                    });
                }
            </script>
            <script type="text/javascript">
                function setContestAttended() {
                    var numberOfContestants = parseInt($('#number-of-examants').html());

                    $('.pull-right', '.exam .header').html('<spring:message code="etms.exams.exam.attended" text="Attended" />');
                    $('#number-of-examants').html(numberOfContestants + 1);
                    $('#attend-exam-button').html('<spring:message code="etms.exams.exam.attended-exam" text="You&acute;ve attended the exam." />');
                    setTimeout(function () {
                        $('#attend-exam-button').remove();
                    }, 1500);
                }
            </script>
        </c:when>
        <c:otherwise>
            <script type="text/javascript">
                function attendContest() {
                    window.location.href = '<c:url value="/accounts/login?forward=" />${requestScope['javax.servlet.forward.request_uri']}';
                }
            </script>
        </c:otherwise>
    </c:choose>
</c:if>

</body>
</html>