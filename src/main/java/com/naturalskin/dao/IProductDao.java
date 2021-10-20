package com.naturalskin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.ProductDto;

@Mapper
public interface IProductDao {

	// 상품 목록
	List<ProductDto> product_list();

	ProductDto productContentView(String product_id);

	int productContentAction(String product_id, String product_name, String product_price,
			String product_main_img_path, String product_content_img_path, String product_stock,
			String product_category, String product_content);

	int productWA(String product_category, String product_name, String product_stock, String product_price,
			String mainImageUrl, String contentImageUrl, String product_content);

	int delete(String product_id);

	int product_count();

	int pageCount();

	List<ProductDto> listPageDao(String start, String end);

	List<ProductDto> SearchName(String input, String start, String end );

	int searchCount( String input );

	List<ProductDto> myPageOrder(String id);

	List<ProductDto> myPageOrderList(String id);

	List<ProductDto> basketList(String id);

	ProductDto reviewV(String id, int product_id);

}
