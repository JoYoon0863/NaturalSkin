package com.naturalskin.dto;

public class OrderDetailDto {
	int order_detail_id;
	int member_order_id;
	String member_id;
	int product_id;
	int order_detail_amount;
	int order_detail_price;
	int order_detail_review;
	
	public OrderDetailDto() {
		super();
	}

	public OrderDetailDto(int order_detail_id, int member_order_id, String member_id, int product_id,
			int order_detail_amount, int order_detail_price, int order_detail_review) {
		super();
		this.order_detail_id = order_detail_id;
		this.member_order_id = member_order_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.order_detail_amount = order_detail_amount;
		this.order_detail_price = order_detail_price;
		this.order_detail_review = order_detail_review;
	}

	public int getOrder_detail_id() {
		return order_detail_id;
	}

	public void setOrder_detail_id(int order_detail_id) {
		this.order_detail_id = order_detail_id;
	}

	public int getMember_order_id() {
		return member_order_id;
	}

	public void setMember_order_id(int member_order_id) {
		this.member_order_id = member_order_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getOrder_detail_amount() {
		return order_detail_amount;
	}

	public void setOrder_detail_amount(int order_detail_amount) {
		this.order_detail_amount = order_detail_amount;
	}

	public int getOrder_detail_price() {
		return order_detail_price;
	}

	public void setOrder_detail_price(int order_detail_price) {
		this.order_detail_price = order_detail_price;
	}

	public int getOrder_detail_review() {
		return order_detail_review;
	}

	public void setOrder_detail_review(int order_detail_review) {
		this.order_detail_review = order_detail_review;
	}
	
}
