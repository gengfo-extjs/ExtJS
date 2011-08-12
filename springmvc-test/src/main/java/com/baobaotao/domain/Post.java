package com.baobaotao.domain;

import org.springframework.web.multipart.MultipartFile;

public class Post {
	private String content;
	private MultipartFile  attach;
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile  attach) {
		this.attach = attach;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
