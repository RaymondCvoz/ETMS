<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.accounts.register.title" text="Create Account"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/accounts/register.css?v=${version}"/>
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/flat-ui.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!-- Content -->
<div id="content">
    <div id="register">
        <h2 align="center"><spring:message code="etms.accounts.register.create-account" text="Create Account"/></h2>
        <div class="alert alert-error hide"></div>
        <c:choose>
            <c:when test="${!isAllowRegister}">
                <div class="alert alert-warning">
                    <h5><spring:message code="etms.accounts.register.registration-closed"
                                        text="Online Registration Closed"/></h5>
                    <p><spring:message code="etms.accounts.register.registration-closed-message"
                                       text="Online registration is now closed. If you would like to register onsite or have questions about your registration, please contact webmaster."/></p>
                </div>
                <!-- .alert -->
            </c:when>
            <c:otherwise>
                <form id="register-form" method="POST" onsubmit="onSubmit(); return false;">
                    <p class="row-fluid">
                        <label for="username"><spring:message code="etms.accounts.register.username"
                                                              text="Username"/></label>
                        <input id="username" name="username" class="span12" type="text" maxlength="16"/>
                    </p>
                    <p class="row-fluid">
                        <label for="email"><spring:message code="etms.accounts.register.email" text="Email"/></label>
                        <input id="email" name="email" class="span12" type="text" maxlength="64"/>
                    </p>
                    <p class="row-fluid">
                        <label for="password"><spring:message code="etms.accounts.register.password"
                                                              text="Password"/></label>
                        <input id="password" name="password" class="span12" type="password" maxlength="16"/>
                    </p>
<%--                    <p class="row-fluid">--%>
<%--                        <label for="language-preference"><spring:message--%>
<%--                                code="etms.accounts.register.language-preference" text="Language Preference"/></label>--%>
<%--                        <select id="language-preference" class="span12">--%>
<%--                            <c:forEach var="language" items="${languages}">--%>
<%--                                <option value="${language.languageSlug}">${language.languageName}</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </p>--%>

                    <p>
                        <button class="btn btn-primary btn-block" type="submit"><spring:message
                                code="etms.accounts.register.create-account" text="Create Account"/></button>
                    </p>
                </form>
                <!-- #register-form -->
            </c:otherwise>
        </c:choose>
        <p class="text-center">
            <spring:message code="etms.accounts.register.already-have-account" text="Already have an account?"/><br/>
            <a href="<c:url value="/accounts/login" />"><spring:message code="etms.accounts.register.sign-in"
                                                                        text="Sign in"/></a>
        </p>
    </div> <!-- #register -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- JavaScript -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<c:if test="${isAllowRegister}">
    <script type="text/javascript">
        function onSubmit() {
            $('.alert-error').addClass('hide');
            $('button[type=submit]').attr('disabled', 'disabled');
            $('button[type=submit]').html('<spring:message code="etms.accounts.register.please-wait" text="Please wait..." />');

            var username = $('#username').val(),
                password = $('#password').val(),
                email = $('#email').val();

            return doRegisterAction(username, password, email);
        };
    </script>
    <script type="text/javascript">
        function doRegisterAction(username, password, email) {
            var postData = {
                'username': username,
                'password': password,
                'email': email
            };

            $.ajax({
                type: 'POST',
                url: '<c:url value="/accounts/register.action" />',
                data: postData,
                dataType: 'JSON',
                success: function (result) {
                    return processRegisterResult(result);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function processRegisterResult(result) {
            if (result['isSuccessful']) {
                var forwardUrl = '${forwardUrl}' || '<c:url value="/" />';
                window.location.href = forwardUrl;
            } else {
                var errorMessage = '';

                if (result['isUsernameEmpty']) {
                    errorMessage += '<spring:message code="etms.accounts.register.username-empty" text="You can&apos;t leave Username empty." /><br>';
                } else if (!result['isUsernameLegal']) {
                    var username = $('#username').val();

                    if (username.length < 6 || username.length > 16) {
                        errorMessage += '<spring:message code="etms.accounts.register.username-length-illegal" text="The length of Username must between 6 and 16 characters." /><br>';
                    } else if (!username[0].match(/[a-z]/i)) {
                        errorMessage += '<spring:message code="etms.accounts.register.username-beginning-illegal" text="Username must start with a letter(a-z)." /><br>';
                    } else {
                        errorMessage += '<spring:message code="etms.accounts.register.username-character-illegal" text="Username can only contain letters(a-z), numbers, and underlines(_)." /><br>';
                    }
                } else if (result['isUsernameExists']) {
                    errorMessage += '<spring:message code="etms.accounts.register.username-existing" text="Someone already has that username." /><br>';
                }
                if (result['isPasswordEmpty']) {
                    errorMessage += '<spring:message code="etms.accounts.register.password-empty" text="You can&apos;t leave Password empty." /><br>';
                } else if (!result['isPasswordLegal']) {
                    errorMessage += '<spring:message code="etms.accounts.register.password-illegal" text="The length of Password must between 6 and 16 characters." /><br>';
                }
                if (result['isEmailEmpty']) {
                    errorMessage += '<spring:message code="etms.accounts.register.email-empty" text="You can&apos;t leave Email empty." /><br>';
                } else if (!result['isEmailLegal']) {
                    errorMessage += '<spring:message code="etms.accounts.register.email-illegal" text="The Email seems invalid." /><br>';
                } else if (result['isEmailExists']) {
                    errorMessage += '<spring:message code="etms.accounts.register.email-existing" text="Someone already use that email." /><br>';
                }

                $('.alert-error').html(errorMessage);
                $('.alert-error').removeClass('hide');
            }

            $('button[type=submit]').html('<spring:message code="etms.accounts.register.create-account" text="Create Account" />');
            $('button[type=submit]').removeAttr('disabled');
            $('html, body').animate({scrollTop: 0}, 100);
        }
    </script>
</c:if>

</body>
</html>