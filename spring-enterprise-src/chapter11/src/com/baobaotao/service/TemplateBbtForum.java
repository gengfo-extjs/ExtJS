package com.baobaotao.service;

import org.springframework.orm.jpa.support.JpaDaoSupport;

import com.baobaotao.domain.Topic;

public class TemplateBbtForum extends JpaDaoSupport implements BbtForum{
	public Topic getTopic(int topicId) {
		return getJpaTemplate().find(Topic.class, topicId);
	}
}
