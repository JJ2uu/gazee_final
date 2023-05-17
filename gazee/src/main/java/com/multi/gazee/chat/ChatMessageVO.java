package com.multi.gazee.chat;

import org.bson.BsonTimestamp;

public class ChatMessageVO {
	
	private int roomId;
	private String sender;
	private String content;
	private BsonTimestamp date;
	
	private String time;
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public BsonTimestamp getDate() {
		return date;
	}
	public void setDate(BsonTimestamp date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Override
	public String toString() {
		return "ChatMessageVO [roomId=" + roomId + ", sender=" + sender + ", content=" + content + ", date=" + date
				+ ", time=" + time + "]";
	}
	
}
