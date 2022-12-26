<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.problems.problems.title" text="Problems"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/problems/problems.css?v=${version}"/>
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
    <div id="main-content" class="row-fluid">
        <div id="sidebar" >
            <div id="search-widget" class="widget">
                <form id="search-form" action="<c:url value="/p" />">
                    <div class="row-fluid">
                        <div class="span10">
                            <input id="keyword" name="keyword" class="span12" type="text"
                                   placeholder="<spring:message code="etms.lessons.lessons.keyword" text="Keyword" />"
                                   value="${param.keyword}"/>
                        </div>
                        <div class="span2">
                            <button class="btn btn-primary btn-block" type="submit"><spring:message
                                    code="etms.problems.problems.search" text="Search"/></button>
                        </div>
                    </div>
                </form> <!-- #search-form -->
            </div> <!-- #search-widget -->
        </div> <!-- #sidebar -->
        <div id="problems">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th class="name"><spring:message code="etms.problems.problems.name" text="Name"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="lesson" items="${lessons}">
                    <tr data-value="${lesson.lessonId}">
                        <td class="name">
                            <a href="<c:url value="/lesson/${lesson.lessonId}" />" style="color: #3E35A8">L${lesson.lessonId} ${lesson.lessonName}</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div> <!-- #problems -->
    </div> <!-- #sidebar -->
</div> <!-- #main-content -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>