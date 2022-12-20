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
    <title><spring:message code="etms.administration.edit-problem.title" text="Edit Problem"/> - ${problem.problemName}</title>

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
                    code="etms.administration.edit-problem.edit-problem" text="Edit Problem"/></h2>
            <form id="problem-form" onSubmit="onSubmit(); return false;">
                <div class="row-fluid">
                    <div class="span8">
                        <div class="alert alert-error hide"></div> <!-- .alert-error -->
                        <div class="alert alert-success hide"><spring:message
                                code="etms.administration.edit-problem.problem-edited" text="Problem updated."/> <a
                                href="<c:url value="/p/" />${problem.problemId}"><spring:message
                                code="etms.administration.edit-problem.view-problem" text="View problem"/></a></div>
                        <!-- .alert-success -->
                        <div class="control-group row-fluid">
                            <label for="problem-name"><spring:message
                                    code="etms.administration.edit-problem.problem-name" text="Problem Name"/></label>
                            <input id="problem-name" class="span12" type="text" maxlength="128"
                                   value="${problem.problemName}"/>
                            <input id="problem-id" type="hidden" value="${problem.problemId}"/>
                        </div> <!-- .control-group -->
                        <div class="row-fluid">
                            <div class="span12">
                                <label for="wmd-input"><spring:message
                                        code="etms.administration.edit-problem.problem-description"
                                        text="Description"/></label>
                                <div id="markdown-editor">
                                    <div class="wmd-panel">
                                        <div id="wmd-button-bar" class="wmd-button-bar"></div> <!-- #wmd-button-bar -->
                                        <textarea id="wmd-input" class="wmd-input">${problem.description}</textarea>
                                    </div> <!-- .wmd-panel -->
                                    <div id="wmd-preview" class="wmd-panel wmd-preview"></div> <!-- .wmd-preview -->
                                </div> <!-- #markdown-editor -->
                            </div> <!-- .span12 -->
                        </div> <!-- .row-fluid -->
                        <div class="control-group row-fluid">
                            <label for="hint"><spring:message code="etms.administration.edit-problem.hint"
                                                              text="Hint"/></label>
                            <textarea id="hint" class="span12">${problem.hint}</textarea>
                        </div> <!-- .control-group -->

                        <div class="control-group row-fluid">
                            <label for="score"><spring:message code="etms.administration.edit-problem.score"
                                                              text="Score"/></label>
                            <textarea id="score" class="span12">${problem.score}</textarea>
                        </div> <!-- .control-group -->

                        <div class="control-group row-fluid">
                            <label for="answer"><spring:message code="etms.administration.edit-problem.answer"
                                                              text="Answer"/></label>
                            <textarea id="answer" class="span12">${problem.answer}</textarea>
                        </div> <!-- .control-group -->

                    </div> <!-- .span8 -->
                    <div class="span4">
                        <div class="section">
                            <div class="header">
                                <h5><spring:message code="etms.administration.edit-problem.edit-problem"
                                                    text="Edit Problem"/></h5>
                            </div> <!-- .header -->
                            <div class="body">
                                <div class="row-fluid">
                                    <div class="span8">
                                        <spring:message code="etms.administration.edit-problem.is-public"
                                                        text="Public to Users?"/>
                                    </div> <!--- .span8 -->
                                    <div class="span4 text-right">
                                        <input id="problem-is-public" type="checkbox" data-toggle="switch"
                                               <c:if test="${problem.isPublic()}">checked="checked"</c:if> />
                                    </div> <!-- .span4 -->
                                </div> <!-- .row-fluid -->

                                <div class="row-fluid">
                                    <div class="span8">
                                        <spring:message code="etms.administration.edit-problem.problem-categories"
                                                        text="Category"/>
                                    </div> <!--- .span8 -->
                                    <div class="span4 text-right">
                                        <input id="problemType" type="checkbox" data-toggle="switch"
                                               <c:if test="${problem.getProblemType()}">checked="checked"</c:if> />
                                    </div> <!-- .span4 -->
                                </div> <!-- .row-fluid -->

                            </div> <!-- .body -->
                            <div class="footer text-left">
                                <button class="btn btn-primary" type="submit"><spring:message
                                        code="etms.administration.edit-problem.update-problem" text="Update"/></button>
                            </div> <!-- .footer -->
                        </div> <!-- .section -->
                        <div class="section">
                            <div class="header">
                                <h5><spring:message code="etms.administration.edit-problem.problem-tags"
                                                    text="Tags"/></h5>
                            </div> <!-- .header -->
                            <div class="body">
                                <input id="problem-tags" class="tagsinput" type="hidden"
                                       value="<c:forEach var="problemTag" items="${problemTags}">${problemTag.problemTagName},</c:forEach>"/>
                            </div> <!-- .body -->
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
    $(function () {
        <c:forEach var="problemCategory" items="${selectedProblemCategories}">
        $('#${problemCategory.problemCategorySlug}').parent().addClass('checked');
        </c:forEach>
        $('.tagsinput').tagsInput();
        $('[data-toggle=switch]').wrap('<div class="switch" />').parent().bootstrapSwitch();
    });
</script>

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
    $('label.checkbox.parent-category').click(function () {
        var currentControl = $(this);
        // Fix the bug for Checkbox in FlatUI
        setTimeout(function () {
            var isChecked = $(currentControl).hasClass('checked');
            if (!isChecked) {
                $('label.checkbox.child-category', $(currentControl).parent()).removeClass('checked');
            }
        }, 50);
    });
</script>
<script type="text/javascript">
    $('label.checkbox.child-category').click(function () {
        var currentControl = $(this);
        // Fix the bug for Checkbox in FlatUI
        setTimeout(function () {
            var isChecked = $(currentControl).hasClass('checked');

            if (isChecked) {
                $('label.checkbox.parent-category', $(currentControl).parent().parent().parent()).addClass('checked');
            }
        }, 50);
    });
</script>
<script type="text/javascript">
    function onSubmit() {
        var problemId = $('#problem-id').val(),
            problemName = $('#problem-name').val(),
            description = $('#wmd-input').val(),
            score = $('#score').val(),
            hint = $('#hint').val(),
            answer = $('#answer').val(),
            problemType = $('#problemType').parent().hasClass('switch-on'),
            problemTags = getProblemTags(),
            isPublic = $('#problem-is-public').parent().hasClass('switch-on');

        $('.alert-success', '#problem-form').addClass('hide');
        $('.alert-error', '#problem-form').addClass('hide');
        $('button[type=submit]', '#problem-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#problem-form').html('<spring:message code="etms.administration.edit-problem.please-wait" text="Please wait..." />');

        return editProblem(problemId, problemName, description,
            hint, answer,problemType, problemTags,score,isPublic);
    }
</script>
<script type="text/javascript">
    function getProblemCategories() {
        var problemCategories = [];

        $('label.checked', '.parent-categories').each(function () {
            problemCategories.push($(this).attr('for'));
        });
        return JSON.stringify(problemCategories);
    }
</script>
<script type="text/javascript">
    function getProblemTags() {
        var problemTags = $('#problem-tags').val();

        if (problemTags == '') {
            problemTags = [];
        } else {
            problemTags = problemTags.split(',');
        }
        return JSON.stringify(problemTags);
    }
</script>
<script type="text/javascript">
    function editProblem(problemId, problemName, description, hint,
                         answer, problemType, problemTags,score,isPublic) {
        var postData = {
            'problemId': problemId,
            'problemName': problemName,
            'description': description,
            'hint': hint,
            'answer': answer,
            'problemType': problemType,
            'problemTags': problemTags,
            'score': score,
            'isPublic': isPublic
        };
        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/editProblem.action" />',
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

            if (!result['isProblemExists']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.problem-not-exist" text="Problem not exists." /><br>';
            }
            if (result['isProblemNameEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.problem-name-empty" text="You can&acute;t leave Problem Name empty." /><br>';
            } else if (!result['isProblemNameLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.problem-name-illegal" text="The length of Problem Name CANNOT exceed 128 characters." /><br>';
            }
            if (!result['isTimeLimitLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.time-limit-illegal" text="The Time Limit should be an integer greater than 0." /><br>';
            }
            if (!result['isMemoryLimitLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.memory-limit-illegal" text="The Memory Limit should be an integer greater than 0." /><br>';
            }
            if (result['isDescriptionEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.description-empty" text="You can&acute;t leave Description empty." /><br>';
            }
            if (result['isInputFormatEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.input-format-empty" text="You can&acute;t leave Input Format empty." /><br>';
            }
            if (result['isOutputFormatEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.output-format-empty" text="You can&acute;t leave Output Format empty." /><br>';
            }
            if (result['isInputSampleEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.input-sample-empty" text="You can&acute;t leave Input Sample empty." /><br>';
            }
            if (result['isOutputSampleEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-problem.output-sample-empty" text="You can&acute;t leave Output Sample empty." /><br>';
            }

            $('.alert-error', '#problem-form').html(errorMessage);
            $('.alert-error', '#problem-form').removeClass('hide');
        }
        $('button[type=submit]', '#problem-form').removeAttr('disabled');
        $('button[type=submit]', '#problem-form').html('<spring:message code="etms.administration.edit-problem.update-problem" text="Update" />');
    }
</script>
</body>
</html>