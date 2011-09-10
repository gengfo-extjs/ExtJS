package com.baobaotao.service;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baobaotao.service.BbtForum;

public class BbtForumTest {
	public static void main(String[] args) {
	   String config = "applicationContext.xml";
	   ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	   BbtForum bbtForum = (BbtForum) ctx.getBean("bbtForum4");
	   System.out.println(bbtForum.getDesc());
	   
//	   BbtForum bbtForum = (BbtForum) ctx.getBean("bbtForum3");
//	   System.out.println(bbtForum.getDesc());
	   
//	   Messenger msg = (Messenger) ctx.getBean("bshMessenger");
//	   System.out.println(msg.getMessage());	   
	}
}
