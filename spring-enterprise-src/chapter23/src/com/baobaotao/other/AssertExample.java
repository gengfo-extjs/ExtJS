package com.baobaotao.other;

import java.io.InputStream;

import org.springframework.util.Assert;

public class AssertExample {

	public static InputStream getData(String file) {
//		if (file == null || file.length() == 0
//				|| file.replaceAll("\\s", "").length() == 0) {
//
//			throw new IllegalArgumentException("file入参不能为null");
//		}
		Assert.hasText(file,"file入参不是有效的文件地址");
		return null;
	}
	
	
	
	public static void main(String[] args) {
		String file ="  ";
		getData(file);
	}
	
}
