<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="zh_CN"/>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.administration.edit-submission.title" text="Edit Submission"/> - ${submission.submissionId}</title>

    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/new-problem.css?v=${version}"/>
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
            <h2 class="page-header"><i class="fa fa-file"></i> <spring:message
                    code="etms.administration.edit-submission.title" text="Edit Submission"/></h2>
            <form id="problem-form" onSubmit="onSubmit(); return false;">
                <div class="row-fluid">
                    <div class="span8">
                        <div class="alert alert-error hide"></div> <!-- .alert-error -->
                        <div class="alert alert-success hide"><spring:message
                                code="etms.administration.edit-submission.submission-edited" text="Submission updated."/> <a
                                href="<c:url value="/submission/" />${submission.submissionId}"><spring:message
                                code="etms.administration.edit-submission.view-submission" text="View Submission"/></a></div>
                        <!-- .alert-success -->
                        <div class="control-group row-fluid">
                            <label for="judge-score"><spring:message
                                    code="etms.administration.edit-submission.judge-result" text="Judge Score"/></label>
                            <input id="judge-score" class="span12" type="text" maxlength="128"
                                   value="${submission.judgeScore}"/>
                            <input id="submission-id" type="hidden" value="${submission.submissionId}"/>
                        </div> <!-- .control-group -->
                        <div class="control-group row-fluid">
                            <label for="submission-context"><spring:message code="etms.administration.edit-submission.context"
                                                              text="Context"/></label>
                            <textarea id="submission-context" class="span12" readonly>${submission.submissionContext}</textarea>
                        </div> <!-- .control-group -->
                        <div class="control-group row-fluid">
                            <label for="submission-submit-time"><spring:message code="etms.administration.edit-submission.submit-time"
                                                                                text="Submit-time"/></label>
                            <input id="submission-submit-time" class="span12" type="text" maxlength="128"
                                   value="<fmt:formatDate value="${submission.submitTime}" type="both" dateStyle="long"
                                                timeStyle="medium"/>" readonly/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                    <div class="span4">
                        <div class="section">
                            <div class="header">
                                <h5><spring:message code="etms.administration.edit-submission.title"
                                                    text="Edit Submission"/></h5>
                            </div> <!-- .header -->
                            <div class="footer text-left">
                                <button class="btn btn-primary" type="submit"><spring:message
                                        code="etms.administration.edit-submission.edit-submission" text="Update"/></button>
                            </div> <!-- .footer -->
                        </div> <!-- .section -->
                    </div> <!-- .span4 -->
                </div> <!-- .row-fluid -->
            </form>
        </div> <!-- #content -->
    </div> <!-- #container -->
</div> <!-- #wrapper -->
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<%@ include file="/WEB-INF/views/administration/include/footer-script.jsp" %>

<script type="text/javascript">
    function onSubmit() {
        var submissionId = $('#submission-id').val(),
            judgeScore = $('#judge-score').val();

        $('.alert-success', '#problem-form').addClass('hide');
        $('.alert-error', '#problem-form').addClass('hide');
        $('button[type=submit]', '#problem-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#problem-form').html('<spring:message code="etms.administration.edit-problem.please-wait" text="Please wait..." />');

        return editSubmission(submissionId, judgeScore);
    }
</script>

<script type="text/javascript">
    function editSubmission(submissionId, judgeScore) {
        var postData = {
            'submissionId': submissionId,
            'judgeScore': judgeScore
        };
        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/editSubmission.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processEditProblemResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processEditProblemResult(result) {
        if (result['isSuccessful']) {
            $('.alert-error').addClass('hide');
            $('.alert-success').removeClass('hide');
        } else {
            var errorMessage = '';

            if (!result['invalidScore']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.invalid-score" text="Invalid Score." /><br>';
            }

            $('.alert-error', '#problem-form').html(errorMessage);
            $('.alert-error', '#problem-form').removeClass('hide');
        }
        $('button[type=submit]', '#problem-form').removeAttr('disabled');
        $('button[type=submit]', '#problem-form').html('<spring:message code="etms.administration.edit-submission.edit-submission" text="Update" />');
    }
</script>
</body>
</html>