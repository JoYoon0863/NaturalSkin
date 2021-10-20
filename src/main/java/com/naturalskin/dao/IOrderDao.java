package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.OrderDto;

@Mapper
public interface IOrderDao {

	// 신규 주문
	int order_count();
	
	// 주문 취소
	int orderCancel_count();
	
	// 주문 목록
	List<OrderDto> order_list();

	// 아이디 검색
	List<OrderDto> SearchID(String input);
	
	// 이름 검색
	List<OrderDto> SearchName(String input);
	
	// 주문번호 검색
	List<OrderDto> SearchOrderNum(String input);
	
	// 주문상세페이지
	OrderDto orderView(String member_order_id);

	// 주문상세페이지 수정
	int aOrderViewUpdate(String member_order_id, String receive_name, String address, String receive_phone,
			String order_state);

	// 주문 삭제
	int orderDelete(String member_order_id);

	List<MemberDto> order_name();

	List<OrderDto> listPageDao(String start, String end);

	int pageCount();

	List<OrderDto> newOrder(String start, String end);

	List<OrderDto> orderCancel(String start, String end);

	List<OrderDto> myOrder(String start, String end, String id);

	int order(String id, int sum, String radio, String order_address, String name, String phone);

	int myOrderCheck(String id);

	OrderDto myPageOrder(String id);

	int update(String id, String name, String address, String phone);

	int cancle(String id);



}
