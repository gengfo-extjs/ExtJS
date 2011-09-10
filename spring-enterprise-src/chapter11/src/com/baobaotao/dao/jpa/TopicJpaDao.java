package com.baobaotao.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.orm.jpa.support.JpaDaoSupport;

import com.baobaotao.dao.TopicDao;
import com.baobaotao.domain.Topic;

public class TopicJpaDao extends JpaDaoSupport implements TopicDao {

	public void addTopic(Topic topic) {
		getJpaTemplate().persist(topic);

	}
	public Topic getTopic(int topicId) {
		return getJpaTemplate().find(Topic.class, topicId);
	}

	public List<Topic> findTopicByUserId(int userId) {
		return getJpaTemplate().find(
				"select t from Topic t where t.userId = ?1", userId);
	}
	public void test() {
		EntityManager em = getJpaTemplate().getEntityManager();
		Query q = em.createQuery("select t from PollTopic t in(p.options)");
		q.getResultList();
	}
}
