package com.baobaotao.dao.jpaem;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;
@Repository
@Transactional
public class PostJpaemDao implements PostDao {
	@PersistenceContext
	private EntityManager em;

	public void addPost(Post post) {
		em.persist(post);
		em.flush();

	}

	public byte[] getAttach(int postId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void test() {
		// Query q = em.createQuery("SELECT t FROM PollTopic t WHERE (SELECT
		// COUNT(o) FROM t.options o) > 6 AND LOCATE('a1b1c1','b1',1) > 1");
		if (em != null) {
			System.out.println("em is not null");
			if (em.isOpen()) {
				System.out.println("em is open");
			} else {
				System.out.println("em is close");
				em.joinTransaction();
			}

		}
		Query q = em.createNativeQuery("SELECT * FROM t_topic");
		// PollOption p = new PollOption();
		// p.setOptionId(502);
		// q.setParameter("option",p);
		// q.setParameter("time",new Date());
		List list = q.getResultList();
		for (Iterator iter = list.iterator(); iter.hasNext();) {
			Vector v = (Vector) iter.next();
			for (int i = 0; i < v.size(); i++) {
				System.out.print(v.elementAt(i) + "|");
			}
			System.out.println("\n");
		}

	}
}
