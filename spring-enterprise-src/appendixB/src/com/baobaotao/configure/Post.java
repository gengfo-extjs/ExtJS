package com.baobaotao.configure;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Configurable;

@Configurable
public class Post implements Serializable{
	private String title;
	private String content;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String toString(){
		return "title:"+title+";content:"+content;
	}
}
