package com.baobaotao.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;
import org.springframework.jdbc.object.SqlUpdate;
import org.springframework.jdbc.object.StoredProcedure;

import com.baobaotao.domain.Forum;

public class ForumJdbcOODao {
	private ForumQuery forumQuery;
	private ForumInsert forumInsert;
    private GetTopicNum getTopicNum;
	public ForumJdbcOODao(DataSource ds) {
		forumQuery = new ForumQuery(ds);
		forumInsert = new ForumInsert(ds);
		getTopicNum = new GetTopicNum(ds);
	}
	public Forum getForum(int forumId) {
		Map map = new HashMap();
		map.put("forumId", forumId);
		return (Forum) forumQuery.findObjectByNamedParam(map);
	}
	public void addForum(Forum forum) {
		forumInsert.insert(forum);
	}
	public int getTopicNum(int userId){
		return getTopicNum.getTopicNum(userId);
	}

	private class ForumQuery extends MappingSqlQuery {
		protected ForumQuery(DataSource ds) {
			super(ds,
					"SELECT forum_id,forum_name,forum_desc FROM t_forum WHERE forum_id=:forumId");
			declareParameter(new SqlParameter("forumId", Types.INTEGER));
			compile();
		}
		protected Object mapRow(ResultSet rs, int rownum) throws SQLException {
			Forum forum = new Forum();
			forum.setForumId(rs.getInt("forum_id"));
			forum.setForumName(rs.getString("forum_name"));
			forum.setForumDesc(rs.getString("forum_desc"));
			return forum;
		}
	}

	private class ForumInsert extends SqlUpdate {
		public ForumInsert(DataSource ds) {
			super(ds,
					"INSERT INTO t_forum(forum_name,forum_desc) VALUES(:forumName,:forumDesc)");
			declareParameter(new SqlParameter("forumDesc", Types.VARCHAR));
			declareParameter(new SqlParameter("forumName", Types.VARCHAR));
			compile();
		}
		public void insert(Forum forum) {
			Map params = new HashMap();
			params.put("forumName", forum.getForumName());
			params.put("forumDesc", forum.getForumDesc());
			super.updateByNamedParam(params);
		}
	}

	private class GetTopicNum extends StoredProcedure {
		private static final String SQL = "P_GET_TOPIC_NUM";
		public GetTopicNum(DataSource ds) {
			setDataSource(ds);
			setSql(SQL);
			declareParameter(new SqlParameter("userId",Types.INTEGER));
			declareParameter(new SqlOutParameter("outNum",Types.INTEGER));
			compile();
		}

		public int getTopicNum(int userId) {
			Map map = new HashMap();
			map.put("userId", userId);
			Map outMap = execute(map);
			return (Integer)outMap.get("outNum");
		}
	}
}
