package com.baobaotao.model;


/**
 * 产品.带jpa与hibernate扩展的annotation 及compass annotation.
 *
 * @author cac
 * @author schweigen
 */


public class Product {
	private static final int SHORT_DESCN_LENGTH = 200;


	private Integer id;


	private Category category;

	private Integer inventory;


	private String name;

	private String descn;

	private Double unitprice=0.0;

	private String status = null;//UndeleteableEntityOperation.NORMAL_VALUE;

	private String shortDescn = null;


	public Category getCategory() {
		return this.category;
	}

	public String getDescn() {
		return this.descn;
	}


	public Integer getId() {
		return id;
	}

	public Integer getInventory() {
		return this.inventory;
	}

	public String getName() {
		return this.name;
	}


	public String getShortDescn() {
		if (shortDescn == null) {
//			shortDescn = StringUtils.substring(descn, 0, SHORT_DESCN_LENGTH) + "...";
		}
		return shortDescn;
	}

	public String getStatus() {
		return this.status;
	}

	public Double getUnitprice() {
		return this.unitprice;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setInventory(Integer inventory) {
		this.inventory = inventory;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setShortDescn(String shortDescn) {
		this.shortDescn = shortDescn;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setUnitprice(Double unitprice) {
		this.unitprice = unitprice;
	}
}
