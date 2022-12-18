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
    <title><spring:message code="etms.accounts.dashboard.title" text="Dashboard"/></title>
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}"/>
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/accounts/dashboard.css?v=${version}"/>
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
    <div id="sub-nav">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-accounts" data-toggle="tab"><spring:message code="etms.accounts.dashboard.accounts"
                                                                          text="Accounts"/></a></li>
            <li><a href="#tab-statistics" data-toggle="tab"><spring:message
                    code="etms.accounts.dashboard.statistics" text="Statistics"/></a></li>
        </ul>
    </div> <!-- #sub-nav -->
    <div id="main-content" class="tab-content">
        <div class="tab-pane active" id="tab-accounts">
            <form id="password-form" class="section" method="POST" onSubmit="onChangePasswordSubmit(); return false;">
                <h4><spring:message code="etms.accounts.dashboard.change-password" text="Change Password"/></h4>
                <div class="row-fluid">
                    <div class="alert alert-error hide"></div>
                    <div class="alert alert-success hide"><spring:message code="etms.accounts.dashboard.password-changed"
                                                                          text="You've changed your password."/></div>
                </div> <!-- .row-fluid -->
                <div class="row-fluid">
                    <div class="span4">
                        <label for="old-password"><spring:message code="etms.accounts.dashboard.old-password"
                                                                  text="Old Password"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="old-password" class="span8" type="password" maxlength="16"/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
                <div class="row-fluid">
                    <div class="span4">
                        <label for="new-password"><spring:message code="etms.accounts.dashboard.new-password"
                                                                  text="New Password"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="new-password" class="span8" type="password" maxlength="16"/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
                <div class="row-fluid">
                    <div class="span4">
                        <label for="confirm-new-password"><spring:message
                                code="etms.accounts.dashboard.confirm-new-password" text="Confirm New Password"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="confirm-new-password" class="span8" type="password" maxlength="16"/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
                <div class="row-fluid">
                    <div class="span12">
                        <button class="btn btn-primary btn-block" type="submit"><spring:message
                                code="etms.accounts.dashboard.change-password" text="Change Password"/></button>
                    </div> <!-- .span12 -->
                </div> <!-- .row-fluid -->
            </form> <!-- #password-form -->
            <form id="profile-form" class="section" method="POST" onSubmit="onChangeProfileSubmit(); return false;">
                <h4><spring:message code="etms.accounts.dashboard.profile" text="Profile"/></h4>
                <div class="row-fluid">
                    <div class="alert alert-error hide"></div>
                    <div class="alert alert-success hide"><spring:message code="etms.accounts.dashboard.profile-changed"
                                                                          text="You've changed your profile."/></div>
                </div> <!-- .row-fluid -->
                <div class="row-fluid">

                    <div class="span4">
                        <label for="email"><spring:message code="etms.accounts.dashboard.email" text="Email"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="email" class="span8" type="text" value="${user.email}" maxlength="64"
                                   placeholder="you@example.com"/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
                <div class="row-fluid">
                    <div class="span4">
                        <label for="college"><spring:message code="etms.accounts.dashboard.college" text="collage"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="college" class="span8" type="text" value="${user.email}" maxlength="64" readonly/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div>

                <div class="row-fluid">
                    <div class="span4">
                        <label for="major"><spring:message code="etms.accounts.dashboard.major" text="Major"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="major" class="span8" type="text" value="${user.email}" maxlength="64" readonly/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div>

                <div class="row-fluid">
                    <div class="span4">
                        <label for="number"><spring:message code="etms.accounts.dashboard.number" text="Number"/></label>
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <div class="control-group">
                            <input id="number" class="span8" type="text" value="${user.email}" maxlength="64" readonly/>
                        </div> <!-- .control-group -->
                    </div> <!-- .span8 -->
                </div>
                <div class="row-fluid">
                    <div class="span12">
                        <button class="btn btn-primary btn-block" type="submit"><spring:message
                                code="etms.accounts.dashboard.update-profile" text="Update Profile"/></button>
                    </div> <!-- .span12 -->
                </div> <!-- .row-fluid -->
            </form> <!-- #profile-form -->
        </div> <!-- #tab-accounts -->

        <div class="tab-pane" id="tab-statistics">
            <div class="section">
                <div class="header">
                    <h4><spring:message code="etms.accounts.dashboard.submissions" text="Submissions"/></h4>
                </div> <!-- .header -->
                <div class="body">
                    <table id="submissions" class="table table-striped">
                        <thead>
                        <tr>
                            <th class="flag"><spring:message code="etms.problems.problems.result" text="Result"/></th>
                            <th class="name"><spring:message code="etms.problems.problems.name" text="Name"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="submission" items="${submissions}">
                            <tr>
                                <td class="flag-${submission.value.judgeScore}">
                                    <a href="<c:url value="/submission/${submission.value.submissionId}" />">
                                            ${submission.value.judgeScore}
                                    </a>
                                </td>
                                <td class="name"><a
                                        href="<c:url value="/p/${submission.key}" />">${submission.value.problem.problemName}</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div> <!-- .body -->
            </div> <!-- .section -->
        </div> <!-- #tab-statistics -->
    </div> <!-- #main-content -->
</div> <!-- #content -->
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- JavaScript -->
<script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<script type="text/javascript">
    $.getScript('${cdnUrl}/js/highcharts.min.js?v=${version}', function () {
        return getSubmissionsOfUsers(7);
    });
</script>
<script type="text/javascript">
    $('#submission-period').change(function () {
        var period = $(this).val();
        return getSubmissionsOfUsers(period);
    });
</script>
<script type="text/javascript">
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
    function onChangePasswordSubmit() {
        $('.alert-success', '#password-form').addClass('hide');
        $('.alert-error', '#password-form').addClass('hide');
        $('button[type=submit]', '#password-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#password-form').html('<spring:message code="etms.accounts.dashboard.please-wait" text="Please wait..." />');

        var oldPassword = $('#old-password').val(),
            newPassword = $('#new-password').val(),
            confirmPassword = $('#confirm-new-password').val();

        return doChangePasswordAction(oldPassword, newPassword, confirmPassword);
    }
</script>
<script type="text/javascript">
    function doChangePasswordAction(oldPassword, newPassword, confirmPassword) {
        var postData = {
            'oldPassword': oldPassword,
            'newPassword': newPassword,
            'confirmPassword': confirmPassword
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/accounts/changePassword.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processChangePasswordResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processChangePasswordResult(result) {
        if (result['isSuccessful']) {
            $('.alert-success', '#password-form').removeClass('hide');
        } else {
            var errorMessage = '';

            if (!result['isOldPasswordCorrect']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.old-password-incorrect" text="Old password is incorrect." /><br>';
            }
            if (result['isNewPasswordEmpty']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.new-password-empty" text="You can&acute;t leave New Password empty." /><br>';
            }
            if (!result['isNewPasswordLegal']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.new-password-illegal" text="The length of password must between 6 and 16 characters." /><br>';
            }
            if (!result['isConfirmPasswordMatched']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.new-password-not-matched" text="New passwords don&acute;t match." /><br>';
            }
            $('.alert-error', '#password-form').html(errorMessage);
            $('.alert-error', '#password-form').removeClass('hide');
        }
        $('button[type=submit]', '#password-form').html('<spring:message code="etms.accounts.dashboard.change-password" text="Change Password" />');
        $('button[type=submit]', '#password-form').removeAttr('disabled');
    }
</script>
<script type="text/javascript">
    function onChangeProfileSubmit() {
        $('.alert-success', '#profile-form').addClass('hide');
        $('.alert-error', '#profile-form').addClass('hide');
        $('button[type=submit]', '#profile-form').attr('disabled', 'disabled');
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.accounts.dashboard.please-wait" text="Please wait..." />');

        var email = $('#email').val(),
            location = $('#location').val(),
            website = $('#website').val(),
            aboutMe = $('#wmd-input').val(),
            csrfToken = $('#csrf-token').val();

        return doUpdateProfileAction(email, location, website, aboutMe, csrfToken);
    }
</script>
<script type="text/javascript">
    function doUpdateProfileAction(email, location, website, aboutMe, csrfToken) {
        var postData = {
            'email': email,
            'location': location,
            'website': website,
            'socialLinks': socialLinks,
            'aboutMe': aboutMe,
            'csrfToken': csrfToken
        };

        $.ajax({
            type: 'POST',
            url: '<c:url value="/accounts/updateProfile.action" />',
            data: postData,
            dataType: 'JSON',
            success: function (result) {
                return processUpdateProfileResult(result);
            }
        });
    }
</script>
<script type="text/javascript">
    function processUpdateProfileResult(result) {
        if (result['isSuccessful']) {
            $('.alert-success', '#profile-form').removeClass('hide');
        } else {
            var errorMessage = '';

            if (!result['isCsrfTokenValid']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.invalid-token" text="Invalid token." />';
            }
            if (result['isEmailEmpty']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.email-empty" text="You can&acute;t leave Email empty." /><br>';
            } else if (!result['isEmailLegal']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.email-illegal" text="The email seems invalid." /><br>';
            } else if (result['isEmailExists']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.email-existing" text="Someone already has that email address." /><br>';
            }
            if (!result['isLocationLegal']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.location-illegal" text="The length of Location CANNOT exceed 128 characters." /><br>';
            }
            if (!result['isWebsiteLegal']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.website-legal" text="The url of website seems invalid." /><br>';
            }
            if (!result['isAboutMeLegal']) {
                errorMessage += '<spring:message code="etms.accounts.dashboard.about-me-legal" text="The length of About Me CANNOT exceed 256 characters." /><br>';
            }
            $('.alert-error', '#profile-form').html(errorMessage);
            $('.alert-error', '#profile-form').removeClass('hide');
        }
        $('button[type=submit]', '#profile-form').html('<spring:message code="etms.accounts.dashboard.update-profile" text="Update Profile" />');
        $('button[type=submit]', '#profile-form').removeAttr('disabled');
    }
</script>

</body>
</html>