package com.baobaotao.event;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

public class MailSendListener implements ApplicationListener {

	public void onApplicationEvent(ApplicationEvent event) {
		if (event instanceof MailSendEvent) {
			MailSendEvent mse = (MailSendEvent) event;
			System.out.println("MailSendListener:向" + mse.getTo() + "发送完一封邮件");
		}
	}
}
