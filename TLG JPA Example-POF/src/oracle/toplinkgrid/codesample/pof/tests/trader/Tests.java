// Copyright (c) 1998, 2010, Oracle and/or its affiliates. 
// All rights reserved. 

package oracle.toplinkgrid.codesample.pof.tests.trader;

import java.math.BigDecimal;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import junit.extensions.TestSetup;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import oracle.eclipselink.coherence.integrated.querying.IgnoreDefaultRedirector;
import oracle.toplinkgrid.codesample.pof.framework.JPAEnvironment;
import oracle.toplinkgrid.codesample.pof.models.trader.Ask;
import oracle.toplinkgrid.codesample.pof.models.trader.Bid;
import oracle.toplinkgrid.codesample.pof.models.trader.Broker;
import oracle.toplinkgrid.codesample.pof.models.trader.Brokerage;
import oracle.toplinkgrid.codesample.pof.models.trader.Call;
import oracle.toplinkgrid.codesample.pof.models.trader.Contact;
import oracle.toplinkgrid.codesample.pof.models.trader.Security;
import oracle.toplinkgrid.codesample.pof.models.trader.Trade;

import org.eclipse.persistence.config.QueryHints;

public class Tests extends TestCase {

    protected String environmentName = "coherence-pu";

    public Tests() {
        super();
    }

    public Tests(String string) {
        super(string);
    }

    protected void setUp() throws Exception {
        JPAEnvironment.getEnvironment(environmentName).initialize(true, true);
        super.setUp();
    }

    protected void tearDown() throws Exception {
        JPAEnvironment.getEnvironment(environmentName).release();
        super.tearDown();
    }

    public void testInheritance() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        em.getTransaction().begin();
        Call call = new Call();
        call.setAmount(2.2);
        call.setQuantity(3456);
        call.setSecurity((Security) em.createQuery("select s from Security s").getResultList().get(0));
        call.setRepresentative((Broker) em.createQuery("select b from Broker b").getResultList().get(0));
        Broker rep = call.getRepresentative();
        em.persist(call);
        em.getTransaction().commit();
        em.clear();
        call = em.find(Call.class, call.getId());
        assertTrue("Call was not persisted and found correctly", call != null);
        assertTrue("Representative was not persisted and found correctly", call.getRepresentative() != null && call.getRepresentative().getId().equals(rep.getId()));

        em.clear();
        call = (Call) em.createQuery("Select c from Call c where c.quantity = 3456").getSingleResult();
        assertTrue("filter not working correctly.  Unable to find call.", call != null);

        em.clear();
        Query query = em.createQuery("Select c from Call c where c.id = " + call.getId());
        query.setHint(QueryHints.QUERY_REDIRECTOR, new IgnoreDefaultRedirector());
        call = (Call) query.getSingleResult();
        assertTrue("Call was not persisted and found correctly", call != null);
        assertTrue("Representative was not written to database correctly", call.getRepresentative() != null && call.getRepresentative().getId().equals(rep.getId()));

        em.clear();
        List<Ask> result = em.createQuery("Select c from Call c").getResultList();
        for (Ask ask : result) {
            if (!ask.getClass().equals(Call.class)) {
                fail("Result returned Ask even though it was call that was queried for");
            }
        }

        em.getTransaction().begin();
        em.remove(em.find(Call.class, call.getId()));
        em.getTransaction().commit();

    }

    public void testParameterQuery() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Query query = em.createQuery("select s from Security s where s.symbol = :symbol");
        query.setParameter("symbol", "LKJH");
        List result = query.getResultList();
        assertTrue("Unable to find a Security", result.size() != 0);
        em.clear();
        assertTrue("Unable to em.find() Security", em.find(Security.class, ((Security) result.get(0)).getId()) != null);
        em.close();
    }

    public void testDoNotRedirectParameterQuery() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Query query = em.createQuery("select s from Security s where s.symbol = :symbol");
        query.setHint(QueryHints.QUERY_REDIRECTOR, "oracle.eclipselink.coherence.integrated.querying.IgnoreDefaultRedirector");
        query.setParameter("symbol", "LKJH");
        List result = query.getResultList();
        assertTrue("Unable to find a Security", result.size() != 0);
        em.clear();
        assertTrue("Unable to em.find() Security", em.find(Security.class, ((Security) result.get(0)).getId()) != null);
        em.close();
    }

    public void testCreateNewSecurity() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        // setup
        Security security = new Security();
        security.setExchange("EXCHANGE11");
        em.getTransaction().begin();
        em.persist(security);
        em.getTransaction().commit();
        em.getTransaction().begin();
        em.remove(security);
        em.getTransaction().commit();
    }

    public void testL2CacheRead() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        em.createQuery("Select b from Brokerage b").getResultList();
        em.close();
    }

    public void testFindNonExistentEntity() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Security security = em.find(Security.class, -1);
        assertNull("Found a Security that should not have existed. Security Id: -1 ", security);
        em.clear();
        em.close();

    }

    public void testFindAsk() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select a from Ask a where a.quantity = 200").getResultList();
        assertTrue("Unable to find an Ask with quantity = 200", result.size() != 0);
        assertTrue("Returned an Ask with quantity not equal 200", ((Ask) result.get(0)).getQuantity() == 200);
        em.clear();
        assertTrue("Unable to em.find() Ask", em.find(Ask.class, ((Ask) result.get(0)).getId()) != null);
        em.close();
    }

    public void testSimpleFindAsk() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        assertTrue("Unable to em.find() Ask", em.find(Ask.class, JPAEnvironment.getGuaranteedId(Ask.class)) != null);
        em.close();

    }

    public void testFindBid() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select b from Bid b where b.quantity < 500").getResultList();
        assertTrue("Unable to find a Bid with quantity < 500", result.size() != 0);
        assertTrue("Returned a Bid with quantity greater than 500", ((Bid) result.get(0)).getQuantity() < 500);
        em.clear();
        assertTrue("Unable to em.find() Bid", em.find(Bid.class, ((Bid) result.get(0)).getId()) != null);
        assertEquals("UOW-finder returns incorrect result", em.find(Bid.class, ((Bid) result.get(0)).getId()), em.find(Bid.class, ((Bid) result.get(0)).getId()));
        em.close();
    }

    public void testFindBroker() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select b from Broker b where b.name = 'John Johnson'").getResultList();
        assertTrue("Unable to find a specific Broker", result.size() != 0);
        em.clear();
        Broker broker = em.find(Broker.class, ((Broker) result.get(0)).getId());
        assertNotNull("Unable to em.find() Broker", broker);
        assertTrue("Broker " + broker.getName() + " has no Qualifications", broker.getQualifications().size() > 0);
        if (!environmentName.contains("ative")) {
            // no map support in native xml
            assertTrue("Broker has incorrect Map contents, size:", broker.getContactInfo().size() == 2);
            assertTrue("Broker has incorrect Map contents, no Work phone", broker.getContactInfo().containsKey("WORK"));
            assertTrue("Broker has incorrect Map contents, no Mobile phone", broker.getContactInfo().containsKey("MOBILE"));
            assertTrue("Broker has incorrect Map contents, no Work phone contact", broker.getContactInfo().get("WORK").equals(new Contact("5555555555")));
            assertTrue("Broker has incorrect Map contents, no Mobile phone contact", broker.getContactInfo().get("MOBILE").equals(new Contact("2222222222")));
            assertTrue("Broker has incorrect Map contents, no Contact contact", broker.getContactContact().get(new Contact("KEY")).equals(new Contact("VALUE")));
        }
        em.close();
    }

    public void testFindBrokerage() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select b from Brokerage b where b.name = 'J,J&J'").getResultList();
        assertTrue("Unable to find a specific Brokerage", result.size() != 0);
        em.clear();
        Brokerage brokerage = em.find(Brokerage.class, ((Brokerage) result.get(0)).getId());
        assertNotNull("Unable to em.find() Broker", brokerage);
        assertTrue("Broker " + brokerage.getName() + " has no brokers", brokerage.getBrokers().size() > 0);
        assertTrue("Broker " + brokerage.getName() + " has no partners", brokerage.getPartners().size() > 0);
        assertTrue("Brokerage " + brokerage.getName() + " has no Attornies", brokerage.getAttornies().size() > 0); 
        em.close();
    }

    public void testFindSecurity() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select s from Security s").getResultList();
        assertTrue("Unable to find a Security", result.size() != 0);
        em.clear();
        assertTrue("Unable to em.find() Bid", em.find(Security.class, ((Security) result.get(0)).getId()) != null);
        em.close();
    }

    public void testUpdateSecurity() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Security result = (Security) em.createQuery("Select s from Security s where s.id = 24").getResultList().get(0);

        for (int i = 0; i < 5; ++i) {
            result = em.find(Security.class, result.getId());
            em.getTransaction().begin();
            result.setName(String.valueOf(System.currentTimeMillis()));
            em.flush();
            result.setName(String.valueOf(System.currentTimeMillis()));
            em.getTransaction().commit();
            em.clear();
        }
    }

    public void testUpdateSecurityWithMerge() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Security result = (Security) em.createQuery("select s from Security s").getResultList().get(0);
        em.clear();
        for (int i = 0; i < 5; ++i) {
            em.getTransaction().begin();
            result.setName(String.valueOf(System.currentTimeMillis()));
            result = em.merge(result); // need to get new version value.
            em.getTransaction().commit();
            em.clear();
        }
    }

    public void testRemoveSecurity() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Security toRemove = new Security();
        toRemove.setExchange("TOREMOVE");
        toRemove.setName("TORE");
        toRemove.setSymbol("TORE");

        em.getTransaction().begin();
        em.persist(toRemove);
        em.getTransaction().commit();
        em.clear();

        em.getTransaction().begin();
        em.remove(em.find(Security.class, toRemove.getId()));
        em.getTransaction().commit();

        em.clear();

        try {
            Security result = (Security) em.createQuery("select s from Security s where s.exchange = 'TOREMOVE' and s.name = " + toRemove.getId()).getSingleResult();
        } catch (Exception ex) {
            assertTrue("Failed to remove Security", (em.find(Security.class, toRemove.getId()) == null));
            return;
        }
        fail("Found removed security");

    }

    public void testProcessTrade() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select b from Bid b where b.quantity > 300").getResultList();
        assertTrue("Unable to find a bid", result.size() != 0);
        Bid bid = (Bid) result.get(0);
        Query query = em.createQuery("Select a from Ask a where a.security.symbol = :symbol and a.quantity <= :quantity");
        query.setParameter("symbol", bid.getSecurity().getSymbol());
        query.setParameter("quantity", bid.getQuantity());
        result = query.getResultList();
        assertTrue("Unable to find an Ask for this bid", result.size() != 0);
        Ask ask = (Ask) result.get(0);
        em.getTransaction().begin();
        bid.setQuantity(bid.getQuantity() - ask.getQuantity());
        Trade trade = new Trade();
        trade.setSecurity(bid.getSecurity());
        trade.setAmount(ask.getAmount());
        trade.setQuantity(ask.getQuantity());
        em.persist(trade);
        em.remove(ask);
        if (bid.getQuantity() <= 0) {
            em.remove(bid);
        }
        em.getTransaction().commit();
        em.close();
        em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        assertTrue("Ask was not deleted.", null == em.find(Ask.class, ask.getId()));
        assertTrue("Trade was not found", null != em.find(Trade.class, trade.getId()));
        Bid newBid = em.find(Bid.class, bid.getId());
        assertTrue("Bid was not updated", null == newBid || newBid.getQuantity() == bid.getQuantity());
        em.close();

    }

    public void testRelationshipQuery() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select a from Ask a where a.security.symbol = 'LKJH'").getResultList();
        assertTrue("Unable to find an Ask with security symbol = 'LKJH'", result.size() != 0);
        assertTrue("Returned an Ask with security symbol not equal 'LKJH'", ((Ask) result.get(0)).getSecurity().getSymbol().equals("LKJH"));
        em.clear();
        assertTrue("Unable to em.find() Ask", em.find(Ask.class, ((Ask) result.get(0)).getId()) != null);
        em.close();
    }

    public void testRemoveAsk() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select s from Security s").getResultList();
        assertTrue("Unable to find a Security", result.size() != 0);
        Ask a = new Ask();
        a.setAmount(5.5);
        a.setQuantity(100);
        a.setSecurity((Security) result.get(0));
        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();
        em.getTransaction().begin();
        em.remove(a);
        em.getTransaction().commit();
        em.clear();
        assertTrue("Found Ask after delete.  Delete failed", em.find(Ask.class, a.getId()) == null);
        em.close();

    }

    public void testAggregateQueries() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Double avg = BigDecimal.valueOf((Double) em.createQuery("select avg(a.amount) from Ask a").getSingleResult()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        Object dbResult = em.createNativeQuery("SELECT AVG(a.amount) from ASK a").getSingleResult();
        Double dbAvg = null;
        if (dbResult != null && dbResult instanceof BigDecimal) {
            dbAvg = ((BigDecimal) dbResult).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        } else {
            dbAvg = BigDecimal.valueOf((Double) dbResult).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
        assertEquals("Different results from ASK amount average", avg, dbAvg);
    }

    public void testMultipleAggregateQueries() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Object[] cohResult = (Object[]) em.createQuery("select avg(a.amount), max(a.amount) from Ask a").getSingleResult();
        Object[] dbResult = (Object[]) em.createNativeQuery("SELECT AVG(a.amount), max(a.amount) from ASK a").getSingleResult();
        Double avg = BigDecimal.valueOf((Double) cohResult[0]).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        Double dbAvg = null;
        if (dbResult != null && dbResult[0] instanceof BigDecimal) {
            dbAvg = ((BigDecimal) dbResult[0]).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        } else {
            dbAvg = BigDecimal.valueOf((Double) dbResult[0]).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
        Double cohMax = (Double) cohResult[1];
        Double dbMax = null;
        if (dbResult[1] instanceof BigDecimal) {
            dbMax = ((BigDecimal) dbResult[1]).doubleValue();
        } else {
            dbMax = (Double) dbResult[1];
        }
        assertEquals("Different results from ASK amount average", avg, dbAvg);
        assertEquals("Different results from ASK amount max", cohMax, dbMax);
    }

    public void testProjectionQueries() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        Double avg = BigDecimal.valueOf((Double) em.createQuery("select AVG(a.amount) from Ask a where a.quantity < 200").getSingleResult()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        Object dbResult = em.createNativeQuery("SELECT AVG(a.amount) from ASK a where a.quantity < 200").getSingleResult();
        Double dbAvg = null;
        if (dbResult != null && dbResult instanceof BigDecimal) {
            dbAvg = ((BigDecimal) dbResult).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        } else {
            dbAvg = BigDecimal.valueOf((Double) dbResult).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
        assertEquals("Different results from ASK amount average", avg, dbAvg);
    }

    public void testMultipleProjectionQueries() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List<Object[]> dbResult = em.createNativeQuery("select a.amount, a.quantity from Ask a where a.quantity < 200").getResultList();
        List<Object[]> cohResult = em.createQuery("select a.amount, a.quantity from Ask a where a.quantity < 200").getResultList();
        assertTrue("The sizes of the results were different. expected: " + dbResult + "coherence: " + cohResult, dbResult.size() == cohResult.size());
        assertTrue("Results were not the same from both database and coherence", compareCollections(dbResult, cohResult));
    }

    public void testLiteralTypes() {
        EntityManager em = JPAEnvironment.getEnvironment(environmentName).getEMF().createEntityManager();
        List result = em.createQuery("select b from Bid b where b.amount < 300").getResultList();
        assertTrue("Unable to find a Bid with amount < 300", result.size() != 0);
        assertTrue("Returned a Bid with amount greater than 300", ((Bid) result.get(0)).getAmount() < 300);
        em.clear();
        assertTrue("Unable to em.find() Bid", em.find(Bid.class, ((Bid) result.get(0)).getId()) != null);
        em.close();
    }

    public static Test suite() {
        TestSuite suite = new TestSuite(Tests.class);

        suite.setName("Tests");

        return new TestSetup(suite) {

            protected void setUp() {
                JPAEnvironment.getEnvironment("coherence-pu").initialize(true, true);
            }

            protected void tearDown() {
                JPAEnvironment.getEnvironment("coherence-pu").release();
            }
        };
    }

    protected boolean compareCollections(List<Object[]> first, List<Object[]> second) {
        for (Object[] firstElement : first) {
            boolean found = false;
            for (Object[] secondElement : second) {
                if (compareArrays(firstElement, secondElement)) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                return false;
            }
        }
        return true;
    }

    public boolean compareArrays(Object[] array1, Object[] array2) {
        if (array1.length != array2.length) {
            return false;
        }
        for (int index = 0; index < array1.length; index++) {
            // Related to Bug#3128838 fix. ! is added to correct the logic.
            Object obj1 = array1[index];
            Object obj2 = array2[index];
            if (!obj1.getClass().equals(obj2)) {
                if (obj2 instanceof Double) {
                    obj2 = BigDecimal.valueOf((Double) obj2);
                } else if (obj2 instanceof Integer) {
                    obj2 = BigDecimal.valueOf((Integer) obj2);
                }
                obj1 = ((BigDecimal) obj1).setScale(((BigDecimal) obj2).scale(), BigDecimal.ROUND_HALF_UP);
            }
            if (!obj1.equals(obj2)) {
                return false;
            }
        }
        return true;
    }

}
