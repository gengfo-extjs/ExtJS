package com.baobaotao.timer;

import java.util.Timer;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

public class TestTimerScheduler
		extends AbstractDependencyInjectionSpringContextTests {
   private Timer timer;
   
	public void setTimer(Timer timer) {
	this.timer = timer;
}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-timer.xml"};
	}
	public void testScheduler() throws Throwable{
		System.out.println("begin...");
		Thread.currentThread().sleep(10000);
		System.out.println("end.");
	}
}
