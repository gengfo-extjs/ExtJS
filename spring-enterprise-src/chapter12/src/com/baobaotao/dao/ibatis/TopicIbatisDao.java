package com.baobaotao.dao.ibatis;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.baobaotao.dao.TopicDao;
import com.baobaotao.domain.Topic;

public class TopicIbatisDao extends SqlMapClientDaoSupport implements TopicDao {
	public void addTopic(Topic topic) {
		getSqlMapClientTemplate().insert("addTopic", topic);
	}
}
