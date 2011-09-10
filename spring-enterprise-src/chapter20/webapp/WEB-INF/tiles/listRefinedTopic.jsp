<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
近日精华帖：
<table>
   <fmt:message key="site.title"/>
	<c:forEach items="${topicList}" var="topic">
		<tr>
			<td>${topic.topicId}</td>
			<td>
				<c:url value="/showTopic.html?topicId=${topic.topicId}" var="showLink" />
				<a href="${editLink}">${topic.title}</a>
			</td>
			<td>
			   <fmt:formatDate value="${topic.createDate}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>
	</c:forEach>
 <table>
