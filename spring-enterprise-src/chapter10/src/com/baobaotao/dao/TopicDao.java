package com.baobaotao.dao;

import org.springframework.jdbc.support.rowset.SqlRowSet;

public interface TopicDao {
	double getReplyRate(int userId);
	int getUserTopicNum(int userId);
	int getUserTopicNum2(int userId);
	SqlRowSet getTopicRowSet(int userId);
}
