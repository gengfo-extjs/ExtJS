// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.OneToOne;
import javax.persistence.Version;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadCustomizer;
import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Customizer(CoherenceReadCustomizer.class)
@Property(name="eclipselink.coherence.cache.name", value="BID_JPA_CACHE")
public class Bid implements Serializable, PortableObject{
    /**
     * 
     */
    private static final long serialVersionUID = -615804827371772412L;
    @Id
    @GeneratedValue
    protected long id;
    protected double amount;
    protected int quantity;
    @Version
    protected int version;
    
    @OneToOne(fetch=FetchType.EAGER)
    protected Security security;
	
    public Bid() {
        super();
    }
    
    public Bid(long id) {
        super();
        this.id = id;
    }
    
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public Security getSecurity() {
        return security;
    }
    public void setSecurity(Security security) {
        this.security = security;
    }
    
    public int getVersion() {
        return version;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readLong(0);
        amount = pofreader.readDouble(1);
        quantity = pofreader.readInt(2);
        version = pofreader.readInt(3);
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeLong(0, id);
        pofwriter.writeDouble(1, amount);
        pofwriter.writeInt(2, quantity);
        pofwriter.writeInt(3, version);
        
    }
    
    @Override
    public String toString() {
        return "Bid [id=" + id + ", quantity=" + quantity + "]";
    }

}
