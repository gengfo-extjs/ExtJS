package com.baobaotao.service;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;
import com.baobaotao.service.impl.BbtForumImpl;

public class TestBbtForumTx extends AbstractDependencyInjectionSpringContextTests{
    private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-tx.xml"};
	}
    public void testAddPost() throws Exception{
    	System.out.println("begin........");
    	Topic topic = new Topic();
    	topic.setTopicTitle("Title -pfb");
    	Post post = new Post();
    	post.setPostText("post content -pfb");
    	topic.setPost(post);
    	bbtForum.addTopic(topic);
    	System.out.println("end........");
    }
}
