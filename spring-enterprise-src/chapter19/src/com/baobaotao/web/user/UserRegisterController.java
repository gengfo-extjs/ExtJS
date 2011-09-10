package com.baobaotao.web.user;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.baobaotao.domain.User;
import com.baobaotao.service.BbtForum;

public class UserRegisterController extends SimpleFormController {
	private BbtForum bbtForum;
	public UserRegisterController() {
		setCommandClass(User.class);
	}
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}

	 protected Object formBackingObject(HttpServletRequest request)
			throws Exception {
		int userId = ServletRequestUtils.getIntParameter(request, "userId",-1);
		User user = bbtForum.getUser(userId);
		user.setUserName("user1");
		return user;
	}
	// @Override
	// protected void doSubmitAction(Object command) throws Exception {
	// User user = (User) command;
	// bbtForum.registerUser(user);
	// }
	@Override
	protected ModelAndView onSubmit(Object command, BindException errors)
			throws Exception {
		User user = (User) command;
		bbtForum.registerUser(user);
		return new ModelAndView(getSuccessView(), "user", user);
	}

	@Override
	protected void onBindAndValidate(HttpServletRequest request,
			Object command, BindException errors) throws Exception {
		User user = (User) command;
		if (bbtForum.isExsitUserName(user.getUserName())) {
			errors.rejectValue("userName", "exists.userName", "用户名已经存在");
		}
	}
}
