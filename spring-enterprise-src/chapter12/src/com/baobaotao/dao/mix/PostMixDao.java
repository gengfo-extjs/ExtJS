package com.baobaotao.dao.mix;

import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;


public class PostMixDao implements PostDao {
	private HibernateTemplate hibernateTemplate;
	private SqlMapClientTemplate sqlMapClientTemplate;
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public void setSqlMapClientTemplate(
			SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	public void addPost(Post post) {
		hibernateTemplate.save(post);
		try {
			Connection conn = hibernateTemplate.getSessionFactory()
					.getCurrentSession().connection();
			sqlMapClientTemplate.getSqlMapClient().setUserConnection(conn);
			post.setPostText(post.getPostText()+"bak");
			sqlMapClientTemplate.insert("addPost",post);
		} catch (SQLException e) {
			throw (new SQLErrorCodeSQLExceptionTranslator()).translate("", "", e);
		}		
	}
	public Post getPost(int postId) {
		return (Post) sqlMapClientTemplate.queryForObject("getPost", postId);
	}
}
