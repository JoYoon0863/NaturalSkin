package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IOrderDetailDao;
import com.naturalskin.dto.OrderDetailDto;

@Component
public class OrderDetailService {
	
	@Autowired
	private IOrderDetailDao orderDetailDao;

	public int orderDetail(int order_id, String id, String product_id, String amount, String price) {
		int result = orderDetailDao.orderDetail(order_id, id, product_id, amount, price);
		return result;
	}

	public List<OrderDetailDto> myPageOrder(String id) {
		List<OrderDetailDto> myPageOrder = orderDetailDao.myPageOrder(id);
		return myPageOrder;
	}

}
