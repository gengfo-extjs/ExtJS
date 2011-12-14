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

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import junit.framework.Assert;
import model.Employee;
import model.Gender;
import model.Project;

import org.eclipse.persistence.config.QueryHints;
import org.junit.Test;

/**
 * These test cases illustrate EclipseLink JPA query features.
 * 
 * 
 * These examples work best when using dynamic weaving enabled in JavaSE through
 * the use of the:
 * 
 * "-javaagent:{path}/eclipselink.jar"
 * 
 * @author dclarke
 * @since EclipseLink 1.0
 */
public class QueryExamples extends EclipseLinkJPATest {

	/**
	 * Simple example using dynamic JP QL to retrieve all Employee instances
	 * sorted by lastName and firstName. The resulting set of employees is then
	 * printed out with their related address and phone numbers. The result of
	 * this is a large quantity of SQL. The following test cases illustrate how
	 * this can be optimized.
	 */
	@Test
	public void readAllEmployees() {
		EntityManager em = getEMF().createEntityManager();

		List<Employee> emps = em.createQuery(
				"SELECT e FROM Employee e WHERE e.firstName LIKE '%'")
				.getResultList();

		Assert.assertNotNull(emps);
		for (Employee emp : emps) {
			System.out.println(emp.toDetailedString());
		}

		em.close();
	}

	/**
	 * Read in all employees using a JOIN FETCH on the address and phone numbers.
	 * the result (with weaving) will be 1 SQL statement.
	 * 
	 * Note: With joining across a 1:M the DISTINCT is required to get a unique set of results
	 */
	@Test
	public void readAllEmployeesWithJoinFetch() {
		EntityManager em = getEMF().createEntityManager();

		List<Employee> emps = em
				.createQuery(
						"SELECT DISTINCT e FROM Employee e JOIN FETCH e.address JOIN FETCH e.phoneNumbers ORDER BY e.lastName ASC, e.firstName ASC")
				.getResultList();

		Assert.assertNotNull(emps);
		for (Employee emp : emps) {
			System.out.println(emp.toDetailedString());
		}

		em.close();
	}

	/**
	 * Simple example using dynamic JP QL to retrieve all Employee instances
	 * sorted by lastName and firstName.
	 */
	@Test
	public void readAllEmployeesWithJoinAndBatch() {
		EntityManager em = getEMF().createEntityManager();

		List<Employee> emps = em
				.createQuery(
						"SELECT e FROM Employee e ORDER BY e.lastName ASC, e.firstName ASC")
				.setHint(QueryHints.BATCH, "e.phoneNumbers").setHint(
						QueryHints.FETCH, "e.address").getResultList();

		Assert.assertNotNull(emps);
		for (Employee emp : emps) {
			System.out.println(emp.toDetailedString());
		}

		em.close();
	}

	@Test
	public void testLazyLoading() {
		EntityManager em = getEMF().createEntityManager();

		Employee emp = em.find(Employee.class, 1);
		Assert.assertNotNull(emp);

		em.close();
	}

	@Test
	public void findEmployeesByGender() throws Exception {
		EntityManager em = getEMF().createEntityManager();

		List<Employee> emps = em
				.createQuery(
						"SELECT e FROM Employee e WHERE e.gender IN (:GENDER1, :GENDER2)")
				.setParameter("GENDER1", Gender.Male).setParameter("GENDER2",
						Gender.Female).getResultList();

		Assert.assertNotNull(emps);

		em.close();
	}

	@Test
	public void inheritanceQuery() throws Exception {
		EntityManager em = getEMF().createEntityManager();

		Query query = em
				.createQuery("SELECT p FROM Project p, Employee e WHERE p.teamLeader.id = e.id AND e.firstName = 'Charles' AND e.lastName = 'Chanley'");
		// query.setMaxResults(1);

		List<Project> projects = query.getResultList();

		Assert.assertNotNull(projects);
		Assert.assertEquals(projects.size(), 2);

		em.close();
	}
}
