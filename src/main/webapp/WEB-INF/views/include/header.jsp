<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>

<div id="header" class="row-fluid" >
    <div class="container">
        <div id="nav" class="span6">
            <ul class="inline">
                <li><a href="${pageContext.request.contextPath}/lesson" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.lessons" text="Lesson"/></a></li>
                <li><a href="${pageContext.request.contextPath}/p" style="font-size: 16px; color: #ffffff" >
                    <spring:message code="etms.include.header.problems" text="Problems"/></a></li>
                <li><a href="${pageContext.request.contextPath}/exam" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.exams" text="Exam"/></a></li>
                <li><a href="${pageContext.request.contextPath}/submission" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.submission" text="Submission"/></a></li>

            </ul>
        </div> <!-- #nav -->
        <div id="nav_usr" class="span6">
            <ul class="inline">
                <c:choose>
                    <c:when test="${isLogin}">
                        <li><a href="${pageContext.request.contextPath}/accounts/login?logout=true&forward=${requestScope['javax.servlet.forward.request_uri']}"
                            style="font-size: 16px;color: #ffffff">
                            <spring:message code="etms.include.header.sign-out" text="Sign out"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="${pageContext.request.contextPath}/accounts/login?forward=${requestScope['javax.servlet.forward.request_uri']}"
                               style="font-size: 16px; color: #ffffff">
                                <spring:message code="etms.include.header.sign-in" text="Sign in"/></a></li>
                    </c:otherwise>
                </c:choose>
                <li><a href="${pageContext.request.contextPath}/accounts/dashboard" style="font-size: 16px; color: #ffffff">
                    <spring:message code="etms.include.header.more" text="More"/></a></li>
                <c:if test="${myProfile.userGroup.userGroupSlug == 'administrators'}">
                    <li><a href="${pageContext.request.contextPath}/administration" style="font-size: 16px; color: #ffffff"><spring:message
                            code="etms.accounts.dashboard.system-administration" text="System Administration"/></a></li>
                </c:if>
            </ul>
        </div>

    </div> <!-- .container -->
</div>