package com.baobaotao.dao.ibatis;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;
import com.ibatis.sqlmap.client.SqlMapExecutor;

public class ForumIbatisDao extends SqlMapClientDaoSupport implements ForumDao {
	public void addForum(Forum forum) {
		getSqlMapClientTemplate().insert("addForum", forum);
	}
	
	public void addForums(final List<Forum> forums) {
		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
                executor.startBatch();
                for (Forum forum : forums) {
					executor.insert("addForum",forum);
				}
                executor.executeBatch();
                return null;
            }
        });
	}
	public void updateForum(Forum forum) {
		getSqlMapClientTemplate().update("updateForum", forum);
	}
	public Forum getForum(int forumId) {
		return (Forum) getSqlMapClientTemplate().queryForObject("getForum",
				forumId);
	}
	public long getForumNum() {
		Object obj = getSqlMapClientTemplate().queryForObject("getForumNum");
		return (Long) obj;
	}
	public List findForumByName(String forumName) {
		return getSqlMapClientTemplate().queryForList("findForumByName",
				forumName);
	}
}
