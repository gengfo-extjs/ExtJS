package com.baobaotao.service;

import java.util.Date;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.baobaotao.domain.User;

public class TestUserService extends TestCase {

	public ApplicationContext factory = null;

	private static String[] CONFIG_FILES = {
			"baobaotao-dao.xml",
			"baobaotao-service.xml" };

	protected void setUp() throws Exception {
		factory = new FileSystemXmlApplicationContext(CONFIG_FILES);
	}

	public void testHasMatchUser() {
		UserService userService = (UserService) factory.getBean("userService");
		boolean b1 = userService.hasMatchUser("admin", "123456");
		boolean b2 = userService.hasMatchUser("admin", "1111");
		assertTrue(b1);
		assertTrue(!b2);
	}

	public void testFindUserByUserName() {
		UserService userService = (UserService) factory.getBean("userService");
		User user = userService.findUserByUserName("admin");
		assertEquals(user.getUserName(), "admin");
	}

	public void testAddLoginLog() {
		UserService userService = (UserService) factory.getBean("userService");
		User user = userService.findUserByUserName("admin");
		user.setUserId(1);
		user.setUserName("admin");
		user.setLastIp("192.168.12.7");
		user.setLastVisit(new Date());
		userService.loginSuccess(user);
	}
}
