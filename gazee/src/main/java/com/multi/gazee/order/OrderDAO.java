package com.multi.gazee.order;

import java.sql.Timestamp;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.gazee.member.MemberVO;
import com.multi.gazee.service.TransactionService;

@Component
public class OrderDAO {

	@Autowired
	SqlSessionTemplate my;
	
	@Autowired
	TransactionService transactionService;
	
	/* 주문 완료 Insert */
	public int orderComplete(OrderVO orderVO, MemberVO memberVO, int paid_amount, int balance) {
		Timestamp transactionTime = transactionService.getTransactionTime();
		String transactionId = transactionService.makeIdentifier("o", memberVO, transactionTime);
		orderVO.setTransactionId(transactionId);
		int result = my.insert("order.insert", orderVO);
		//transactionService.orderToTransactionHistory(orderVO, paid_amount, balance);
		
		return result;
	}
	
	/* 주문 상태 확인 */
	public OrderVO orderCheck(int productId) {
		OrderVO orderVO = my.selectOne("order.check", productId);
		return orderVO;
	}
}
