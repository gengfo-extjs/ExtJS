package com.baobaotao.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class IndexController implements Controller {
    private String greeting;
	public String getGreeting() {
		return greeting;
	}
	public void setGreeting(String greeting) {
		this.greeting = greeting;
	}
	public ModelAndView handleRequest(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {
		return new ModelAndView("index","greeting",greeting);
	}
}
