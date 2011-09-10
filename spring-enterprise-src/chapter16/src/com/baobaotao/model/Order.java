package com.baobaotao.model;

import java.util.Date;
import java.util.List;

/**
 * 订单.带jpa 与hibernate扩展的annotation配置.
 *
 * @author cac
 * @author calvin
 * @author schweigen
 */

public class Order {

	public static final String STATUS_ORDERED = "1";

	public static final String STATUS_SHIPPED = "2";

	private Integer id;

	private Customer customer;

	private List<OrderItem> orderItems;

	private Date orderDate;

	/**
	 * 送货地区
	 */
	private String region;

	private String shipAddress;

	/**
	 * 实际售价
	 */
	private Double totalPrice;

	private Date shipDate;

	private String status;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Date getOrderDate() {
		return this.orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getShipAddress() {
		return this.shipAddress;
	}

	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}

	public Double getTotalPrice() {
		return this.totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Date getShipDate() {
		return this.shipDate;
	}

	public void setShipDate(Date shipDate) {
		this.shipDate = shipDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public List<OrderItem> getOrderItems() {
		return this.orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	/**
	 * 取得直接价格合计，未计算促销.
	 */
	public Double subTotalPrice() {
		Double subTotal = (double) 0;
		for (OrderItem item : orderItems) {
			//subTotal = NumberUtils.add(subTotal, NumberUtils.multiply(item.getUnitprice(), item.getQuantity()));
		}
		return subTotal;
	}
}
