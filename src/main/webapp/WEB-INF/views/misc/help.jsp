<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><spring:message code="etms.misc.help.title" text="Help Center"/></title>
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <h1>Help</h1>
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>