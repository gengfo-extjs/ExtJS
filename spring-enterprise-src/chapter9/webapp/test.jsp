<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="com.baobaotao.service.BbtForum"/>
<jsp:directive.page import="org.springframework.context.ApplicationContext"/>
<jsp:directive.page import="org.springframework.web.context.support.WebApplicationContextUtils"/>
<jsp:directive.page import="com.baobaotao.domain.Topic"/>
<jsp:directive.page import="com.baobaotao.domain.Post"/>
<%
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
        BbtForum bbtForum = (BbtForum)ctx.getBean("bbtForum");
    	System.out.println("begin........");
    	Topic topic = new Topic();
    	topic.setTopicTitle("Title:jta-tomcat");
    	Post post = new Post();
    	post.setPostText("post content:jta-tomcat");
    	topic.setPost(post);
    	bbtForum.addTopic(topic);
    	System.out.println("end........");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>