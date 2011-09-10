package com.baobaotao.service;

import org.springframework.test.AbstractTransactionalSpringContextTests;

import com.baobaotao.domain.User;

public class UserServiceIntegrateTest
		extends
			AbstractTransactionalSpringContextTests {
	private UserService userService;

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@Override
	protected String[] getConfigLocations() {
		return new String[]{"baobaotao-service.xml", "baobaotao-dao.xml"};
	}
	public void testRegisterUser(){
		User user = new User();
		user.setUserId(2);
		user.setUserName("john");
		user.setPassword("123456");
		userService.registerUser(user);
		User user1 = userService.findUserByUserName("john");
		assertEquals(user.getUserId(), user1.getUserId());
//		setComplete();
	}
	
//	public void testXxx(){
//		System.out.println("execute testXxx...");
//	}
//	
//	public void testYyy(){
//		System.out.println("execute testYyy...");
//	}
//	
//	@Override
//	protected void onSetUpBeforeTransaction() throws Exception {
//		System.out.println("onSetUpBeforeTransaction...");
//	}
//	
//	@Override
//	protected void onTearDownAfterTransaction() throws Exception {
//		System.out.println("onTearDownAfterTransaction");
//	}
}
