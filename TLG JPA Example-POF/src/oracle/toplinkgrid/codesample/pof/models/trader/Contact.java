// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

@Entity
@Property(name = "coherence.cache.name", value = "CONTACT_JPA_CACHE")
@Customizer(CoherenceReadCustomizer.class)
public class Contact implements Serializable, PortableObject {

    @Id
    protected String info;
    
    public Contact(){
        
    }
    
    public Contact(String info){
        this.info = info;
    }

    public void readExternal(PofReader pofreader) throws IOException {
        info = pofreader.readString(0);
    }

    public void writeExternal(PofWriter pofwriter) throws IOException {
        pofwriter.writeString(0, info);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((info == null) ? 0 : info.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Contact other = (Contact) obj;
        if (info == null) {
            if (other.info != null)
                return false;
        } else if (!info.equals(other.info))
            return false;
        return true;
    }
    
}
