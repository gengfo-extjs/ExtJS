package com.baobaotao.domain;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
@Entity(name = "T_POST")
public class Post implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "POST_ID")
	private int postId;

	@Lob
	@Basic(fetch = FetchType.EAGER)
	@Column(name = "POST_TEXT", columnDefinition = "LONGTEXT NOT NULL")
	private String postText;

	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(name = "POST_ATTACH", columnDefinition = "BLOB")
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

}
