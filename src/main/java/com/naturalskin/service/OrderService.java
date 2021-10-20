package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IOrderDao;
import com.naturalskin.dto.OrderDto;

@Component
public class OrderService {

	@Autowired
	private IOrderDao orderDao;
	
	// 신규 주문 count
	public Object order_count() {
		int result = 0;
		int count = orderDao.order_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}
	
	// 주문 취소 count
	public Object orderCancel_count() {
		int result = 0;
		int count = orderDao.orderCancel_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}
	
	// 주문 목록
	public List<OrderDto> order_list() {
		List<OrderDto> order_list = orderDao.order_list();
		return order_list;
	}
	
	// 아이디 검색
	public List<OrderDto> SearchID( String input ) {
		List<OrderDto> SearchID = orderDao.SearchID( input );
		return SearchID;
	}
	
	// 이름 검색
	public List<OrderDto> SearchName( String input ) {
		List<OrderDto> SearchName = orderDao.SearchName( input );
		return SearchName;
	}
	
	// 주문번호 검색
	public List<OrderDto> SearchOrderNum( String input ) {
		List<OrderDto> SearchOrderNum = orderDao.SearchOrderNum( input );
		return SearchOrderNum;
	}

	// 주문상세페이지
	public OrderDto orderView( String member_order_id ) {
		OrderDto orderDto = orderDao.orderView( member_order_id );
		return orderDto;
	}

	// 주문상세페이지 수정
	public int aOrderViewUpdate(String member_order_id, String receive_name, String address, String receive_phone, String order_state) {
		int reuslt = orderDao.aOrderViewUpdate( member_order_id, receive_name, address, receive_phone, order_state );
		return reuslt;
	}

	// 주문 삭제
	public int orderDelete(String member_order_id) {
		int result = orderDao.orderDelete( member_order_id );
		return result;
	}

	public List<OrderDto> listPageDao(String start, String end) {
		List<OrderDto> listPageDao = orderDao.listPageDao( start, end);
		return listPageDao;
	}

	public int pageCount() {
		int result = 0;
		int count = orderDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<OrderDto> newOrder(String start, String end) {
		List<OrderDto> newOrder = orderDao.newOrder(start, end);
		return newOrder;
	}

	public List<OrderDto> orderCancel(String start, String end) {
		List<OrderDto> orderCancel = orderDao.orderCancel(start, end);
		return orderCancel;
	}

	public List<OrderDto> myOrder(String start, String end, String id) {
		List<OrderDto> myOrder = orderDao.myOrder(start, end, id);
		return myOrder;
	}

	public int order(String id, int sum, String radio, String order_address, String name, String phone) {
		int result = orderDao.order(id, sum, radio, order_address, name, phone);
		return result;
	}

	public int myOrderCheck(String id) {
		int dto = orderDao.myOrderCheck(id);
		System.out.println(dto);
		return dto;
	}

	public OrderDto myPageOrder(String id) {
		OrderDto myPageOrder = orderDao.myPageOrder(id);
		return myPageOrder;
	}

	public int update(String id, String name, String address, String phone) {
		int result = orderDao.update(id, name, address, phone);
		return result;
	}

	public int cancle(String id) {
		int result = orderDao.cancle(id);
		return result;
	}
}
