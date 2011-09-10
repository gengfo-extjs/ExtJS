package com.baobaotao.scope;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestScope  extends TestCase {
	public ApplicationContext factory = null;

	private static String[] CONFIG_FILES = { "com/baobaotao/scope/beans.xml" };
	public void setUp() throws Exception {
		factory = new ClassPathXmlApplicationContext(CONFIG_FILES);
		
	}
    public void testSingleton(){
//    	Boss boss1 = (Boss)factory.getBean("boss1");
//    	Boss boss2 = (Boss)factory.getBean("boss2");
//    	Boss boss3 = (Boss)factory.getBean("boss3");
//    	assertSame(boss1.getCar(),boss2.getCar());
//    	assertSame(boss2.getCar(),boss3.getCar());
    }
}
