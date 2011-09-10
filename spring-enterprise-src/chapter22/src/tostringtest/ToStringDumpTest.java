package tostringtest;

import java.util.ArrayList;
import java.util.List;

public class ToStringDumpTest {

	public static void main(String args[]) {

		Order o = new Order();
		o.setId("order id 1");
		OrderItem oi = new OrderItem();
		oi.setItemId("item id 1");
		List<OrderItem> list = new ArrayList<OrderItem>();
		o.setItemList(list);
		o.getItemList().add(oi);

		//dump(o);

	}

}
