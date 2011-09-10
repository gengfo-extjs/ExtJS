package com.baobaotao.quartz;

import org.quartz.Scheduler;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

public class TestQuartzScheduler
		extends AbstractDependencyInjectionSpringContextTests {
	private Scheduler scheduler;
	
	public void setScheduler(Scheduler scheduler) {
		this.scheduler = scheduler;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-quartz.xml"};
	}
	public void testScheduler() throws Throwable{
		System.out.println("begin...");
//		scheduler.start();
		Thread.currentThread().sleep(10000);
		System.out.println("end.");
	}
}
