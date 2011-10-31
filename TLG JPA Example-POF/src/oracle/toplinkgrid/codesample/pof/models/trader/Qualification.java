// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.OneToMany;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadWriteCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Customizer(CoherenceReadWriteCustomizer.class)
@Property(name="coherence.cache.name", value="QUAL_JPA_CACHE")
@IdClass(QualificationId.class)
public class Qualification implements Serializable, PortableObject{
    @Id
    protected Integer id;
    
    @Id
    protected String name;
    
    @OneToMany
    protected Collection<Qualification> preReqs;

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

    public Collection<Qualification> getPreReqs() {
        return preReqs;
    }

    public void setPreReqs(Collection<Qualification> preReqs) {
        this.preReqs = preReqs;
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
