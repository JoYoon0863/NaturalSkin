package com.naturalskin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IProductDao;
import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.NoticeBoardDto;
import com.naturalskin.dto.OrderDto;
import com.naturalskin.dto.ProductDto;

@Component
public class ProductService {
	
	@Autowired
	private IProductDao productDao;

	// 상품 목록
	public List<ProductDto> product_list() {
		List<ProductDto> product_list = productDao.product_list();
		System.out.println(product_list.get(0).getProduct_main_img_path());
		return product_list;
	}

	public ProductDto productContentView(String product_id) {
		ProductDto productDto = productDao.productContentView( product_id );
		return productDto;
	}

	public int productContentAction(String product_id, String product_name, String product_price,
			String product_main_img_path, String product_content_img_path, String product_stock,
			String product_category, String product_content) {
		
		int result = productDao.productContentAction( product_id, product_name, product_price, product_main_img_path, 
													product_content_img_path, product_stock,product_category, product_content);
		
		return result;
		
	}

	public int productWA(String product_category, String product_name, String product_stock, String product_price,
			String mainImageUrl, String contentImageUrl, String product_content) {
		
		int result = productDao.productWA( product_category, product_name, product_stock, product_price, 
											mainImageUrl, contentImageUrl, product_content );
		
		return result;
	}

	public int delete(String product_id) {
		int result = productDao.delete( product_id );
		return result;
	}

	
	public int product_count() {
		int result = 0;
		int count = productDao.product_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public int pageCount() {
		int result = 0;
		int count = productDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<ProductDto> listPageDao(String start, String end) {
		List<ProductDto> listPageDao = productDao.listPageDao( start, end );
		return listPageDao;
	}

	public List<ProductDto> SearchName( String input, String start, String end ) {
		List<ProductDto> SearchName = productDao.SearchName( input, start, end );
		return SearchName;
	}

	public int searchCount( String input ) {
		int result = 0;
		int count = productDao.searchCount( input );
		
		System.out.println( "검색된 갯수 : " + count );
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<ProductDto> myPageOrder(String id) {
		List<ProductDto> myPageOrder = productDao.myPageOrder(id);
		return myPageOrder;
	}

	public List<ProductDto> myPageOrderList(String id) {
		List<ProductDto> myPageOrderList = productDao.myPageOrderList(id);
		return myPageOrderList;
	}

	public List<ProductDto> basketList(String id) {
		List<ProductDto> basketList = productDao.basketList(id);
		return basketList;
	}

	public ProductDto reviewV(String id, int product_id) {
		ProductDto reviewV = productDao.reviewV(id, product_id);
		return reviewV;
	}

}
