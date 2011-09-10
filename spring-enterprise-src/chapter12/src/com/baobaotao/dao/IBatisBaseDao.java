package com.baobaotao.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
@SuppressWarnings("unchecked")
public class IBatisBaseDao<T> extends SqlMapClientDaoSupport{
	private Class<T> entityClass;
	public IBatisBaseDao() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		entityClass =  (Class)params[0];
	}

	public void save(Object o) {
		getHibernateTemplate().saveOrUpdate(o);
	}
	public void remove(Object o) {
		getHibernateTemplate().delete(o);
	}
	public void update(Object o) {
		getHibernateTemplate().update(o);		
	}
}