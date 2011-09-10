package com.baobaotao.xfire.client;

public class StubClient {
	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		BbtForumServiceClient client = new BbtForumServiceClient();
		String serviceUrl = "http://localhost:8080/baobaotao/service/BbtForumService";
		BbtForumServicePortType portType = client.getBbtForumServiceHttpPort(serviceUrl);
		int count = portType.getRefinedTopicCount(20);
		System.out.println("count:" + count);
		start = System.currentTimeMillis() - start;
		System.out.println("time:" + start);
	}
}
