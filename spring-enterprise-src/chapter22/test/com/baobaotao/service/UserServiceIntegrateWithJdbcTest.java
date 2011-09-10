package com.baobaotao.service;

import org.springframework.test.AbstractTransactionalDataSourceSpringContextTests;

import com.baobaotao.domain.User;

public class UserServiceIntegrateWithJdbcTest
		extends
		AbstractTransactionalDataSourceSpringContextTests {
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
		
		String sqlStr = " SELECT user_id "
			+ " FROM t_user WHERE user_name ='john' ";
        int userId = jdbcTemplate.queryForInt(sqlStr);      
        assertEquals(user.getUserId(), userId);
//		setComplete();
	}
}
