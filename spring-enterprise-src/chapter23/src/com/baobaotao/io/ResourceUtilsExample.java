package com.baobaotao.io;

import java.io.File;
import java.net.URL;

import org.springframework.util.ResourceUtils;

public class ResourceUtilsExample {
	public static void main(String[] args) throws Throwable{
		File clsFile = ResourceUtils.getFile("classpath:conf/file1.txt");
		System.out.println(clsFile.isFile());
		
		String httpFilePath = "file:D:/masterSpring/chapter23/webapp/WEB-INF/classes/conf/file1.txt";
		File httpFile = ResourceUtils.getFile(httpFilePath);
		System.out.println(httpFile.isFile());	
		
	}
}
