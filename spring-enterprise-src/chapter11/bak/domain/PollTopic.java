package com.baobaotao.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

@Entity 
@DiscriminatorValue(value="2")
public class PollTopic extends Topic {
	private boolean multiple;
	@Column(name = "MAX_CHOICES")
	private int maxChoices;
	@OneToMany(mappedBy="pollTopic",cascade=CascadeType.ALL)
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
}
