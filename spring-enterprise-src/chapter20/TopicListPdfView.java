package com.baobaotao.web.topic;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.baobaotao.domain.Topic;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class TopicListPdfView extends AbstractPdfView {
	@Override
	protected void buildPdfDocument(Map model, Document document, PdfWriter writer, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Topic> topicList = (List<Topic>)model.get("topicList");
        Table table = new Table(3);
        table.setWidth(80);
        table.setBorder(1);
        table.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
        table.setDefaultVerticalAlignment(Element.ALIGN_MIDDLE);
		
        BaseFont cnBaseFont = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);
        Font cnFont = new Font(cnBaseFont, 10, Font.NORMAL, Color.BLUE);


        table.addCell(buildFontCell("cc",cnFont));
        table.addCell(buildFontCell("主题",cnFont));
        table.addCell(buildFontCell("时间",cnFont));
        for (Topic topic : topicList) {
			table.addCell(buildFontCell(""+topic.getTopicId(),cnFont));
			table.addCell(buildFontCell(topic.getTitle(),cnFont));    
			String createDate = DateFormatUtils.format(topic.getCreateDate(), "yyyy-MM-dd");
			table.addCell(buildFontCell(createDate,cnFont));
		}
        document.add(table);
	}
	
	private Cell buildFontCell(String content,Font font) throws RuntimeException{ 
		try {
			Phrase phrase = new Phrase(content, font);
			return new Cell(phrase);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}		
	}
}
