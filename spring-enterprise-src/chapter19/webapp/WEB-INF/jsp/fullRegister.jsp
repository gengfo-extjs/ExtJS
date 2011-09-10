<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
			<input type="submit" name="_target1" value="下一步" />
			<input type="submit" name="_cancel" value="取消" />
		</form:form>
	</body>
</html>