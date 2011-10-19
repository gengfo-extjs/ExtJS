<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<h:panelGrid>
  <h:dataTable value="#{inventoryManagerBean.criticalInventoryForCategory}" var="items"
               border="1" frame="none" style="text-align:center;">
    <h:column>
      <h:outputText value="#{items.item.SKU}"/>
      <f:facet name="header">
        <h:outputText value="SKU"/>
      </f:facet>
    </h:column>
    <h:column>
      <h:outputText value="#{items.item.name}"/>
      <f:facet name="header">
        <h:outputText value="Name"/>
      </f:facet>
    </h:column>
    <h:column>
      <h:outputText value="#{items.item.description}"/>
      <f:facet name="header">
        <h:outputText value="Description"/>
      </f:facet>
    </h:column>
    <h:column>
      <h:outputText value="#{items.quantity}" style="color:rgb(198,0,0);"/>
      <f:facet name="header">
        <h:outputText value="Quantity"/>
      </f:facet>
    </h:column>
    <h:column>
       <h:commandButton value="orders"
                       type="submit"
                       actionListener="#{inventoryManagerBean.itemSelected}"
                       action="orderItem">
        <f:facet name="extraParameter">
          <f:param name="commandButtonParam"
                   value="#{items.item.SKU}"/>
        </f:facet>
      </h:commandButton>
     <f:facet name="header">
        <h:outputText value="Select"/>
      </f:facet>
    </h:column>
    <f:facet name="header">
      <h:outputText value="Critical Items" style="color:rgb(255,0,0);"/>
    </f:facet>
  </h:dataTable>
</h:panelGrid>