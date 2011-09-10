package com.baobaotao.configure;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Configurable;

@Configurable
public class Topic implements Serializable{
	private String title;
	private Post post;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String toString(){
		return "title:"+title+";\ntopic:"+post;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
}
