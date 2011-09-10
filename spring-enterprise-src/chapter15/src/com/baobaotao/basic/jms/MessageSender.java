package com.baobaotao.basic.jms;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;

public class MessageSender {
	public void send(String msgText) {
		Connection connection = null;
		try {
			InitialContext ctx = new InitialContext();
			ConnectionFactory factory = (ConnectionFactory) ctx
					.lookup("jndi/jmsConn");
			Destination dest = (Destination) ctx.lookup("jndi/dest");
			ctx.close();
			connection = factory.createConnection();
			Session session = connection.createSession(false,Session.AUTO_ACKNOWLEDGE);
			MessageProducer sender = session.createProducer(dest);
			TextMessage message = session.createTextMessage(msgText);
			sender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				connection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
	}
}
