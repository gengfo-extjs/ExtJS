<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
	<head>
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body>   
        <form:form>
			地 址：<form:input path="address" />
			<font color="red"><form:errors path="address" /></font>
			<br>
			电　话：<form:password path="telephone" />
			<font color="red"><form:errors path="telephone" /></font>
			<br>		
			<input type="submit" name="_target0" value="上一步" />
			<input type="submit" name="_target2" value="下一步" />
			<input type="submit" name="_cancel" value="取　消" />
		</form:form>
	</body>
</html>