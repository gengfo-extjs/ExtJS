package mypack;

public class MainTstObject {

	private MayMockObject mayMockObject;

	public String create(String str1, String str2) {
		return str1 + this.mayMockObject.getString(str2);
	}

	public void setMayMockObject(MayMockObject mayMockObject) {
		this.mayMockObject = mayMockObject;
	}
}
