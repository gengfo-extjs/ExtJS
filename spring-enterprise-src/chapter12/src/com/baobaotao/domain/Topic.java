package com.baobaotao.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;


public class Topic implements Serializable {
	private static final long serialVersionUID = 1L; 
	private int topicId;
	private int userId;
	private String topicTitle;
	private Date topicTime;
	private Forum forum;
	private List<Post> posts;
	private int topicViews;


	public int getTopicId() {
		return topicId;
	}

	public void setTopicId(int topicId) {
		this.topicId = topicId;
	}

	public Date getTopicTime() {
		return topicTime;
	}

	public void setTopicTime(Date topicTime) {
		this.topicTime = topicTime;
	}

	public String getTopicTitle() {
		return topicTitle;
	}

	public void setTopicTitle(String topicTitle) {
		this.topicTitle = topicTitle;
	}

	public int getTopicViews() {
		return topicViews;
	}

	public void setTopicViews(int topicViews) {
		this.topicViews = topicViews;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}

	public Forum getForum() {
		return forum;
	}

	public void setForum(Forum forum) {
		this.forum = forum;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
