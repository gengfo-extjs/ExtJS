package com.baobaotao.web.topic;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.baobaotao.domain.Topic;
import com.lowagie.text.Cell;

public class TopicListExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List<Topic> topicList = (List<Topic>)model.get("topicList");
		HSSFSheet sheet = workbook.createSheet("refined Topic");
		HSSFRow header = sheet.createRow(0);
		createCnCell(header,0,"ID");
		createCnCell(header,1,"标题");
		createCnCell(header,2,"时间");
		
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyy-mm-dd"));
		int rowNum = 1;
		for (Topic topic : topicList) {
			 HSSFRow row = sheet.createRow(rowNum++);
			 createCnCell(row,0,""+topic.getTopicId());
			 createCnCell(row,1,topic.getTitle());
			 String createDate = DateFormatUtils.format(topic.getCreateDate(), "yyyy-MM-dd");
			 createCnCell(row,2,createDate);
	     }
	}
	
	private HSSFCell createCnCell(HSSFRow row,int colIndex,String content){
		HSSFCell cell = row.createCell((short)colIndex);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell.setCellValue(content);
		return cell;
	}
}
