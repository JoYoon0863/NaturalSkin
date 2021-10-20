package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IQnaDao;
import com.naturalskin.dto.QnaDto;

@Component
public class QnaService {

	@Autowired
	private IQnaDao qnaDao;

	public int qna_count() {
		int result = 0;
		int count = qnaDao.qna_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}
	
	public List<QnaDto> qna_list() {
		List<QnaDto> qna_list = qnaDao.qna_list();
		return qna_list;
	}
	
	public List<QnaDto> SearchID(String input) {
		List<QnaDto> SearchID = qnaDao.SearchID( input );
		return SearchID;
	}
	
	public List<QnaDto> SearchType(String type) {
		List<QnaDto> searchType = qnaDao.serachType( type );
		return searchType;
	}
	
	public List<QnaDto> SearchState(String state) {
		List<QnaDto> searchState = qnaDao.searchState( state );
		return searchState;
	}

	public QnaDto qnaContentView(String qna_board_id) {
		qnaDao.hit(qna_board_id);
		QnaDto qnaContentView = qnaDao.qnaContentView( qna_board_id ); 
		return qnaContentView;
	}

	public int qnaDelete(String qna_board_id) {
		int result = qnaDao.qnaDelete( qna_board_id );
		return result;
	}

	public int qnaReplyWrite(String qna_board_id, String qna_board_type, String qna_board_title, String id, String qna_board_content, String qna_board_lock, String product_id) {
		int result = qnaDao.qnaReplyWrite( qna_board_id, qna_board_type, qna_board_title, id, qna_board_content, qna_board_lock, product_id );
		return result;
	}

	public void contentViewUpdate(String qna_board_id) {
		qnaDao.contentViewUpdate( qna_board_id );
		
	}

	public int pageCount() {
		int result = 0;
		int count = qnaDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<QnaDto> listPageDao(String start, String end) {
		List<QnaDto> listPageDao = qnaDao.listPageDao( start, end );
		return listPageDao;
	}

	public int qnaDelete2(String qna_board_id) {
		int result = qnaDao.qnaDelete2( qna_board_id );
		return result;
	}

	public void update(String parents_id) {
		qnaDao.update( parents_id) ;	
	}

	public int aQnaViewUpdate(String qna_board_id, String qna_board_content) {
		int result = qnaDao.aQnaViewUpdate( qna_board_id, qna_board_content );
		return result;
	}

	public int qnaWrite(String id, String qna_board_type, int product_id, int qna_board_lock,
			String qna_board_title, String qna_board_content) {
		int result = qnaDao.qnaWrite( id, qna_board_type, product_id, qna_board_lock, qna_board_title, qna_board_content );

		return result;
	}

	public int qnaM(String qna_board_id, String qna_board_type, int product_id, int qna_board_lock,
			String qna_board_title, String qna_board_content) {
		int result = qnaDao.qnaM( qna_board_id, qna_board_type, product_id, qna_board_lock, qna_board_title, qna_board_content );

		return result;
	}

	public List<QnaDto> myQnaList(String start, String end, String id) {
		List<QnaDto> myQnaList = qnaDao.myQnaList( start, end, id );
		return myQnaList;
	}

	public List<QnaDto> productQna(String id) {
		List<QnaDto> productQna = qnaDao.productQna(id);
		return productQna;
	}

	
	
}
