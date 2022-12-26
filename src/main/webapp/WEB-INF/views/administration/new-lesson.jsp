<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.administration.new-lesson.title" text="New Lesson"/> - ${lesson.lessonName}</title>
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
                    code="etms.administration.new-lesson.new-lesson" text="New Lesson"/></h2>
            <form id="lesson-form" onSubmit="onSubmit(); return false;">
                <div class="row-fluid">
                    <div class="span8">
                        <div class="alert alert-error hide"></div> <!-- .alert-error -->
                        <div class="alert alert-success hide"><spring:message
                                code="etms.administration.new-lesson.lesson-created" text="Lesson created."/></div>

                        <div class="control-group row-fluid">
                            <label for="lesson-name"><spring:message
                                    code="etms.administration.new-lesson.lesson-name" text="Lesson Name"/></label>
                            <input id="lesson-name" class="span12" type="text" maxlength="128"/>
                        </div> <!-- .control-group -->
                        <div class="row-fluid">
                            <div class="span12">
                                <label for="wmd-input"><spring:message
                                        code="etms.administration.new-lesson.lesson-description"
                                        text="Description"/></label>
                                <div id="markdown-editor">
                                    <div class="wmd-panel">
                                        <div id="wmd-button-bar" class="wmd-button-bar"></div> <!-- #wmd-button-bar -->
                                        <textarea id="wmd-input" class="wmd-input"></textarea>
                                    </div> <!-- .wmd-panel -->
                                    <div id="wmd-preview" class="wmd-panel wmd-preview"></div> <!-- .wmd-preview -->
                                </div> <!-- #markdown-editor -->
                            </div> <!-- .span12 -->
                        </div> <!-- .row-fluid -->
                    </div> <!-- .span8 -->
                    <div class="span4">
                        <div class="section">
                            <div class="header">
                                <h5><spring:message code="etms.administration.new-lesson.new-lesson"
                                                    text="New Lesson"/></h5>
                            </div> <!-- .header -->
                            <div class="footer text-left">
                                <button class="btn btn-primary" type="submit"><spring:message
                                        code="etms.administration.new-lesson.new-lesson" text="Confirm"/></button>
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

<script type='text/javascript'>
    $.getScript('${cdnUrl}/js/markdown.min.js?v=${version}', function () {
        converter = Markdown.getSanitizingConverter();
        editor = new Markdown.Editor(converter);
        editor.run();

        $('.markdown').each(function () {
            var plainContent = $(this).text(),
                markdownContent = converter.makeHtml(plainContent.replace(/\\\n/g, '\\n'));

            $(this).html(markdownContent);
        });
    });
</script>
<script type="text/javascript">
    function onSubmit() {
        var lessonName = $('#lesson-name').val(),
            description = $('#wmd-input').val();

        $('.alert-success', '#lesson-form').addClass('hide');
        $('.alert-error', '#lesson-form').addClass('hide');
        $('button[type=submit]', '#lesson-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#lesson-form').html('<spring:message code="etms.administration.edit-lesson.please-wait" text="Please wait..." />');
        return editLesson(lessonName, description);
    }
</script>
<script type="text/javascript">
    function editLesson(lessonName, description) {
        var postData = {
            'lessonName': lessonName,
            'description': description
        };
        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/createLesson.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processCreateLessonResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processCreateLessonResult(result) {
        if (result['isSuccessful']) {
            $('.alert-error').addClass('hide');
            $('.alert-success').removeClass('hide');
        } else {
            var errorMessage = '';
            if (result['isLessonNameEmpty']) {
                errorMessage += '<spring:message code="etms.administration.new-lesson.lesson-name-empty" text="You can&acute;t leave Lesson Name empty." /><br>';
            } else if (!result['isLessonNameLegal']) {
                errorMessage += '<spring:message code="etms.administration.new-lesson.lesson-name-illegal" text="The length of Lesson Name CANNOT exceed 128 characters." /><br>';
            }
            if (result['isDescriptionEmpty']) {
                errorMessage += '<spring:message code="etms.administration.new-lesson.description-empty" text="You can&acute;t leave Description empty." /><br>';
            }
            if (result['isDescriptionEmpty']) {
                errorMessage += '<spring:message code="etms.administration.new-lesson.description-empty" text="You can&acute;t leave Description empty." /><br>';
            }

            $('.alert-error', '#lesson-form').html(errorMessage);
            $('.alert-error', '#lesson-form').removeClass('hide');
        }
        $('button[type=submit]', '#lesson-form').removeAttr('disabled');
        $('button[type=submit]', '#lesson-form').html('<spring:message code="etms.administration.new-lesson.create-lesson" text="Create" />');
    }
</script>
</body>
</html>