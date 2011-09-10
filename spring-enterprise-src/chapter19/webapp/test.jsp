<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title>fgsdfg/title>
	</head>
	<body>
		asdfasdfasdf
		<%
		out.print("<hr>");
		String s = request.getParameter("submitName");
		out.print("s:" + s);
		String address = request.getParameter("address");
		out.print("address:" + address);
	%>
	</body>
</html>
