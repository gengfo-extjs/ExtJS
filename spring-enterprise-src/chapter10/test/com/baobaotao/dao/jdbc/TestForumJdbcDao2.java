package com.baobaotao.dao.jdbc;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class TestForumJdbcDao2
		extends
			AbstractDependencyInjectionSpringContextTests {
	private ForumDao forumDao;
	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	};

	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext2.xml"};
	}

	 public void testAddForum() throws Throwable {
		Forum forum = new Forum();
		forum.setForumName("2二手市场");
		forum.setForumDesc("2二手货物的交流论坛。");
		forumDao.addForum(forum);
	}

}
