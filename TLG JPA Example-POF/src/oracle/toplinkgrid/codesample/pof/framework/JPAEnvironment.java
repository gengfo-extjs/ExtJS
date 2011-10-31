package oracle.toplinkgrid.codesample.pof.framework;
// Copyright (c) 2011, Oracle and/or its affiliates. 
// All rights reserved. 



import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import oracle.toplinkgrid.codesample.pof.models.trader.Ask;
import oracle.toplinkgrid.codesample.pof.models.trader.Attorney;
import oracle.toplinkgrid.codesample.pof.models.trader.Bid;
import oracle.toplinkgrid.codesample.pof.models.trader.Broker;
import oracle.toplinkgrid.codesample.pof.models.trader.Brokerage;
import oracle.toplinkgrid.codesample.pof.models.trader.Contact;
import oracle.toplinkgrid.codesample.pof.models.trader.Qualification;
import oracle.toplinkgrid.codesample.pof.models.trader.Security;

public class JPAEnvironment {
    protected String puName;
    protected EntityManagerFactory emf;
    protected int initCount;
    
    protected static Map<String, JPAEnvironment> environments = new HashMap<String, JPAEnvironment>();
    protected static Map<Class, Object> guaranteedId = new HashMap<Class, Object>();
    
    protected JPAEnvironment(String puname){
        this.puName = puname;
    }
    public EntityManagerFactory getEMF(){
        if (emf == null) acquireEMF(new HashMap<String, String>());
        return emf;
    }
    /**
     * @return the guaranteedId
     */
    public static Object getGuaranteedId(Class clazz) {
        return guaranteedId.get(clazz);
    }

    public static JPAEnvironment getEnvironment(String puname){
        if (!environments.containsKey(puname)){
            environments.put(puname, new JPAEnvironment(puname));
        }
        return environments.get(puname);
    }
    
    public void releaseEMF(){
        if (this.emf != null) this.emf.close();
        this.emf = null;
    }
    
    public void initialize(boolean generate, boolean populate) {
        try {
            if (initCount == 0) {
        		// Configure Single Server Mode 
        		// http://download.oracle.com/docs/cd/E15357_01/coh.360/e15723/cluster_singleserver.htm#sthref19
        		System.setProperty("tangosol.coherence.localhost","127.0.0.1");
        		System.setProperty("tangosol.coherence.ttl","0");
        		// Disable local storage--need to start independent CacheServer
        		System.setProperty("tangosol.coherence.distributed.localstorage","false");
        		System.setProperty("tangosol.coherence.cacheconfig","EclipseLink-POF-Cache-Store.xml");
                if (generate) generateDatabase();
                if (populate) populate();
            }
            ++initCount;
        } catch (RuntimeException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public void release(){
        --initCount;
        if (initCount == 0) {
            environments.remove(this.puName).releaseEMF();
        }
    }
    
    public static void main(String args[]){
        JPAEnvironment env = new JPAEnvironment("coherence-pu");
        env.generateDatabase();
    }
    
    public void populate(){
        EntityManager em = getEMF().createEntityManager();
        em.getTransaction().begin();
        ArrayList<Security> securities = new ArrayList<Security>(10);
        for (int i = 0; i< 2; ++i){
            StringBuffer symbol = new StringBuffer();
            for (int c = 0; c < 4; ++c){
                symbol.append('A' + (char)Math.rint(Math.random() *25));
            }
            Security security = new Security();
            security.setExchange("MYEX");
            security.setSymbol(symbol.toString());
            securities.add(security);
            em.persist(security);
            this.guaranteedId.put(Security.class, security.getId());
        }
        Security security = new Security();
        security.setExchange("MYEX");
        security.setSymbol("LKJH");
        security.setId(24);
        securities.add(security);
        em.persist(security);
        em.getTransaction().commit();
        em.getTransaction().begin();
        
        ArrayList<Qualification> qualifications = new ArrayList<Qualification>(10);
        for (int i = 0; i < 10; ++i){
            StringBuffer name = new StringBuffer(3);
            for (int c = 0; c < 3; ++c){
                name.append('B' + (char)Math.rint(Math.random() *3));
            }
            Qualification qual = new Qualification();
            qual.setName(name.toString());
            qual.setId(Integer.valueOf((int) System.currentTimeMillis()));
            qualifications.add(qual);
            em.persist(qual);
            this.guaranteedId.put(Qualification.class, qual.getId());
        }
        ArrayList<Qualification> quals = (ArrayList<Qualification>)qualifications.clone();
        int preReq = qualifications.size()-2;
        for (int i = qualifications.size()-1; i >= 0 && preReq > 0; --i){
            Qualification qual = qualifications.get(i);
            for (int pres = (int)Math.rint(Math.random() * (preReq % 4)); pres > 0; --pres){
                qual.getPreReqs().add(qualifications.get(preReq));
                preReq--;
            }
        }
        em.getTransaction().commit();
        em.getTransaction().begin();
        Brokerage brokerage = new Brokerage();
        em.persist(brokerage);
        this.guaranteedId.put(Brokerage.class, brokerage.getId());

        brokerage.setName("J,J&J");
        brokerage.getPartners().add("J");
        brokerage.getPartners().add("J");
        brokerage.getPartners().add("J");

        Attorney attorney1 = new Attorney("Lahey & Lahey", "Corporate Acquisistions");
        em.persist(attorney1);
        brokerage.getAttornies().put(attorney1.getSpecialty(), attorney1);
        Attorney attorney2 = new Attorney("Cutter & Jones", "Document Discovery");
        em.persist(attorney2);
        brokerage.getAttornies().put(attorney2.getSpecialty(), attorney2);
        
        Broker broker = new Broker();
        em.persist(broker);
        this.guaranteedId.put(Broker.class, broker.getId());

        broker.setName("John Johnson");
        brokerage.getBrokers().add(broker);
        broker.setBrokerage(brokerage);
        broker.getQualifications().add(qualifications.get(0));
        broker.getQualifications().addAll(qualifications.get(0).getPreReqs());
        broker.getContactInfo().put("WORK", new Contact("5555555555"));
        broker.getContactInfo().put("MOBILE", new Contact("2222222222"));
        Contact key = new Contact("KEY");
        em.persist(key);
        broker.getContactContact().put(key, new Contact("VALUE"));
        broker = new Broker();
        em.persist(broker);
        broker.setName("Dwayne DeWolfe");
        brokerage.getBrokers().add(broker);
        broker.setBrokerage(brokerage);
        broker.getQualifications().add(qualifications.get(4));
        broker.getQualifications().addAll(qualifications.get(4).getPreReqs());
        broker.getContactInfo().put("Office", new Contact("1111111111"));
        broker.getContactInfo().put("Home", new Contact("3333333333"));
        em.getTransaction().commit();
        
        em.getTransaction().begin();
        for (int i = 0; i < 10; ++i){
            Ask ask = new Ask();
            ask.setQuantity((((int)Math.rint(Math.random()*2))+1)*100);
            ask.setSecurity(securities.get((int)Math.floor(Math.random()*securities.size())));
            ask.setAmount(Math.rint(Math.random()*500)/100);
            em.persist(ask);
            this.guaranteedId.put(Ask.class, ask.getId());
        }
        
        for (int i = 0; i < 10; ++i){
            Bid bid = new Bid();
            bid.setQuantity((((int)Math.rint(Math.random()*3))+2)*100);
            bid.setSecurity(securities.get((int)Math.floor(Math.random()*securities.size())));
            bid.setAmount(Math.rint(Math.random()*500)/100);
            em.persist(bid);
            this.guaranteedId.put(Bid.class, bid.getId());
        }
        em.getTransaction().commit();
        em.close();
        
    }
    
    public void generateDatabase(){
        releaseEMF();
        Map<String, String> properties = new HashMap<String, String>();
        properties.put("eclipselink.ddl-generation.output-mode", "database");
        properties.put("eclipselink.ddl-generation", "drop-and-create-tables");
        acquireEMF(properties);
        getEMF().createEntityManager().close();
        releaseEMF();
    }
    
    public void acquireEMF(Map<String, String> properties){
        if (this.emf == null)
        this.emf = Persistence.createEntityManagerFactory(this.puName, properties);
    }

}
