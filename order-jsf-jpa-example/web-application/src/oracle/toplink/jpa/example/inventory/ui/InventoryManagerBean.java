package oracle.toplink.jpa.example.inventory.ui;

import java.sql.Date;

import java.util.ArrayList;
import java.util.Collection;

import java.util.Iterator;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;

import javax.faces.event.ValueChangeEvent;

import javax.persistence.EntityManager;
import javax.persistence.OptimisticLockException;
import javax.persistence.PersistenceContext;

import javax.persistence.RollbackException;

import oracle.toplink.jpa.example.inventory.model.Inventory;
import oracle.toplink.jpa.example.inventory.model.Item;
import oracle.toplink.jpa.example.inventory.model.Order;
import oracle.toplink.jpa.example.inventory.nonentity.Category;
import oracle.toplink.jpa.example.inventory.services.InventoryService;
import oracle.toplink.jpa.example.inventory.services.OrderService;
import oracle.toplink.jpa.example.inventory.services.impl.JPAResourceBean;
import oracle.toplink.jpa.example.inventory.services.impl.ManagedInventoryBean;


/**
 * This class is the main resource for managing the user interface.  It
 * all of the bound properties for the JSF UI.
 * 
 * @author Gordon Yorke
 */

public class InventoryManagerBean{

    // This caches the categories.  We can assume they are non-volatile and
    //can cache them in this session scoped bean.
    protected Category[] categories;
    
    // This item temporarily stores the items that fall within the currently
    // selected category.  It will be cleared as the category is changed
    protected Inventory[] inventory;
    
    // This item temporarily stores the items that fall within the currently
    // selected category and have quantities below the minQuantity value. 
    // It will be cleared as the category or the minQuantity is changed
    protected Inventory[] criticalInventory;
    
    //stores the current item category that will be displayed
    protected String currentCategory;
    
    //Stores the minimum quantity that will be used to filter the inventory
    //items that may need ordering
    protected int minQuantity = 5;
    
    // This attribute holds a reference to the Inventory service that will provide
    // data access for the ui.
    protected InventoryService inventoryService;
    
    // This attribute holds a reference to the data service that will provide
    // data access for the ui.
    protected OrderService orderService;

    //The attribute stores the item that is being ordered
    protected long orderedItemId;
    
    //This is the current order used for the order input screen.  This object may
    //be new in which case the orderId will be == 0.  If it not new the orderId > 0
    protected Order currentOrder;
    
    //This stores the current modification operation that is taking place with
    // the order.  It has 2 possibilities "Update" and "Create"
    protected static final String UPDATE_OPERATION = "Update";
    protected static final String CREATE_OPERATION = "Create";
    protected String orderEntryOperation;
    
    //This stores the result of a modification operation.  There are predefined
    //messages for success and failure.
    protected String orderModificationResult;
    protected static final String SUCCESS = "Success";
    
    public InventoryManagerBean() {
    }
    
    public Category[] getCategories(){
        try{
            if (this.categories == null){
                Collection<Category> tempCollection = inventoryService.getCategories();
                this.categories = tempCollection.toArray(new Category[tempCollection.size()]);
                this.currentCategory = this.categories[0].getName();
            }
        }catch (RuntimeException ex){
            handleException(ex);
        }
        return this.categories;
    }
    
    public Inventory[] getInventoryForCategory(){
        try{
            if (this.inventory == null){
                Collection<Inventory> tempCollection = inventoryService.getInventoryForCategoryMaxQuantity(this.currentCategory, Integer.MAX_VALUE);
                this.inventory = tempCollection.toArray(new Inventory[tempCollection.size()]);
            }
         }catch (RuntimeException ex){
            handleException(ex);
        }
        return this.inventory;
    }

    public void setInventoryService(InventoryService inventoryService) {
        this.inventoryService = inventoryService;
    }

    public InventoryService getInventoryService() {
        return inventoryService;
    }

    public void changeCategory(ActionEvent actionEvent) {
        this.inventory = null;
        this.currentCategory = (String)actionEvent.getComponent().getAttributes().get("value");
        this.inventory = null;
        this.criticalInventory = null;
    }

    public void setCurrentCategory(String currentCategory) {
        this.currentCategory = currentCategory;
    }

    public String getCurrentCategory() {
        return currentCategory;
    }

    public void setMinQuantity(int minQuantity) {
        this.minQuantity = minQuantity;
    }

    public int getMinQuantity() {
        return minQuantity;
    }

    public void minQuantityUpdated(ValueChangeEvent valueChangeEvent) {
        this.minQuantity =  ((Integer)valueChangeEvent.getNewValue()).intValue();
        this.criticalInventory = null;
    }

    public Inventory[] getCriticalInventoryForCategory(){
        try{
            if (this.criticalInventory == null){
                Collection<Inventory> tempCollection = inventoryService.getInventoryForCategoryMaxQuantity(this.currentCategory , this.minQuantity);
                this.criticalInventory = tempCollection.toArray(new Inventory[tempCollection.size()]);
            }
        }catch (RuntimeException ex){
            handleException(ex);
        }
        return this.criticalInventory;
    }
    
    public Order[] getShippedOrdersForCurrentItem(){
        try{
            Collection<Order> tempCollection = orderService.getShippedOrdersForItem(this.orderedItemId);
            return tempCollection.toArray(new Order[tempCollection.size()]);
        }catch (RuntimeException ex){
            handleException(ex);
        }
        return new Order[0];
    }

    public Order[] getPendingOrdersForCurrentItem(){
        try{
            Collection<Order> tempCollection = orderService.getPendingOrdersForItem(this.orderedItemId);
            return tempCollection.toArray(new Order[tempCollection.size()]);
        }catch (RuntimeException ex){
            handleException(ex);
        }
        return new Order[0];
    }

    public void itemSelected(ActionEvent actionEvent) {
        //the facet extra parameter is used here because in the JSF 1.1 reference impl
        //attribute EL is calculated at a different stage making it difficult to
        //assign 
        this.orderedItemId = ((Long)((UIParameter)actionEvent.getComponent().getFacet("extraParameter")).getValue()).longValue();
    }
    
    public void orderUpdate(ActionEvent actionEvent){
        try{
            long orderId = ((Long)((UIParameter)actionEvent.getComponent().getFacet("extraParameter")).getValue()).longValue();
            this.currentOrder = orderService.getOrderById(orderId);
            this.orderEntryOperation = UPDATE_OPERATION;
        }catch (RuntimeException ex){
            handleException(ex);
        }
    }
    
    public void orderRemoved(ActionEvent actionEvent){
        long orderId = ((Long)((UIParameter)actionEvent.getComponent().getFacet("extraParameter")).getValue()).longValue();
        try{
            orderService.requestCancelOrder(orderId);
            this.orderModificationResult = "Success";
        }catch (OptimisticLockException ex){
            this.orderModificationResult = "Failed to " + this.orderEntryOperation.toLowerCase() + " Order.  Order status has changed since last viewed";
        }catch (Exception ex){
            this.orderModificationResult = "Failed to " + this.orderEntryOperation.toLowerCase() + " Order.  An unexpected Error ocurred: " +ex.toString();
        }
    }

    public void createNewOrder(ActionEvent actionEvent){
        try{
            this.currentOrder = new Order();
            this.currentOrder.setOrderInitiated(new Date(System.currentTimeMillis()));
            this.currentOrder.setItem(orderService.getItemById(this.orderedItemId));
            this.orderEntryOperation = CREATE_OPERATION;
        }catch (RuntimeException ex){
            handleException(ex);
        }
    }

    public void setOrderedItemId(long orderedItem) {
        this.orderedItemId = orderedItem;
    }

    public long getOrderedItemId() {
        return orderedItemId;
    }

    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public OrderService getOrderService() {
        return orderService;
    }

    public void setCurrentOrder(Order currentOrder) {
        this.currentOrder = currentOrder;
    }

    public Order getCurrentOrder() {
        return currentOrder;
    }

    public void completeOrderUpdate(ActionEvent actionEvent) {
        try{
            if (this.orderEntryOperation == this.UPDATE_OPERATION){
                orderService.alterOrderQuantity(this.currentOrder.getOrderId(), this.currentOrder.getQuantity());
            }else{
                orderService.createNewOrder(this.currentOrder);
            }
            this.orderModificationResult = SUCCESS;
        }catch (RollbackException ex){
            if (ex.getCause() instanceof OptimisticLockException){
                this.orderModificationResult = "Failed to " + this.orderEntryOperation.toLowerCase() + " Order.  Order status has changed since last viewed";
            }else{
                this.orderModificationResult = "Failed to " + this.orderEntryOperation.toLowerCase() + " Order.  An unexpected Error ocurred: " +ex.toString();                
            }
        }catch (Exception ex){
        this.orderModificationResult = "Failed to " + this.orderEntryOperation.toLowerCase() + " Order.  An unexpected Error ocurred: " +ex.toString();
        }
    }

    public void setOrderEntryOperation(String orderEntryOperation) {
        this.orderEntryOperation = orderEntryOperation;
    }

    public String getOrderEntryOperation() {
        return orderEntryOperation;
    }

    public void setOrderModificationResult(String orderModificationResult) {
        this.orderModificationResult = orderModificationResult;
    }

    public String getOrderModificationResult() {
        return orderModificationResult;
    }

    public void refreshInventoryManagement(ActionEvent actionEvent) {
        this.inventory = null;
        this.criticalInventory = null;
    }
    
    public boolean getSuccess(){
        return orderModificationResult == SUCCESS;
    }
    
    public void setSuccess(){
        //no-op just provides the other half of the property being bound into
        //the UI.
    }

    //This method is used to handle exceptions and display cause to user.
    protected void handleException (RuntimeException ex){
        StringBuffer details = new StringBuffer();
        Throwable causes = ex;
        while(causes.getCause() != null){
            details.append(ex.getMessage());
            details.append("    Caused by:");
            details.append(causes.getCause().getMessage());
            causes = causes.getCause();
        }
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, ex.getMessage(), details.toString());
        FacesContext.getCurrentInstance().addMessage("errorTag", message);
    }
}
