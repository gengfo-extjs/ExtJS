package com.baobaotao.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.dao.PostDao;
import com.baobaotao.dao.TopicDao;
import com.baobaotao.domain.Forum;
import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;
import com.baobaotao.service.BbtForum;
@Transactional
public class BbtForumImpl implements BbtForum {
	private ForumDao forumDao;
	private TopicDao topicDao;
	private PostDao postDao;
	public void addForum(Forum forum) {
		forumDao.addForum(forum);
	}
	public void addTopic(Topic topic) {
		topicDao.addTopic(topic);
	}
	public void addPost(Post post) {
		postDao.addPost(post);
	}

	public Forum getForum(int forumId) {
		return forumDao.getForum(forumId);
	}
	public void updateForum(Forum forum) {
		forumDao.updateForum(forum);
	}
	public long getForumNum() {
		return forumDao.getForumNum();
	}

	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	}
	public void setPostDao(PostDao postDao) {
		this.postDao = postDao;
	}
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	public List findForumByName(String forumName) {
		return forumDao.findForumByName(forumName);
	}
	public Post getPost(int postId) {
		return postDao.getPost(postId);
	}

}
