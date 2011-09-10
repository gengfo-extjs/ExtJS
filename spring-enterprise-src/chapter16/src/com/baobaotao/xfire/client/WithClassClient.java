package com.baobaotao.xfire.client;

import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import com.baobaotao.xfire.server.BbtForumService;

public class WithClassClient {
	public int getRefinedTopicCount() {
		Service serviceModel = new ObjectServiceFactory()
				.create(BbtForumService.class);
		String serviceURL = "http://localhost:8088/baobaotao/service/BbtForumService";
		BbtForumService service = null;
		try {
			service = (BbtForumService) new XFireProxyFactory().create(
					serviceModel, serviceURL);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return service.getRefinedTopicCount(20);
	}

	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		WithClassClient client = new WithClassClient();
		System.out.println("topic count is:"+client.getRefinedTopicCount());
		start = System.currentTimeMillis()-start;
		System.out.println("time:"+start);
	}
}
