<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:directive.page import="org.acegisecurity.context.SecurityContext"/>
<jsp:directive.page import="org.acegisecurity.context.SecurityContextHolder"/>
<jsp:directive.page import="org.acegisecurity.Authentication"/>
<html>
  <head> 
    <title>Hello 1</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <body>
    hello 1!!
		<%
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			out.print(auth.getPrincipal().toString());
		}
	   %>
    <hr>
    <a href="<c:url value="/main.jsp"/>">返回</a>
  </body>
</html>
