package com.baobaotao.service;

import org.acegisecurity.Authentication;
import org.acegisecurity.event.authentication.AuthenticationSuccessEvent;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

public class LoginSuccessListener implements ApplicationListener {

	public void onApplicationEvent(ApplicationEvent event) {
		if (event instanceof AuthenticationSuccessEvent) {
			AuthenticationSuccessEvent authEvent = (AuthenticationSuccessEvent)event;
			Authentication auth = authEvent.getAuthentication();
			String userName = auth.getName();
			System.out.println("模拟记录用户["+userName+"]成功登录日志...");
		}
	}
}
