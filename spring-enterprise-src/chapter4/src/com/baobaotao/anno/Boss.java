package com.baobaotao.anno;

import org.springframework.beans.factory.annotation.Autowired;

import com.baobaotao.attr.Car;
import com.baobaotao.auto.Office;

public class Boss {
	private Title title;
	@Autowired
	private Car car;
	private Office office;
	
    @Autowired
	public Boss(Title title) {
		this.title = title;
	}
	public void setCar(Car car) {
		this.car = car;
	}
    public Title getTitle() {
		return title;
	}
	public void setTitle(Title title) {
		this.title = title;
	}
	public Car getCar() {
		return car;
	}
	public Office getOffice() {
		return office;
	}
	@Autowired
	public void setOffice(Office office) {
		this.office = office;
	}
}
