package myGroup.service;

import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;

import javax.inject.Named;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;

@Named
public class ServerInfo {

	@ExtDirectMethod
	public String getInfo() {
		OperatingSystemMXBean osBean = ManagementFactory.getOperatingSystemMXBean();

		String infoString = "Arch: %s\nProcessors: %d\nOS Name: %s\nOS Version: %s\n";

		return String.format(infoString, osBean.getArch(), osBean.getAvailableProcessors(), osBean.getName(),
				osBean.getVersion());
	}
}
