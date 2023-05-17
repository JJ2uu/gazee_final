package com.multi.gazee.chat;

import java.sql.Timestamp;

public class ChatVO {
	private int roomId;
	private String sellerId;
	private String buyerId;
	private int productId;
	private String transaction;
	private Timestamp trasactionDate;
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
	public String getTransaction() {
		return transaction;
	}
	public void setTransaction(String transaction) {
		this.transaction = transaction;
	}
	public Timestamp getTrasactionDate() {
		return trasactionDate;
	}
	public void setTrasactionDate(Timestamp trasactionDate) {
		this.trasactionDate = trasactionDate;
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
				+ productId + ", transaction=" + transaction + ", trasactionDate=" + trasactionDate
				+ ", lastMessageDate=" + lastMessageDate + ", chatPartner=" + chatPartner + ", lastMessage="
				+ lastMessage + ", lastMessageTime=" + lastMessageTime + "]";
	}
}
