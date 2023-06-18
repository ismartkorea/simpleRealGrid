package com.products.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.products.model.Product;

public interface ProductsMapper {
	
	@Select("select * from Products")
	public List<Product> getProductList();
	
	public int addProduct(Product product);
	
	public int updateProduct(Product product);
	
	public int delProduct(String code);
}
