package reflection;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class SimpleClassDesc {

	public static void main(String[] args) throws IllegalArgumentException,
			IllegalAccessException, InvocationTargetException {
		SimpleClassDesc scd = new SimpleClassDesc();

		Class type = scd.getClass();

		System.out.println(type.getName());

		for (int i = 0; i < type.getMethods().length; i++) {
			Method m = type.getMethods()[i];

			// m.invoke(obj, args)
			if ("test".equals(m.getName())) {

				m.invoke(scd, null);

			}

			if ("testHello".equals(m.getName())) {

				m.invoke(scd, "world");
			}

			System.out.println(m.toString());
			System.out.println(m.getName());
			System.out.println(m.getModifiers());
		}
	}

	public static void test() {

		System.out.println("test be invoked");

	}

	public static void testHello(String who) {

		System.out.println("test be invoked" + who);

	}
}
