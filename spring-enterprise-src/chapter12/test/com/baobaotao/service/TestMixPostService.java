package com.baobaotao.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
import org.springframework.util.FileCopyUtils;

import com.baobaotao.domain.Forum;
import com.baobaotao.domain.Post;
import com.baobaotao.domain.Topic;

public class TestMixPostService
		extends
			AbstractDependencyInjectionSpringContextTests {
	private MixPostService postService;

	public void setPostService(MixPostService postService) {
		this.postService = postService;
	}

	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext-mix.xml"};
	}

	public void testAddPost() throws Exception {
		System.out.println("begin........");
		Post post = new Post();
		post.setUserId(2);
		ClassPathResource res = new ClassPathResource("temp.jpg");
		byte[] mockImg = FileCopyUtils.copyToByteArray(res.getFile());
		post.setPostAttach(mockImg);
		post.setPostText("test post --23");
		Topic topic = new Topic();
		topic.setTopicId(4);
		post.setTopic(topic);
		postService.addPost(post);
		System.out.println("end........");
		Class c = byte[].class;
	}

	// public void testGetPost() throws Exception {
	// System.out.println("begin........");
	// Post p = postService.getPost(5);
	// System.out.println("post:" + p);
	// System.out.println("end........");
	// }

}
