package com.multi.gazee.chat;

import java.sql.Timestamp;

public class ChatAndProductVO {
	
	private int roomId;
	private String sellerId;
	private String buyerId;
	private int productId;
	private String dealType;
	private Timestamp dealDirectDate;
	private String productName;
	private int price;
	
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "ChatAndProductVO [roomId=" + roomId + ", sellerId=" + sellerId + ", buyerId=" + buyerId + ", productId="
				+ productId + ", dealType=" + dealType + ", dealDirectDate=" + dealDirectDate + ", productName="
				+ productName + ", price=" + price + "]";
	}
}
