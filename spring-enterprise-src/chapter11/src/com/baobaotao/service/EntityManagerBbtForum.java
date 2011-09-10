package com.baobaotao.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.baobaotao.domain.Topic;
@Transactional
@Repository
public class EntityManagerBbtForum implements BbtForum{
	@PersistenceContext
	private EntityManager em;
	public Topic getTopic(int topicId) {
		return em.find(Topic.class, 501);
	}
}
