<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>宝宝淘注册页面</title>
</head>
<body>
<s:form>
    <s:textfield key="user.userName" label="用户名"/>
    <s:password key="user.password" label="密  码"/>
    <s:textfield key="user.email" label="Email"/>
    <s:submit/>
</s:form>
</body>
</html>