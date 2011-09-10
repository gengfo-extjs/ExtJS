<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
	<head>
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body>   
        <form:form  enctype="multipart/form-data">
			内容：<form:textarea path="content" /><br>
			附件：<input type="file" name="attach"/><br>
	
			<input type="submit" value="提交" />
			<input type="reset" value="重置" />
		</form:form>
	</body>
</html>