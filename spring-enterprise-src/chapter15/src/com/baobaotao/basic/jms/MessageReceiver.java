package com.baobaotao.basic.jms;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;

public class MessageReceiver implements MessageListener {
	public void receive() {
		Connection connection = null;
		try {
			InitialContext ctx = new InitialContext();
			ConnectionFactory factory = (ConnectionFactory) ctx
					.lookup("jndi/jmsConn");
			Destination dest = (Destination) ctx.lookup("jndi/dest");
			ctx.close();
			connection = factory.createConnection();
			Session session = connection.createSession(false,
					Session.AUTO_ACKNOWLEDGE);
			MessageConsumer receiver = session.createConsumer(dest);
			receiver.setMessageListener(this);
//			TextMessage textMsg = (TextMessage) receiver.receive();
//			System.out.println("msg is:" + textMsg.getText());	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				connection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void onMessage(Message msg) {
		try {
			TextMessage textMsg = (TextMessage) msg;
			System.out.println("msg is:" + textMsg.getText());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
