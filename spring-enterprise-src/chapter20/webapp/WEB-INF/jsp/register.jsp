<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
			<meta http-equiv="Content-Type"
			content="text/html; charset=UTF-8">
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body>   
        <form:form>
			用户名：<form:input path="userName" cssClass="inputStyle" cssErrorClass="asdfe"/>
			<font color="red"><form:errors path="userName" /></font>
			<br>
			密 码：<form:password path="password" />
			<font color="red"><form:errors path="password" /></font>
			<br>
			Email：<form:input path="email" /></br>
			<font color="red"><form:errors path="email" /></font>
			描述：<form:textarea path="desc" cols="20" rows="3"/></br>
			<form:hidden path="times"/>
			性 别：<form:radiobutton path="sex" value="0"/>男
			<form:radiobutton path="sex" value="1"/>女
			<br> 
			兴趣爱好:<c:forEach items="${favoriteMap}" var="favorite">
			<form:checkbox path="favorites" value="${favorite.key}" />${favorite.value}
             </c:forEach>
			<br>	
		   	<form:select path="city">
		   	   <form:option value="" label="--请选择--"/>
		   	   <form:options items="${cityMap}" itemValue="key" itemLabel="value"/>
		   	</form:select>
		   	</br>
					
			<input type="submit" value="注册" name="testSubmit"/>
			<input type="reset" value="重置" />
		</form:form>
	</body>
</html>