package oracle.toplink.jpa.example.inventory.services;

import java.util.Collection;

import oracle.toplink.jpa.example.inventory.nonentity.Category;
import oracle.toplink.jpa.example.inventory.model.Inventory;
import oracle.toplink.jpa.example.inventory.model.Order;

/**
 * This class provides the interface point for the 'InventoryService'.  The
 * implemenation of the OrderService accesses the persistence store and
 * provides the caller with data about the Inventory in the system.  
 *
 * @author Gordon Yorke
 */
public interface InventoryService {

    /**
     * Returns a list of available item categories.  The Categories are not
     * entities but is a summary of data available.
     */
    public Collection<Category> getCategories();
    
    /**
     * Returns a list items for the specified category with Quantitieg less than
     * or equal to the provided int value.
     */
    public  Collection<Inventory> getInventoryForCategoryMaxQuantity(String category, int quantity);
    
}
