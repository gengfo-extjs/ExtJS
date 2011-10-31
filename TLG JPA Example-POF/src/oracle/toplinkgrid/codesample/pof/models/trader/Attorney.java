// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import oracle.eclipselink.coherence.IntegrationProperties;
import oracle.eclipselink.coherence.integrated.config.CoherenceReadCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;

import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Property(name = "coherence.cache.name", value = "ATTORNEY_JPA_CACHE")
@Customizer(CoherenceReadCustomizer.class)
public class Attorney implements Serializable, PortableObject{
    @Id
    @GeneratedValue()
    protected Integer id;

    @Property(name=IntegrationProperties.INDEXED, value = "TRUE")
    protected String name;
    
    protected String specialty;

    public Attorney() {
        super();
    }

    public Attorney(String name, String speciality) {
        super();
        this.name = name;
        this.specialty = speciality;
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
    

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        id = pofreader.readInt(0);
        name = pofreader.readString(1);
        specialty = pofreader.readString(2);
    }
    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeInt(0, id);
        pofwriter.writeString(1, name);
        pofwriter.writeString(2, specialty);
    }

}
