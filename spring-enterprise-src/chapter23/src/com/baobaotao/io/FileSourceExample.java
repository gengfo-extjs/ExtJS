b package com.baobaotao.io;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.mock.web.MockServletContext;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.web.context.support.ServletContextResource;

public class FileSourceExample {
	public static void main(String[] args) {
		try {
			String filePath = "D:/masterSpring/chapter23/webapp/WEB-INF/classes/conf/file1.txt";
			Resource res1 = new FileSystemResource(filePath);
            Resource res2 = new ClassPathResource("conf/file1.txt");
            MockServletContext servletContext = new MockServletContext();
            Resource res3 = new ServletContextResource(servletContext,"conf/file1.txt");
            
            InputStream ins1 = res1.getInputStream();
            InputStream ins2 = res2.getInputStream();
            InputStream ins3 = res3.getInputStream();
            System.out.println("res1:"+res1.getFilename());
            System.out.println("res2:"+res2.getFilename());
            System.out.println("res3:"+res3.getFilename());
            
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
