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
 * 	    ssmith  - mapped using annotations and simplified
 ******************************************************************************/
package gridcache.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

import oracle.eclipselink.coherence.integrated.cache.CoherenceInterceptor;

import org.eclipse.persistence.annotations.CacheInterceptor;

@Entity
@Table(name="TLG_GC_ADDRESS")
@CacheInterceptor(CoherenceInterceptor.class)
public class Address implements Serializable {
	private static final long serialVersionUID = 6715878993874634402L;

	@Id
	@GeneratedValue
	private int id;
	private String city;
	
	private String country;
	private String province;
	private String postalCode;
	private String street; 
	@Version
	private long version;

	public Address() {
	}

	public long getVersion() {
		return version;
	}

	public int getId() {
		return this.id;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPostalCode() {
		return this.postalCode;
	}

	public void setPostalCode(String pCode) {
		this.postalCode = pCode;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}
	
	@Override
	public String toString() {
		return "Address(" + getId() + ": " + getCity() + ", " + getCountry() + ")";
	}
}
