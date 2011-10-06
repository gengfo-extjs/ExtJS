package com.baobaotao.dao.jpa;


import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.support.JpaDaoSupport;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class PostJpaDao extends JpaDaoSupport implements PostDao {

	public void addPost(Post post) {
		getJpaTemplate().persist(post);
	}

	public byte[] getAttach(final int postId) {
		Object obj = getJpaTemplate().execute(

		new JpaCallback() {

			public Object doInJpa(EntityManager em) throws PersistenceException {
				Query query = em
						.createQuery("SELECT post.postAttach FROM Post post WHERE post.postId=:postId");
				query.setParameter("postId", postId);
				return query.getSingleResult();
			}
		}

		);
		return (byte[]) obj;
	}

	public void test() {
		// TODO Auto-generated method stub

	}
}
