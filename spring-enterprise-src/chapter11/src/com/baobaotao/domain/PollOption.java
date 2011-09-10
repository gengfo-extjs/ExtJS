package com.baobaotao.domain;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class PollOption implements Serializable {
	private static final long serialVersionUID = 1L; 

	private int optionId;

	private String optionItem;

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
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
