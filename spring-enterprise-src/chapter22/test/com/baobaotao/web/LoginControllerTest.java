package com.baobaotao.web;

import junit.framework.TestCase;

import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.web.servlet.ModelAndView;

import com.baobaotao.domain.User;

public class LoginControllerTest extends TestCase {

	private LoginController loginController;
	@Override
	protected void setUp() throws Exception {
		loginController = new LoginController();
		super.setUp();
	}
	
	public void testHandlerWithUserInSession() throws Throwable{

		MockHttpServletRequest request = new MockHttpServletRequest();
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("user", new User());
		request.setSession(session);

		ModelAndView mv1 = loginController.handle(request, null, null, null);
		assertEquals(mv1.getViewName(),"target");
	}
}
