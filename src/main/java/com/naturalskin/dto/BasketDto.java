package com.naturalskin.dto;

public class BasketDto {
	int basket_id;
	String member_id;
	int product_id;
	int basket_amount;
	
	public BasketDto() {
		super();
	}

	public BasketDto(int basket_id, String member_id, int product_id, int basket_amount) {
		super();
		this.basket_id = basket_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.basket_amount = basket_amount;
	}

	public int getBasket_id() {
		return basket_id;
	}

	public void setBasket_id(int basket_id) {
		this.basket_id = basket_id;
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

	public int getBasket_amount() {
		return basket_amount;
	}

	public void setBasket_amount(int basket_amount) {
		this.basket_amount = basket_amount;
	}
	
}
