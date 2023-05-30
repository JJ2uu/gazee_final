package com.multi.gazee.productImage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.gazee.product.ProductVO;

@Component
public class ProductImageDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public ProductImageVO productImage(int productId) {
		ProductImageVO bag = my.selectOne("productImage.productImage",productId);
		return bag;
	}
	
	public ProductImageVO productImageThumbnail(int productId) {
		ProductImageVO bag = my.selectOne("productImage.productImageThumbnail",productId);
		return bag;
	}
	
	public void productImageDelete(ProductVO product) {
		int result = my.delete("productImage.productImageDelete", product);
		System.out.println(result);
	}
}
