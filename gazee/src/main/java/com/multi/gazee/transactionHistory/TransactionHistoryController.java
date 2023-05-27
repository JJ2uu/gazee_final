package com.multi.gazee.transactionHistory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TransactionHistoryController {
	
	@Autowired
	TransactionHistoryDAO dao;
	
	@RequestMapping("transactionHistory/checkBalance")
	@ResponseBody
	public int checkBalance(String memberId) {
		int balance = dao.select(memberId);
		return balance;
	}
}
