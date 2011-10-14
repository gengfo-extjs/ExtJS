package com.baobaotao.service;

import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.baobaotao.dao.ForumDao;
import com.baobaotao.domain.Forum;

public class ForumService1 {
	private ForumDao forumDao;
	TransactionTemplate template;
	public TransactionTemplate getTemplate() {
		return template;
	}
	public void setTemplate(TransactionTemplate template) {
		this.template = template;
	}
	public ForumDao getForumDao() {
		return forumDao;
	}
	public void addForum(final Forum forum) {
		
		template.execute(new TransactionCallbackWithoutResult() {
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				forumDao.addForum(forum);
			}
		});

	}
	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	}
}
