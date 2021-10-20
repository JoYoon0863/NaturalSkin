package com.naturalskin.dto;

import java.util.Date;

public class OrderDto {
	
	int member_order_id;
	String member_id;
	String member_order_state;
	Date member_order_date;
	int member_order_price;
	String member_order_payment_method;
	String member_order_receive_address;
	String member_order_receive_name;
	String member_order_receive_phone;
	
	public OrderDto() {
		super();
	}

	public OrderDto(int member_order_id, String member_id, String member_order_state, Date member_order_date,
			int member_order_price, String member_order_payment_method, String member_order_receive_address,
			String member_order_receive_name, String member_order_receive_phone) {
		super();
		this.member_order_id = member_order_id;
		this.member_id = member_id;
		this.member_order_state = member_order_state;
		this.member_order_date = member_order_date;
		this.member_order_price = member_order_price;
		this.member_order_payment_method = member_order_payment_method;
		this.member_order_receive_address = member_order_receive_address;
		this.member_order_receive_name = member_order_receive_name;
		this.member_order_receive_phone = member_order_receive_phone;
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

	public String getMember_order_state() {
		return member_order_state;
	}

	public void setMember_order_state(String member_order_state) {
		this.member_order_state = member_order_state;
	}

	public Date getMember_order_date() {
		return member_order_date;
	}

	public void setMember_order_date(Date member_order_date) {
		this.member_order_date = member_order_date;
	}

	public int getMember_order_price() {
		return member_order_price;
	}

	public void setMember_order_price(int member_order_price) {
		this.member_order_price = member_order_price;
	}

	public String getMember_order_payment_method() {
		return member_order_payment_method;
	}

	public void setMember_order_payment_method(String member_order_payment_method) {
		this.member_order_payment_method = member_order_payment_method;
	}

	public String getMember_order_receive_address() {
		return member_order_receive_address;
	}

	public void setMember_order_receive_address(String member_order_receive_address) {
		this.member_order_receive_address = member_order_receive_address;
	}

	public String getMember_order_receive_name() {
		return member_order_receive_name;
	}

	public void setMember_order_receive_name(String member_order_receive_name) {
		this.member_order_receive_name = member_order_receive_name;
	}

	public String getMember_order_receive_phone() {
		return member_order_receive_phone;
	}

	public void setMember_order_receive_phone(String member_order_receive_phone) {
		this.member_order_receive_phone = member_order_receive_phone;
	}
	
}
