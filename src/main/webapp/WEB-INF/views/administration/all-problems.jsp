<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.administration.all-problems.title" text="All Problems"/></title>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/all-problems.css?v=${version}"/>
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/flat-ui.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/pace.min.js?v=${version}"></script>

</head>
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%@ include file="/WEB-INF/views/administration/include/sidebar.jsp" %>
    <div id="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/administration/include/header.jsp" %>
        <!-- Content -->
        <div id="content">
            <h2 class="page-header"><i class="fa fa-question-circle"></i> <spring:message
                    code="etms.administration.all-problems.all-problems" text="All Problems"/></h2>
            <div class="alert alert-error hide"></div> <!-- .alert-error -->
            <div id="filters" class="row-fluid">
                <div class="span4">
                    <div class="row-fluid">
                        <div class="span8">
                            <select id="actions">
                                <option value="delete"><spring:message code="etms.administration.all-problems.delete"
                                                                       text="Delete"/></option>
                            </select>
                        </div> <!-- .span8 -->
                        <div class="span4">
                            <button class="btn btn-danger"><spring:message code="etms.administration.all-problems.apply"
                                                                           text="Apply"/></button>
                        </div> <!-- .span4 -->
                    </div> <!-- .row-fluid -->
                </div> <!-- .span4 -->
                <div class="span8 text-right">
                    <form action="<c:url value="/administration/all-problems" />" method="GET" class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <input id="keyword" name="keyword" class="span12" type="text"
                                       placeholder="<spring:message code="etms.administration.all-problems.keyword" text="Keyword" />"
                                       value="${keyword}"/>
                            </div> <!-- .control-group -->
                        </div> <!-- .span5 -->
                        <div class="span5">
                            <select name="problemTag" id="problem-tag">
                                <option value=""><spring:message
                                        code="etms.administration.all-problems.all-problem-categories"
                                        text="All Problem Categories"/></option>
                                <c:forEach var="problemTag" items="${problemTags}">
                                    <option value="${problemTag.problemTagSlug}"
                                            <c:if test="${problemTag.problemTagSlug == selectedProblemTag}">selected</c:if> >${problemTag.problemTagName}</option>
                                </c:forEach>
                            </select>
                        </div> <!-- .span5 -->
                        <div class="span2">
                            <button class="btn btn-primary"><spring:message
                                    code="etms.administration.all-problems.filter" text="Filter"/></button>
                        </div> <!-- .span2 -->
                    </form> <!-- .row-fluid -->
                </div> <!-- .span8 -->
            </div> <!-- .row-fluid -->
            <table class="table table-striped">
                <thead>
                <tr>
                    <th class="check-box">
                        <label class="checkbox" for="all-problems">
                            <input id="all-problems" type="checkbox" data-toggle="checkbox">
                        </label>
                    </th>
                    <th class="problem-id"><spring:message code="etms.administration.all-problems.id"/></th>
                    <th class="problem-is-public"><spring:message code="etms.administration.all-problems.is-public"
                                                                  text="Public/Private"/></th>
                    <th class="problem-name"><spring:message code="etms.administration.all-problems.problem-name"
                                                             text="Problem Name"/></th>
                    <th class="problem-tags"><spring:message code="etms.administration.all-problems.problem-tags"
                                                             text="Tags"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="problem" items="${problems}">
                    <tr data-value="${problem.problemId}">
                        <td class="check-box">
                            <label class="checkbox" for="problem-${problem.problemId}">
                                <input id="problem-${problem.problemId}" type="checkbox" value="${problem.problemId}"
                                       data-toggle="checkbox"/>
                            </label>
                        </td>
                        <td class="problem-id">
                            <a href="<c:url value="/administration/edit-problem/${problem.problemId}"/>" > ${problem.problemId}</a>
                        </td>
                        <td class="problem-is-public">
                            <c:choose>
                                <c:when test="${problem.isPublic()}"><spring:message
                                        code="etms.administration.all-problems.public" text="Public"/></c:when>
                                <c:otherwise><spring:message code="etms.administration.all-problems.private"
                                                             text="Private"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="problem-name">${problem.problemName}</td>
                        <td class="problem-tags">
                            <c:choose>
                                <c:when test="${problemTagRelationships[problem.problemId] == null}"></c:when>
                                <c:otherwise>
                                    <c:forEach var="problemTag"
                                               items="${problemTagRelationships[problem.problemId]}"
                                               varStatus="loop">
                                        <a href="<c:url value="/administration/all-problems?problemTag=${problemTag.problemTagSlug}" />">
                                                ${problemTag.problemTagName}
                                        </a><c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div> <!-- #content -->
    </div> <!-- #container -->
</div> <!-- #wrapper -->
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<%@ include file="/WEB-INF/views/administration/include/footer-script.jsp" %>
<script type="text/javascript">
    $('label[for=all-problems]').click(function () {
        // Fix the bug for Checkbox in FlatUI
        var isChecked = false;
        setTimeout(function () {
            isChecked = $('label[for=all-problems]').hasClass('checked');

            if (isChecked) {
                $('label.checkbox').addClass('checked');
            } else {
                $('label.checkbox').removeClass('checked');
            }
        }, 100);
    });
</script>
<script type="text/javascript">
    $('button.btn-danger', '#filters').click(function () {
        if (!confirm('<spring:message code="etms.administration.all-problems.continue-or-not" text="Are you sure to continue?" />')) {
            return;
        }
        $('.alert-error').addClass('hide');
        $('button.btn-danger', '#filters').attr('disabled', 'disabled');
        $('button.btn-danger', '#filters').html('<spring:message code="etms.administration.all-problems.please-wait" text="Please wait..." />');

        var problems = [],
            action = $('#actions').val();

        $('label.checkbox', 'table tbody').each(function () {
            if ($(this).hasClass('checked')) {
                var problemId = $('input[type=checkbox]', $(this)).val();
                problems.push(problemId);
            }
        });

        if (action == 'delete') {
            return doDeleteProblemsAction(problems);
        }
    });
</script>
<script type="text/javascript">
    function doDeleteProblemsAction(problems) {
        var postData = {
            'problems': JSON.stringify(problems)
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/deleteProblems.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                if (result['isSuccessful']) {
                    for (var i = 0; i < problems.length; ++i) {
                        $('tr[data-value=%s]'.format(problems[i])).remove();
                    }
                } else {
                    $('.alert').html('<spring:message code="etms.administration.all-problems.delete-error" text="Some errors occurred while deleting problems." />');
                    $('.alert').removeClass('hide');
                }
                $('button.btn-danger', '#filters').removeAttr('disabled');
                $('button.btn-danger', '#filters').html('<spring:message code="etms.administration.all-problems.apply" text="Apply" />');
            }
        });
    }
</script>
</body>
</html>