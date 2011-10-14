package myGroup.web;

public class FormBean {
	private String firstName;
	private String lastName;
	private String time;
	private String serverInfo;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getServerInfo() {
		return serverInfo;
	}

	public void setServerInfo(String serverInfo) {
		this.serverInfo = serverInfo;
	}

	@Override
	public String toString() {
		return "FormBean [firstName=" + firstName + ", lastName=" + lastName + ", time=" + time + ", serverInfo="
				+ serverInfo + "]";
	}

}
