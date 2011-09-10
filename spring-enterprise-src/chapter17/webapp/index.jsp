<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<body>
	1.用户john/john:可以访问hello_0.jsp、main.jsp<br>
	2.用户tom/tom:可以访问main.jsp、hello_0.jsp、hello_1.jsp、updateForum.jsp<br>
	<c:if test="${not empty param.login_error}">
	   <font color="red">用户名或密码错误。</font>
	</c:if>
		<form name="form1" method="post" action="<c:url value="/j_acegi_security_check"/>">
			用户名：<input type="text" name="j_username"/><br/>
			密 码：<input type="password" name="j_password"/><br/>
			 <input type="checkbox" name="_acegi_security_remember_me">5天内不用再登录<br/>
			 <input type="submit" value="登录"/>
		</form>
	</body>
</html>
