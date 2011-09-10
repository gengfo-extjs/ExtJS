package com.baobaotao.event;

import org.springframework.context.ApplicationEvent;

public class MailSendEvent extends ApplicationEvent {
	private String to;
	public MailSendEvent(Object source, String to) {
		super(source);
		this.to = to;
	}
	public String getTo() {
		
		return this.to;
	}
}
