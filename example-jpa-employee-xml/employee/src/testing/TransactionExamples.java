/*******************************************************************************
 * Copyright (c) 1998, 2008 Oracle. All rights reserved.
 * This program and the accompanying materials are made available under the 
 * terms of the Eclipse Public License v1.0 and Eclipse Distribution License v. 1.0 
 * which accompanies this distribution. 
 * The Eclipse Public License is available at http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at 
 * http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 * 		dclarke - initial JPA Employee example using XML (bug 217884)
 ******************************************************************************/
package testing;

import javax.persistence.EntityManager;
import javax.persistence.FlushModeType;

import junit.framework.Assert;

import model.Address;
import model.Employee;
import model.Gender;
import model.PhoneNumber;

import org.eclipse.persistence.config.PessimisticLock;
import org.eclipse.persistence.config.QueryHints;
import org.junit.Test;

/**
 * Set of test case examples illustrating common EclipseLink JPA transaction
 * usage in JavaSE.
 * 
 * @author djclarke
 * @since Eclipselink 1.0
 */
public class TransactionExamples extends EclipseLinkJPATest {

	/**
	 * Create a new Employee with related new address & phones relying on
	 * cascade persist configuration on these mappings. The new employee will
	 * also be connected to an existing employee
	 */
	@Test
	public void createNewEmployee() throws Exception {
		EntityManager em = getEMF().createEntityManager();

		em.getTransaction().begin();

		// Set the flush-mode so the manager query does not force a write before
		// the read.
		em.setFlushMode(FlushModeType.COMMIT);

		Employee emp = new Employee();
		emp.setFirstName("John");
		emp.setLastName("Doe");
		emp.setGender(Gender.Male);
		emp.setSalary(10000);

		Address newAddr = new Address();
		newAddr.setStreet("123 Anywhere Avenue");
		newAddr.setStreet("Confusion");

		PhoneNumber newPhone = new PhoneNumber("Cell", "650", "555-1212");

		emp.setAddress(newAddr);
		emp.addPhoneNumber(newPhone);

		em.persist(emp);

		Employee manager = (Employee) em
				.createQuery(
						"SELECT e FROM Employee e WHERE e.firstName = 'Jill' AND e.lastName = 'May'")
				.getSingleResult();

		Assert.assertNotNull(manager);

		manager.addManagedEmployee(emp);

		// This will cause the 3 inserts to occur
		em.flush();

		em.getTransaction().rollback();

	}

	@Test
	public void pessimisticLocking() throws Exception {
		EntityManager em = getEMF().createEntityManager();

		em.getTransaction().begin();

		// Lock Employee using query with hint
		Employee emp = (Employee) em.createQuery(
				"SELECT e FROM Employee e WHERE e.firstName = 'Jill' AND e.lastName = 'May'").
				setHint(QueryHints.PESSIMISTIC_LOCK,PessimisticLock.Lock).
				getSingleResult();

		emp.setSalary(emp.getSalary() + 1);

		em.getTransaction().commit();
	}
}
