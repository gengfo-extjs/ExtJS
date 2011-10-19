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
         <style type="text/css">
        .mainHeader {font-size:larger; border-bottom: thin solid}
                .menuHeader {text-align:center; border-bottom: thin dotted;}
                .menu {vertical-align:top; text-align: right}
    </style>
      <link href="css/bc4j.css" rel="stylesheet" media="screen"/>
    </head>
    <body background="images/crate.jpg"><h:form>
        <h:panelGrid columns="1" border="0" style="text-align:center;" headerClass="mainHeader">
          <f:facet name="header">
            <h:outputText value="Orders"/>
          </f:facet>
          <h:dataTable value="#{inventoryManagerBean.shippedOrdersForCurrentItem}"
                       var="order" width="100%" cellpadding="1" cellspacing="1" border="1">
            <h:column>
              <f:facet name="header">
                <h:outputText value="Order Number"/>
              </f:facet>
              <h:outputText value="#{order.orderId}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="ArrivalDate"/>
              </f:facet>
              <h:outputText value="#{order.arrivalDate}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Quantity"/>
              </f:facet>
              <h:outputText value="#{order.quantity}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Order Date"/>
              </f:facet>
              <h:outputText value="#{order.orderInitiated}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Current Location"/>
              </f:facet>
              <h:outputText value="#{order.currentLocation}"/>
            </h:column>
            <f:facet name="header">
              <h:outputText value="Current orders for Item with SKU : #{inventoryManagerBean.orderedItemId}"/>
            </f:facet>
          </h:dataTable>
          <f:verbatim>
            <hr/>
          </f:verbatim>
          <h:dataTable value="#{inventoryManagerBean.pendingOrdersForCurrentItem}"
                       var="order" width="100%" cellpadding="1" cellspacing="1" border="1">
            <h:column>
              <f:facet name="header">
                <h:outputText value="Order Number"/>
              </f:facet>
              <h:outputText value="#{order.orderId}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Quantity"/>
              </f:facet>
              <h:outputText value="#{order.quantity}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Order Date"/>
              </f:facet>
              <h:outputText value="#{order.orderInitiated}"/>
            </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="Current Location"/>
              </f:facet>
              <h:outputText value="#{order.currentLocation}"/>
            </h:column>
    <h:column>
              <h:panelGroup>
                <h:commandButton value="remove" type="submit"
                                 actionListener="#{inventoryManagerBean.orderRemoved}"
                                 action="result">
                  <f:facet name="extraParameter">
                    <f:param name="commandButtonParam"
                             value="#{order.orderId}"/>
                  </f:facet>
                </h:commandButton>
                <f:verbatim>
                  &nbsp;
                </f:verbatim>
                <h:commandButton value="update" type="submit"
                                 actionListener="#{inventoryManagerBean.orderUpdate}"
                                 action="orderEntry">
                  <f:facet name="extraParameter">
                    <f:param name="commandButtonParam"
                             value="#{order.orderId}"/>
                  </f:facet>
                </h:commandButton>
              </h:panelGroup>
              <f:facet name="header">
                <h:outputText value=" "/>
              </f:facet>
            </h:column>
             <f:facet name="header">
              <h:outputText value="Pending orders for Item with SKU : #{inventoryManagerBean.orderedItemId}"/>
            </f:facet>
          </h:dataTable>
          <f:verbatim>
            <hr/>
          </f:verbatim>
          <h:panelGroup style="vertical-align:middle;">
              <h:commandButton value="Create New Order" type="submit" actionListener="#{inventoryManagerBean.createNewOrder}" action="orderEntry"/>
            <h:outputText value="        "/>
            <h:commandButton value="Return To Inventory" action="inventory"/>
          </h:panelGroup>
        </h:panelGrid>
      </h:form>
      <h:message id="errorTag" for="errorTag" showDetail="true"/>
    </body>
  </html>
</f:view>