package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.BasketDto;

@Mapper
public interface IBasketDao {

	int add(String id, String product_id, int amount);

	List<BasketDto> list(String id);

	void selectDelete(String basket_id);

	void allDelete(String member_id);

	List<BasketDto> orderlist(String basket_id, String amount);

	int update(String bid, String amount);

	int count(String id);

}
