package com.baobaotao.service;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;
import com.baobaotao.service.impl.BbtForumImpl;

public class TestBbtForumAspectj extends AbstractDependencyInjectionSpringContextTests{
    private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-aspectj.xml"};
	}
    public void testAddPost() throws Exception{
    	
    	Topic topic = new Topic();
    	topic.setTopicTitle("Title -pfb");
    	Post post = new Post();
    	post.setPostText("post content -pfb");
    	topic.setPost(post);
    	System.out.println("begin........");
    	bbtForum.addTopic(topic);
    	System.out.println("end........");
    }
}
