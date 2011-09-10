package com.baobaotao.model;

import java.util.Date;


public class Book extends Product {


	private String author;

	private String image;


	private String publisher;

	private Date publishDate;


	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}


	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}


	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public Date getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
}
