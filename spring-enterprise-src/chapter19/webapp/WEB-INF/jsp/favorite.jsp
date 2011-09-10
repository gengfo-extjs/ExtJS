<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body>   
        <form:form>
			 爱好<hr/>
			 <font color="red"><form:errors path="favorites" /></font>
			 <form:checkbox path="favorites" value="computer"/>computer
			 <form:checkbox path="favorites" value="sport"/>sport
			 <form:checkbox path="favorites" value="entertainment"/>entertainment
			 <form:checkbox path="favorites" value="literature"/>literature
			 param1 is:${param1}
			<br>			
			<input type="submit" name="_target1" value="上一步" />
			<input type="submit" name="_finish" value="确　定" />
			<input type="submit" name="_cancel" value="取　消" />
		</form:form>
	</body>
</html>