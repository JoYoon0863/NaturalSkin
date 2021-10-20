package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IReviewBoardDao;
import com.naturalskin.dto.ReviewBoardDto;

@Component
public class ReviewBoardService {

	@Autowired
	IReviewBoardDao reviewBoardDao;
	
	public List<ReviewBoardDto> listPageDao(String start, String end) {
		List<ReviewBoardDto> listPageDao = reviewBoardDao.listPageDao( start, end );
		return listPageDao;
	}

	public int pageCount() {
		int result = 0;
		int count = reviewBoardDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<ReviewBoardDto> myReviewList(String start, String end, String id) {
		List<ReviewBoardDto> myReviewList = reviewBoardDao.myReviewList( start, end, id );
		return myReviewList;
	}

	public int reviewWA(String id, String product_id, String title, String rating, String contentImageUrl,
			String content) {
		int result = reviewBoardDao.reviewWA(id, product_id, title, rating, contentImageUrl, content);
		return result;
	}

	public ReviewBoardDto list(String id) {
		reviewBoardDao.hit(id);
		ReviewBoardDto list = reviewBoardDao.list(id);
		return list;
	}

	public int reviewMA(String review_id, String title, String rating, String contentImageUrl,
			String content) {
		int result = reviewBoardDao.reviewMA(review_id, title, rating, contentImageUrl, content);
		return result;
	}

	public int delete(String id) {
		int result = reviewBoardDao.delete(id);
		return result;
	}

	public List<ReviewBoardDto> reviewList(String id) {
		List<ReviewBoardDto> reviewList = reviewBoardDao.reviewList(id);
		return reviewList;
	}
}
