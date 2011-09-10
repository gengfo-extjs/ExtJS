package com.baobaotao.dao.jdbc;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;
import com.baobaotao.service.BbtForum;

public class TestForumJdbcDao
		extends
			AbstractDependencyInjectionSpringContextTests {
	private ForumDao forumDao;
	private BbtForum bbtForum;
	
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}

	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	};

	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}

	// public void testAddForum() throws Throwable{
	// Forum forum = new Forum();
	// forum.setForumName("1二手市场");
	// forum.setForumDesc("1二手货物的交流论坛。");
	// forumDao.addForum(forum);
	// }
	// public void testAddForums() throws Throwable{
	// Forum f1 = new Forum();
	// f1.setForumName("爱美妈妈");
	// f1.setForumDesc("减肥、塑身、化妆品");
	//		
	// Forum f2 = new Forum();
	// f2.setForumName("育儿话题");
	// f2.setForumDesc("交流育儿的感受和经验");
	//		
	// List<Forum> forums = new ArrayList<Forum>();
	// forums.add(f1);
	// forums.add(f2);
	// forumDao.addForums(forums);
	// }
	// public void testGetForum() throws Throwable{
	// Forum forum = forumDao.getForum(56);
	// System.out.println(forum);
	// }
//	public void testGetForums() throws Throwable {
//		List forums = forumDao.getForums(1, 10);
//		for (Iterator iter = forums.iterator(); iter.hasNext();) {
//			Forum forum = (Forum) iter.next();
//			System.out.println(forum);
//		}
//	}
	public void testGetForumNum() throws Throwable {

		System.out.println("num is:" + forumDao.getForumNum());
	}
	
	public void testAddForum(){
		Forum forum = new Forum();
		forum.setForumName("1二手市场");
		forum.setForumDesc("1二手货物的交流论坛。");		
		bbtForum.addForum(forum);
	}

}
