<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.administration.new-exam.new-exam" text="New Exam"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/new-user.css?v=${version}"/>
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
            <h2 class="page-header"><i class="fa fa-user"></i> <spring:message
                    code="etms.administration.edit-exam.edit-exam" text="New Exam"/></h2>
            <form id="profile-form" onSubmit="onSubmit(); return false;">
                <div class="alert alert-error hide"></div> <!-- .alert-error -->
                <div class="alert alert-success hide"><spring:message code="etms.administration.edit-exam.exam-created"
                                                                      text="The exam has been created successfully."/></div>
                <!-- .alert-success -->
                <div class="control-group row-fluid">
                    <label for="exam-name"><spring:message code="etms.administration.edit-exam.exam-name"
                                                           text="Exam-name"/></label>
                    <input id="exam-name" class="span12" type="text" maxlength="16" value="${exam.examName}" required/>
                    <input id="exam-id" class="hidden" value="${exam.examId}">
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="start-time"><spring:message code="etms.administration.edit-exam.start-time"
                                                            text="start time"/></label>
                    <input id="start-time" class="span12" type="text" value="${beginTimeToString}" maxlength="64" placeholder="yyyy-mm-dd hh:mm:ss" required />
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="end-time"><spring:message code="etms.administration.edit-exam.end-time"
                                                          text="end time"/></label>
                    <input id="end-time" class="span12" type="text" value="${endTimeToString}" maxlength="64" placeholder="yyyy-mm-dd hh:mm:ss" required/>
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="rule"><spring:message code="etms.administration.edit-exam.rule"
                                                      text="Rule"/></label>
                    <select id="rule" name="ruleGroup">
                        <option value="Exam">Exam</option>
                        <option value="Survey">Survey</option>
                    </select>
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="problems"><spring:message code="etms.administration.edit-exam.problems"
                                                          text="Problems"/></label>
                    <input id="problems" class="span12" type="text" maxlength="64"
                           placeholder="<spring:message code="etms.administration.edit-exam.problems-hint" text="Hint"/>" value="${exam.examProblems}" required/>
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="note"><spring:message code="etms.administration.new-exam.note"
                                                      text="Problems"/></label>
                    <input id="note" class="span12" type="text" maxlength="64"
                           placeholder="<spring:message code="etms.administration.edit-exam.note-hint" text="Hint"/>" value="${exam.examNotes}"/>
                </div> <!-- .control-group -->
                <div class="row-fluid">
                    <div class="span12">
                        <button class="btn btn-primary" type="submit"><spring:message
                                code="etms.administration.edit-exam.save-edit" text="Edit Exam"/></button>
                    </div> <!-- .span12 -->
                </div> <!-- .row-fluid -->
            </form> <!-- #profile-form -->
        </div> <!-- #content -->
    </div> <!-- #container -->
</div> <!-- #wrapper -->
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<%@ include file="/WEB-INF/views/administration/include/footer-script.jsp" %>
<script type="text/javascript">
    function onSubmit() {
        var examId = $('#exam-id').val(),
            examName = $('#exam-name').val(),
            startTime = $('#start-time').val(),
            endTime = $('#end-time').val(),
            examMode = $('#rule').val(),
            examNotes = $('#note').val(),
            problems = $('#problems').val();

        $('.alert-success', '#profile-form').addClass('hide');
        $('.alert-error', '#profile-form').addClass('hide');
        $('button[type=submit]', '#profile-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.administration.new-exam.please-wait" text="Please wait..." />');

        return doCreateExamAction(examId, examName, examNotes, startTime, endTime, examMode, problems);
    }
</script>
<script type="text/javascript">
    function doCreateExamAction(examId, examName, examNotes, startTime, endTime, examMode, problems) {
        var postData = {
            'examId':examId,
            'examName': examName,
            'examNotes': examNotes,
            'startTime': startTime,
            'endTime': endTime,
            'examMode': examMode,
            'examProblems': problems
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/editExam.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processCreateExamResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processCreateExamResult(result) {
        if (result['isSuccessful']) {
            $('input').val('');
            $('.alert-success', '#profile-form').removeClass('hide');
        } else {
            var errorMessage = '';

            if (result['isExamNameEmpty']) {
                errorMessage += '<spring:message code="etms.administration.new-exam.exam-empty" text="Exam Name is Empty" /><br>';
            }
            <%--if () {--%>
            <%--    errorMessage += '<spring:message code="etms.administration.new-exam.exam-date-begin-end-error" text="The End Time Must After The Begin Time" /><br>';--%>
            <%--}--%>
            if (!result['isBeginDateGreaterThanCurrentDate'] || !result['isEndDateGreaterThanBeginDate']) {
                errorMessage += '<spring:message code="etms.administration.new-exam.exam-date-begin-current-error" text="The Begin Time Must After The Current Time" /><br>';
            }
            if (!result['isProblemsAvailable']) {
                errorMessage += '<spring:message code="etms.administration.new-exam.exam-problem-error" text="Please Check Your Selection" /><br>';
            }
            $('.alert-error', '#profile-form').html(errorMessage);
            $('.alert-error', '#profile-form').removeClass('hide');
        }
        $('button[type=submit]', '#profile-form').removeAttr('disabled');
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.administration.new-exam.new-exam" text="Create Exam" />');
    }
</script>
</body>
</html>