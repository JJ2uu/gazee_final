package com.multi.gazee.product;

import java.sql.Timestamp;

public class ProductVO {
	private int productId;
	private String category;
	private String memberId;
	private String productName;
	private String productContent;
	private int price;
	private int dealDelivery;
	private int dealDirect;
	private String directAddressx;
	private String directAddressy;
	private int productViews;
	private int temporary;
	private Timestamp savedTime;
	private Timestamp sellTime;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductContent() {
		return productContent;
	}
	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDealDelivery() {
		return dealDelivery;
	}
	public void setDealDelivery(int dealDelivery) {
		this.dealDelivery = dealDelivery;
	}
	public int getDealDirect() {
		return dealDirect;
	}
	public void setDealDirect(int dealDirect) {
		this.dealDirect = dealDirect;
	}
	public String getDirectAddressx() {
		return directAddressx;
	}
	public void setDirectAddressx(String directAddressx) {
		this.directAddressx = directAddressx;
	}
	public String getDirectAddressy() {
		return directAddressy;
	}
	public void setDirectAddressy(String directAddressy) {
		this.directAddressy = directAddressy;
	}
	public int getProductViews() {
		return productViews;
	}
	public void setProductViews(int productViews) {
		this.productViews = productViews;
	}
	public int getTemporary() {
		return temporary;
	}
	public void setTemporary(int temporary) {
		this.temporary = temporary;
	}
	public Timestamp getSavedTime() {
		return savedTime;
	}
	public void setSavedTime(Timestamp savedTime) {
		this.savedTime = savedTime;
	}
	
	public Timestamp getSellTime() {
		return sellTime;
	}
	public void setSellTime(Timestamp sellTime) {
		this.sellTime = sellTime;
	}
}
