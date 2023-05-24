package com.multi.gazee.order;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderDAO {

	@Autowired
	SqlSessionTemplate my;
	
	public int orderComplete(OrderVO bag) {
		int result = my.insert("order.insert", bag);
		return result;
	}
}
