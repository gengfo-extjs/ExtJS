package com.baobaotao.io;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.OutputStream;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.util.FileCopyUtils;

public class FileCopyUtilsExample {

	public static void main(String[] args) throws Throwable {
		Resource res = new ClassPathResource("conf/file1.txt");
		byte[] fileData = FileCopyUtils.copyToByteArray(res.getFile());
		String fileStr = FileCopyUtils.copyToString(new FileReader(res
				.getFile()));

		FileCopyUtils.copy(res.getFile(), new File(res.getFile().getParent()
				+ "/file2.txt"));

		OutputStream os = new ByteArrayOutputStream();
		FileCopyUtils.copy(res.getInputStream(), os);
	}
}
