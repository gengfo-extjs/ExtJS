package gridcache.example;

import gridcache.model.Address;
import gridcache.model.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class InsertExample {
	
	public static void main(String[] args) {
		// Configure Single Server Mode 
		// http://download.oracle.com/docs/cd/E15357_01/coh.360/e15723/cluster_singleserver.htm#sthref19
		System.setProperty("tangosol.coherence.localhost","127.0.0.1");
		System.setProperty("tangosol.coherence.ttl","0");
		// Disable local storage--need to start independent CacheServer
		System.setProperty("tangosol.coherence.distributed.localstorage","false");
		
		EntityManagerFactory emf = Persistence
				.createEntityManagerFactory("employee-pu");

		// Create an Employee with an Address and PhoneNumber
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		Employee employee = createEmployee();
		em.persist(employee);
		em.getTransaction().commit();		
		em.close();	
		emf.close();
	}

	public static Employee createEmployee() {
		Employee employee = new Employee();
		employee.setFirstName("Bob");
		employee.setLastName("Smith");

		Address address = new Address();
		address.setCity("Toronto");
		address.setPostalCode("L5J2B5");
		address.setProvince("ONT");
		address.setStreet("1450 Acme Cr., Suite 4");
		address.setCountry("Canada");
		employee.setAddress(address);
		
		employee.addPhoneNumber("Work", "613", "5558812");

		return employee;
	}
}
