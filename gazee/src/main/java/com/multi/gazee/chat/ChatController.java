package com.multi.gazee.chat;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.gazee.member.MemberDAO;

@Controller
public class ChatController {
	
	@Autowired
	ChatDAO dao;
	
	@Autowired
	ChatMessageDAO dao2;
	
	@Autowired
	MemberDAO memberDao;

	@RequestMapping("chat/chatRoomCreate")
	@ResponseBody
	public int chatRoomCreate(ChatVO bag) {
		int result = dao.create(bag);
		if (result != 0) {
			return result;
		} else {
			return 0;
		}
	}
	
	@RequestMapping("chat/chatRoomCheck")
	@ResponseBody
	public int chatRoomCheck(ChatVO bag) {
		ChatVO bag2 = dao.chatRoomSearch(bag);
		if (bag2 != null) {
			return bag2.getRoomId();
		} else {
			return 0;
		}
	}
	
	@RequestMapping("chat/myChatList")
	public void myChatList(String memberId, Model model) {
		List<ChatVO> list = dao.chatList(memberId);
		for (int i = 0; i < list.size(); i++) {
			String sellerNickname = memberDao.nickname(list.get(i).getSellerId());
			String buyerNickname = memberDao.nickname(list.get(i).getBuyerId());
			if (list.get(i).getBuyerId().equals(memberId)) { //구매자 아이디와 로그인 아이디가 같을 경우
				list.get(i).setChatPartner(sellerNickname); //판매자 닉네임이 보이게
			} else {
				list.get(i).setChatPartner(buyerNickname); //아닐 시 구매자 닉네임이 보이게
			}
			int roomId = list.get(i).getRoomId(); //각각의 roomId를 가져와서
			ChatMessageVO bag = dao2.lastMessageList(roomId); //마지막 메세지를 찾아와서
			//마지막 메세지가 있을 시
			if (bag != null) {
				Date date = new Date(bag.getDate().getTime() * 1000L);
				SimpleDateFormat format = new SimpleDateFormat("HH:mm");
				String time = format.format(date);
				list.get(i).setLastMessage(bag.getContent()); //list에 추가
				list.get(i).setLastMessageTime(time);
				
				//메세지가 있으면 정렬을 맨 위로
				ChatVO item = list.get(i);
			    list.remove(i);
			    list.add(0, item);
			} else {
				list.get(i).setLastMessage("채팅을 시작해보세요!");
				list.get(i).setLastMessageTime(" ");
			}
		}
		model.addAttribute("list", list);
	}
	
	@RequestMapping("chat/chatRoomEntry")
	public void chatRoomEntry(int roomId, Model model, HttpSession session) {
		ChatAndProductVO bag = dao.chatRoomEntry(roomId);
		String sellerNickname = memberDao.nickname(bag.getSellerId());
		String buyerNickname = memberDao.nickname(bag.getBuyerId());
		DecimalFormat decFormat = new DecimalFormat("###,###");
		String priceDec = decFormat.format(bag.getPrice());
		model.addAttribute("priceDec", priceDec);
		model.addAttribute("dealType", bag.getDealType());
		model.addAttribute("sellerId", bag.getSellerId());
		model.addAttribute("sellerNickname", sellerNickname);
		model.addAttribute("buyerNickname", buyerNickname);
		model.addAttribute("bag", bag);
	}
	
	@RequestMapping("chat/roomLeave")
	@ResponseBody
	public int roomLeave(int roomId) {
		int result = dao.roomLeave(roomId);
		return result;
	}
	
	@RequestMapping("chat/paymentModal")
	public void paymentModal(int roomId, Model model) {
		ChatAndProductVO bag = dao.chatRoomEntry(roomId);
		DecimalFormat decFormat = new DecimalFormat("###,###");
		String priceDec = decFormat.format(bag.getPrice());
		model.addAttribute("bag", bag);
		model.addAttribute("dealType", bag.getDealType());
		model.addAttribute("priceDec", priceDec);
	}
		
}
