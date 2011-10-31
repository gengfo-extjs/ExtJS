// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.toplinkgrid.codesample.pof.models.trader;

import java.io.IOException;
import java.io.Serializable;

import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

public class QualificationId implements Serializable, PortableObject{

    public Integer id;
    
    public String name;

    public QualificationId(){
        
    }
    
    public QualificationId(Integer id, String name) {
        this.id = id;
        this.name = name;
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

    @Override
    public void readExternal(PofReader in) throws IOException {
        id = in.readInt(0);
        name = in.readString(1);
        
    }

    @Override
    public void writeExternal(PofWriter out) throws IOException {
        out.writeInt(0, id);
        out.writeString(1, name);
    }
}
