package com.baobaotao.escape;

import org.springframework.web.util.HtmlUtils;

public class HtmpEscapeExample {
	public static void main(String[] args) {
	   String specialStr = "<div id=\"testDiv\">test1;test2</div>";
       String str1 = HtmlUtils.htmlEscape(specialStr);
       System.out.println("str1:"+str1);
       
       String str2 = HtmlUtils.htmlEscapeDecimal(specialStr);
       System.out.println("str2:"+str2);
       
       String str3 = HtmlUtils.htmlEscapeHex(specialStr);
       System.out.println("str3:"+str3);
       
       System.out.println(HtmlUtils.htmlUnescape(str1));
       System.out.println(HtmlUtils.htmlUnescape(str2));
       System.out.println(HtmlUtils.htmlUnescape(str3));      
	}
}
