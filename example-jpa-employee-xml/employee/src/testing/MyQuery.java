package testing;

import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import model.Employee;
import model.Project;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.eclipse.persistence.expressions.Expression;
import org.eclipse.persistence.expressions.ExpressionBuilder;
import org.eclipse.persistence.jpa.JpaEntityManager;
import org.eclipse.persistence.jpa.JpaHelper;

public class MyQuery {
	public static Logger logger = LogManager.getLogger(MyQuery.class);

	private EntityManagerFactory emf = Persistence
			.createEntityManagerFactory("employee");

	private EntityManager em = emf.createEntityManager();

	public void createEmployee(String fName, String lName) {
		em.getTransaction().begin();
		Employee employee = new Employee();
		employee.setFirstName(fName);
		employee.setLastName(lName);
		em.persist(employee);
		em.flush();
		em.getTransaction().commit();
	}

	public void findEmployee() {

		Employee emp = (Employee) em.find(Employee.class, 21);

		logger.debug("lastname-> " + emp.getLastName());
	}

	public void findProjectWithName1(String name) {
		Project project = (Project) em
				.createQuery(
						"SELECT OBJECT(project) FROM Project project WHERE project.name = :projectName")
				.setParameter("projectName", name).getSingleResult();
		logger.debug(project.getName());
	}

	public Collection findLargeProjectsWithBudgetLargerThan(double budget) {
		Collection projects = em.createNamedQuery("findWithBudgetLargerThan")
				.setParameter("amount", budget).getResultList();
		return projects;
	}

	public Collection findProjectsWithName(String name) {
		ExpressionBuilder builder = new ExpressionBuilder();
		Expression ex1 = builder.get("name");
		Expression ex2 = builder.getParameter("projectName");
		Expression ex3 = ex1.equal(ex2);

		JpaEntityManager jpaEm = JpaHelper.getEntityManager(em);
		Query query = jpaEm.createQuery(ex3, Project.class);
		query.setParameter("projectName", name);
		Collection projects = query.getResultList();
		logger.debug(" projects " + projects.size());
		
		return projects;
	}

	public static void main(String args[]) {

		MyQuery mq = new MyQuery();
		//mq.findEmployee();

		 mq.createEmployee("gengfo", "test");
		//mq.findProjectWithName1("TOPEmployee Management");

		// mq.findLargeProjectsWithBudgetLargerThan(1);
		
		//mq.findProjectsWithName("TOPEmployee Management");
		
		logger.debug("Done!");

	}
}
