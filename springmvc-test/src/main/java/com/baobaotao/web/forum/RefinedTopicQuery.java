package com.baobaotao.web.forum;
import java.util.Date;
public class RefinedTopicQuery {
	private Date beginDate;

	private int forumId;
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public int getForumId() {
		return forumId;
	}
	public void setForumId(int forumId) {
		this.forumId = forumId;
	}
}
