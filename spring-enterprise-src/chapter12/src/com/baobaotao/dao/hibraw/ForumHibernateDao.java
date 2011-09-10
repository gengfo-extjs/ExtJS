package com.baobaotao.dao.hibraw;

import java.util.List;

import org.hibernate.SessionFactory;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumHibernateDao implements ForumDao {
	private SessionFactory sessionFactory;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public void addForum(Forum forum) {
		sessionFactory.getCurrentSession().save(forum);
	}
	public void updateForum(Forum forum) {
		sessionFactory.getCurrentSession().update(forum);
	}
	public Forum getForum(int forumId) {
		return (Forum) sessionFactory.getCurrentSession().load(Forum.class,
				forumId);
	}
	public long getForumNum() {
		Object obj = sessionFactory.getCurrentSession().createQuery(
				"select count(f.forumId) from Forum f").list().iterator();
		return (Long) obj;
	}
	public List findForumByName(String forumName) {
		return sessionFactory
		      .getCurrentSession()
		      .createQuery("from Forum f where f.forumName like ?")
		      .setString(1, forumName + "%")
		      .list();
	}
}
