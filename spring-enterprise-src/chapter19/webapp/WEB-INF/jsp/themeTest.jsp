<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page
	import="org.springframework.web.servlet.theme.SessionThemeResolver" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%
	session.setAttribute(SessionThemeResolver.THEME_SESSION_ATTRIBUTE_NAME, "warm");
%>
<html>
	<head>
		<title>宝宝淘论坛</title>
		<link rel="stylesheet"
			href="<c:url value="/"/><spring:theme code="cssFile"/>"
			type="text/css" />
	</head>
	<body>
		<font class="label">用户模块</font>
		<input type="button" value="测试按钮" class="actionBtnSty" />
	</body>
</html>
