package com.multi.gazee.transactionHistory;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionHistoryDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public int select(String id) {
		int balance;

		try {
			balance = my.selectOne("history.select", id);
		} catch (Exception e) {
			balance = 0;
		}
		
		return balance;
	}
	
	public int insert(TransactionHistoryVO transactionHistoryVO) {
		int result = my.insert("history.insert", transactionHistoryVO);
		return result;
	}
	
    /* ALL */
    public List<TransactionHistoryVO> listTransactionHistory() {
        List<TransactionHistoryVO> transactionHistoryVo = my.selectList("history.all");
        return transactionHistoryVo;
    }
    
    /* ONE */
    public TransactionHistoryVO one(String id) {
        TransactionHistoryVO bag = my.selectOne("history.one",id);
        return bag;
    }
	
}
