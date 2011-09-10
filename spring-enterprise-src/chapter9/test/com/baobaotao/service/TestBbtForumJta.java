package com.baobaotao.service;

import org.apache.log4j.Logger;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;

public class TestBbtForumJta extends AbstractDependencyInjectionSpringContextTests{
    private BbtForum bbtForum;
    private final Logger logger = Logger.getLogger(getClass());
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-jta.xml"};
	}
    public void testAddPost() throws Exception{
    	logger.info("begin........");
    	Topic topic = new Topic();
    	topic.setTopicTitle("Title -pfb");
    	Post post = new Post();
    	post.setPostText("post content -pfb");
    	topic.setPost(post);
    	bbtForum.addTopic(topic);
    	logger.info("end........");
    }
}
