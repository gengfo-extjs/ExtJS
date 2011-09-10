package com.baobaotao.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;

import com.baobaotao.domain.User;
import com.baobaotao.service.UserService;

public class LoginController extends AbstractCommandController {
	private UserService userService;

	public LoginController() {
		setCommandClass(LoginCommand.class);
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		LoginCommand loginCommand = (LoginCommand) command;
		boolean isValidUser = userService.hasMatchUser(loginCommand
				.getUserName(), loginCommand.getPassword());
		if (!isValidUser) {
			return new ModelAndView("login", "error", "用户名或密码错误。");
		} else {
			User user = userService.findUserByUserName(loginCommand
					.getUserName());
			user.setLastIp(request.getLocalAddr());
			user.setLastVisit(new Date());
			userService.loginSuccess(user);
			request.getSession().setAttribute("user", user);
			return new ModelAndView("main");
		}
	}
}
