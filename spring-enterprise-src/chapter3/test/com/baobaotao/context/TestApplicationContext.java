package com.baobaotao.context;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.Resource;

public class TestApplicationContext extends TestCase {
	public ApplicationContext ctx = null;
	private static String[] CONFIG_FILES = { "com/baobaotao/context/beans.xml" };

	public void setUp() throws Exception {
		super.setUp();
		ctx = new ClassPathXmlApplicationContext(CONFIG_FILES);
	}

	public void testResource() {
		// 显式指定资源地址前缀
		Resource res1 = ctx
				.getResource("resource.txt");

		try {
			Thread.sleep(100000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		assertTrue(res1.exists());
	}

	public void testApplicationContextCycle() {
		Car car = (Car) ctx.getBean("car");
		assertNotNull(car);
		System.out.println(car);
	}

	@Override
	protected void tearDown() throws Exception {
		super.tearDown();
		((ClassPathXmlApplicationContext) ctx).close();
	}

}
