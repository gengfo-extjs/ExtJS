package com.baobaotao.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baobaotao.domain.Forum;
import com.baobaotao.domain.FullUser;
import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;
import com.baobaotao.domain.User;
import com.baobaotao.web.forum.RefinedTopicQuery;

public class BbtForum {

	public List<Forum> getAllForum() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Topic> findRefinedTopic(RefinedTopicQuery rtq) {
		// TODO Auto-generated method stub
		
		return null;
	}

	public void registerUser(User user) {
		// TODO Auto-generated method stub
		System.out.println("注册成功");
	}

	public User getUser(int userId) {
		// TODO Auto-generated method stub
		return null;
	}


	public boolean isExsitUserName(String userName) {
		List userNames = new ArrayList();
		userNames.add("tom");
		userNames.add("john");
		return userNames.contains(userName);
	}

	public void registerFullUser(FullUser user) {
		System.out.println("FullUser注册成功");
	}

	public List<Topic> findRefinedTopic(int forumId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Topic getTopic(int topicId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(int topicId) {
		// TODO Auto-generated method stub
		
	}

	public void savePost(Post post) {
		// TODO Auto-generated method stub
		
	}

}
