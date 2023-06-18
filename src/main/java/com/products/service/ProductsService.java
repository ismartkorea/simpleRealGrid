package com.products.service;

import java.util.List;

import com.products.model.Product;

public interface ProductsService {

	public List<Product> getProductList();
	
	public int addAllProduct(List<Product> productList);
	
	public int addProduct(Product product);
	public int updateProduct(Product product);
	public int delProduct(String code);
}
