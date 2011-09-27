package com.baobaotao.dao;

import com.baobaotao.domain.Post;

public interface PostDao {
	void addPost(Post post);

	byte[] getAttach(final int postId);

	void test();
}
