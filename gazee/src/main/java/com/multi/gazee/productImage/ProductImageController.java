package com.multi.gazee.productImage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ProductImageController {
	
	@Autowired
	ProductImageDAO productImagedao;

	@RequestMapping("productImage/productImageThumbnail")
	@ResponseBody
	public String productImageThumbnail(int productId) {
		ProductImageVO productImageVO = productImagedao.productImageThumbnail(productId);
		String thumbnail = productImageVO.getProductImageName();
		String thumbnailAddr = "http://awswlqccbpkd17595311.cdn.ntruss.com/"+thumbnail+"?type=f&w=120&h=120";
		return thumbnailAddr;
	}
}
