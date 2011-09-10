package com.baobaotao.dao.jdbc;

import java.util.List;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumJdbcDao2 extends NamedParameterJdbcDaoSupport
		implements
			ForumDao {

	public void addForum(final Forum forum) {
		final String sql = "INSERT INTO t_forum(forum_name,forum_desc) VALUES(:forumName,:forumDesc)";
		// 使用BeanPropertySqlParameterSource参数源
		// SqlParameterSource sps = new BeanPropertySqlParameterSource(forum);
		// 使用MapSqlParameterSource参数名
		MapSqlParameterSource sps = new MapSqlParameterSource().
		                             addValue("forumName", forum.getForumName()).
		                             addValue("forumDesc",forum.getForumDesc());
		getNamedParameterJdbcTemplate().update(sql, sps);
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

	public List getForums(int fromId, int toId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void initDb() {
		// TODO Auto-generated method stub

	}

}
