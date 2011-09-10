package com.baobaotao.domain;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Post implements Serializable {
	private int postId;
	private int userId;
	private Topic topic;
	private String postText;
	private byte[] postAttach;
	private Date postTime;
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
	public Date getPostTime() {
		return postTime;
	}
	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public byte[] getPostAttach() {
		return postAttach;
	}
	public void setPostAttach(byte[] postAttach) {
		this.postAttach = postAttach;
	}
	public Topic getTopic() {
		return topic;
	}
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
