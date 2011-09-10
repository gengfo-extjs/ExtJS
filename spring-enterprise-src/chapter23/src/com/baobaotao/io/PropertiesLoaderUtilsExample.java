package com.baobaotao.io;
import java.util.Properties;
import org.springframework.core.io.support.PropertiesLoaderUtils;
public class PropertiesLoaderUtilsExample {
	public static void main(String[] args) throws Throwable {	
        Properties props = PropertiesLoaderUtils.loadAllProperties("jdbc.properties");
        System.out.println(props.getProperty("jdbc.driverClassName"));
	}
}
