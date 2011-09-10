package com.baobaotao.dao.jdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.CallableStatementCreatorFactory;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.baobaotao.dao.TopicDao;

public class TopicJdbcDao extends JdbcDaoSupport implements TopicDao {
	public double getReplyRate(int userId) {
		String sql = "SELECT topic_replies,topic_views FROM t_topic WHERE user_id=?";
		Object obj = getJdbcTemplate().queryForObject(sql, new Object[]{userId},new RowMapper(){
			public Object mapRow(ResultSet rs, int index) throws SQLException {
				int replies = rs.getInt("topic_replies");
				int views = rs.getInt("topic_views");
				if(views >0) return new Double((double)replies/views);
				else return new Double(0.0);
			}});
		return ((Double)obj).doubleValue();
	}

	public int getUserTopicNum(final int userId) {
		String sql = "{call P_GET_TOPIC_NUM(?,?)}";
		//使用	Object execute(String callString, CallableStatementCallback action)接口
		Object obj = getJdbcTemplate().execute(sql,new CallableStatementCallback(){
			public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException {
				cs.setInt(1,userId);
				cs.registerOutParameter(2, Types.INTEGER);
				cs.execute();
				return new Integer(cs.getInt(2));
			}	
		});
	    return ((Integer)obj).intValue();
	}

	public int getUserTopicNum2(final int userId) {
		String sql = "{call P_GET_TOPIC_NUM(?,?)}";
		//使用bject execute(CallableStatementCreator csc, CallableStatementCallback action)接口
		CallableStatementCreatorFactory fac = new CallableStatementCreatorFactory(sql);
		fac.addParameter(new SqlParameter("userId",Types.INTEGER));
		fac.addParameter(new SqlOutParameter("topicNum",Types.INTEGER));
		Map paramsMap = new HashMap();
		paramsMap.put("userId",userId);
		CallableStatementCreator csc = fac.newCallableStatementCreator(paramsMap);	
		Object obj = getJdbcTemplate().execute(csc,new CallableStatementCallback(){
			public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException {
				cs.execute();
				return new Integer(cs.getInt(2));
			}	
		});
	    return ((Integer)obj).intValue();
	}
	
	public void test() throws Throwable{
		Connection conn  = DataSourceUtils.getConnection(getJdbcTemplate().getDataSource());
		Statement stat = conn.createStatement();
		stat.setFetchSize(3);
//		stat.setMaxRows(2);
		ResultSet rs = stat.executeQuery("select * from t_topic");
		while (rs.next()) {
			System.out.println("row:"+rs.getRow()+"/"+rs.getString(1));
		}
		
//		CallableStatement cs = conn.prepareCall("call P_GET_TOPIC_NUM()");
//		boolean b = cs.execute();
//		System.out.println("here:"+b);
	}
	public static void main(String[] args) {
		
	}

	public SqlRowSet getTopicRowSet(int userId) {
		String sql = "SELECT topic_id,topic_title FROM t_topic WHERE user_id=?";
		return getJdbcTemplate().queryForRowSet(sql,new Object[]{userId});
	}
}
