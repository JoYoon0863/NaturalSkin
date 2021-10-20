package com.naturalskin.dto;

import java.util.Date;

public class ReviewBoardDto {
	int review_board_id;
	String member_id;
	int product_id;
	String review_board_title;
	String review_board_content;
	Date review_board_date;
	int review_board_score;
	int review_board_hit;
	String review_board_img_path;
	
	public ReviewBoardDto() {
		super();
	}

	public ReviewBoardDto(int review_board_id, String member_id, int product_id, String review_board_title,
			String review_board_content, Date review_board_date, int review_board_score, int review_board_hit,
			String review_board_img_path) {
		super();
		this.review_board_id = review_board_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.review_board_title = review_board_title;
		this.review_board_content = review_board_content;
		this.review_board_date = review_board_date;
		this.review_board_score = review_board_score;
		this.review_board_hit = review_board_hit;
		this.review_board_img_path = review_board_img_path;
	}

	public int getReview_board_id() {
		return review_board_id;
	}

	public void setReview_board_id(int review_board_id) {
		this.review_board_id = review_board_id;
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

	public String getReview_board_title() {
		return review_board_title;
	}

	public void setReview_board_title(String review_board_title) {
		this.review_board_title = review_board_title;
	}

	public String getReview_board_content() {
		return review_board_content;
	}

	public void setReview_board_content(String review_board_content) {
		this.review_board_content = review_board_content;
	}

	public Date getReview_board_date() {
		return review_board_date;
	}

	public void setReview_board_date(Date review_board_date) {
		this.review_board_date = review_board_date;
	}

	public int getReview_board_score() {
		return review_board_score;
	}

	public void setReview_board_score(int review_board_score) {
		this.review_board_score = review_board_score;
	}

	public int getReview_board_hit() {
		return review_board_hit;
	}

	public void setReview_board_hit(int review_board_hit) {
		this.review_board_hit = review_board_hit;
	}

	public String getReview_board_img_path() {
		return review_board_img_path;
	}

	public void setReview_board_img_path(String review_board_img_path) {
		this.review_board_img_path = review_board_img_path;
	}
	
	
}
