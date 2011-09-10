package com.baobaotao.dao.jdbc;

import org.springframework.core.io.ClassPathResource;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
import org.springframework.util.FileCopyUtils;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class TestPostJdbcDao
		extends
			AbstractDependencyInjectionSpringContextTests {
	private PostDao postDao;
	
	public void setPostDao(PostDao postDao) {
		this.postDao = postDao;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
//    public void testGetNativeConn(){
//    	postDao.getNativeConn();
//    }	
	public void testAddPost() throws Throwable{
		Post post = new Post();
		post.setPostId(1);
		post.setUserId(2);
		ClassPathResource res = new ClassPathResource("temp.jpg");
		byte[] mockImg = FileCopyUtils.copyToByteArray(res.getFile());	
		post.setPostAttach(mockImg);
		post.setPostText("测试帖子的内容");
		postDao.addPost(post);
	}
	
//    public void testgetAttach() throws Throwable{
//    	FileOutputStream fos = new FileOutputStream("d:/temp.jpg");
//    	postDao.getAttach(1, fos);
//    }
//    
//    public void testgetAttachs() throws Throwable{    	
//    	List list = postDao.getAttachs(2);
//    	for (Iterator iter = list.iterator(); iter.hasNext();) {
//			Post post = (Post) iter.next();
//			System.out.println(post.getPostId()+";"+post.getPostAttach().length);
//		}
//    }	    

}
