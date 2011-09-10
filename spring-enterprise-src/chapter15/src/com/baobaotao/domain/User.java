package com.baobaotao.domain;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class User implements Serializable{
	private String userName;
	private String userId;
	private int level;
	private String email;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
}
