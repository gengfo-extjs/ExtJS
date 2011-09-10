package com.baobaotao.jms;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageProducer;
import javax.jms.Session;

import org.springframework.jms.core.MessageCreator;
import org.springframework.jms.core.MessagePostProcessor;
import org.springframework.jms.core.SessionCallback;
import org.springframework.jms.core.support.JmsGatewaySupport;
import org.springframework.transaction.annotation.Transactional;

import com.baobaotao.domain.User;

public class MessageSender extends JmsGatewaySupport {
	public void sendTextMsg(final String msg) {
		getJmsTemplate().send(new MessageCreator() {
			public Message createMessage(Session session) throws JMSException {
				return session.createTextMessage(msg);
			}
		});
	}
	
	public void transmit(final String fromQueue,final String toQueue){
	   getJmsTemplate().execute(new SessionCallback(){
		public Object doInJms(Session session) throws JMSException {		
			Destination fromDest = session.createQueue(fromQueue);
			Destination toDest = session.createQueue(toQueue);   
			MessageConsumer consumer = session.createConsumer(fromDest);
			System.out.println("receive msg...");
			Message msg = consumer.receiveNoWait();
			if (msg != null) {
				System.out.println("receive !"+msg.getJMSMessageID());
				MessageProducer producer = session.createProducer(toDest);
	            System.out.println("send msg...");
	            producer.send(msg);
	            System.out.println("send!");
			}else{
				System.out.println("no msg!");
			}     
			return null;
		}   
	   });
	}
	public void sendUserMsg(User user){
		getJmsTemplate().convertAndSend("userMsgQ",user);
	}
	
	public void sendUserMsg2(final User user){
		getJmsTemplate().convertAndSend("userMsgQ",user,new MessagePostProcessor(){
			public Message postProcessMessage(Message message) throws JMSException {
				message.setJMSExpiration(System.currentTimeMillis() + 60*60*1000);
				message.setIntProperty("level", user.getLevel());
				return message;
			}});
	}	
	
    @Transactional
	public void sendUserMsgInTrans(){
    	for (int i = 1; i < 7; i++) {
			User user = new User();
			user.setUserId("100");
			user.setUserName("Tom");
			user.setEmail("abc@123.com");
			user.setLevel(i);
			sendUserMsg2(user);
            //if(i == 4) throw new RuntimeException("发送异常");
			System.out.println("[level:"+user.getLevel()+"]发送成功！");			
		}
	}	
}
