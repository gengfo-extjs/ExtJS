package com.baobaotao.dao;

import java.util.List;

import com.baobaotao.domain.Topic;

public interface TopicDao {
	void addTopic(Topic topic);

	Topic getTopic(int topicId);

	List<Topic> findTopicByUserId(int userId);

	void test();
}
