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

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.AfterClass;

/**
 * Base test case for testing a JPA persistence unit in JavaSE using JUnit4.
 * 
 * @author dclarke
 * @since EclipseLink 1.0
 */
public abstract class EclipseLinkJPATest {

	/**
	 * This is he current EMF in use
	 */
	private static EntityManagerFactory emf;

	public EntityManagerFactory getEMF() {
		if (emf == null) {
			emf = createEMF();
		}

		return emf;
	}

	private EntityManagerFactory createEMF() {
		try {
			return Persistence.createEntityManagerFactory("employee");
		} catch (RuntimeException e) {
			System.out.println("Persistence.createEMF FAILED: "
					+ e.getMessage());
			e.printStackTrace();
			throw e;
		}
	}

	@After
	public void cleanupClosedEMF() {
		if (emf != null && !emf.isOpen()) {
			emf = null;
		}
	}

	@AfterClass
	public static void closeEMF() throws Exception {
		if (emf != null && emf.isOpen()) {
			emf.close();
			emf = null;
		}
	}

}
