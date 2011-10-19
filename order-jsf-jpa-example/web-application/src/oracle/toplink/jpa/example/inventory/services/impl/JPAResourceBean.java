package oracle.toplink.jpa.example.inventory.services.impl;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * This is an Application Scoped bean that holds the JPA 
 * EntityManagerFactory.  By making this bean Applciation scoped the 
 * EntityManagerFactory resource will be created only once for the application
 * and cached here.
 *
 *@author Gordon Yorke
 */
 public class JPAResourceBean {

    protected EntityManagerFactory emf;

    /*
     * Lazily acquire the EntityManagerFactory and cache it.
     */
     public EntityManagerFactory getEMF (){
        if (emf == null){
            emf = Persistence.createEntityManagerFactory("default", new java.util.HashMap());
        }
        return emf;
    }
}
