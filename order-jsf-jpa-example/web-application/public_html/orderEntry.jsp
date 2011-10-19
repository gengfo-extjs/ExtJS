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
    <body background="images/crate.jpg"><h:form>
        <h:panelGrid columns="1" style="text-align:center;">
          <h:panelGrid columns="2">
            <h:outputText value="Item Name"/>
            <h:inputText readonly="true"
                         value="#{inventoryManagerBean.currentOrder.item.name}"/>
            <h:outputText value="Item Description"/>
            <h:inputText readonly="true"
                         value="#{inventoryManagerBean.currentOrder.item.description}"/>
            <h:outputText value="Quantity"/>
            <h:inputText value="#{inventoryManagerBean.currentOrder.quantity}"/>
          </h:panelGrid>
          <f:verbatim>
            <hr/>
          </f:verbatim>
          <h:panelGroup>
            <h:commandButton value="#{inventoryManagerBean.orderEntryOperation}"
                             action="result"
                             actionListener="#{inventoryManagerBean.completeOrderUpdate}"
                             style="text-align:center;"/>
          <h:commandButton value="Cancel"
                           action="cancel"
                           style="text-align:center;"/>
          </h:panelGroup>
        </h:panelGrid>
      </h:form>
      <h:message id="errorTag" for="errorTag" showDetail="true"/>
    </body>
  </html>
</f:view>