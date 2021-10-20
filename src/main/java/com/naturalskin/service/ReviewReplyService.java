package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IReviewReplyDao;
import com.naturalskin.dto.ReviewReplyDto;

@Component
public class ReviewReplyService {
	
	@Autowired
	private IReviewReplyDao reviewReplyDao;

	public List<ReviewReplyDto> list(String id) {
		List<ReviewReplyDto> list = reviewReplyDao.list(id);
		return list;
	}

	public void replyW(String review_id, String product_id, String id, String review_reply_content) {
		reviewReplyDao.replyW(review_id, product_id, id, review_reply_content);
	}

	public void rereplyW(String review_id, String product_id, String id, String review_reply_content, String review_reply_id) {
		reviewReplyDao.rereplyW(review_id, product_id, id, review_reply_content, review_reply_id);	
	}

	public void replyD(String review_reply_id) {
		reviewReplyDao.replyD(review_reply_id);	
	}

	public void replyM(String review_reply_id, String content2) {
		reviewReplyDao.replyM(review_reply_id, content2);	
		
	}

}
