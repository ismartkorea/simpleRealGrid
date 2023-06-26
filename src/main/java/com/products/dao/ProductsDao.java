package com.products.dao;

import java.util.List;

import com.products.model.ProductModel;

public interface ProductsDao {
	
	public List<ProductModel> getProductList();
	public int addProduct(ProductModel product);
	public int updateProduct(ProductModel product);
	public int delProduct(String code);
}
