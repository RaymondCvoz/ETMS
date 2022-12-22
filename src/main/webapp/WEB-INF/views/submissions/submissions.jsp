<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="zh_CN"/>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.submissions.submissions.title" text="Submission"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/submissions/submissions.css?v=${version}"/>
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
    <form id="filter" action="<c:url value="/submission" />">
        <div class="row-fluid">
            <div class="span5">
                <div class="form-group">
                    <input name="username" type="text" value="${param.username}"
                           placeholder="<spring:message code="etms.submissions.submissions.submitter-username" text="Submitter's Username" />"
                           class="form-control span12">
                </div> <!-- .form-group -->
            </div> <!-- .span5 -->
            <div class="span5">
                <div class="form-group">
                    <input name="problemId" type="text" value="${param.problemId}"
                           placeholder="<spring:message code="etms.submissions.submissions.problem-id" text="Problem ID" />"
                           class="form-control span12">
                </div> <!-- .form-group -->
            </div> <!-- .span5 -->
            <div class="span2">
                <button class="btn btn-primary btn-block" type="submit"><spring:message
                        code="etms.submissions.submissions.filter" text="Filter"/></button>
            </div> <!-- .span2 -->
        </div> <!-- .row-fluid -->
    </form> <!-- #filter -->
    <div id="main-content">
        <div class="row-fluid">
            <div id="submission" class="span12">
                <table class="table">
                    <thead>
                    <tr>
                        <th class="score"><spring:message code="etms.submissions.submissions.score" text="Score"/></th>
                        <th class="name"><spring:message code="etms.submissions.submissions.problem"
                                                         text="Problem"/></th>
                        <th class="user"><spring:message code="etms.submissions.submissions.user" text="User"/></th>
                        <th class="submit-time"><spring:message code="etms.submissions.submissions.submit-time"
                                                                text="Submit Time"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="submission" items="${submissions}">
                        <tr>
                            <td class="score">${submission.judgeScore}</td>
                            <td class="name"><a
                                    href="<c:url value="/p/${submission.problem.problemId}" />">P${submission.problem.problemId} ${submission.problem.problemName}</a>
                            </td>
                            <td class="user"><a
                                    href="<c:url value="/accounts/user/${submission.user.uid}" />">${submission.user.username}</a>
                            </td>
                            <td class="submit-time">
                                <fmt:formatDate value="${submission.submitTime}" type="both" dateStyle="long"
                                                timeStyle="medium"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div> <!-- #submission -->
        </div> <!-- .row-fluid -->
    </div> <!-- #main-content -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>