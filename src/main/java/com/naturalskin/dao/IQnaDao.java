package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.QnaDto;

@Mapper
public interface IQnaDao {

	int qna_count();
	
	List<QnaDto> qna_list();
	
	List<QnaDto> SearchID(String input);
	
	List<QnaDto> serachType(String type);
	
	List<QnaDto> searchState(String state);

	QnaDto qnaContentView(String qna_board_id);

	int qnaDelete(String qna_board_id);

	void hit(String qna_board_id);

	int qnaReplyWrite(String qna_board_id, String qna_board_type, String qna_board_title, String id, String qna_board_content, String qna_board_lock, String product_id);

	void contentViewUpdate(String qna_board_id);

	int pageCount();

	List<QnaDto> listPageDao(String start, String end);

	List<MemberDto> role();

	int qnaDelete2(String qna_board_id);

	void update(String parents_id);

	int aQnaViewUpdate(String qna_board_id, String qna_board_content);

	int qnaWrite(String id, String qna_board_type, int product_id, int qna_board_lock, String qna_board_title,
			String qna_board_content);

	int qnaM(String qna_board_id, String qna_board_type, int product_id, int qna_board_lock,
			String qna_board_title, String qna_board_content);

	List<QnaDto> myQnaList(String start, String end, String id);

	List<QnaDto> productQna(String id);

}
