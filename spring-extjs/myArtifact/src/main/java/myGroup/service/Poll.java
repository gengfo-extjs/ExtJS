package myGroup.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.inject.Named;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

@Named
public class Poll {

	@ExtDirectMethod(value = ExtDirectMethodType.POLL, event = "timeChange")
	public String currentTime() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd 'at' hh:mm:ss");
		return formatter.format(now);
	}

}