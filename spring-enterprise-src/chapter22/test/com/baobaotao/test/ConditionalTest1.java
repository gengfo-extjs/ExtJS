package com.baobaotao.test;

import org.springframework.test.ConditionalTestCase;

public class ConditionalTest1 extends ConditionalTestCase {
   
	private static String[] IGNORED_METHODS = {"testMethod1","testMethod3"};
	@Override
	protected boolean isDisabledInThisEnvironment(String testMethodName) {
		for (String method : IGNORED_METHODS) {
			if (method.equals(testMethodName)) {
				return true;
			}
		}
		return false;
	}
	
	public void testMethod1(){
		System.out.println("method1");
	}
	public void testMethod2(){
		System.out.println("method2");
	}
	public void testMethod3(){
		System.out.println("method3");
	}
}
