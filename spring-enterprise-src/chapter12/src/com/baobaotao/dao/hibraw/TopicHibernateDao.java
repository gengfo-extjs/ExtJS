package com.baobaotao.dao.hibraw;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.baobaotao.dao.TopicDao;
import com.baobaotao.domain.Topic;

public class TopicHibernateDao implements TopicDao {
	private SessionFactory sessionFactory;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public void addTopic(Topic topic) {
		sessionFactory.getCurrentSession().save(topic);
	}
}
