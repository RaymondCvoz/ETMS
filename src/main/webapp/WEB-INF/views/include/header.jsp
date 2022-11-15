<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>

<div id="header" class="row-fluid" >
    <div class="container">
        <div id="nav" class="span6">
            <ul class="inline">
                <li><a href="<c:url value="/lesson" />" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.lessons" text="Lesson"/></a></li>
                <li><a href="<c:url value="/p" />" style="font-size: 16px; color: #ffffff" >
                    <spring:message code="etms.include.header.problems" text="Problems"/></a></li>
                <li><a href="<c:url value="/exam" />" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.exams" text="Exam"/></a></li>
                <li><a href="<c:url value="/submission" />" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.submission" text="Submission"/></a></li>

            </ul>
        </div> <!-- #nav -->
        <div id="nav_usr" class="span6">
            <ul class="inline">
                <c:choose>
                    <c:when test="${isLogin}">
                        <li><a href="<c:url value="/accounts/login?logout=true" />" style="font-size: 16px;color: #ffffff">
                            <spring:message code="etms.include.header.sign-out" text="Sign out"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="<c:url value="/accounts/login?forward=" />${requestScope['javax.servlet.forward.request_uri']}"
                               style="font-size: 16px; color: #ffffff">
                                <spring:message code="etms.include.header.sign-in" text="Sign in"/></a></li>
                    </c:otherwise>
                </c:choose>
                <li><a href="<c:url value="/accounts/dashboard" />" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.more" text="More"/></a></li>
                <c:if test="${myProfile.userGroup.userGroupSlug == 'administrators'}">
                    <li><a href="<c:url value="/administration" />" style="font-size: 16px; color: #ffffff"><spring:message
                            code="etms.accounts.dashboard.system-administration" text="System Administration"/></a></li>
                </c:if>
            </ul>
        </div>

    </div> <!-- .container -->
</div>
<!-- #header -->
<div id="drawer-nav">
    <span class="close-trigger"><a href="javascript:closeDrawerMenu();"><spring:message code="etms.include.header.close"
                                                                                        text="Close"/> &times;</a></span>
    <div id="accounts" class="section">
        <h4><spring:message code="etms.include.header.my-accounts" text="My Accounts"/></h4>
        <div id="profile">
            <c:choose>
                <c:when test="${isLogin}">
                    <h5>${myProfile.username}</h5>
                    <p class="email">${myProfile.email}</p>
                    <p><spring:message code="etms.include.header.accepted" text="Accepted"/>/<spring:message
                            code="etms.include.header.submit"
                            text="Submit"/>: ${mySubmissionStats.get("acceptedSubmission")}/${mySubmissionStats.get("totalSubmission")}(${mySubmissionStats.get("acRate")}%)</p>
                    <p><spring:message code="etms.include.header.language-preference"
                                       text="Language Preference"/>: ${myProfile.preferLanguage.languageName}</p>
                    <ul class="inline">
                        <li><a href="<c:url value="/accounts/dashboard" />"><spring:message
                                code="etms.include.header.dashboard" text="Dashboard"/></a></li>
                        <li><a href="<c:url value="/accounts/login?logout=true" />"><spring:message
                                code="etms.include.header.sign-out" text="Sign out"/></a></li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p><spring:message code="etms.include.header.not-logged-in" text="You are not logged in."/></p>
                    <ul class="inline">
                        <li>
                            <a href="<c:url value="/accounts/login?forward=" />${requestScope['javax.servlet.forward.request_uri']}">
                                <spring:message code="etms.include.header.sign-in" text="Sign in"/></a></li>
                        <li>
                            <a href="<c:url value="/accounts/register?forward=" />${requestScope['javax.servlet.forward.request_uri']}">
                                <spring:message code="etms.include.header.sign-up" text="Sign up"/></a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div> <!-- #profile -->
    </div> <!-- .section -->
</div>
<!-- #drawer-nav -->