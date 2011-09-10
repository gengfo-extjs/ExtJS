<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<f:view>
  <html>
    <head>
	  <title>jsf-spring quickstart</title>
    </head>
    <body>
    	<h:outputText value="#{forumBean.forumDesc}"/>
    </body>
  </html>
</f:view>