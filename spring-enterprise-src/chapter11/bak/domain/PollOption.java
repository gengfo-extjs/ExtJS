package com.baobaotao.domain;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity(name="T_POLL_OPTION")
public class PollOption implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "OPTION_ID")
	private int optionId;
	
	@Column(name = "OPTION_ITEM")
	private String optionItem;
	
	@ManyToOne
    @JoinColumn(name="TOPIC_ID", nullable=false)
	private PollTopic pollTopic;
	
	public int getOptionId() {
		return optionId;
	}
	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}
	public PollTopic getPollTopic() {
		return pollTopic;
	}
	public void setPollTopic(PollTopic pollTopic) {
		this.pollTopic = pollTopic;
	}
	public String getOptionItem() {
		return optionItem;
	}
	public void setOptionItem(String optionItem) {
		this.optionItem = optionItem;
	}
}
