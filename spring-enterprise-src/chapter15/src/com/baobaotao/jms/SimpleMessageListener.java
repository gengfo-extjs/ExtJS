package com.baobaotao.jms;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;

import com.baobaotao.domain.User;

public class SimpleMessageListener implements MessageListener {

  public void onMessage(Message message) {
    if (message instanceof ObjectMessage) {   
    	try {
    		ObjectMessage objMsg = (ObjectMessage)message;
    		User user = (User)objMsg.getObject();
    		System.out.println("user:"+user);
      } catch (JMSException ex) {
        ex.printStackTrace();
      }
    } else {
       System.out.println("warning,not ObjectMessage!");
    }
  }
}