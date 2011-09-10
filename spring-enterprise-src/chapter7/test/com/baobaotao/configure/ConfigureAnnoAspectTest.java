package com.baobaotao.configure;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class ConfigureAnnoAspectTest {
	public static void main(String[] args) {
		String configPath = "com/baobaotao/configure/beans.xml";
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configPath);
		//@Configurable测试
		Topic topic = new Topic();
		System.out.println(topic.toString());	
	}
}
