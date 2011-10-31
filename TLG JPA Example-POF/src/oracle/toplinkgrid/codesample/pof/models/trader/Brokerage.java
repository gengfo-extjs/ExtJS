// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MapKey;
import javax.persistence.OneToMany;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Property(name = "eclipselink.coherence.cache.name", value = "BROKERAGE_JPA_CACHE")
@Customizer(CoherenceReadCustomizer.class)
public class Brokerage implements Serializable, PortableObject {
    @Id
    @GeneratedValue
    protected long id;

    protected String name;

    @OneToMany(mappedBy = "brokerage")
    protected Collection<Broker> brokers;
    
    @OneToMany
    @MapKey(name="specialty")
    protected Map<String, Attorney> attornies;
    
    @ElementCollection
    protected Collection<String> partners;

    public Brokerage() {
        super();
        this.brokers = new ArrayList<Broker>();
        this.partners = new ArrayList<String>();
        this.attornies = new HashMap<String, Attorney>();
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Collection<Broker> getBrokers() {
        return brokers;
    }

    public void setBrokers(Collection<Broker> brokers) {
        this.brokers = brokers;
    }

    /**
     * @return the partners
     */
    public Collection<String> getPartners() {
        return partners;
    }

    /**
     * @param partners the partners to set
     */
    public void setPartners(Collection<String> partners) {
        this.partners = partners;
    }

    public Map<String, Attorney> getAttornies() {
        return attornies;
    }

    public void setAttornies(Map<String, Attorney> attornies) {
        this.attornies = attornies;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readLong(0);
        name = pofreader.readString(1);
        partners = pofreader.readCollection(2, new ArrayList<String>());
        
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeLong(0, id);
        pofwriter.writeString(1, name);
        pofwriter.writeCollection(2, partners);
        
    }

}
