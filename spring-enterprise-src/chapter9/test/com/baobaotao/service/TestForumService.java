package com.baobaotao.service;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.Forum;

public class TestForumService extends AbstractDependencyInjectionSpringContextTests{
	private ForumService forumService;
	private ForumService1 forumService1;
	public void setForumService(ForumService forumService) {
		this.forumService = forumService;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
	
//	public void testAddTopic(){
//		System.out.println("begin...........");
//		forumService.addTopic();
//		System.out.println("end!!!!!!!!!!!!!");
//	}
	
	public void testAddForum() {
		Forum forum = new Forum();

		forum.setForumDesc("desc1");
		forum.setForumName("name1");
		forumService1.addForum(forum);
		
	}
	
	public void setForumService1(ForumService1 forumService1) {
		this.forumService1 = forumService1;
	}
}
