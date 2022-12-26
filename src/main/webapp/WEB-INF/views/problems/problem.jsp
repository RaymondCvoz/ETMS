<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>P${problem.problemId} ${problem.problemName}</title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/codemirror.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/problems/problem.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/highlight.min.css?v=${version}"/>
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!-- Content -->
<div id="content" class="container" >
    <div class="row-fluid" style="margin-top: 10px">
        <div id="sidebar" class="span2">
            <c:choose>
                <c:when test="${isExam}">
                    <div id="actions" class="section">
                        <ul>
                            <c:choose>
                                <c:when test="${currentTime.after(exam.endTime)}">
                                    <li><button class="btn btn-primary btn-block" onclick="window.location.href='<c:url value="/p/${problem.problemId}" />'">
                                        <spring:message
                                                code="etms.problems.problem.view-in-problem-mode"
                                                text="View in Problem Mode"/></button>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li><button id="submit-solution" class="btn btn-primary btn-block" onclick="javascript:void(0);"><spring:message
                                            code="etms.problems.problem.submit-solution" text="Submit Solution"/></button>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li><button class="btn btn-primary btn-block" style="margin-top: 10px" onclick="window.location.href='<c:url value="/exam/${exam.examId}" />'"><spring:message
                                    code="etms.problems.problem.back-to-exam" text="Back to Exam"/></button></li>
                        </ul>
                    </div>
                    <!-- #actions -->
                </c:when>
                <c:otherwise>
                    <div id="actions" class="section">
                        <ul>
                            <c:choose>
                                <c:when test="${isLogin}">
                                    <li><button id="submit-solution" class="btn btn-primary btn-block" onclick="javascript:void(0);"><spring:message
                                            code="etms.problems.problem.submit-solution" text="Submit Solution"/></button></li>
                                </c:when>
                                <c:otherwise>
                                    <li><button id="login-to-submit" class="btn btn-primary btn-block" onclick="window.location.href='<c:url value="/accounts/login?forward=" />${requestScope['javax.servlet.forward.request_uri']}'"><spring:message
                                            code="etms.problems.problem.login-to-submit" text="Login to Submit Solution"/></button></li>
                                </c:otherwise>
                            </c:choose>
                            <li><button class="btn btn-primary btn-block" style="margin-top: 10px" onclick="window.location.href='<c:url value="/submission?problemId=${problem.problemId}" />'">
                                <spring:message code="etms.problems.problem.view-submission" text="Submit Solution"/></button></li>
                        </ul>
                    </div>
                    <!-- #actions -->
                </c:otherwise>
            </c:choose>
            <c:if test="${isLogin}">
                <c:choose>
                    <c:when test="${submissions == null || submissions.size() == 0}"></c:when>
                    <c:otherwise>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th><spring:message code="etms.problems.problem.submission" text="My submission"/></th>
                                <th><spring:message code="etms.problems.problems.result" text="Result"/></th>
                            </tr>
                            </thead>
                            <c:forEach var="submission" items="${submissions}">
                                <tr>
                                    <td><a href="<c:url value="/submission/${submission.submissionId}" />">
                                        <fmt:formatDate value="${submission.submitTime}" type="date" dateStyle="short"
                                                        timeStyle="short"/>
                                    </a></td>
                                    <td>${submission.judgeScore}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div> <!-- #sidebar -->
        <div id="main-content" class="span10">
            <div class="problem">
                <div class="header">
                    <span class="name" id="problem-info">P${problem.problemId} ${problem.problemName}</span>
                </div> <!-- .header -->
                <div class="body">
                    <div class="section">
                        <h5><spring:message code="etms.problems.problem.description" text="Description"/></h5>
                        <div class="description markdown" >${problem.description}</div> <!-- .description -->
                    </div> <!-- .section -->
                    <c:if test="${problem.hint != null and problem.hint != ''}">
                        <div class="section">
                            <h4><spring:message code="etms.problems.problem.hint" text="Hint"/></h4>
                            <div class="description markdown">${problem.hint.replace("<", "&lt;").replace(">", "&gt;")}</div>
                            <!-- .description -->
                        </div>
                        <!-- .section -->
                    </c:if>
                    <form id="code-editor" onsubmit="onSubmit(); return false;" method="POST" >
                        <textarea name="codemirror-editor" id="codemirror-editor"></textarea>
                        <div class="row-fluid">
                            <div id="submission-error" class="offset1 span3"></div> <!-- #submission-error -->
                            <div id="submission-action" class="span8">
                                <button type="submit" class="btn btn-primary"><spring:message
                                        code="etms.problems.problem.submit" text="Submit"/></button>
                                <button id="close-submission" class="btn"><spring:message
                                        code="etms.problems.problem.cancel" text="Cancel"/></button>
                            </div> <!-- #submission-action -->
                        </div> <!-- .row-fluid -->
                    </form> <!-- #code-editor-->
                    <div id="mask" class="hide"></div> <!-- #mask -->
                </div> <!-- .body -->
            </div> <!-- .problem -->
        </div> <!-- #main-content -->

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
<script type="text/javascript">
    $.getScript('${cdnUrl}/js/codemirror.min.js?v=${version}', function () {
        $.when(
            $.getScript('${cdnUrl}/mode/clike.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/go.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/pascal.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/perl.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/php.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/python.min.js?v=${version}'),
            $.getScript('${cdnUrl}/mode/ruby.min.js?v=${version}'),
            $.Deferred(function (deferred) {
                $(deferred.resolve);
            })
        ).done(function () {
            window.codeMirrorEditor = CodeMirror.fromTextArea(document.getElementById('codemirror-editor'), {
                mode: $('select#languages').val(),
                tabMode: 'indent',
                theme: 'neat',
                tabSize: 4,
                indentUnit: 4,
                lineNumbers: true,
                lineWrapping: true
            });
        });
    });
</script>
<script type="text/javascript">
    $.getScript('${cdnUrl}/js/highlight.min.js?v=${version}', function () {
        $('code').each(function (i, block) {
            hljs.highlightBlock(block);
        });
    });
</script>
<script type="text/javascript">
    $('select#languages').change(function () {
        window.codeMirrorEditor.setOption('mode', $(this).val());
    });
</script>
<script type="text/javascript">
    $('#submit-solution').click(function () {
        $('#mask').removeClass('hide');
        $('#code-editor').addClass('fade');
    });
</script>
<script type="text/javascript">
    $('#close-submission').click(function (e) {
        e.preventDefault();

        $('#code-editor').removeClass('fade');
        $('#mask').addClass('hide');
    });
</script>
<script type="text/javascript">
    function onSubmit() {
        var problemId = ${problem.problemId},
            context = window.codeMirrorEditor.getValue();

        $('button[type=submit]', '#code-editor').attr('disabled', 'disabled');
        $('button[type=submit]', '#code-editor').html('<spring:message code="etms.problems.problem.please-wait" text="Please wait..." />');

        return createSubmissionAction(problemId,context);
    }
</script>
<c:choose>
    <c:when test="${isExam}">
        <script type="text/javascript">
            function createSubmissionAction(problemId, context) {
                var postData = {
                    'problemId': problemId,
                    'context': context
                };

                $.ajax({
                    type: 'POST',
                    url: '<c:url value="/exam/${exam.examId}/createSubmission.action" />',
                    data: postData,
                    dataType: 'JSON',
                    success: function (result) {
                        if (result['isSuccessful']) {
                            var submissionId = result['submissionId'];
                            window.location.href = '<c:url value="/submission/" />' + submissionId;
                        } else {
                            var errorMessage = '';
                            if (!result['isUserLogined']) {
                                errorMessage = '<spring:message code="etms.problems.problem.user-not-login" text="Please sign in first." />';
                            } else if (!result['isProblemExists']) {
                                errorMessage = '<spring:message code="etms.problems.problem.problem-not-exists" text="The problem not exists." />';
                            } else if (result['isContextEmpty']) {
                                errorMessage = '<spring:message code="etms.problems.problem.empty-context" text="Please enter the context." />';
                            }
                            $('#submission-error').html(errorMessage);
                        }

                        $('button[type=submit]', '#code-editor').removeAttr('disabled');
                        $('button[type=submit]', '#code-editor').html('<spring:message code="etms.problems.problem.submit" text="Submit" />');
                    }
                });
            }
        </script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
            function createSubmissionAction(problemId, context) {
                var postData = {
                    'problemId': problemId,
                    'context': context
                };
                $.ajax({
                    type: 'POST',
                    url: '<c:url value="/p/createSubmission.action" />',
                    data: postData,
                    dataType: 'JSON',
                    success: function (result) {
                        if (result['isSuccessful']) {
                            var submissionId = result['submissionId'];
                            window.location.href = '<c:url value="/submission/" />' + submissionId;
                        } else {
                            var errorMessage = '';

                            if (!result['isUserLogined']) {
                                errorMessage = '<spring:message code="etms.problems.problem.user-not-login" text="Please sign in first." />';
                            } else if (!result['isProblemExists']) {
                                errorMessage = '<spring:message code="etms.problems.problem.problem-not-exists" text="The problem not exists." />';
                            } else if (result['isCodeEmpty']) {
                                errorMessage = '<spring:message code="etms.problems.problem.empty-context" text="Please enter the context." />';
                            }
                            $('#submission-error').html(errorMessage);
                        }

                        $('button[type=submit]', '#code-editor').removeAttr('disabled');
                        $('button[type=submit]', '#code-editor').html('<spring:message code="etms.problems.problem.submit" text="Submit" />');
                    }
                });
            }
        </script>
    </c:otherwise>
</c:choose>

</body>
</html>