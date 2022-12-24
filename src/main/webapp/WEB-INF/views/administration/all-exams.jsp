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
    <title><spring:message code="etms.administration.all-problems.title" text="All Problems"/></title>

    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/all-contests.css?v=${version}"/>
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
                    code="etms.administration.all-exams.all-exams" text="All Contests"/></h2>
            <div class="alert alert-error hide"></div> <!-- .alert-error -->
            <div id="filters" class="row-fluid">
                <div class="span4">
                    <div class="row-fluid">
                        <div class="span8">
                            <select id="actions">
                                <option value="delete"><spring:message code="etms.administration.all-exams.delete"
                                                                       text="Delete"/></option>
                            </select>
                        </div> <!-- .span8 -->
                        <div class="span4">
                            <button class="btn btn-danger"><spring:message code="etms.administration.all-exams.apply"
                                                                           text="Apply"/></button>
                        </div> <!-- .span4 -->
                    </div> <!-- .row-fluid -->
                </div> <!-- .span4 -->
                <div class="span8 text-right">
                    <form action="<c:url value="/administration/all-exams" />" method="GET" class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <input id="keyword" name="keyword" class="span12" type="text"
                                       placeholder="<spring:message code="etms.administration.all-exams.keyword" text="Keyword" />"
                                       value="${keyword}"/>
                            </div> <!-- .control-group -->
                        </div> <!-- .span5 -->
                        <div class="span2">
                            <button class="btn btn-primary"><spring:message
                                    code="etms.administration.all-exams.filter" text="Filter"/></button>
                        </div> <!-- .span2 -->
                    </form> <!-- .row-fluid -->
                </div> <!-- .span8 -->
            </div> <!-- .row-fluid -->
            <table class="table table-striped">
                <thead>
                <tr>
                    <th class="check-box">
                        <label class="checkbox" for="all-exams">
                            <input id="all-exams" type="checkbox" data-toggle="checkbox">
                        </label>
                    </th>
                    <th class="exam-id">#</th>

                    <th class="exam-name"><spring:message code="etms.administration.all-exams.exam-name"
                                                             text="Contest Name"/></th>
                    <th class="exam-start-time"><spring:message
                            code="etms.administration.all-exams.start-time" text="Start-Time"/></th>
                    <th class="exam-end-time"><spring:message code="etms.administration.all-exams.end-time"
                                                                 text="End-Time"/></th>
                    <th class="rule"><spring:message
                            code="etms.administration.all-exams.rule" text="Rule"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="exam" items="${exams}">
                    <tr data-value="${exam.examId}">
                        <td class="check-box">
                            <label class="checkbox" for="exam-${exam.examId}">
                                <input id="exam-${exam.examId}" type="checkbox" value="${exam.examId}"
                                       data-toggle="checkbox"/>
                            </label>
                        </td>
                        <td class="exam-id">
                            <a href="<c:url value="/administration/edit-exam/${exam.examId}" />">${exam.examId}</a>
                        </td>
                        <td class="exam-name">${exam.examName}</td>
                        <td class="exam-start-time"><fmt:formatDate value="${exam.startTime}" type="both" dateStyle="long"
                                                                       timeStyle="medium"/></td>
                        <td class="exam-end-time"><fmt:formatDate value="${exam.endTime}" type="both" dateStyle="long"
                                                                     timeStyle="medium"/></td>
                        <td class="rule">${exam.examMode}</td>
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
    $('label[for=all-exams]').click(function () {
        // Fix the bug for Checkbox in FlatUI
        var isChecked = false;
        setTimeout(function () {
            isChecked = $('label[for=all-exams]').hasClass('checked');

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
        if (!confirm('<spring:message code="etms.administration.all-exams.continue-or-not" text="Are you sure to continue?" />')) {
            return;
        }
        $('.alert-error').addClass('hide');
        $('button.btn-danger', '#filters').attr('disabled', 'disabled');
        $('button.btn-danger', '#filters').html('<spring:message code="etms.administration.all-exams.please-wait" text="Please wait..." />');

        var exams = [],
            action = $('#actions').val();

        $('label.checkbox', 'table tbody').each(function () {
            if ($(this).hasClass('checked')) {
                var examId = $('input[type=checkbox]', $(this)).val();
                exams.push(examId);
            }
        });

        if (action == 'delete') {
            return doDeleteContestsAction(exams);
        }
    });
</script>
<script type="text/javascript">
    function doDeleteContestsAction(exams) {
        var postData = {
            'exams': JSON.stringify(exams)
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/deleteContests.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                if (result['isSuccessful']) {
                    for (var i = 0; i < exams.length; ++i) {
                        $('tr[data-value=%s]'.format(exams[i])).remove();
                    }
                } else {
                    $('.alert').html('<spring:message code="etms.administration.all-exams.delete-error" text="Some errors occurred while deleting exams." />');
                    $('.alert').removeClass('hide');
                }
                $('button.btn-danger', '#filters').removeAttr('disabled');
                $('button.btn-danger', '#filters').html('<spring:message code="etms.administration.all-exams.apply" text="Apply" />');
            }
        });
    }
</script>
</body>
</html>