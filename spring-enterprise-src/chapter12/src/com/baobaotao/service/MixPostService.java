package com.baobaotao.service;

import org.springframework.transaction.annotation.Transactional;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;
@Transactional
public class MixPostService {
	private PostDao postDao;

	public void setPostDao(PostDao postDao) {
		this.postDao = postDao;
	}

	public void addPost(Post post) {
		postDao.addPost(post);
	}
	public Post getPost(int postId) {
		return postDao.getPost(postId);
	}
}
