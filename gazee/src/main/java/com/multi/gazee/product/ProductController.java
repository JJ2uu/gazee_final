package com.multi.gazee.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ProductController {
	
	@Autowired
	ProductDAO dao;
	
	@RequestMapping("product/productOne")
	@ResponseBody
	public ProductVO productOne(int roomId) {
		ProductVO bag = dao.productone(roomId);
		return bag;
	}

}
