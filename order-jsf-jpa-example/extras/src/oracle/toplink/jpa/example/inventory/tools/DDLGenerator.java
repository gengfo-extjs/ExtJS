package oracle.toplink.jpa.example.inventory.tools;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * This utility class demonstrates a simple way to have TopLink generate the
 * database schema by passing the toplink.ddl-generation flag on create of
 * EntityManagerFactory.
 *
 * @author Gordon Yorke
 */
 public class DDLGenerator {
    public DDLGenerator() {
    }
    public static void main(String args[]){
        Map properties = new HashMap();
        properties.put("toplink.ddl-generation", "drop-and-create-tables");
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("default", properties);
        emf.createEntityManager().close();
        emf.close();
    }
}
