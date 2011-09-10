package com.baobaotao.dao.jdbc;

import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.baobaotao.dao.TopicDao;

public class TestTopicJdbcDao
		extends
			AbstractDependencyInjectionSpringContextTests {
	private TopicDao topicDao;
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
//	 public void testGetReplyRate(){
//	 double rate = topicDao.getReplyRate(2);
//	 System.out.println("rate is:"+rate);
//	 }
//	public void testGetUserTopicNum() throws Throwable{
//		int num = topicDao.getUserTopicNum(1);
//		System.out.println("num is:" + num);
//		((TopicJdbcDao)topicDao).test();
//	}
//
//	public void testGetUserTopicNum2() throws Throwable{
//		int num = topicDao.getUserTopicNum2(1);
//		System.out.println("num is:" + num);
//	}
    public void testGetTopicRowSet(){
    	SqlRowSet srs = topicDao.getTopicRowSet(1);
    	while (srs.next()) {
			System.out.println(srs.getString("topic_id"));
		}
    }

}
