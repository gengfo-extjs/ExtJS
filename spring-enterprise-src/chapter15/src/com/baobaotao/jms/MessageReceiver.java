package com.baobaotao.jms;

import javax.jms.JMSException;
import javax.jms.TextMessage;

import org.springframework.jms.core.support.JmsGatewaySupport;

import com.baobaotao.domain.User;

public class MessageReceiver extends JmsGatewaySupport {
	public void receiveTextMsg() {
		TextMessage textMsg = (TextMessage) getJmsTemplate().receive();
		try {
			System.out.println("msgId:"
					+ textMsg.getJMSMessageID());
			System.out.println("msg:" + textMsg.getText());
		} catch (JMSException e) {
			e.printStackTrace();
		}
	}	
	public void receiveUserMsg(){
		 User user = (User)getJmsTemplate().receiveAndConvert("userMsgQ");
		 System.out.println("user:"+user);
	}
	
	public void receiveFiltedUserMsg(){
		User user =(User)getJmsTemplate().receiveSelectedAndConvert("userMsgQ","level%2 = 0");
		System.out.println("user:"+user);
	}
}
