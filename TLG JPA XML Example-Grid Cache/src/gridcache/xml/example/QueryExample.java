package gridcache.xml.example;

import gridcache.xml.model.Employee;
import gridcache.xml.model.PhoneNumber;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class QueryExample {

	public static void main(String[] args) {
		// Configure Single Server Mode 
		// http://download.oracle.com/docs/cd/E15357_01/coh.360/e15723/cluster_singleserver.htm#sthref19
		System.setProperty("tangosol.coherence.localhost","127.0.0.1");
		System.setProperty("tangosol.coherence.ttl","0");
		// Disable local storage--need to start independent CacheServer
		System.setProperty("tangosol.coherence.distributed.localstorage","false");

		EntityManagerFactory emf = Persistence
				.createEntityManagerFactory("employee-pu");
		EntityManager em = emf.createEntityManager();
		List<Employee> employees = em
			.createNamedQuery("Employee.findByLastNameLike", Employee.class)
			.setParameter("lastName", "Smit%")
			.getResultList();
		
		for (Employee employee : employees) {
			System.err.println(employee);
			for (PhoneNumber phone : employee.getPhoneNumbers()) {
				System.err.println("\t" + phone);
			}
		}
		emf.close();
	}
}
