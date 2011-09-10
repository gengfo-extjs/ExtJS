package com.baobaotao.dao.jpa;



import org.springframework.test.jpa.AbstractJpaTests;

import com.baobaotao.dao.PostDao;
import com.baobaotao.dao.TopicDao;

public class TestBbtDao extends AbstractJpaTests {

	private TopicDao topicDao;
	private PostDao postDao;

	public void setPostDao(PostDao postDao) {
		this.postDao = postDao;
	}

	public TestBbtDao() {
		super.setDependencyCheck(false);
	}

	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}

	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
	// public String getActualOrmXmlLocation(){
	// return "META-INF/jpa-orm.xml";
	// }
	public void testAddTopic() {
		// PollTopic pt = new PollTopic();
		// pt.setTopicTitle("dc");
		// pt.setTopicTime(new Date());
		// pt.setMaxChoices(1);
		// pt.setMultiple(true);
		//
		// PollOption po1 = new PollOption();
		// po1.setOptionItem("xx1");
		// po1.setPollTopic(pt);
		//
		// PollOption po2 = new PollOption();
		// po2.setOptionItem("xx2");
		// po2.setPollTopic(pt);
		//
		// pt.addOption(po1);
		// pt.addOption(po2);
		// topicDao.addTopic(pt);
		//
		// super.setComplete();
	}
	
	public void testTest() {
		postDao.test();
		super.setComplete();
	}	

	public void testAddPost() throws Throwable {
//		Post post = new Post();
//		post.setPostText("测试帖内容");
//		ClassPathResource res = new ClassPathResource("temp.jpg");
//		byte[] mockImg = FileCopyUtils.copyToByteArray(res.getFile());
//		post.setPostAttach(mockImg);
//		postDao.addPost(post);
//		super.setComplete();
	}
}
