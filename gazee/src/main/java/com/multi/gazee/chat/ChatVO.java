package com.multi.gazee.chat;

import java.sql.Timestamp;

public class ChatVO {
	private int roomId;
	private String sellerId;
	private String buyerId;
	private int productId;
	private String dealType;
	private Timestamp dealDirectDate;
	private Timestamp lastMessageDate;
	
	// 출력용 변수
	private String chatPartner;
	private String lastMessage;
	private String lastMessageTime;

	public String getChatPartner() {
		return chatPartner;
	}
	public void setChatPartner(String chatPartner) {
		this.chatPartner = chatPartner;
	}
	public int getRoomId() {
		return roomId;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	
	public String getDealType() {
		return dealType;
	}
	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	
	public Timestamp getDealDirectDate() {
		return dealDirectDate;
	}
	public void setDealDirectDate(Timestamp dealDirectDate) {
		this.dealDirectDate = dealDirectDate;
	}
	public String getLastMessage() {
		return lastMessage;
	}
	public void setLastMessage(String lastMessage) {
		this.lastMessage = lastMessage;
	}
	public String getLastMessageTime() {
		return lastMessageTime;
	}
	public void setLastMessageTime(String lastMessageTime) {
		this.lastMessageTime = lastMessageTime;
	}
	public Timestamp getLastMessageDate() {
		return lastMessageDate;
	}
	public void setLastMessageDate(Timestamp lastMessageDate) {
		this.lastMessageDate = lastMessageDate;
	}
	@Override
	public String toString() {
		return "ChatVO [roomId=" + roomId + ", sellerId=" + sellerId + ", buyerId=" + buyerId + ", productId="
				+ productId + ", dealType=" + dealType + ", dealDirectDate=" + dealDirectDate + ", lastMessageDate="
				+ lastMessageDate + ", chatPartner=" + chatPartner + ", lastMessage=" + lastMessage
				+ ", lastMessageTime=" + lastMessageTime + "]";
	}
}
