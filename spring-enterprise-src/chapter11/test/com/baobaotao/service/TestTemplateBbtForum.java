package com.baobaotao.service;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.baobaotao.domain.Topic;
public class TestTemplateBbtForum {

	 public static void main(String[] args) {
		 
		 String[] path = new String[]{"classpath:applicationContext.xml"};
		 ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(path);
//		 System.out.println("here1");
//		 PostDao postDao = (PostDao)ctx.getBean("postDao");
//		 System.out.println("here2");
//		 Post post = new Post();
//		 post.setPostText("aaa");
//		 System.out.println("here3");
//		 postDao.addPost(post);
//		 System.out.println("here4");	 
		 BbtForum bbtForum = (BbtForum)ctx.getBean("bbtForum");
		 Topic t = bbtForum.getTopic(501);
		 System.out.println(t);
	}
}
