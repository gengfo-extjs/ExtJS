package reflection;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DebugProxy implements InvocationHandler {

	private final Object obj; // underlying object
	private final List<Method> methods; // methods invoked
	private final List<Method> history; // viewable history

	private DebugProxy(Object obj) {
		this.obj = obj;
		methods = new ArrayList<Method>();
		history = Collections.unmodifiableList(methods);
	}

	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {

		methods.add(method); //log the call

		return method.invoke(obj, args);
	}

	public static synchronized Object proxyFor(Object obj) {
		Class<?> objClass = obj.getClass();

		return Proxy.newProxyInstance(objClass.getClassLoader(),
				objClass.getInterfaces(), new DebugProxy(obj));

	}

	public List<Method> getHistory() {
		return history;

	}
}
