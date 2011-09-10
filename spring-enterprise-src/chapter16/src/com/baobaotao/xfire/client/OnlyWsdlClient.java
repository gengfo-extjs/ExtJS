package com.baobaotao.xfire.client;
import java.net.URL;
import org.codehaus.xfire.client.Client;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class OnlyWsdlClient {
	public int getRefinedTopicCount() {
		try {
//			URL serviceURL = new URL(
//					"http://localhost:8080/baobaotao/service/BbtForumService?wsdl");
			String wsdl = "com/baobaotao/xfire/client/BbtForumService.wsdl";
			Resource resource = new ClassPathResource(wsdl);
			Client client = new Client(resource.getInputStream(), null);
			Object[] results = client.invoke("getRefinedTopicCount",
					new Object[]{20});
			return (Integer) results[0];
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		OnlyWsdlClient client = new OnlyWsdlClient();
		System.out.println("topic count is:" + client.getRefinedTopicCount());
		start = System.currentTimeMillis() - start;
		System.out.println("time:" + start);
	}
}
