package com.baobaotao.model;

import java.util.Set;

public class Category {
	private Integer id;

	private Set products;


	private String name;


	private String descn;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescn() {
		return this.descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}


	public Set getProducts() {
		return this.products;
	}

	public void setProducts(Set products) {
		this.products = products;
	}
}
