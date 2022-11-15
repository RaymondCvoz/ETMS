<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version"/>
<jsp:useBean id="date" class="java.util.Date"/>
<div id="footer">
    <div class="container">
        <ul id="footer-nav" class="inline">
            <li><a href="<c:url value="/help" />"><spring:message code="etms.include.footer.help" text="Help"/></a></li>
        </ul>
    </div>
</div>
