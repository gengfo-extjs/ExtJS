package com.baobaotao.xfire.server;

import javax.jws.WebService;

@WebService(targetNamespace = "http://www.baobaotao.com")
public interface BbtForumService {
   int getRefinedTopicCount(int lastDay);
}
