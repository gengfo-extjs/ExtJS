package oracle.toplink.jpa.example.inventory.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Version;


/**
 * The Order class represents a request for delivery of a particular Item.  It
 * includes the date the order was placed, the estimated date of arrival and the
 * current location.  The Item on order is referenced as is the quantity in the
 * order.
 *
 * @author Gordon Yorke
 */
 
@Entity
 // specify table name as the default will be ORDER which is a reserved word
@Table(name="ORDER_TABLE")

@NamedQueries({

@NamedQuery(
name="shippedOrdersForItem",
query="SELECT o FROM Order o JOIN o.item i WHERE i.sKU = :itemId and o.arrivalDate is not null"
),

@NamedQuery(
name="pendingOrdersForItem",
query="SELECT o FROM Order o WHERE o.item.sKU = :itemId and o.arrivalDate is null"
)})


public class Order {

    @Id
    @GeneratedValue
    protected long orderId;
    
    protected Date orderInitiated;
    
    protected Date arrivalDate;
    
    protected String currentLocation;
    
    protected int quantity;
    
    @Version
    protected int version;
    
    @OneToOne
    protected Item item ;
    
    public Order() {
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderInitiated(Date orderInitiated) {
        this.orderInitiated = orderInitiated;
    }

    public Date getOrderInitiated() {
        return orderInitiated;
    }

    public void setArrivalDate(Date arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public Date getArrivalDate() {
        return arrivalDate;
    }

    public void setCurrentLocation(String currentLocation) {
        this.currentLocation = currentLocation;
    }

    public String getCurrentLocation() {
        return currentLocation;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Item getItem() {
        return item;
    }
}
