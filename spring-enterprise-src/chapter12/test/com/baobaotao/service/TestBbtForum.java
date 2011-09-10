package com.baobaotao.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
import org.springframework.util.FileCopyUtils;

import com.baobaotao.domain.Forum;
import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;

public class TestBbtForum extends AbstractDependencyInjectionSpringContextTests {
	private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
	// public void testAddForum() throws Exception {
	// System.out.println("begin........");
	// Forum forum = new Forum();
	// forum.setForumName("forum name1");
	// forum.setForumDesc("forum desc 1");
	// bbtForum.addForum(forum);
	// System.out.println("end........");
	// }

	public void testGetForum() throws Exception {
		System.out.println("begin........");
		Forum forum = bbtForum.getForum(1);
		System.out.println(forum);
		System.out.println("end........");
	}

	// public void testAddPost() throws Exception {
	// System.out.println("begin........");
	// Post post = new Post();
	// post.setUserId(2);
	// ClassPathResource res = new ClassPathResource("temp.jpg");
	// byte[] mockImg = FileCopyUtils.copyToByteArray(res.getFile());
	// post.setPostAttach(mockImg);
	// post.setPostText("test post --23");
	// Topic topic = new Topic();
	// topic.setTopicId(4);
	// post.setTopic(topic);
	// bbtForum.addPost(post);
	// System.out.println("end........");
	// Class c = byte[].class;
	// }

	// public void testGetForunNum() throws Exception {
	// long i = bbtForum.getForumNum();
	// System.out.println("i:"+i);
	//		
	// List forums = bbtForum.findForumByName("");
	// assertTrue(forums.size() > 0);
	//		
	// Forum forum = bbtForum.getForum(4);
	// assertNotNull(forum);
	// }
	// public void testGetForum() throws Exception {
	// System.out.println("begin........");
	// Forum f = bbtForum.getForum(4);
	// System.out.println("forum:"+f);
	// System.out.println("end........");
	// }

//	public void testGetPost() throws Exception {
//		System.out.println("begin........");
//		Post p = bbtForum.getPost(5);
//		System.out.println("post:" + p);
//		System.out.println("end........");
//	}

}
