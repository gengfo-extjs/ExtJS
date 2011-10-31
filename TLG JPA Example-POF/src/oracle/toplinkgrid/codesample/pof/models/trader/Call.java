// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.OneToOne;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadWriteCustomizer;

import org.eclipse.persistence.annotations.Customizer;
import org.eclipse.persistence.annotations.Property;
import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;

@Entity
@DiscriminatorValue("C")
//the cache name should be ignored because all classes in an inheritance heirarchy are stored in the same cache to allow for polymorphic queries.
@Property(name = "eclipselink.coherence.cache.name", value = "CALL_JPA_CACHE")
@Customizer(CoherenceReadWriteCustomizer.class)
public class Call extends Ask {
    @OneToOne
    protected Broker representative;

    public Broker getRepresentative() {
        return representative;
    }

    public void setRepresentative(Broker representative) {
        this.representative = representative;
    }

    @Override
    public void readExternal(PofReader pofreader) throws IOException {
        super.readExternal(pofreader);
    }
    
    @Override
    public void writeExternal(PofWriter pofwriter) throws IOException {
        super.writeExternal(pofwriter);
    }
}
