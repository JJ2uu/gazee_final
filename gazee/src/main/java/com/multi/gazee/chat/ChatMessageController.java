package com.multi.gazee.chat;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatMessageController {

	@Autowired
	ChatMessageDAO dao;
	
	@RequestMapping("chat/chatMessageList")
	@ResponseBody
	public ArrayList<ChatMessageVO> list(int roomId) {
		ArrayList<ChatMessageVO> arrList = dao.list(roomId);
		return arrList;
	}
	
	@RequestMapping("chat/chatLastMessage")
	@ResponseBody
	public ChatMessageVO lastMeesage(int roomId) {
		ChatMessageVO bag = dao.lastMessageList(roomId);
		return bag;
	}
}
