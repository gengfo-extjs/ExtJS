package com.baobaotao.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumJdbcDao3 extends SimpleJdbcDaoSupport implements ForumDao {

	public void addForum(final Forum forum) {
	}

	public void addForums(List<Forum> forums) {
		// TODO Auto-generated method stub

	}

	public Forum getForum(int forumId) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getForumNum() {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<Forum> getForums(final int fromId, final int toId) {
		String sql = "SELECT forum_id,forum_name,forum_desc FROM t_forum WHERE forum_id between ? and ?";
		return getSimpleJdbcTemplate().query(sql,
				new ParameterizedRowMapper<Forum>() {
					public Forum mapRow(ResultSet rs, int index)
							throws SQLException {
						Forum forum = new Forum();
						forum.setForumId(rs.getInt("forum_id"));
						forum.setForumName(rs.getString("forum_name"));
						forum.setForumDesc(rs.getString("forum_desc"));
						return forum;
					}
				}, fromId, toId);
	}

	public void initDb() {
		// TODO Auto-generated method stub
	}

}
