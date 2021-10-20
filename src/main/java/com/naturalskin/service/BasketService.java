package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IBasketDao;
import com.naturalskin.dto.BasketDto;

@Component
public class BasketService {

	@Autowired
	private IBasketDao basketDao;
	
	public int add(String id, String product_id, int amount) {
		int result = basketDao.add(id, product_id, amount);
		return result;
	}

	public List<BasketDto> list(String id) {
		List<BasketDto> list = basketDao.list(id);
		return list;
	}

	public void selectDelete(String basket_id) {
		basketDao.selectDelete(basket_id);
	}

	public void allDelete(String member_id) {
		basketDao.allDelete(member_id);
		
	}

	public List<BasketDto> orderlist(String basket_id, String amount) {
		List<BasketDto> orderlist = basketDao.orderlist(basket_id, amount);
		return orderlist;
	}

	public int update(String bid, String amount) {
		int result = basketDao.update(bid, amount);
		return result;
	}

	public int count(String id) {
		int result = 0;
		int count = basketDao.count(id);
		
		if( count > 0 ) {
			result = count;
		}
		
		return result;
	}

}
