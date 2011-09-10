package com.baobaotao.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T> {
	T get(Serializable id);
	List<T> getAll();
//	List<T> find(String hql,);
	void save(Object o);
	void remove(Object o);
	void update(Object o);
}
