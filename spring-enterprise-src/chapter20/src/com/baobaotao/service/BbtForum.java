package com.baobaotao.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.baobaotao.domain.Topic;
import com.baobaotao.domain.User;

public class BbtForum {
	public List<Topic> findRefinedTopic(int forumId) {
		Topic t1 = new Topic();
		t1.setTopicId(1);
		t1.setTitle("请问哪个地方买纸尿裤方便？");
		t1.setCreateDate(new Date());
		Topic t2 = new Topic();
		t2.setTopicId(2);
		t2.setTitle("解决宝宝多动症的好办法");
		t2.setCreateDate(new Date());	
		Topic t3 = new Topic();
		t3.setTopicId(3);
		t3.setTitle("二手货大交换喽");
		t3.setCreateDate(new Date());		
		List<Topic> topicList = new ArrayList<Topic>();
		topicList.add(t1);
		topicList.add(t2);
		topicList.add(t3);
		return topicList;
	}
	

	public User getUser(int userId) {
		User user = new User();
		user.setEmail("tom@aaa.com");
		return user;
	}

	public void registerUser(User user) {
		// TODO Auto-generated method stub		
	}
}
