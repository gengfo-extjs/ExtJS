package com.baobaotao.domain;

import java.util.List;

public class FullUser {
	private String userName;
	private String password;
	private String email;
	private String address;
	private String telephone;
	private List favorites;
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public List getFavorites() {
		return favorites;
	}
	public void setFavorites(List favorites) {
		this.favorites = favorites;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
