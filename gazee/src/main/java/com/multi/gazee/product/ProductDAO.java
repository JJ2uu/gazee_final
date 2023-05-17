package com.multi.gazee.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductDAO {

	@Autowired
	SqlSessionTemplate my;
	
	public ProductVO productone(int productId) {
		ProductVO bag = my.selectOne("product.productOne", productId);
		return bag;
	}

}
