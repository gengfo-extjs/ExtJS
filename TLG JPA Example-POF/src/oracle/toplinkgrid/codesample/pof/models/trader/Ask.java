// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToOne;
import javax.persistence.Version;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadWriteCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Customizer(CoherenceReadWriteCustomizer.class)
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorValue("A")
public class Ask implements Serializable, PortableObject{
    /**
     * 
     */
    private static final long serialVersionUID = -3468262622629825093L;
    @Id
    @GeneratedValue
    protected long id;
    protected double amount;
    protected int quantity;
    @OneToOne(fetch=FetchType.LAZY)
    protected Security security;
    @Version
    protected int version;
    
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
    
    public Security getSecurity(String name){
        return this.security;
    }
    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readLong(0);
        amount = pofreader.readDouble(1);
        quantity = pofreader.readInt(2);
        version = pofreader.readInt(4);
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeLong(0,id);
        pofwriter.writeDouble(1, amount);
        pofwriter.writeInt(2, quantity);
        pofwriter.writeInt(4, version);
    }

}
