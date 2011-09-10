package com.baobaotao.other;
import java.io.StringReader;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.springframework.util.xml.DomUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;

public class DomUtilsExample {
	
	public static void main(String[] args) throws Throwable{
        String xmlStr = "<tr><td>姓名</td><td>Tom</td></tr>";
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document dom = builder.parse(new InputSource(new StringReader(xmlStr)));
        
        Element tdEle = DomUtils.getChildElementByTagName(dom.getDocumentElement(),"td");
        System.out.println(DomUtils.getTextValue(tdEle));
	}	
}

