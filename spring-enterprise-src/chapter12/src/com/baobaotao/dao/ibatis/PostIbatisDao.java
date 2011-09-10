package com.baobaotao.dao.ibatis;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class PostIbatisDao extends SqlMapClientDaoSupport implements PostDao {
	public void addPost(Post post)  {
		getSqlMapClientTemplate().insert("addPost", post);
	}

	public Post getPost(int postId) {
		return (Post)getSqlMapClientTemplate().queryForObject("getPost",postId);
	}
}
