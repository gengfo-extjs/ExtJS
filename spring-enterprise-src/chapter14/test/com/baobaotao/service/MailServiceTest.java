package com.baobaotao.service;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
public class MailServiceTest
		extends
			AbstractDependencyInjectionSpringContextTests {
	private MailService mailService;
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	protected String[] getConfigLocations() {
		return new String[]{"classpath:applicationContext.xml"};
	}
	// public void testSendSimpleMail()
	// {
	// mailService.sendSimpleMail(100);
	// System.out.println("发送成功！");
	// }
	// public void testSendHtmlMail()
	// {
	// try {
	// mailService.sendHtmlMail(100);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// System.out.println("发送成功！");
	// }

	// public void testSendInlineMail() {
	// try {
	// mailService.sendInlineMail();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// System.out.println("发送成功！");
	// }

	// public void testSendAttachmentMail() {
	// try {
	// mailService.sendAttachmentMail();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// System.out.println("发送成功！");
	// }

	// public void testSendAlternativeMail() {
	// try {
	// mailService.sendAlternativeMail();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// System.out.println("发送成功！");
	// }

//	public void testSendTemplateMail() {
//		try {
//			long s = System.currentTimeMillis();
//			mailService.sendTemplateMail(100);
//			s = s - System.currentTimeMillis();
//			System.out.println("s:"+s);
//	
//		} catch (Exception e) {
//			e.printStackTrace();
//		}		
//		System.out.println("发送成功！");
//	}
	
	public void testSendAsyncMail() {
		try {
			long s = System.currentTimeMillis();
			mailService.sendAsyncMail(100);
			s = s - System.currentTimeMillis();
			System.out.println("s:"+s);	
		} catch (Exception e) {
			e.printStackTrace();
		}		
		System.out.println("调用结束！");
		try {
			Thread.sleep(15000);//防止JVM停止导致执行器关闭
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}	
}
