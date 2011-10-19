package oracle.toplink.jpa.example.inventory.nonentity;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * This class is a helper class used in the application.  It is not an
 * Entity but can be used in JPQL queries to return summaries of the Item.
 * that are available in the database.
 *
 * @author Gordon Yorke
 */
 
 public class Category {
    protected int itemCount;
    protected String name;
    
    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public int getItemCount() {
        return itemCount;
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
