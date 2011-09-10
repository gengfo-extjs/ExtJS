package com.baobaotao.fb;

import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestFactoryBean  extends TestCase {
	public ApplicationContext factory = null;
	private static String[] CONFIG_FILES = {"com/baobaotao/fb/beans.xml" };
	
	public void setUp() throws Exception {
		factory = new ClassPathXmlApplicationContext(CONFIG_FILES);		
	}
	
    public void testCarFactoryBean(){
       Car car_1 = (Car)factory.getBean("car1");
       Car car_2 = (Car)factory.getBean("car1");
       assertNotNull(car_1);
       assertNotSame(car_1,car_2);
       System.out.println(car_1);
    }
    
    public void testCollFactoryBean(){
        List list = (List)factory.getBean("favoriteList");
        Set set = (Set)factory.getBean("favoriteSet");
        Map map = (Map)factory.getBean("emails");
        Properties props = (Properties)factory.getBean("emailProps");
        assertEquals(set.size(),3);
        assertEquals(list.size(),3);
        assertEquals(map.size(),2);
        assertEquals(props.size(),2);
    }
    
    public void testFieldFactoryBean(){
    	Car car2 = (Car)factory.getBean("car2");
    	assertNotNull(car2);
    	System.out.println(car2);
    }
    
    public void testPropPathFactoryBean(){
    	Car car5 = (Car)factory.getBean("car5");
    	Car car6 = (Car)factory.getBean("car6");
    	assertNotNull(car5);
    	assertNotNull(car6);
    	System.out.println(car5);
    	System.out.println(car6);
    }    
}
