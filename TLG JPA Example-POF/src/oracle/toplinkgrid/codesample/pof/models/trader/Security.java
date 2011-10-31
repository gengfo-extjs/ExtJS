// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Version;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadWriteCustomizer;

import org.eclipse.persistence.annotations.Cache;
import org.eclipse.persistence.annotations.CacheType;
import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Cache(type=CacheType.HARD_WEAK, size=10000)
@Customizer(CoherenceReadWriteCustomizer.class)
@Property(name="eclipselink.coherence.cache.name", value="SECURITY_JPA_CACHE")

public class Security implements Serializable, PortableObject{
    
    /**
     * 
     */
    private static final long serialVersionUID = -3011676436414317485L;
    @Id
    @GeneratedValue
    protected int id;
    protected String name;
    protected String symbol;
    protected String exchange;
    @Version
    protected int version;
    public int getVersion() {
        return version;
    }
    public void setVersion(int version) {
        this.version = version;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSymbol() {
        return symbol;
    }
    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }
    public String getExchange() {
        return exchange;
    }
    public void setExchange(String exchange) {
        this.exchange = exchange;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readInt(0);
        name = pofreader.readString(1);
        symbol = pofreader.readString(2);
        exchange = pofreader.readString(3);
        version = pofreader.readInt(4);
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeInt(0, id);
        pofwriter.writeString(1, name);
        pofwriter.writeString(2, symbol);
        pofwriter.writeString(3, exchange);
        pofwriter.writeInt(4, version);
        
    }

    @Override
    public String toString() {
        return "Security [id=" + id + ", version=" + version + "]";
    }

}
