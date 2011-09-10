
package com.baobaotao.service;

import java.util.List;

import org.codehaus.xfire.spring.AbstractXFireSpringTest;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baobaotao.model.Book;
import com.baobaotao.xfire.client.security.BookServiceWSS4JClient;


public class TestBbtForumWebService extends AbstractXFireSpringTest {
	
	@Override 
    protected ApplicationContext createContext() { 
       return new ClassPathXmlApplicationContext( new String[] { 
              "com/baobaotao/xfire/applicationContext-xfire-security.xml"}); 
    }   
    public void testService() throws Exception 
    { 
//    	Collection coll = getServiceRegistry().getServices();
//    	System.out.println("coll:"+coll.size());
//    	for (Iterator iter = coll.iterator(); iter.hasNext();) {
//    		Service s = (Service) iter.next();
//			String uri =s.getName().getNamespaceURI();
//			System.out.println("uri:"+uri);
//		}
//        Document wsdl = getWSDLDocument("BookServiceJSR181"); 
//        printNode(wsdl);
//    	Document response = invokeService("BbtForumWebService", "/request_soap.xml");
//    	printNode(response);

    	BookServiceWSS4JClient client = new BookServiceWSS4JClient();
    	client.setServiceURL("http://localhost:8088/baobaotao/service/BookServiceWSS4J");
    	List<Book>  list = client.findBooksByCategory("1", "WSS4J");
    	System.out.println("list.size:"+list.size());
    }
}
