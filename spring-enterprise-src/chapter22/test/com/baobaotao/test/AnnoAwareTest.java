package com.baobaotao.test;

import org.springframework.test.annotation.AbstractAnnotationAwareTransactionalTests;
import org.springframework.test.annotation.ExpectedException;
import org.springframework.test.annotation.NotTransactional;
import org.springframework.test.annotation.Repeat;
import org.springframework.test.annotation.Timed;

public class AnnoAwareTest extends AbstractAnnotationAwareTransactionalTests {

	@Override
	protected String[] getConfigLocations() {
		return new String[]{"baobaotao-service.xml", "baobaotao-dao.xml"};
	}
	@ExpectedException(RuntimeException.class)
	public void testThrowsException(){
	    System.out.println("execute testThrowsException...");
	    throw new RuntimeException("test");
	}
	
	@Timed(millis=400)
	public void testTimedMethod() throws Throwable{
		System.out.println("execute testTimedMethod...");
		Thread.sleep(250);
	}
	@Repeat(3)
	public void testRepeatedMethod(){
		System.out.println("execute testRepeatedMethod...");
	}
	
	@NotTransactional
	public void testNoTransactionMethod(){
		System.out.println("");
	}
}
