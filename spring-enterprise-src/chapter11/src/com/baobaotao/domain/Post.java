package com.baobaotao.domain;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Post implements Serializable {
	private static final long serialVersionUID = 1L; 
	private int postId;

	private String postText;

	private byte[] postAttach;

	public byte[] getPostAttach() {
		return postAttach;
	}

	public void setPostAttach(byte[] postAttach) {
		this.postAttach = postAttach;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public String getPostText() {
		return postText;
	}

	public void setPostText(String postText) {
		this.postText = postText;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}

}
