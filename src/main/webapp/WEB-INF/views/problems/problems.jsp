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
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description}">
    <!-- Icon -->
    <link href="${cdnUrl}/img/favicon.ico?v=${version}" rel="shortcut icon" type="image/x-icon">
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
                                   placeholder="<spring:message code="etms.problems.problems.keyword" text="Keyword" />"
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
                    <th class="submission"><spring:message code="etms.problems.problems.pass"
                                                           text="Pass"/>/<spring:message code="etms.problems.problems.submission"
                                                                                         text="Submission"/></th>
                    <c:if test="${isLogin}">
                        <th class="flag"><spring:message code="etms.problems.problems.result" text="Result"/></th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="problem" items="${problems}">
                    <tr data-value="${problem.problemId}">
                        <td class="name">
                            <a href="<c:url value="/p/${problem.problemId}" />" style="color: #3E35A8">P${problem.problemId} ${problem.problemName}</a>
                        </td>
<%--                        <td>${problem.acceptedSubmission}/${problem.totalSubmission}</td>--%>
<%--                        <c:if test="${isLogin}">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${submissionOfProblems[problem.problemId] == null}">--%>
<%--                                    <td></td>--%>
<%--                                </c:when>--%>
<%--                                <c:otherwise>--%>
<%--                                    <td class="flag-${submissionOfProblems[problem.problemId].judgeResult.judgeResultSlug}">--%>
<%--                                        <a href="<c:url value="/submission/${submissionOfProblems[problem.problemId].submissionId}" />">--%>
<%--                                                ${submissionOfProblems[problem.problemId].judgeResult.judgeResultSlug}--%>
<%--                                        </a>--%>
<%--                                    </td>--%>
<%--                                </c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </c:if>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="more-problems">
                <p class="availble"><spring:message code="etms.problems.problems.more-problems"
                                                    text="More Problems..."/></p>
                <img src="${cdnUrl}/img/loading.gif?v=${version}" alt="Loading" class="hide"/>
            </div>
        </div> <!-- #problems -->

        <%--            <div id="categories-widget" class="widget">--%>
        <%--                <h4><spring:message code="etms.problems.problems.categories" text="Categories"/></h4>--%>
        <%--                <c:forEach var="entry" items="${problemCategories}">--%>
        <%--                    <h6>--%>
        <%--                        <a--%>
        <%--                                <c:if test="${param.category == entry.key.problemCategorySlug}">class="active" </c:if>--%>
        <%--                                href="<c:url value="/p?category=${entry.key.problemCategorySlug}" />">--%>
        <%--                                ${entry.key.problemCategoryName}--%>
        <%--                        </a>--%>
        <%--                    </h6>--%>
        <%--                    <ul class="inline">--%>
        <%--                        <c:forEach var="problemCategory" items="${entry.value}">--%>
        <%--                            <li>--%>
        <%--                                <a--%>
        <%--                                        <c:if test="${param.category == problemCategory.problemCategorySlug}">class="active" </c:if>--%>
        <%--                                        href="<c:url value="/p?category=${problemCategory.problemCategorySlug}" />">--%>
        <%--                                        ${problemCategory.problemCategoryName}--%>
        <%--                                </a>--%>
        <%--                            </li>--%>
        <%--                        </c:forEach>--%>
        <%--                    </ul>--%>
        <%--                </c:forEach>--%>
        <%--            </div> <!-- #categories-widget -->--%>
    </div> <!-- #sidebar -->
</div> <!-- #main-content -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<script type="text/javascript">
    $(function () {
        var numberOfProblems = $('tr', '#problems tbody').length;

        if (numberOfProblems == 0) {
            return processProblemsResult(false);
        }
    });
</script>
<script type="text/javascript">
    function setLoadingStatus(isLoading) {
        if (isLoading) {
            $('p', '#more-problems').addClass('hide');
            $('img', '#more-problems').removeClass('hide');
        } else {
            $('img', '#more-problems').addClass('hide');
            $('p', '#more-problems').removeClass('hide');
        }
    }
</script>
<script type="text/javascript">
    $('#more-problems').click(function (event) {
        var isLoading = $('img', this).is(':visible'),
            hasNextRecord = $('p', this).hasClass('availble'),
            lastProblemRecord = $('tr:last-child', '#problems tbody'),
            lastProblemId = parseInt($(lastProblemRecord).attr('data-value'));

        if (!isLoading && hasNextRecord) {
            setLoadingStatus(true);
            return getMoreProblems(lastProblemId + 1);
        }
    });
</script>
<script type="text/javascript">
    function getMoreProblems(startIndex) {
        var pageRequests = {
            'startIndex': startIndex,
            'keyword': '${param.keyword}',
            'category': '${param.category}'
        };

        $.ajax({
            type: 'GET',
            url: '<c:url value="/p/getProblems.action" />',
            data: pageRequests,
            dataType: 'JSON',
            success: function (result) {
                return processProblemsResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processProblemsResult(result) {
        if (result['isSuccessful']) {
            displayProblemsRecords(result['problems'], result['submissionOfProblems']);
        } else {
            $('p', '#more-problems').removeClass('availble');
            $('p', '#more-problems').html('<spring:message code="etms.problems.problems.no-more-problem" text="No more problem" />');
            $('#more-problems').css('cursor', 'default');
        }
        setLoadingStatus(false);
    }
</script>
<script type="text/javascript">
    function displayProblemsRecords(problems, submissionOfProblems) {
        for (var i = 0; i < problems.length; ++i) {
            $('table > tbody', '#problems').append(
                getProblemContent(problems[i]['problemId'], problems[i]['problemName'],
                    problems[i]['totalSubmission'], problems[i]['acceptedSubmission'], submissionOfProblems)
            );
        }
    }
</script>
<script type="text/javascript">
    <c:choose>
    <c:when test="${isLogin}">

    function getProblemContent(problemId, problemName, totalSubmission, acceptedSubmission, submissionOfProblems) {
        var problemTemplate = '<tr data-value="%s">' +
            '    %s' +
            '    <td class="name"><a href="<c:url value="/p/%s" />">P%s %s</a></td>' +
            '    <td>%s</td>' +
            '    <td>%s%</td>' +
            '</tr>';

        return problemTemplate.format(problemId, getSubmissionOfProblemHtml(problemId, submissionOfProblems[problemId]),
            problemId, problemId, problemName, totalSubmission, getAcRate(acceptedSubmission, totalSubmission));
    }

    </c:when>
    <c:otherwise>

    function getProblemContent(problemId, problemName, totalSubmission, acceptedSubmission) {
        var problemTemplate = '<tr data-value="%s">' +
            '    <td class="name"><a href="<c:url value="/p/%s" />">P%s %s</a></td>' +
            '    <td>%s</td>' +
            '    <td>%s%</td>' +
            '</tr>';

        return problemTemplate.format(problemId, problemId, problemId, problemName,
            totalSubmission, getAcRate(acceptedSubmission, totalSubmission));
    }

    </c:otherwise>
    </c:choose>
</script>
<script type="text/javascript">
    function getSubmissionOfProblemHtml(problemId, submissionOfProblem) {
        if (typeof (submissionOfProblem) == 'undefined') {
            return '<td></td>';
        }

        var submissionId = submissionOfProblem['submissionId'],
            judgeResultSlug = submissionOfProblem['judgeResult']['judgeResultSlug'],
            submissionTemplate = '<td class="flag-%s">' +
                '    <a href="<c:url value="/submission/%s" />">%s</a>' +
                '</td>';

        return submissionTemplate.format(judgeResultSlug, submissionId, judgeResultSlug);
    }
</script>
<script type="text/javascript">
    function getAcRate(acceptedSubmission, totalSubmission) {
        if (totalSubmission == 0) {
            return 0;
        }
        return Math.round(acceptedSubmission / totalSubmission) * 100;
    }
</script>

</body>
</html>