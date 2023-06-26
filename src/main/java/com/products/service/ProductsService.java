package com.products.service;

import java.util.List;

import com.products.model.ProductModel;

public interface ProductsService {

	public List<ProductModel> getProductList();
	
	public int addAllProduct(List<ProductModel> productList);
	
	public int addProduct(ProductModel product);
	public int updateProduct(ProductModel product);
	public int delProduct(String code);
}
