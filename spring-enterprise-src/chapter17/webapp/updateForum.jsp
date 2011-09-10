<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="org.springframework.context.ApplicationContext"/>
<jsp:directive.page import="org.springframework.web.context.support.WebApplicationContextUtils"/>
<jsp:directive.page import="com.baobaotao.service.BbtForum"/>
<jsp:directive.page import="com.baobaotao.domain.Forum"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    BbtForum bbtForum = (BbtForum)ctx.getBean("bbtForum");
    out.print("开始调用BbtForum#updateForum...<br>");
    bbtForum.updateForum(new Forum());
    out.print("成功调用.");
%>
<a href="<c:url value="/main.jsp"/>">返回</a>
