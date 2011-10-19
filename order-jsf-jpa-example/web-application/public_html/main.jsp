<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
   <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
   <%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
   <%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
   <f:view>
      <head>
         <title>Inventory Management</title>
         <style type="text/css">
        .mainHeader {font-size:larger; border-bottom: thin solid}
                .menuHeader {text-align:center; border-bottom: thin dotted;}
                .menu {vertical-align:top; text-align: right}
    </style>
      <link href="css/bc4j.css" rel="stylesheet" media="screen"/>
      </head>
      <body background="images/inventory.jpg"><h:form>
            <h:panelGrid columns="2"
                         style="text-align:center; vertical-align:top;" headerClass="mainHeader" columnClasses="menu">
               <f:facet name="header">
                  <h:outputText value="Inventory Management"/>
               </f:facet>
               <h:dataTable value="#{inventoryManagerBean.categories}"
                            var="menuItem" cellpadding="0" cellspacing="2"
                            border="0" headerClass="menuHeader" columnClasses="menu"

                            style="vertical-align:top; border-right: solid; ">
                  <h:column>
                     <f:facet name="header">
                        <h:outputText value="Category"/>
                     </f:facet>
                     <h:panelGroup>
                        <h:outputText value="  - "/>
                        <h:commandLink value="#{menuItem.name}"
                                       rendered="#{inventoryManagerBean.currentCategory != menuItem.name}"
                                       actionListener="#{inventoryManagerBean.changeCategory}"/>
                     </h:panelGroup>
                     <h:outputText value="#{menuItem.name}"
                                   rendered="#{inventoryManagerBean.currentCategory == menuItem.name}"/>
                  </h:column>
               </h:dataTable>
               <h:panelGrid columns="1" style="text-align:center;">
                  <c:import url="/inventory.jsp"/>
                  <h:panelGroup id="minQuantity" style="text-align:center;">
                     <h:outputLabel value="Min Quantity" for="minQuantity"/>
                     <h:inputText value="#{inventoryManagerBean.minQuantity}"
                                  valueChangeListener="#{inventoryManagerBean.minQuantityUpdated}"
                                  immediate="true"/>
                     <h:commandButton value="refresh"
                                      actionListener="#{inventoryManagerBean.refreshInventoryManagement}"/>
                  </h:panelGroup>
                  <c:import url="criticalInventory.jsp"/>
                 </h:panelGrid>
            </h:panelGrid>
         </h:form>
         <h:message id="errorTag" for="errorTag" showDetail="true"/>
</body>
   </f:view>
</html>