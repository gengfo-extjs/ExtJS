package com.baobaotao.dao.jdbc;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class TestForumJdbcOODao
		extends
			AbstractDependencyInjectionSpringContextTests {
	private ForumJdbcOODao forumJdbcOODao;
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContextOO.xml"};
	}
	public void setForumJdbcOODao(ForumJdbcOODao forumJdbcOODao) {
		this.forumJdbcOODao = forumJdbcOODao;
	}
	
//	public void testGetForum(){
//		Forum forum = forumJdbcOODao.getForum(1);
//		System.out.println(forum);
//	}

//	public void testInsertForum(){
//		Forum forum = new Forum();
//		forum.setForumName("论坛1");
//		forum.setForumDesc("论坛描述1");
//		forumJdbcOODao.addForum(forum);
//	}
	public void testGetTopicNum(){
		int topicNum = forumJdbcOODao.getTopicNum(1);
		System.out.println("topicNum:"+topicNum);
	}	
}
