package com.baobaotao.dao.hibernate;

import java.util.Iterator;
import java.util.List;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.dao.HibernateBaseDao;
import com.baobaotao.domain.Forum;

public class ForumHibernateDao2 extends HibernateBaseDao<Forum> implements ForumDao{
	public long getForumNum() {
		Iterator iter = getHibernateTemplate().iterate(
		"select count(f.forumId) from Forum f");
        return ((Long)iter.next());
	}

	public void addForum(Forum forum) {
		// TODO Auto-generated method stub	
	}

	public List findForumByName(String forumName) {
		// TODO Auto-generated method stub
		return null;
	}

	public Forum getForum(int forumId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void updateForum(Forum forum) {
		// TODO Auto-generated method stub		
	}
}
