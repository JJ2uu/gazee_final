package com.multi.gazee.product;

public class ProductVO {
	private int productId;
	private String memberId;
	private String productName;
	private int price;
	private int dealDirect;
	private int dealDelivery;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDealDirect() {
		return dealDirect;
	}
	public void setDealDirect(int dealDirect) {
		this.dealDirect = dealDirect;
	}
	public int getDealDelivery() {
		return dealDelivery;
	}
	public void setDealDelivery(int dealDelivery) {
		this.dealDelivery = dealDelivery;
	}
	@Override
	public String toString() {
		return "ProductVO [productId=" + productId + ", memberId=" + memberId + ", productName=" + productName
				+ ", price=" + price + ", dealDirect=" + dealDirect + ", dealDelivery=" + dealDelivery + "]";
	}
	
	
}
