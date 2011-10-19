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

import static org.eclipse.persistence.config.PersistenceUnitProperties.DDL_GENERATION;
import static org.eclipse.persistence.config.PersistenceUnitProperties.DROP_AND_CREATE;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.*;

import model.SamplePopulation;

import org.eclipse.persistence.jpa.JpaHelper;
import org.eclipse.persistence.tools.schemaframework.SchemaManager;

/**
 * Utility class to create the database schema and populate it for the Employee
 * JPA example using XML configuration. This
 * 
 * @author dclarke
 * @since EclipseLink 1.0
 */
public class CreateDatabase {

	public static void main(String[] args) {
		Map properties = new HashMap();

		// Add in properties to have the database re-created
		properties.put(DDL_GENERATION, DROP_AND_CREATE);
		// properties.put(TARGET_DATABASE, TargetDatabase.Oracle10);

		EntityManagerFactory emf = Persistence
				.createEntityManagerFactory("employee", properties);

		EntityManager em = emf.createEntityManager();
		new SchemaManager(JpaHelper.getServerSession(emf)).createSequences();

		em.getTransaction().begin();

		new SamplePopulation().persistAll(em);

		em.getTransaction().commit();

		em.close();
	}
}
