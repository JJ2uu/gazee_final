package com.multi.gazee.scheduler;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.multi.gazee.product.ProductDAO;

@Component
public class ProductScheduler {
	
	@Autowired
	ProductDAO productDao;
	
	private int productId; // 클래스의 멤버 변수로 선언

	public void setProductId(int productId) {
	    this.productId = productId;
	}

    @Scheduled(initialDelay = 10 * 60 * 1000, fixedDelay = Long.MAX_VALUE) // 10분 후에 실행
    public void scheduleSellTimeUpdate() {
    	LocalDateTime currentTime = LocalDateTime.now();
        System.out.println("Scheduled task is executing at: " + currentTime);
        productDao.sellTimeDelete(productId);
    }
}
