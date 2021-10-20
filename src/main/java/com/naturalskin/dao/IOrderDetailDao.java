package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.OrderDetailDto;

@Mapper
public interface IOrderDetailDao {

	int orderDetail(int order_id, String id, String product_id, String amount, String price);

	List<OrderDetailDto> myPageOrder(String id);


}
