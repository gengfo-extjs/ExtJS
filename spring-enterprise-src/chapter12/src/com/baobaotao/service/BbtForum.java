package com.baobaotao.service;
import java.util.List;

import com.baobaotao.domain.Forum;
import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;

public interface BbtForum {
	void addForum(Forum forum);
	void addTopic(Topic topic);
	void addPost(Post post);
	void updateForum(Forum forum);
	Forum getForum(int forumId);
	long getForumNum();
	Post getPost(int postId);
	List findForumByName(String forumName);
}
