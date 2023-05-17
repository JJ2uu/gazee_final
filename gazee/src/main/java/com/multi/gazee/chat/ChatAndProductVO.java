package com.multi.gazee.chat;

import java.sql.Timestamp;

public class ChatAndProductVO {
	
	private int roomId;
	private String sellerId;
	private String buyerId;
	private int productId;
	private String transaction;
	private Timestamp trasactionDate;
	private String productName;
	private int price;
	private String memberId;
	private String priceDec;
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
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
	public String getPriceDec() {
		return priceDec;
	}
	public void setPriceDec(String priceDec) {
		this.priceDec = priceDec;
	}
	@Override
	public String toString() {
		return "ChatAndProductVO [roomId=" + roomId + ", sellerId=" + sellerId + ", buyerId=" + buyerId + ", productId="
				+ productId + ", transaction=" + transaction + ", trasactionDate=" + trasactionDate + ", productName="
				+ productName + ", price=" + price + ", memberId=" + memberId + ", priceDec=" + priceDec + "]";
	}
}
