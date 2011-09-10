package tostringtest;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONFunction;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import net.sf.json.util.PropertyFilter;

import org.apache.commons.beanutils.PropertyUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings({ "deprecation", "unchecked" })
public class JsonlibTest {

	private JSONArray jsonArray = null;
	private JSONObject jsonObject = null;
	private JSONObject json = null;

	private Student bean = null;

	@Before
	public void init() {
		jsonArray = new JSONArray();
		jsonObject = new JSONObject();

		bean = new Student();
		bean.setAddress("address");
		bean.setEmail("email");
		bean.setId(1);
		bean.setName("haha");
		Birthday day = new Birthday();
		day.setBirthday("2010-11-22");
		bean.setBirthday(day);
	}

	@After
	public void destory() {
		jsonArray = null;
		jsonObject = null;
		bean = null;
		System.gc();
	}

	public final void fail(String string) {
		System.out.println(string);
	}

	public final void failRed(String string) {
		System.err.println(string);
	}

	@Test
	public void writeEntity2JSON() {
		fail("==============Java Bean >>> JSON Object==================");
		fail(JSONObject.fromObject(bean).toString());
		fail("==============Java Bean >>> JSON Array==================");
		fail(JSONArray.fromObject(bean).toString());// array会在最外层套上[]
		fail("==============Java Bean >>> JSON Object ==================");
		fail(JSONSerializer.toJSON(bean).toString());

		fail("========================JsonConfig========================");
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Birthday.class,
				new JsonValueProcessor() {
					public Object processArrayValue(Object value,
							JsonConfig jsonConfig) {
						if (value == null) {
							return new Date();
						}
						return value;
					}

					public Object processObjectValue(String key, Object value,
							JsonConfig jsonConfig) {
						fail("key:" + key);
						return value + "##修改过的日期";
					}

				});
		jsonObject = JSONObject.fromObject(bean, jsonConfig);

		fail(jsonObject.toString());
		Student student = (Student) JSONObject
				.toBean(jsonObject, Student.class);
		fail(jsonObject.getString("birthday"));
		fail(student.toString());

		fail("#####################JsonPropertyFilter############################");
		jsonConfig.setJsonPropertyFilter(new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				fail(source + "%%%" + name + "--" + value);
				// 忽略birthday属性
				if (value != null
						&& Birthday.class.isAssignableFrom(value.getClass())) {
					return true;
				}
				return false;
			}
		});
		fail(JSONObject.fromObject(bean, jsonConfig).toString());
		fail("#################JavaPropertyFilter##################");
		jsonConfig.setRootClass(Student.class);
		jsonConfig.setJavaPropertyFilter(new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				fail(name + "@" + value + "#" + source);
				if ("id".equals(name) || "email".equals(name)) {
					value = name + "@@";
					return true;
				}
				return false;
			}
		});
		// jsonObject = JSONObject.fromObject(bean, jsonConfig);
		// student = (Student) JSONObject.toBean(jsonObject, Student.class);
		// fail(student.toString());
		student = (Student) JSONObject.toBean(jsonObject, jsonConfig);
		fail("Student:" + student.toString());
	}

	@Test
	public void writeList2JSON() {
		fail("==============Java List >>> JSON Array==================");
		List<Student> stu = new ArrayList<Student>();
		stu.add(bean);
		bean.setName("jack");
		stu.add(bean);
		fail(JSONArray.fromObject(stu).toString());
		fail(JSONSerializer.toJSON(stu).toString());
	}

	@Test
	public void writeMap2JSON() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("A", bean);

		bean.setName("jack");
		map.put("B", bean);
		map.put("name", "json");
		map.put("bool", Boolean.TRUE);
		map.put("int", new Integer(1));
		map.put("arr", new String[] { "a", "b" });
		map.put("func", "function(i){ return this.arr[i]; }");
		fail("==============Java Map >>> JSON Object==================");
		fail(JSONObject.fromObject(map).toString());
		fail("==============Java Map >>> JSON Array ==================");
		fail(JSONArray.fromObject(map).toString());
		fail("==============Java Map >>> JSON Object==================");
		fail(JSONSerializer.toJSON(map).toString());
	}

	@Test
	public void writeObject2JSON() {
		String[] sa = { "a", "b", "c" };
		fail("==============Java StringArray >>> JSON Array ==================");
		fail(JSONArray.fromObject(sa).toString());
		fail(JSONSerializer.toJSON(sa).toString());
		fail("==============Java boolean Array >>> JSON Array ==================");
		boolean[] bo = { true, false, true };
		fail(JSONArray.fromObject(bo).toString());
		fail(JSONSerializer.toJSON(bo).toString());
		Object[] o = { 1, "a", true, 'A', sa, bo };
		fail("==============Java Object Array >>> JSON Array ==================");
		fail(JSONArray.fromObject(o).toString());
		fail(JSONSerializer.toJSON(o).toString());
		fail("==============Java String >>> JSON ==================");
		fail(JSONArray.fromObject("['json','is','easy']").toString());
		fail(JSONObject.fromObject("{'json':'is easy'}").toString());
		fail(JSONSerializer.toJSON("['json','is','easy']").toString());
		fail("==============Java JSONObject >>> JSON ==================");
		jsonObject = new JSONObject().element("string", "JSON")
				.element("integer", "1").element("double", "2.0")
				.element("boolean", "true");
		fail(JSONSerializer.toJSON(jsonObject).toString());

		fail("==============Java JSONArray >>> JSON ==================");
		jsonArray = new JSONArray().element("JSON").element("1").element("2.0")
				.element("true");
		fail(JSONSerializer.toJSON(jsonArray).toString());

		fail("==============Java JSONArray JsonConfig#setArrayMode >>> JSON ==================");
		List input = new ArrayList();
		input.add("JSON");
		input.add("1");
		input.add("2.0");
		input.add("true");
		JSONArray jsonArray = (JSONArray) JSONSerializer.toJSON(input);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setArrayMode(JsonConfig.MODE_OBJECT_ARRAY);
		Object[] output = (Object[]) JSONSerializer.toJava(jsonArray,
				jsonConfig);
		System.out.println(output[0]);

		fail("==============Java JSONFunction >>> JSON ==================");
		String str = "{'func': function( param ){ doSomethingWithParam(param); }}";
		JSONObject jsonObject = (JSONObject) JSONSerializer.toJSON(str);
		JSONFunction func = (JSONFunction) jsonObject.get("func");
		fail(func.getParams()[0]);
		fail(func.getText());
	}

	@Test
	public void readJSON2Bean() {
		fail("==============JSON Object String >>> Java Bean ==================");
		jsonObject = JSONObject.fromObject(json);
		Student stu = (Student) JSONObject.toBean(jsonObject, Student.class);
		fail(stu.toString());
	}

	@Test
	public void readJSON2DynaBean() {
		try {
			fail("==============JSON Object String >>> Java MorphDynaBean ==================");
			JSON jo = JSONSerializer.toJSON(json);
			Object o = JSONSerializer.toJava(jo);// MorphDynaBean
			fail(PropertyUtils.getProperty(o, "address").toString());
			jsonObject = JSONObject.fromObject(json);
			fail(jsonObject.getString("email"));
			o = JSONSerializer.toJava(jsonObject);// MorphDynaBean
			fail(PropertyUtils.getProperty(o, "name").toString());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
	}

	// @Test
	// public void readJSON2Array() {
	// try {
	// fail("==============JSON Arry String >>> Java Array ==================");
	// json = "[" + json + "]";
	// jsonArray = JSONArray.fromObject(json);
	// fail("#%%%" + jsonArray.get(0).toString());
	// Object[] os = jsonArray.toArray();
	// System.out.println(os.length);
	//
	// fail(JSONArray.fromObject(json).join(""));
	// fail(os[0].toString());
	// Student[] stus = (Student[]) JSONArray.toArray(jsonArray, Student.class);
	// System.out.println(stus.length);
	// System.out.println(stus[0]);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
}
