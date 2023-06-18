package com.products.dao;

import java.util.List;

import com.products.model.Product;

public interface ProductsDao {
	
	public List<Product> getProductList();
	public int addProduct(Product product);
	public int updateProduct(Product product);
	public int delProduct(String code);
}
