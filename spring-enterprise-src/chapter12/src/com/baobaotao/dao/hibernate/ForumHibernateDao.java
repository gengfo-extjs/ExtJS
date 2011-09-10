package com.baobaotao.dao.hibernate;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumHibernateDao extends HibernateDaoSupport implements ForumDao {

	public void addForum(Forum forum) {
		getHibernateTemplate().save(forum);
	}
	public void updateForum(Forum forum) {
		getHibernateTemplate().update(forum);
	}
	public Forum getForum(int forumId) {
		return (Forum) getHibernateTemplate().load(Forum.class, forumId);
	}
	public long getForumNum() {
		Object obj =getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return session.createQuery("select count(f.forumId) from Forum f")
				.list()
				.iterator();
			}
		});
		return (Long)obj;
	
		//使用Template接口方法的版本
//		Iterator iter = getHibernateTemplate().iterate(
//				"select count(f.forumId) from Forum f");
//		return ((Long)iter.next());

	}
	public List findForumByName(String forumName) {
		return getHibernateTemplate().find(
				"from Forum f where f.forumName like ?",forumName+"%");
	}
}
