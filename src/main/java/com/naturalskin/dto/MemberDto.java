package com.naturalskin.dto;

import java.util.Date;

public class MemberDto {
	String member_id;
	int member_idx;
	String member_pw;
	String member_name;
	String member_phone;
	String member_gender;
	String member_email;
	String member_address;
	int member_birthday;
	int member_role;
	Date member_date;
	
	public MemberDto() {
		super();
	}

	public MemberDto(String member_id, int member_idx, String member_pw, String member_name, String member_phone,
			String member_gender, String member_email, String member_address, int member_birthday, int member_role,
			Date member_date) {
		super();
		this.member_id = member_id;
		this.member_idx = member_idx;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_phone = member_phone;
		this.member_gender = member_gender;
		this.member_email = member_email;
		this.member_address = member_address;
		this.member_birthday = member_birthday;
		this.member_role = member_role;
		this.member_date = member_date;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	public int getMember_birthday() {
		return member_birthday;
	}

	public void setMember_birthday(int member_birthday) {
		this.member_birthday = member_birthday;
	}

	public int getMember_role() {
		return member_role;
	}

	public void setMember_role(int member_role) {
		this.member_role = member_role;
	}

	public Date getMember_date() {
		return member_date;
	}

	public void setMember_date(Date member_date) {
		this.member_date = member_date;
	}

}



