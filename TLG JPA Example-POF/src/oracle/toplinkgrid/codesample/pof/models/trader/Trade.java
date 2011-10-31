// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

/**
 * This class will not be stored within Coherence as Trades are not high throughput
 * objects in this model.
 * @author Gordon
 *
 */
@Entity
public class Trade implements Serializable, PortableObject{
    /**
     * 
     */
    private static final long serialVersionUID = -244532585419336780L;
    @Id
    @GeneratedValue
    protected long id;
    @OneToOne(fetch=FetchType.EAGER)
    protected Security security;
    protected int quantity;
    protected double amount;
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public Security getSecurity() {
        return security;
    }
    public void setSecurity(Security security) {
        this.security = security;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readLong(0);
        quantity = pofreader.readInt(2);
        amount = pofreader.readDouble(3); 
        
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeLong(0, id);
        pofwriter.writeInt(2, quantity);
        pofwriter.writeDouble(3, amount);
        
    }
    
    

}
