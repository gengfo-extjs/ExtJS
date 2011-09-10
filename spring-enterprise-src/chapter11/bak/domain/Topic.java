package com.baobaotao.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "T_TOPIC")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorValue(value="1")
@DiscriminatorColumn(name = "TOPIC_TYPE", discriminatorType = DiscriminatorType.INTEGER, length = 1)
public class Topic implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "TOPIC_ID")
	private int topicId;

	@Column(name = "TOPIC_TITLE", length = 100)
	private String topicTitle;

	@Column(name = "TOPIC_TIME")
	@Temporal(TemporalType.DATE)
	private Date topicTime;

	@Column(name = "TOPIC_VIEWS")
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

}
