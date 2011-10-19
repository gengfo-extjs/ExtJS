package oracle.toplink.jpa.example.inventory.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.OneToOne;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQuery;
import javax.persistence.Version;

/**
 * This class models those items that are in inventory.
 * It has special mappings because the underlying data table has been modeled
 * to use the foreign key as the primary key.
 *
 * @author Gordon Yorke
 */
@Entity

@NamedQuery(
name="inventoryForCategory",
query="SELECT i FROM Inventory i WHERE i.item.category = :category and i.quantity <= :maxQuantity"
)
public class Inventory {
    /*
     * This Entity uses the foreign key as its primary key.  Because JPA
     * requires a primary key property an 'id' property has been added that
     * references the foreign key column.  Note that this column has been
     * made 'read-only' for this mapping.  The name of the column matches the
     * default name that will be generated for the OneToOne mapping.
     */
    @Id
    @Column(name = "ITEM_SKU", insertable=false, updatable=false)
    protected long id;
    
    @OneToOne
    @JoinColumn(name="ITEM_SKU")
    protected Item item;
    
    protected int quantity;
    
    protected double cost;
    
    protected double price;
    
    @Version
    protected int version;

    public Inventory() {
    }

    public long getId() {
        return id;
    }

    public void setItem(Item item) {
        this.item = item;
        this.id = item.getSKU();
    }

    public Item getItem() {
        return item;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public double getCost() {
        return cost;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getPrice() { 
        return price;
    }
}
