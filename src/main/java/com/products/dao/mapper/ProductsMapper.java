package com.products.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.products.model.ProductModel;

public interface ProductsMapper {
	
	@Select("select * from Products")
	public List<ProductModel> getProductList();
	
	public int addProduct(ProductModel product);
	
	public int updateProduct(ProductModel product);
	
	public int delProduct(String code);
}
