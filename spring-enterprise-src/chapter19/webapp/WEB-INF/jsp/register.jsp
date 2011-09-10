<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="org.springframework.web.servlet.i18n.SessionLocaleResolver"/>
<jsp:directive.page import="java.util.Locale"/>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
   //session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,Locale.US);
   //response.addCookie(new Cookie("clientlanguage","en_US"));
   out.print("locale:"+request.getParameter("locale"));
%>
<html>
	<head>
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body>   
        <form:form>
			用户名：<form:input path="userName" />
			<font color="red"><form:errors path="userName" /></font>
			<br>
			密 码：<form:password path="password" />
			<font color="red"><form:errors path="password" /></font>
			<br>
			Email：<form:input path="email" />
			<font color="red"><form:errors path="email" /></font>
			<br>			
			<input type="text" value="en" name="locale"/>
			<input type="submit" value="注册" name="testSubmit"/>
			<input type="reset" value="重置" />
		</form:form>
	</body>
</html>