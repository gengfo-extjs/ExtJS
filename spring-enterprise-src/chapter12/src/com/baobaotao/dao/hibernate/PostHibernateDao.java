package com.baobaotao.dao.hibernate;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class PostHibernateDao extends HibernateDaoSupport implements PostDao {
	public void addPost(Post post) {
		getHibernateTemplate().save(post);	
	}

	public Post getPost(int postId) {
		// TODO Auto-generated method stub
		return null;
	}

}
