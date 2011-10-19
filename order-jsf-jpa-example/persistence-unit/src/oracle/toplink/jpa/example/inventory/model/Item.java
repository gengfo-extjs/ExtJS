package oracle.toplink.jpa.example.inventory.model;

import javax.persistence.Entity ;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Version;

/**
 * The Item class represents the physical 'things' that can be ordered
 * or carried in the inventory.
 * 
 * @author Gordon Yorke
 */
 
@Entity
public class Item {
     
    protected long SKU;
    protected String description;
    protected String name;
    protected String category;

    protected int version;
    
    public Item() {
    }

    @Id
    @GeneratedValue
    public long getSKU() {
        return SKU;
    }

    public void setSKU(long sku) {
        this.SKU = sku;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Version
    public void setVersion(int version) {
        this.version = version;
    }

    public int getVersion() {
        return version;
    }
}
