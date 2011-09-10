package com.baobaotao.io;
import java.util.Locale;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.LocalizedResourceHelper;
public class LocaleResourceTest {
	public static void main(String[] args){
		LocalizedResourceHelper lrHalper = new LocalizedResourceHelper();
		Resource msg_us  = lrHalper.findLocalizedResource("i18n/message", ".properties", Locale.US);
		Resource msg_cn  = lrHalper.findLocalizedResource("i18n/message", ".properties", Locale.CHINA);
		System.out.println("fileName(us):"+msg_us.getFilename()); 
		System.out.println("fileName(cn):"+msg_cn.getFilename());
	}
}
