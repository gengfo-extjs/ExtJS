// Copyright (c) 1998, 2010, Oracle and/or its affiliates. 
// All rights reserved. 
package oracle.eclipselink.coherence.integrated.internal.cache;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;
import com.tangosol.util.Binary;
import com.tangosol.util.BinaryEntry;
import com.tangosol.util.InvocableMap.Entry;
import com.tangosol.util.InvocableMap.EntryProcessor;
import com.tangosol.util.extractor.AbstractExtractor;
import com.tangosol.util.processor.AbstractProcessor;

public class RelationshipUpdateProcessor extends AbstractProcessor implements PortableObject{
    
    protected Object[] references;
    protected String attributeName;
    protected Object versionValue;
    protected AbstractExtractor extractor;

    public RelationshipUpdateProcessor(){
    }

    public RelationshipUpdateProcessor(Object[] references, String attributeName, Object versionValue, AbstractExtractor extractor){
        this.references = references;
        this.attributeName = attributeName;
        this.versionValue = versionValue;
        this.extractor = extractor;
        
    }

    @Override
    public Object process(Entry entry) {
        if (entry.isPresent()){
            if (extractor != null){
                Binary internalValue = ((BinaryEntry)entry).getBinaryValue();
                
                Comparable targetValue = (Comparable) ((BinaryEntry)entry).getContext().getInternalValueDecoration(internalValue, 4);
                if (targetValue == null){
                    targetValue = (Comparable) extractor.extract(entry.getValue());
                }
                if (targetValue != null && (! (targetValue.compareTo(versionValue)<= 0))){
                    return null;
                }
            }
            WrapperInternal wrapper = (WrapperInternal) entry.getValue();
            wrapper.getPrimaryKeys().put(attributeName, references);
            wrapper.getForeignKeys().remove(attributeName);
            entry.setValue(wrapper, true);
        }
        return null;
    }

    @Override
    public Map processAll(Set setEntries) {
        return null;
    }

    @Override
    public void readExternal(PofReader in) throws IOException {
        this.references = in.readObjectArray(0, new Object[]{});
        this.attributeName = in.readString(1);
        this.versionValue = in.readObject(2);
        this.extractor = (AbstractExtractor) in.readObject(3);
    }

    @Override
    public void writeExternal(PofWriter out) throws IOException {
        out.writeObjectArray(0, this.references);
        out.writeString(1, this.attributeName);
        out.writeObject(2, this.versionValue);
        out.writeObject(3, this.extractor);
        
    }

}
