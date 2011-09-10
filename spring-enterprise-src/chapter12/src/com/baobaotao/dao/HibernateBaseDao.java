package com.baobaotao.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class HibernateBaseDao<T> extends HibernateDaoSupport implements BaseDao<T>{
	private Class<T> entityClass;
	public HibernateBaseDao() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		entityClass =  (Class)params[0];
	}
	public T get(Serializable id) {
		return (T)getHibernateTemplate().load(entityClass, id);
	}
	 public List<T> getAll() {
		return getHibernateTemplate().loadAll(entityClass);
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