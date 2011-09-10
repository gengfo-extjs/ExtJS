package com.baobaotao.dao.jdbc;

import java.util.Iterator;
import java.util.List;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class TestForumJdbcDao3
		extends
			AbstractDependencyInjectionSpringContextTests {
	private ForumDao forumDao;
	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	};

	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext3.xml"};
	}

	public void testGetForums(){
		List<Forum> forums = forumDao.getForums(1, 4);
		for (Forum forum : forums) {
			System.out.println(forum);
		}
	}

}
