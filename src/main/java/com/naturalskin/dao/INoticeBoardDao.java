package com.naturalskin.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.NoticeBoardDto;

@Mapper
public interface INoticeBoardDao {
	
	// 공지사항 목록
	public ArrayList<NoticeBoardDto> noticeBoard_list();

	// 아이디 검색
	public List<NoticeBoardDto> SearchID(String input);

	// 이름 검색
	public List<NoticeBoardDto> SearchName(String input);
	
	// 공지사항 등록
	public int noticeBoardWrite(String id, String notice_board_title, String notice_board_content);

	// 공지사항 상세보기
	public NoticeBoardDto noticeBoardContentView(String notice_board_id);

	// 조회수 증가
	public void hit(String notice_board_id);

	// 공지사항 수정
	public int aNoticeViewUpdate(String notice_board_id, String notice_board_title, String notice_board_content);

	// 공지사항 삭제
	public int noticeDelete(String notice_board_id);

	public List<NoticeBoardDto> listPageDao(String start, String end);

	public int pageCount();

	public List<NoticeBoardDto> SearchTitle(String input);


}
