package com.baobaotao.web.user;

import com.baobaotao.domain.User;
import com.baobaotao.service.BbtForum;
import com.opensymphony.xwork2.ActionSupport;

public class UserRegisterAction extends ActionSupport {
	private BbtForum bbtForum;
	private User user;
	@Override
	public String execute() throws Exception {
		if (user == null) {
			user = new User();
			return INPUT;
		} else {
			System.out.println("user:"+user);
			bbtForum.registerUser(user);
			return SUCCESS;
		}
	}
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User getUser() {
		return user;
	}
}
