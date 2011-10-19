package oracle.toplink.jpa.example.inventory.services;

import java.util.Collection;

import oracle.toplink.jpa.example.inventory.model.Item;
import oracle.toplink.jpa.example.inventory.model.Order;

/**
 * This class provides the interface point for the 'OrderService'.  The
 * implemenation of the OrderService access the persistence store and
 * provides the caller with data about the Orders in the system.  
 * This interface also provides maintenance operation on the Order data.
 *
 * @author Gordon Yorke
 */
 public interface OrderService {
    /**
     * Returns those orders that have a set arrival date indicating that they have shipped
     */
    public Collection<Order> getShippedOrdersForItem(long itemId);
    
    /**
     * Returns those orders that have a set arrival date indicating that they have shipped
     */
    public Collection<Order> getPendingOrdersForItem(long itemId);
    
    /**
     * request that an order be canceled.  Assume the operation completed
     * successfully unless an exception is thrown. 
     */
    public void requestCancelOrder(long orderId);
    
    /**
     * request that an order quantity be updated.  Assume the operation completed
     * successfully unless an exception is thrown.
     */
    public void alterOrderQuantity(long orderId, int newQuantity);
    
    /**
     * Create a new order request for a particular item;  This will create an 
     * Order in the order system.  Assume success unless an exception is thrown
     */
    public void  createNewOrder(Order order);
    
    public Order getOrderById(long orderId);
    
    public Item getItemById(long itemId);
}
