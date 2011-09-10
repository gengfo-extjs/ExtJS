package com.baobaotao.web.topic;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.baobaotao.domain.Topic;

public class TopicListExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List<Topic> topicList = (List<Topic>)model.get("topicList");
		HSSFSheet sheet = workbook.createSheet("精华帖子");
		HSSFRow header = sheet.createRow(0);
		header.createCell((short)0).setCellValue("ID");
		header.createCell((short)1).setCellValue("标题");
		header.createCell((short)2).setCellValue("时间");
		
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyy-mm-dd"));
		int rowNum = 1;
		 for (Topic topic : topicList) {
			 HSSFRow row = sheet.createRow(rowNum++);
			 row.createCell((short)0).setCellValue(topic.getTopicId());
			 row.createCell((short)1).setCellValue(topic.getTitle());
			 String createDate = DateFormatUtils.format(topic.getCreateDate(), "yyyy-MM-dd");
			 row.createCell((short)2).setCellValue(createDate);
	     }
	}
}
