package oracle.toplink.jpa.example.inventory.services.impl;

import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import oracle.toplink.jpa.example.inventory.model.Item;
import oracle.toplink.jpa.example.inventory.model.Order;
import oracle.toplink.jpa.example.inventory.services.OrderService;

/**
 * This is the JSF Managed Bean implementation of the OrderService.  The 
 * PersistenceProvider is accessed through the JPAResourceBean which will be
 * 'injected' as a JSF managed bean.
 *
 * @author Gordon Yorke
 */
public class ManagedOrderBean implements OrderService{

    //stores a reference to global EMF for acquiring EM
    protected JPAResourceBean jpaResourceBean;
    
    // Returns those orders that have a set arrival date indicating that they have shipped
    public Collection<Order> getShippedOrdersForItem(long itemId){
        //Create an EntityManager from the Factory stored in the JPAResourceBean
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            //create an instance of the NamedQuery defined in the Inventory class.
            Query query = em.createNamedQuery("shippedOrdersForItem");
            //setting the provided parameters on the query
            query.setParameter("itemId", itemId);
            //return result of query
            return query.getResultList();
        }finally{
            em.close();
        }
    }

    // Returns those orders that have a set arrival date indicating that they have shipped
    public Collection<Order> getPendingOrdersForItem(long itemId){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            Query query = em.createNamedQuery("pendingOrdersForItem");
            query.setParameter("itemId", itemId);
            return query.getResultList();
        }finally{
            em.close();
        }
    }
    
    // request that an order be canceled.  Assume success if no exception is thrown
    public void requestCancelOrder(long orderId){
           //Create an EntityManager from the Factory stored in the JPAResourceBean
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            //changes will be made so begin a transaction
            em.getTransaction().begin();
            //find the order that will be deleted.  This step ensures the order
            //will be managed as the specification requires the object be
            //managed before remove can be called.
            Order order = em.find(Order.class, orderId);
            //set the order to be delet4ed
            em.remove(order);
            //commit the transaction, this will cause the the delete SQL to be
            //sent to the database.
            em.getTransaction().commit();
        }finally{
            em.close();
        }
    }
    
    // request that an order be canceled assume success if no exception is thrown
    public void alterOrderQuantity(long orderId, int newQuantity){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            em.getTransaction().begin();
            //ensure that this order is a managed object.
            Order order = em.find(Order.class, orderId);
            //update the order object directly
            order.setQuantity(newQuantity);
            //commit the transaction to have the update sent to the database
            em.getTransaction().commit();
        }finally{
            em.close();
        }
    }
    
    // Create a new order request for a particular item;
    public void  createNewOrder(Order order){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            em.getTransaction().begin();
            //calling persist on the order object will mark the object as new
            //within the persistence context.
            em.persist(order);
            //commit the transaction to have the object data inserted to the 
            //database
            em.getTransaction().commit();
        }finally{
            em.close();
        }
    }
    
    // finds a particular order by the specified order id
    public Order getOrderById(long orderId){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            return em.find(Order.class, orderId);
        }finally{
            em.close();
        }
    }

    // finds a particular order by the specified order id
    public Item getItemById(long itemId){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            return em.find(Item.class, itemId);
        }finally{
            em.close();
        }
    }

    public void setJpaResourceBean(JPAResourceBean jpaResourceBean) {
        this.jpaResourceBean = jpaResourceBean;
    }

    public JPAResourceBean getJpaResourceBean() {
        return jpaResourceBean;
    }
}
