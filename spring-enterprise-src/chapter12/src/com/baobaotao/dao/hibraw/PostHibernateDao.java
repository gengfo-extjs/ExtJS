package com.baobaotao.dao.hibraw;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class PostHibernateDao implements PostDao {
	private SessionFactory sessionFactory;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public void addPost(Post post) {
		sessionFactory.getCurrentSession().save(post);
	}
	public Post getPost(int postId) {
		// TODO Auto-generated method stub
		return null;
	}

}
