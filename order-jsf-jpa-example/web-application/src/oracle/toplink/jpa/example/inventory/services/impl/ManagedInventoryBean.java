package oracle.toplink.jpa.example.inventory.services.impl;

import java.util.Collection;

import javax.persistence.EntityManager;

import javax.persistence.Query;

import oracle.toplink.jpa.example.inventory.nonentity.Category;
import oracle.toplink.jpa.example.inventory.model.Inventory;
import oracle.toplink.jpa.example.inventory.model.Item;
import oracle.toplink.jpa.example.inventory.model.Order;
import oracle.toplink.jpa.example.inventory.services.InventoryService;

/**
 * This is the JSF Managed Bean implementation of the InventoryService.  The 
 * PersistenceProvider is accessed through the JPAResourceBean which will be
 * 'injected' as a JSF managed bean.
 *
 * @author Gordon Yorke
 */
 public class ManagedInventoryBean implements InventoryService{

    //stores a reference to global EMF for acquiring EM
    protected JPAResourceBean jpaResourceBean;
    

    public ManagedInventoryBean() {
    }

    //Returns a list of available item categories
    public Collection<Category> getCategories(){
        //Create an EntityManager from the Factory stored in the JPAResourceBean
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        
        try{
            //execute a JPQL query that collects summary data and stores it in a
            //non-entity class Category.  This query will pass the results  of the
            //query into the constructor of Category and return a list of Category
            //objects
            Collection<Category> result = em.createQuery("Select new oracle.toplink.jpa.example.inventory.nonentity.Category(i.category) from Item i group by i.category").getResultList();
            return result;
        }finally{
            em.close();
        }
    }

    //Returns a list of available item categories
    public Collection<Inventory> getInventoryForCategoryMaxQuantity(String category, int quantity){
        EntityManager em = jpaResourceBean.getEMF().createEntityManager();
        try{
            //create an instance of the NamedQuery defined in the Inventory class.
            Query query = em.createNamedQuery("inventoryForCategory");
            //setting the provided parameters on the query
            query.setParameter("category", category);
            query.setParameter("maxQuantity", quantity);
            //return the results.
            return query.getResultList();
        }finally{
            em.close();
        }
    }

    //These are standard bean property accessors.
    public void setJpaResourceBean(JPAResourceBean jpaResourceBean) {
        this.jpaResourceBean = jpaResourceBean;
    }

    public JPAResourceBean getJpaResourceBean() {
        return jpaResourceBean;
    }
}
