package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.INoticeBoardDao;
import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.NoticeBoardDto;

@Component
public class NoticeBoardService {

	@Autowired
	private INoticeBoardDao noticeBoardDao;
	
	// 공지사항 목록
	public List<NoticeBoardDto> noticeBoard_list() {
		List<NoticeBoardDto> noticeBoard_list = noticeBoardDao.noticeBoard_list();
		return noticeBoard_list;
	}
	
	// 아이디 검색
	public List<NoticeBoardDto> SearchID( String input ) {
		List<NoticeBoardDto> SearchID = noticeBoardDao.SearchID( input );
		return SearchID;
	}
	
	// 이름 검색
	public List<NoticeBoardDto> SearchName( String input ) {
		List<NoticeBoardDto> SearchName = noticeBoardDao.SearchName( input );
		return SearchName;
	}

	// 공지사항 등록
	public int noticeBoardWrite(String id, String notice_board_title, String notice_board_content) {
		int result = noticeBoardDao.noticeBoardWrite( id, notice_board_title, notice_board_content );
		return result;
	}

	// 공지사항 상세보기
	public NoticeBoardDto noticeBoardContentView(String notice_board_id) {
		
		// 조회수 증가
		noticeBoardDao.hit(notice_board_id);
		
		NoticeBoardDto noticeBoardDto = noticeBoardDao.noticeBoardContentView( notice_board_id );
		return noticeBoardDto;
	}

	// 공지사항 수정
	public int aNoticeViewUpdate(String notice_board_id, String notice_board_title, String notice_board_content) {
		int result = noticeBoardDao.aNoticeViewUpdate( notice_board_id, notice_board_title, notice_board_content );
		return result;
	}

	// 공지사항 삭제
	public int noticeDelete(String notice_board_id) {
		int reuslt = noticeBoardDao.noticeDelete( notice_board_id );
		return reuslt;
	}

	public List<NoticeBoardDto> listPageDao(String start, String end) {
		List<NoticeBoardDto> listPageDao = noticeBoardDao.listPageDao( start, end );
		return listPageDao;
	}

	public int pageCount() {
		int result = 0;
		int count = noticeBoardDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<NoticeBoardDto> SearchTitle(String input) {
		List<NoticeBoardDto> SearchTitle = noticeBoardDao.SearchTitle( input );
		return SearchTitle;
	}

}
