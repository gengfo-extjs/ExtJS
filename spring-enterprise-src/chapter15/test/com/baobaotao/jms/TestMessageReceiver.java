package com.baobaotao.jms;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

public class TestMessageReceiver
		extends
			AbstractDependencyInjectionSpringContextTests {
	private MessageReceiver messageReceiver;

	public void setMessageReceiver(MessageReceiver messageReceiver) {
		this.messageReceiver = messageReceiver;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-receiver.xml"};
	}
	// public void testReceiveTextMsg() {
	// messageReceiver.receiveTextMsg();
	// }
	// public void testReceiveUserMsg() {
	// messageReceiver.receiveUserMsg();
	// }
//	public void testReceiveFiltedUserMsg() {
//		while (true) {
//			System.out.println("开始接收消息...");
//			messageReceiver.receiveFiltedUserMsg();
//			System.out.println("成功接收消息.");
//		}
//	}
	public void testMessageListener() throws Throwable {
       Thread.sleep(1000000);
	}	
}
