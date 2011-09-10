package com.baobaotao.service;
import com.baobaotao.service.BbtForum;
class GroovyBbtForum implements BbtForum {
	def desc;
	public void setDesc(String desc){
		this.desc = desc; 
	}
	public String getDesc(){
		return desc;
	}
}