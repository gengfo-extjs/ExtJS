package com.baobaotao.service;

import java.util.ArrayList;
import java.util.List;

import com.baobaotao.model.Book;
import com.baobaotao.springside.xfire.server.simple.BookService;



/**
 * 图书管理业务类.
 * 继承于HibernateEntityDao,拥有默认的对Book对象的CRUD函数.
 * 因为<code>Category</code>实体过于简单,没有独立的Manager,因此BookManager同时充当了CategoryDao的角色.
 *
 * @author calvin
 * @see HibernateEntityExtendDao
 * @see org.springside.core.dao.HibernateGenericDao
 */
public class BookManager implements BookService {


	/**
	 * 按目录列出图书.
	 */
	public List<Book> findBooksByCategory(String categoryId) {
		Book b = new Book();
		b.setAuthor("chenxh");
		b.setCategory(null);
		b.setId(12);
		b.setName("master Spring");
		List<Book> lb = new ArrayList<Book>();
		lb.add(b);
		return lb;
	}

}
