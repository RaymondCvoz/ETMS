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
    <title><spring:message code="etms.submissions.submission.title" text="Submission #"/>${submission.submissionId}</title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/submissions/submission.css?v=${version}"/>
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
<div id="content" class="container">
    <div class="row-fluid">
        <div id="main-content" class="span12">
            <div class="submission">
                <div class="header">
                    <span class="pull-right"></span>
                    <span class="name">P${submission.problem.problemId} ${submission.problem.problemName}</span>
                </div> <!-- .header -->
                <div class="body">
                    <div class="section">
                        <h4><spring:message code="etms.submissions.submission.overview" text="Overview"/></h4>
                        <div class="description">
                            <table class="table">
                                <tr>
                                    <td><spring:message code="etms.submissions.submission.judge-result"
                                                        text="Judge Result"/></td>
                                    <td id="judge-result">${submission.judgeScore}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="etms.submissions.submission.problem" text="Problem"/></td>
                                    <td id="problem-summery"><a
                                            href="<c:url value="/p/${submission.problem.problemId}" />">P${submission.problem.problemId} ${submission.problem.problemName}</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><spring:message code="etms.submissions.submission.submit-time"
                                                        text="Submit Time"/></td>
                                    <td id="submit-time"><fmt:formatDate value="${submission.submitTime}" type="both"
                                                                         dateStyle="long" timeStyle="medium"/></td>
                                </tr>
                            </table>
                        </div> <!-- .description -->
                    </div> <!-- .section -->
                </div> <!-- .body -->
            </div> <!-- .submission -->
        </div> <!-- #main-content -->
    </div> <!-- .row-fluid -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- Java Script -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
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
<c:if test="${submission.judgeResult.judgeResultName == 'Pending'}">
    <script type="text/javascript">
        $.getScript('${cdnUrl}/js/date-${language}.min.js?v=${version}', function () {
            var currentJudgeResult = 'Pending',
                getterInterval = setInterval(function () {
                    getRealTimeJudgeResult();
                    currentJudgeResult = $('#judge-result').html();
                    // if (currentJudgeResult != 'Pending') {
                    //     clearInterval(getterInterval);
                    // }
                }, 2000);
        });
    </script>
    <script type="text/javascript">
        $(function () {
            var subscriptionUrl = '<c:url value="/submission/getRealTimeJudgeResult.action?submissionId=${submission.submissionId}&csrfToken=${csrfToken}" />',
                source = new EventSource(subscriptionUrl),
                lastMessage = '';

            source.onmessage = function (e) {
                var message = e['data'];

                if (message == lastMessage) {
                    return;
                }
                lastMessage = message;

                if (message == 'Established') {
                    $('#judge-log').append('<p><spring:message code="etms.submissions.submission.connection" text="Connected To Judge Service"/></p>');
                    return;
                }
                var mapMessage = JSON.parse(message),
                    judgeResult = mapMessage['judgeResult'],
                    judgeLog = mapMessage['message'];

                $('#judge-result').html(judgeResult);
                $('#judge-log').append(converter.makeHtml(judgeLog));
            }
        });
    </script>
    <script type="text/javascript">
        function getRealTimeJudgeResult() {
            var pageRequests = {
                'submissionId': ${submission.submissionId}
            };

            $.ajax({
                type: 'GET',
                url: '<c:url value="/submission/getSubmission.action" />',
                data: pageRequests,
                dataType: 'JSON',
                success: function (result) {
                    if (result['isSuccessful']) {
                        if (result['submission']['judgeResult']['judgeResultSlug'] != 'PD') {
                            $('#judge-result').removeClass();
                            $('#judge-result').addClass("flag-" + result['submission']['judgeResult']['judgeResultSlug'])
                            $('#judge-result').html(result['submission']['judgeResult']['judgeResultName']);
                            $('#used-time').html(result['submission']['usedTime'] + " ms");
                            $('#used-memory').html(result['submission']['usedMemory'] + " KB");
                            $('#execute-time').html(getFormatedDateString(result['submission']['executeTime'], '${language}'));
                            $('#judge-log').html(converter.makeHtml(result['submission']['judgeLog'].replace(/\\\n/g, '\\n')));
                        }
                    }
                }
            });
        }
    </script>
    <script type="text/javascript">
        function getFormatedDateString(dateTime, locale) {
            var dateObject = new Date(dateTime),
                dateString = dateObject.toString();

            if (locale == 'en_US') {
                dateString = dateObject.toString('MMM d, yyyy h:mm:ss tt');
            } else if (locale == 'zh_CN') {
                dateString = dateObject.toString('yyyy-M-dd HH:mm:ss');
            }

            return dateString;
        }
    </script>
</c:if>
<script type="text/javascript">
    $.getScript('${cdnUrl}/js/highlight.min.js?v=${version}', function () {
        $('pre code').each(function (i, block) {
            hljs.highlightBlock(block);
        });
    });
</script>

</body>
</html>