package testing;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.metamodel.Attribute;
import javax.persistence.metamodel.EmbeddableType;
import javax.persistence.metamodel.EntityType;
import javax.persistence.metamodel.ManagedType;
import javax.persistence.metamodel.Metamodel;

import junit.framework.Assert;
import model.Employee;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class MyAppTest extends EclipseLinkJPATest {
	
	public static Logger logger = LogManager.getLogger(MyAppTest.class);
	
	public static void amain(String args[]) {
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("employee");
		
		EntityManager em = emf.createEntityManager();
		
		

		List<Employee> emps = em.createQuery(
				"SELECT e.salary,e.lastName FROM Employee e WHERE e.id = '21'")
				.getResultList();
		
		
		
		logger.debug("Done");
		
		

		Assert.assertNotNull(emps);
		
	}

	public static void main(String args[]) {

		EntityManagerFactory emf = Persistence
				.createEntityManagerFactory("employee");
		
		emf.getMetamodel();

		EntityManager em = emf.createEntityManager();
		
		Metamodel model = em.getMetamodel();
		
		Set<EntityType<?>> a = model.getEntities();
		Iterator it = a.iterator();
		while (it.hasNext()){
			EntityType et = (EntityType)it.next();
			
			logger.debug("getBindableJavaType() -> " +et.getBindableJavaType().getName());
			logger.debug("getBindableType() -> " +et.getBindableType());
			logger.debug("getIdType() -> " +et.getIdType());
			
			
			
			
			
			System.out.println("------------------"+et.getName()+"------------------");
			Set at =  et.getAttributes();
			et.getPersistenceType();
			Iterator itat = at.iterator();
			while (itat.hasNext()){
				Attribute attr = (Attribute)itat.next();
				
				System.out.print("name " + attr.getName());
				
				System.out.println(" getDeclaringType " +attr.getDeclaringType());
				System.out.println(" class " +attr.getJavaMember());
				
				
			}
		}
		
		Set<EmbeddableType<?>> b = model.getEmbeddables();
		
		Set<ManagedType<?>> c = model.getManagedTypes();
		
		
		
		System.out.println("Done");

	}

}
