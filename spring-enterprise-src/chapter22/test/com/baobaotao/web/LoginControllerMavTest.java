package com.baobaotao.web;

import org.easymock.EasyMock;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.springframework.web.servlet.ModelAndView;

import com.baobaotao.service.UserService;

public class LoginControllerMavTest extends AbstractModelAndViewTests {

	private LoginController loginController;
	@Override
	protected void setUp() throws Exception {
		loginController = new LoginController();
		super.setUp();
	}
	
	public void testHandlerUserNamePwError() throws Throwable{
		MockHttpServletRequest request = new MockHttpServletRequest();
		LoginCommand command1 = new LoginCommand();
		command1.setUserName("tom");
		command1.setPassword("654321");
		
		UserService userService = EasyMock.createMock(UserService.class);
		loginController.setUserService(userService);
        
		EasyMock.expect(userService.hasMatchUser("tom", "654321")).andReturn(false).once();	
		EasyMock.replay(userService);
		
		ModelAndView mav = loginController.handle(request, null, command1, null);
		assertViewName(mav,"login");
		System.out.println("model value is:"+mav.getModel().get("error"));
		assertModelAttributeValue(mav,"error","user name or password error.") ;
			
		EasyMock.verify(userService);
	}
}
