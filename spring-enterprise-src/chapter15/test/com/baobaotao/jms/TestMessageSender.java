package com.baobaotao.jms;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.User;

public class TestMessageSender
		extends
			AbstractDependencyInjectionSpringContextTests {
	private MessageSender messageSender;
	public void setMessageSender(MessageSender messageSender) {
		this.messageSender = messageSender;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-sender.xml"};
	}
//	public void testSendTextMsg() {
//		messageSender.sendTextMsg("Hello World！");
//	}
//	public void testSendUserMsg() {
//		User user = new User();
//		user.setUserId("100");
//		user.setUserName("Tom");
//		user.setEmail("abc@123.com");
//		messageSender.sendUserMsg(user);
//		System.out.println("发送成功！");
//	}	
//	public void testSendUserMsg2() {
//		User user = new User();
//		user.setUserId("100");
//		user.setUserName("Tom");
//		user.setEmail("abc@123.com");
//		user.setLevel(10);
//		messageSender.sendUserMsg2(user);
//		System.out.println("发送成功！");
//	}	
//	public void testSendUserMsg2() {
//		for (int i = 1; i < 7; i++) {
//			User user = new User();
//			user.setUserId("100");
//			user.setUserName("Tom");
//			user.setEmail("abc@123.com");
//			user.setLevel(i);
//			messageSender.sendUserMsg2(user);
//			System.out.println("发送成功！");			
//		}
//	}
	public void testSendUserMsgInTrans() {
		messageSender.sendUserMsgInTrans();
	}	
}
