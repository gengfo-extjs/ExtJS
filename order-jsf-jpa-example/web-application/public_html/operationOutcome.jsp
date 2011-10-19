<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
  <html>
    <head>
      <meta http-equiv="Content-Type"
            content="text/html; charset=windows-1252"/>
      <title>Product</title>
      <link href="css/bc4j.css" rel="stylesheet" media="screen"/>
    </head>
    <body><h:form>
        <h:panelGrid columns="1" style="text-align:center;">
          <h:graphicImage url="/images/success.jpg"
                          rendered="#{inventoryManagerBean.success}"/>
          <h:graphicImage url="/images/exclaim.jpg" rendered="#{!inventoryManagerBean.success}"/>
          <h:outputText value="#{inventoryManagerBean.orderModificationResult}"/>
          <h:panelGroup>
            <h:commandButton value="OK" action="inventory"
                             type="submit"/>
          </h:panelGroup>
        </h:panelGrid>
      </h:form></body>
  </html>
</f:view>