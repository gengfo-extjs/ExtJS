package com.baobaotao.dao;

import java.io.OutputStream;
import java.util.List;

import com.baobaotao.domain.Post;

public interface PostDao {
   void addPost(Post post);
	void getNativeConn();
	List getAttachs(final int userId);
	void getAttach(final int postId,final OutputStream os);
}
