package oracle.toplink.jpa.example.inventory.tools;

import java.sql.Date;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import oracle.toplink.jpa.example.inventory.model.Inventory;
import oracle.toplink.jpa.example.inventory.model.Item;
import oracle.toplink.jpa.example.inventory.model.Order;

/**
 * This utility class demonstrates a simple way to have TopLink populate the 
 * sample data to the test database using JPA.
 *
 * @author Gordon Yorke
 */
public class Populator {
    public static void main(String args[]){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("default", new java.util.HashMap());
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Populator.populate(em);
        em.getTransaction().commit();
        em.close();
        emf.close();
    }
    
    public static void populate(EntityManager em){
        Item item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("120GB HardDrive");
        item1.setName("HardDrive120");
        Inventory inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(50.00);
        inv.setPrice(55.0);
        inv.setQuantity(5);
        em.persist(inv);
        
        Order order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);
        
        item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("400GB HardDrive");
        item1.setName("HardDrive400");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(240.00);
        inv.setPrice(245.0);
        inv.setQuantity(3);
        em.persist(inv);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("80GB HardDrive");
        item1.setName("HardDrive80");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(40.00);
        inv.setPrice(45.0);
        inv.setQuantity(3);
        em.persist(inv);
        
        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("1.7 Ghz Yorez CPU");
        item1.setName("Yorez17");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(240.00);
        inv.setPrice(245.0);
        inv.setQuantity(3);
        em.persist(inv);
        
        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("4.0 Ghz Yorez CPU");
        item1.setName("Yorez40");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(840.00);
        inv.setPrice(945.0);
        inv.setQuantity(3);
        em.persist(inv);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Component");
        item1.setDescription("3.2 Ghz Yorez brand CPU");
        item1.setName("Yorez32");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(350.00);
        inv.setPrice(355.0);
        inv.setQuantity(2);
        em.persist(inv);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Upgrades");
        item1.setDescription("1 MB DIMM ram chip");
        item1.setName("DIMM1");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(150.00);
        inv.setPrice(155.0);
        inv.setQuantity(5);
        em.persist(inv);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Peripheral");
        item1.setDescription("SWGA+ 19 inch Monitor");
        item1.setName("swga19");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(550.00);
        inv.setPrice(555.0);
        inv.setQuantity(5);
        em.persist(inv);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

        item1 = new Item();
        item1.setCategory("Peripheral");
        item1.setDescription("360 DPI Dotmaxtrix Printer");
        item1.setName("DotMaxOld");
        inv = new Inventory();
        em.persist(item1);
        //set item in inventory after persist to ensure an id is available in
        //item for the foreign key value
        inv.setItem(item1);
        inv.setCost(5.00);
        inv.setPrice(5.50);
        inv.setQuantity(2);
        em.persist(inv);
        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-500000000));
        order.setQuantity(8);
        em.persist(order);

        order = new Order();
        order.setItem(item1);
        order.setOrderInitiated(new Date(System.currentTimeMillis()-800000000));
        order.setArrivalDate(new Date(System.currentTimeMillis()+200000000));
        order.setCurrentLocation("In Transit");
        order.setQuantity(2);
        em.persist(order);

    }
}
