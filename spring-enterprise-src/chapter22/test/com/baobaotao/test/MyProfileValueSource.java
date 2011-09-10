package com.baobaotao.test;

import java.util.Properties;

import org.springframework.test.annotation.ProfileValueSource;

public class MyProfileValueSource implements ProfileValueSource {
    private Properties pvsProperties;
	public void setPvsProperties(Properties pvsProperties){
		this.pvsProperties = pvsProperties;
	}
	public String get(String key) {
		return pvsProperties.getProperty(key);
	}
}
