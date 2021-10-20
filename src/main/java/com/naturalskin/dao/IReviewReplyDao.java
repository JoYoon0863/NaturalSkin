package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.ReviewReplyDto;

@Mapper
public interface IReviewReplyDao {

	List<ReviewReplyDto> list(String id);

	void replyW(String review_id, String product_id, String id, String review_reply_content);

	void rereplyW(String review_id, String product_id, String id, String review_reply_content, String review_reply_id);

	void replyD(String review_reply_id);

	void replyM(String review_reply_id, String content2);

}
