package com.baobaotao.web.topic;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.baobaotao.domain.Topic;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Table;
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

        table.addCell("ID");
        table.addCell("标题");
        table.addCell("日期");
        for (Topic topic : topicList) {
			table.addCell(""+topic.getTopicId());
			table.addCell(topic.getTitle());    
			String createDate = DateFormatUtils.format(topic.getCreateDate(), "yyyy-MM-dd");
			table.addCell(createDate);
		}
        document.add(table);
	}
}
