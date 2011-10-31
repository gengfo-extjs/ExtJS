// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapKeyColumn;
import javax.persistence.OneToMany;

import oracle.eclipselink.coherence.IntegrationProperties;
import oracle.eclipselink.coherence.integrated.config.CoherenceReadCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Property(name = "coherence.cache.name", value = "BROKER_JPA_CACHE")
@Customizer(CoherenceReadCustomizer.class)
public class Broker implements Serializable, PortableObject{
    @Id
    @GeneratedValue()
    protected Integer id;

    @Property(name=IntegrationProperties.INDEXED, value = "TRUE")
    protected String name;

    @ManyToOne(fetch=FetchType.LAZY)
    protected Brokerage brokerage;

    @OneToMany
    protected Collection<Qualification> qualifications;
    
    @OneToMany (cascade=CascadeType.PERSIST)
    @JoinColumn(name="OWNER")
    @MapKeyColumn(name="TYPE")
    protected Map<String, Contact> contactInfo;
    
    @OneToMany (cascade=CascadeType.PERSIST)
    @JoinColumn(name="OWNER2")
    protected Map<Contact, Contact> contactContact;

    public Broker() {
        super();
        this.qualifications = new ArrayList<Qualification>();
        this.contactInfo = new HashMap<String, Contact>();
        this.contactContact = new HashMap<Contact, Contact>();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Brokerage getBrokerage() {
        return brokerage;
    }

    public void setBrokerage(Brokerage brokerage) {
        this.brokerage = brokerage;
    }

    public Collection<Qualification> getQualifications() {
        return qualifications;
    }

    public void setQualifications(Collection<Qualification> qualifications) {
        this.qualifications = qualifications;
    }
    
    public Map<String, Contact> getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(Map<String, Contact> contactInfo) {
        this.contactInfo = contactInfo;
    }

    public Map<Contact, Contact> getContactContact() {
        return contactContact;
    }

    public void setContactContact(Map<Contact, Contact> contactContact) {
        this.contactContact = contactContact;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readInt(0);
        name = pofreader.readString(1);
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeInt(0, id);
        pofwriter.writeString(1, name);
    }

}
