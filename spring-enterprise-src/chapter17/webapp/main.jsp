<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<html>
  <head>
    <title>main</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  <body>
    当前用户:<authz:authentication operation="username"/><br/>
	<a href="<c:url value="/hello_0.jsp"/>">hello 0</a>‖
	<authz:authorize ifAnyGranted="PRIV_2">
	   <a href="<c:url value="/hello_1.jsp"/>">hello 1</a>‖
	</authz:authorize>
	<authz:authorize ifAllGranted="PRIV_2,PRIV_1">
 	   <a href="<c:url value="/updateForum.jsp"/>">update Forum</a>
	</authz:authorize>
	<hr>
	<A href="<c:url value="/j_acegi_logout"/>">退出系统</A>
  </body>
</html>
