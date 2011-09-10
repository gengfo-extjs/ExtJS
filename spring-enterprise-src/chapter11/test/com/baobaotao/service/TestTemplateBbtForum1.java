package com.baobaotao.service;
import org.springframework.test.jpa.AbstractJpaTests;

import com.baobaotao.domain.Topic;
public class TestTemplateBbtForum1 extends AbstractJpaTests {
	public TestTemplateBbtForum1(){
		super.setDependencyCheck(false);
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
	private BbtForum bbtForum;

	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public void testGetTopic() {
		Topic t = bbtForum.getTopic(501);
		assertNotNull(t);
		System.out.println(t);
	}
}
