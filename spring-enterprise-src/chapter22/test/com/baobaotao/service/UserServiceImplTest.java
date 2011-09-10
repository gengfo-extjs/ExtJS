package com.baobaotao.service;

import junit.framework.TestCase;
import org.easymock.EasyMock;
import com.baobaotao.dao.UserDao;

public class UserServiceImplTest extends TestCase {
	private UserServiceImpl userService;
	@Override
	protected void setUp() throws Exception {
		userService = new UserServiceImpl();
		super.setUp();
	}
	public void testHasMatchUser() {
		UserDao userDao = EasyMock.createMock(UserDao.class);
		userService.setUserDao(userDao);

		EasyMock.expect(userDao.getMatchCount("tom", "654321")).andReturn(0).anyTimes();
		EasyMock.expect(userDao.getMatchCount("tom", "123456")).andReturn(1).times(2,3);
		EasyMock.replay(userDao);

		assertEquals(userService.hasMatchUser("tom", "654321"), false);
		assertEquals(userService.hasMatchUser("tom", "654321"), false);

		assertEquals(userService.hasMatchUser("tom", "123456"), true);
		assertEquals(userService.hasMatchUser("tom", "123456"), true);
		EasyMock.verify(userDao);
	}
}
