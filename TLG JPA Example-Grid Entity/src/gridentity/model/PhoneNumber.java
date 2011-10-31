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
package gridentity.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Version;

import oracle.eclipselink.coherence.integrated.config.CoherenceReadWriteCustomizer;

import org.eclipse.persistence.annotations.Customizer;

@Entity
@Table(name="TLG_GE_PHONE")
@Customizer(CoherenceReadWriteCustomizer.class)
public class PhoneNumber implements Serializable {
	private static final long serialVersionUID = -599329001060932771L;

	@Id
	@GeneratedValue
	private int id;
	private String areaCode;
	@Column(name="NUM")
	private String number;
	private String type;
	@ManyToOne(fetch=FetchType.LAZY)
	private Employee owner;
	@Version
	private long version;

	public PhoneNumber() {
	}

	public PhoneNumber(String type, String areaCode, String number) {
		this();
		setType(type);
		setAreaCode(areaCode);
		setNumber(number);
	}

	public long getVersion() {
		return version;
	}

	public String getAreaCode() { 
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public int getId() {
		return this.id;
	}

	public String getNumber() {
		return this.number;
	}

	public void setNumber(String pNumber) {
		this.number = pNumber;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Employee getOwner() {
		return this.owner;
	}

	public void setOwner(Employee employee) {
		this.owner = employee;
		if (employee == null) {
			this.id = 0;
		} else {
			this.id = employee.getId();
		}
	}

	@Override
	public String toString() {
		return "PhoneNumber(" + getId() + ": " + getAreaCode() + "-" + getNumber() + ")";
	}
}
