package com.multi.gazee.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.gazee.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;
	
	@RequestMapping("order/orderComplete")
	@ResponseBody
	public int orderComplete(OrderVO orderVO) {
		return orderService.orderComplete(orderVO);
	}

}
