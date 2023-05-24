package com.multi.gazee.order;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.gazee.chat.ChatDAO;
import com.multi.gazee.chat.ChatVO;
import com.multi.gazee.member.MemberDAO;
import com.multi.gazee.member.MemberVO;

@Controller
public class OrderController {

	@Autowired
	OrderDAO orderDao;
	
	@Autowired
	ChatDAO chatDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@RequestMapping("order/orderComplete")
	@ResponseBody
	public int orderComplete(OrderVO orderBag) {
		ChatVO chatBag = chatDao.chatRoomOne(orderBag.getRoomId());
		MemberVO memberBag = memberDao.searchOne(chatBag.getBuyerId());
		String formatNo = String.format("%0" + 10 + "d", memberBag.getNo());
		String memberId = memberBag.getId().substring(0, 2);
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String paymentDate = sdf.format(new Date());
		StringBuilder sb = new StringBuilder();
		sb.append("o");
		sb.append(formatNo);
		sb.append(memberId);
		sb.append(paymentDate);
		
		orderBag.setTransactionId(String.valueOf(sb));
		orderBag.setRoomId(orderBag.getRoomId());
		orderBag.setDealType(chatBag.getDealType());
		orderBag.setProductId(chatBag.getProductId());
		orderBag.setSellerId(chatBag.getSellerId());
		orderBag.setBuyerId(chatBag.getBuyerId());
		
		int result = orderDao.orderComplete(orderBag);
		return result;
	}
}
