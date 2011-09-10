package com.baobaotao.xfire.client;

import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.spring.AbstractXFireSpringTest;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baobaotao.xfire.server.BbtForumService;

public class TextBbtForumService extends AbstractXFireSpringTest {
	@Override
	protected ApplicationContext createContext() {
		return new ClassPathXmlApplicationContext(
				new String[]{"applicationContext.xml"});
	}

	public void testGetRefinedTopicCount() throws Throwable {
		Service serviceModel = new ObjectServiceFactory()
				.create(BbtForumService.class);
		XFireProxyFactory factory = new XFireProxyFactory(getXFire());
		BbtForumService service = (BbtForumService) factory.create(serviceModel,
				"xfire.local://BbtForumService");
		int count = service.getRefinedTopicCount(20);
		assertEquals(count,32);
	}
}
