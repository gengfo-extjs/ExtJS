package com.baobaotao.dao.hibernate;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.baobaotao.dao.TopicDao;
import com.baobaotao.domain.Topic;

public class TopicHibernateDao extends HibernateDaoSupport implements TopicDao {
	public void addTopic(Topic topic) {
		getHibernateTemplate().save(topic);
	}
}
