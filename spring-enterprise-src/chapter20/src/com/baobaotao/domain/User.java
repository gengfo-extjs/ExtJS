package com.baobaotao.domain;

import java.util.List;
import java.util.Map;

public class User {
	private String userName;
	private String password;
	private String email;
	private String desc;
	private int times;
	private int sex;
	private List favorites;
	private String city;
	public List getFavorites() {
		return favorites;
	}
	public void setFavorites(List favorites) {
		this.favorites = favorites;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getTimes() {
		return times;
	}
	public void setTimes(int times) {
		this.times = times;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
}
