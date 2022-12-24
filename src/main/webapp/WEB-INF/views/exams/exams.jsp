<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.exams.exams.title" text="Contests"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/contests/contests.css?v=${version}"/>
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
        <div id="sidebar">
            <div id="search-widget" class="widget">
                <%--                <h4><spring:message code="etms.exams.exams.search" text="Search"/></h4>--%>
                <form id="search-form" action="<c:url value="/exam" />">
                    <div class="row-fluid">
                        <div class="span10">
                            <input name="keyword" class="span12" type="text"
                                   placeholder="<spring:message code="etms.exams.exams.keyword" text="Keyword" />"
                                   value="${param.keyword}"/>
                        </div>
                        <div class="span2">
                            <button class="btn btn-primary btn-block" type="submit"><spring:message
                                    code="etms.exams.exams.search" text="Search"/></button>
                        </div>
                    </div>
                </form> <!-- #search-form -->
            </div> <!-- #search-widget -->
        </div> <!-- #sidebar -->

        <div id="exams">
            <table class="table table-striped" id="exam-table">
                <thead>
                <tr>
                    <th><spring:message code="etms.exams.exams.title" text="Contest Title"/></th>
                    <th><spring:message code="etms.exams.exam.start-time" text="Start Time"/></th>
                    <th><spring:message code="etms.exams.exams.end-time" text="End Time"/></th>
                    <th><spring:message code="etms.exams.exam.rule" text="Rule"/></th>
                    <th><spring:message code="etms.exams.exam.status" text="Status"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="exam" items="${exams}">
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
                    <tr>
                        <td><a href="<c:url value="/exam/${exam.examId}" />">${exam.examName}</a></td>
                        <td><fmt:formatDate value="${exam.startTime}" type="both" dateStyle="long"
                                            timeStyle="medium"/></td>
                        <td><fmt:formatDate value="${exam.endTime}" type="both" dateStyle="long"
                                            timeStyle="medium"/></td>
                        <td>${exam.examMode}</td>
                        <td>${examStatus}</td>
                    </tr>

                </c:forEach>
                </tbody>
                <%--                <c:forEach var="exam" items="${exams}">--%>
                <%--                    <c:choose>--%>
                <%--                        <c:when test="${currentTime.before(exam.startTime)}">--%>
                <%--                            <c:set var="examStatus" value="Ready"/>--%>
                <%--                        </c:when>--%>
                <%--                        <c:when test="${currentTime.after(exam.endTime)}">--%>
                <%--                            <c:set var="examStatus" value="Done"/>--%>
                <%--                        </c:when>--%>
                <%--                        <c:when test="${currentTime.after(exam.startTime) and currentTime.before(exam.endTime)}">--%>
                <%--                            <c:set var="examStatus" value="Live"/>--%>
                <%--                        </c:when>--%>
                <%--                    </c:choose>--%>
                <%--                    <tr class="exam ${examStatus}">--%>
                <%--                        <td class="overview">--%>
                <%--                            <h5><a href="<c:url value="/exam/${exam.examId}" />">${exam.examName}</a>--%>
                <%--                            </h5>--%>
                <%--                            <ul class="inline">--%>
                <%--                                <li>${exam.examMode}</li>--%>
                <%--                                <li><spring:message code="etms.exams.exams.start-time" text="Start Time"/>:--%>
                <%--                                    <fmt:formatDate value="${exam.startTime}" type="both" dateStyle="long"--%>
                <%--                                                    timeStyle="medium"/></li>--%>
                <%--                                <li><spring:message code="etms.exams.exams.end-time" text="End Time"/>:--%>
                <%--                                    <fmt:formatDate value="${exam.endTime}" type="both" dateStyle="long"--%>
                <%--                                                    timeStyle="medium"/></li>--%>
                <%--                            </ul>--%>
                <%--                        </td>--%>
                <%--                        <td class="status">${examStatus}</td>--%>
                <%--                    </tr>--%>
                <%--                </c:forEach>--%>
            </table> <!-- .table -->
        </div> <!-- #exams -->

    </div> <!-- #main-content -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<script type="text/javascript" src="${cdnUrl}/js/date-${language}.min.js?v=${version}"></script>
<script type="text/javascript">
    function setLoadingStatus(isLoading) {
        if (isLoading) {
            $('p', '#more-exams').addClass('hide');
            $('img', '#more-exams').removeClass('hide');
        } else {
            $('img', '#more-exams').addClass('hide');
            $('p', '#more-exams').removeClass('hide');
        }
    }
</script>
<script type="text/javascript">
    $('#more-exams').click(function () {
        var isLoading = $('img', this).is(':visible'),
            hasNextRecord = $('p', this).hasClass('availble'),
            // numberOfContests = $('tr.exam').length;
            numberOfContests = document.getElementById('exam-table').tBodies[0].rows.length;

        if (!isLoading && hasNextRecord) {
            setLoadingStatus(true);
            return getMoreContests(numberOfContests);
        }
    });
</script>
<script type="text/javascript">
    function getMoreContests(startIndex) {
        var pageRequests = {
            'keyword': '${param.keyword}',
            'startIndex': startIndex
        };

        $.ajax({
            type: 'GET',
            url: '<c:url value="/exam/getContests.action" />',
            data: pageRequests,
            dataType: 'JSON',
            success: function (result) {
                return processContestsResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processContestsResult(result) {
        if (result['isSuccessful']) {
            displayContests(result['exams']);
        } else {
            $('p', '#more-exams').removeClass('availble');
            $('p', '#more-exams').html('<spring:message code="etms.exams.exams.no-more-exams" text="No more exams" />');
            $('#more-exams').css('cursor', 'default');
        }
        setLoadingStatus(false);
    }
</script>
<script type="text/javascript">
    function displayContests(exams) {
        for (var i = 0; i < exams.length; ++i) {
            var examStatus = 'Done',
                currentTime = new Date(),
                examStartTime = new Date(exams[i]['startTime']),
                examEndTime = new Date(exams[i]['endTime']);

            if (currentTime < examStartTime) {
                examStatus = 'Ready';
            } else if (currentTime >= examStartTime && currentTime <= examEndTime) {
                examStatus = 'Live';
            }
            <%--$('#exams tbody').append('<tr class="exam %s">'.format(examStatus) +--%>
            <%--    '    <td class="overview">' +--%>
            <%--    '        <h5><a href="<c:url value="/exam/" />%s">%s</a></h5>'.format(exams[i]['examId'], exams[i]['examName']) +--%>
            <%--    '        <ul class="inline">' +--%>
            <%--    '            <li>%s</li>'.format(exams[i]['examMode']) +--%>
            <%--    '            <li><spring:message code="etms.exams.exams.start-time" text="Start Time" />: %s</li>'.format(getFormatedDateString(exams[i]['startTime'], '${language}')) +--%>
            <%--    '            <li><spring:message code="etms.exams.exams.end-time" text="End Time" />: %s</li>'.format(getFormatedDateString(exams[i]['endTime'], '${language}')) +--%>
            <%--    '        </ul>' +--%>
            <%--    '    </td>' +--%>
            <%--    '    <td class="status">%s</td>'.format(examStatus) +--%>
            <%--    '</tr>');--%>

            $('#exams tbody').append('<tr>' +
                '<td><a href="<c:url value="/exam/" />%s">%s</a></td>'.format(exams[i]['examId'], exams[i]['examName']) +
                '<td>%s</td>'.format(getFormatedDateString(exams[i]['startTime'],'${language}')) +
                '<td>%s</td>'.format(getFormatedDateString(exams[i]['endTime'],'${language}')) +
                '<td>%s</td>'.format(exams[i]['examMode']) +
                '<td>%s</td>'.format(examStatus) +
                '</tr>');
        }
    }
</script>

</body>
</html>