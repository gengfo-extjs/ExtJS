<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://jakarta.apache.org/struts/tags-tiles"%>
<html>
	<head>
		<title><tiles:getAsString name="title" />
		</title>
	</head>
	<body>
		<table width="100%" border="0">
			<tr>
				<td>
					<tiles:insert name="header" />
				</td>
			</tr>
			<tr>
				<td>
					<tiles:insert name="body" />
				</td>
			</tr>
			<tr>
				<td>
					<tiles:insert name="footer" />
				</td>
			</tr>
		</table>
	</body>
</html>
