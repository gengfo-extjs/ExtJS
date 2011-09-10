package com.baobaotao.test;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.User;
import com.baobaotao.service.UserService;

public class DependencyInjectionCtxTest
		extends
			AbstractDependencyInjectionSpringContextTests {
	protected UserService userService;
	
//	public void setUserService(UserService userService) {
//		this.userService = userService;
//	}
	protected User user;
//	public void setUser(User user) {
//		this.user = user;
//	}

	public DependencyInjectionCtxTest(){
		setDependencyCheck(false);
		setPopulateProtectedVariables(true);
	}
	@Override
	protected String[] getConfigLocations() {
		return new String[]{"baobaotao-service.xml","baobaotao-dao.xml"};
	}	
	public void testHasMatchUser(){
		System.out.println("run testHasMatchUser");
		boolean match = userService.hasMatchUser("tom","123456");
		assertEquals(true, match);
	}
}
