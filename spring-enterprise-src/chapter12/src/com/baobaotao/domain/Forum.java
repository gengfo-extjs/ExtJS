package com.baobaotao.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.apache.commons.lang.builder.ToStringBuilder;
@Entity(name = "T_FORUM")
public class Forum implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "FORUM_ID")
	private int forumId;
	
	@Column(name = "FORUM_NAME")
	private String forumName;
	
	@Column(name = "FORUM_DESC")
	private String forumDesc;
	public String getForumDesc() {
		return forumDesc;
	}
	public void setForumDesc(String forumDesc) {
		this.forumDesc = forumDesc;
	}
	public int getForumId() {
		return forumId;
	}
	public void setForumId(int forumId) {
		this.forumId = forumId;
	}
	public String getForumName() {
		return forumName;
	}
	public void setForumName(String forumName) {
		this.forumName = forumName;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
