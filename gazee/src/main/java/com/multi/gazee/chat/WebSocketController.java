package com.multi.gazee.chat;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.bson.BsonTimestamp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WebSocketController {
	
	@Autowired
	ChatMessageDAO dao;
	
	@MessageMapping("/chat/{roomId}")
	@SendTo("/topic/{roomId}")
	public ChatOutputMessage chatMessage(ChatMessageVO message, @DestinationVariable String roomId) {
		BsonTimestamp timestamp = new BsonTimestamp((int) (System.currentTimeMillis() / 1000), 0);
		message.setDate(timestamp);
		message.setRoomId(Integer.parseInt(roomId));
		dao.insert(message);
		ChatOutputMessage output = new ChatOutputMessage();
		output.setRoomId(roomId);
		output.setSender(message.getSender());
		output.setContent(message.getContent());
		SimpleDateFormat simple2 = new SimpleDateFormat("HH:mm");
		output.setTime(simple2.format(new Timestamp(System.currentTimeMillis())));
		return output;
	}

}
