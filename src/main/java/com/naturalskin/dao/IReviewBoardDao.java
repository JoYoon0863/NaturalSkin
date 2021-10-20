package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.ReviewBoardDto;
import com.naturalskin.service.ReviewBoardService;

@Mapper
public interface IReviewBoardDao {

	List<ReviewBoardDto> listPageDao(String start, String end);

	int pageCount();

	List<ReviewBoardDto> myReviewList(String start, String end, String id);

	int reviewWA(String id, String product_id, String title, String rating, String contentImageUrl, String content);

	ReviewBoardDto list(String id);

	void hit(String id);

	int reviewMA(String review_id, String title, String rating, String contentImageUrl, String content);

	int delete(String id);

	List<ReviewBoardDto> reviewList(String id);

}
