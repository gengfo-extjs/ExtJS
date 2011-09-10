package com.baobaotao.domain;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.builder.ToStringBuilder;


public class PollTopic extends Topic {
	private static final long serialVersionUID = 1L; 

	private boolean multiple;

	private int maxChoices;

	private Set<PollOption> options = new HashSet<PollOption>();
	
	public int getMaxChoices() {
		return maxChoices;
	}
	public void setMaxChoices(int maxChoices) {
		this.maxChoices = maxChoices;
	}
	public boolean isMultiple() {
		return multiple;
	}
	public void setMultiple(boolean multiple) {
		this.multiple = multiple;
	}
	public Set<PollOption> getOptions() {
		return options;
	}
	public void addOption(PollOption option) {
		this.options.add(option);
	}
	public void setOptions(Set<PollOption> options) {
		this.options = options;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
