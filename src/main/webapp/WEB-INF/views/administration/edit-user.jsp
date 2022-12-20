<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.administration.edit-user.title" text="Edit User"/></title>
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
                    code="etms.administration.edit-user.edit-user" text="Edit User"/></h2>
            <form id="profile-form" onSubmit="onSubmit(); return false;">
                <div class="alert alert-error hide"></div> <!-- .alert-error -->
                <div class="alert alert-success hide"><spring:message code="etms.administration.edit-user.user-edited"
                                                                      text="The user has been edited successfully."/></div>
                <!-- .alert-success -->
                <div class="control-group row-fluid">
                    <label for="username"><spring:message code="etms.administration.edit-user.username"
                                                          text="Username"/></label>
                    <input id="username" class="span12" type="text" maxlength="16" value="${user.username}"/>
                    <input id="uid" type="hidden" value="${user.uid}">
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="password"><spring:message code="etms.administration.edit-user.password"
                                                          text="Password"/></label>
                    <input id="password" class="span12" type="password" maxlength="16" value="${user.password}"/>
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="email"><spring:message code="etms.administration.edit-user.email" text="Email"/></label>
                    <input id="email" class="span12" type="text" maxlength="64" value="${user.email}"/>
                </div> <!-- .control-group -->
                <div class="control-group row-fluid">
                    <label for="user-group"><spring:message code="etms.administration.edit-user.user-group"
                                                            text="User Group"/></label>
                    <select id="user-group" name="userGroup">
                        <c:forEach var="userGroup" items="${userGroups}">
                            <option value="${userGroup.userGroupSlug}">${userGroup.userGroupName}</option>
                        </c:forEach>
                    </select>
                </div> <!-- .control-group -->
                <div class="row-fluid">
                    <div class="span12">
                        <button class="btn btn-primary" type="submit"><spring:message
                                code="etms.administration.edit-user.edit-account" text="Create Account"/></button>
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
        var uid = $('#uid').val(),
            username = $('#username').val(),
            password = $('#password').val(),
            email = $('#email').val(),
            userGroup = $('#user-group').val();

        $('.alert-success', '#profile-form').addClass('hide');
        $('.alert-error', '#profile-form').addClass('hide');
        $('button[type=submit]', '#profile-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.administration.edit-user.please-wait" text="Please wait..." />');

        return doCreateUserAction(uid,username, password, email, userGroup);
    }
</script>
<script type="text/javascript">
    function doCreateUserAction(uid,username, password, email, userGroup) {
        var postData = {
            'uid':uid,
            'username': username,
            'password': password,
            'email': email,
            'userGroup': userGroup
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/administration/editUser.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processCreateUserResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processCreateUserResult(result) {
        if (result['isSuccessful']) {
            $('.alert-success', '#profile-form').removeClass('hide');
        } else {
            var errorMessage = '';

            if (result['isUsernameEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.username-empty" text="You can&apos;t leave Username empty." /><br>';
            } else if (!result['isUsernameLegal']) {
                var username = $('#username').val();

                if (username.length < 6 || username.length > 16) {
                    errorMessage += '<spring:message code="etms.administration.edit-user.username-length-illegal" text="The length of Username must between 6 and 16 characters." /><br>';
                } else if (!username[0].match(/[a-z]/i)) {
                    errorMessage += '<spring:message code="etms.administration.edit-user.username-beginning-illegal" text="Username must start with a letter(a-z)." /><br>';
                } else {
                    errorMessage += '<spring:message code="etms.administration.edit-user.username-character-illegal" text="Username can only contain letters(a-z), numbers, and underlines(_)." /><br>';
                }
            } else if (result['isUsernameExists']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.username-existing" text="Someone already has that username." /><br>';
            }
            if (result['isPasswordEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.password-empty" text="You can&apos;t leave Password empty." /><br>';
            } else if (!result['isPasswordLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.password-illegal" text="The length of Password must between 6 and 16 characters." /><br>';
            }
            if (result['isEmailEmpty']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.email-empty" text="You can&apos;t leave Email empty." /><br>';
            } else if (!result['isEmailLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.email-illegal" text="The Email seems invalid." /><br>';
            } else if (result['isEmailExists']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.email-existing" text="Someone already use that email." /><br>';
            }
            if (!result['isUserGroupLegal']) {
                errorMessage += '<spring:message code="etms.administration.edit-user.user-group-empty" text="You can&apos;t leave User Group empty." /><br>';
            }
            $('.alert-error', '#profile-form').html(errorMessage);
            $('.alert-error', '#profile-form').removeClass('hide');
        }
        $('button[type=submit]', '#profile-form').removeAttr('disabled');
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.administration.edit-user.edit-account" text="Create Account" />');
    }
</script>
</body>
</html>