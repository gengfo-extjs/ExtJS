package com.baobaotao.dao.jdbc;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumJdbcDao extends JdbcDaoSupport implements ForumDao {
	public void initDb() {
		String sql = "create table t_user(user_id int primary key,user_name varchar(60))";
		getJdbcTemplate().execute(sql);
	}
	public void addForum(final Forum forum) {
		final String sql = "INSERT INTO t_forum(forum_name,forum_desc) VALUES(?,?)";
		final Object[] params = new Object[]{forum.getForumName(),
				forum.getForumDesc()};
		getJdbcTemplate().update(sql, params,
				new int[]{Types.VARCHAR, Types.VARCHAR});
		//以下版本，可以从数据库中获取主键
		// KeyHolder keyHolder = new GeneratedKeyHolder();
		// getJdbcTemplate().update(new PreparedStatementCreator() {
		// public PreparedStatement createPreparedStatement(Connection conn)
		// throws SQLException {
		// PreparedStatement ps = conn.prepareStatement(sql);
		// ps.setString(1, forum.getForumName());
		// ps.setString(2, forum.getForumDesc());
		// return ps;
		// }
		// }, keyHolder);
		// forum.setForumId(keyHolder.getKey().intValue());
		// Set set = keyHolder.getKeys().keySet();
		// System.out.println("size:" + set.size() + " key:" +
		// forum.getForumId());
		// for (Iterator iter = set.iterator(); iter.hasNext();) {
		// System.out.println(iter.next());
		// }
	}

	public void addForums(final List<Forum> forums) {
		final String sql = "INSERT INTO t_forum(forum_name,forum_desc) VALUES(?,?)";
		getJdbcTemplate().batchUpdate(sql, new BatchPreparedStatementSetter() {
			public int getBatchSize() {
				return forums.size();
			}
			public void setValues(PreparedStatement ps, int index)
					throws SQLException {
				Forum forum = forums.get(index);
				ps.setString(1, forum.getForumName());
				ps.setString(2, forum.getForumDesc());
			}
		});
	}

	public Forum getForum(final int forumId) {
		String sql = "SELECT forum_name,forum_desc FROM t_forum WHERE forum_id=?";
		final Forum forum = new Forum();
		getJdbcTemplate().query(sql,new Object[]{forumId},new RowCallbackHandler(){
			public void processRow(ResultSet rs) throws SQLException {
				forum.setForumId(forumId);
				forum.setForumName(rs.getString("forum_name"));
				forum.setForumDesc(rs.getString("forum_desc"));
			}});
		return forum;
	}
	
	public List getForums(final int fromId,final int toId) {
		String sql = "SELECT forum_id,forum_name,forum_desc FROM t_forum WHERE forum_id between ? and ?";
//使用RowCallbackHandler
//		final List forums = new ArrayList();
//		getJdbcTemplate().query(sql,new Object[]{fromId,toId},new RowCallbackHandler(){
//			public void processRow(ResultSet rs) throws SQLException {
//				Forum forum = new Forum();
//				forum.setForumId(rs.getInt("forum_id"));
//				forum.setForumName(rs.getString("forum_name"));
//				forum.setForumDesc(rs.getString("forum_desc"));
//				forums.add(forum);
//			}});
//		return forums;
		return  getJdbcTemplate().query(sql,new Object[]{fromId,toId},new RowMapper(){
			public Object mapRow(ResultSet rs, int index) throws SQLException {
				Forum forum = new Forum();
				forum.setForumId(rs.getInt("forum_id"));
				forum.setForumName(rs.getString("forum_name"));
				forum.setForumDesc(rs.getString("forum_desc"));				
				return forum;
			}
			
		});
	}

	public int getForumNum() {
		String sql = "SELECT forum_id FROM t_forum "; 
		return getJdbcTemplate().queryForInt(sql);
	}	
}
