package com.naturalskin.dto;

import java.util.Date;

public class NoticeBoardDto {

	int notice_board_id;
	String member_id;
	String notice_board_title;
	String notice_board_content;
	Date notice_board_date;
	int notice_board_hit;
	
	public NoticeBoardDto() {
		super();
	}

	public NoticeBoardDto(int notice_board_id, String member_id, String notice_board_title, String notice_board_content,
			Date notice_board_date, int notice_board_hit) {
		super();
		this.notice_board_id = notice_board_id;
		this.member_id = member_id;
		this.notice_board_title = notice_board_title;
		this.notice_board_content = notice_board_content;
		this.notice_board_date = notice_board_date;
		this.notice_board_hit = notice_board_hit;
	}

	public int getNotice_board_id() {
		return notice_board_id;
	}

	public void setNotice_board_id(int notice_board_id) {
		this.notice_board_id = notice_board_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getNotice_board_title() {
		return notice_board_title;
	}

	public void setNotice_board_title(String notice_board_title) {
		this.notice_board_title = notice_board_title;
	}

	public String getNotice_board_content() {
		return notice_board_content;
	}

	public void setNotice_board_content(String notice_board_content) {
		this.notice_board_content = notice_board_content;
	}

	public Date getNotice_board_date() {
		return notice_board_date;
	}

	public void setNotice_board_date(Date notice_board_date) {
		this.notice_board_date = notice_board_date;
	}

	public int getNotice_board_hit() {
		return notice_board_hit;
	}

	public void setNotice_board_hit(int notice_board_hit) {
		this.notice_board_hit = notice_board_hit;
	}
	
}
