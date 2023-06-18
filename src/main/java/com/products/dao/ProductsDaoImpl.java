package com.products.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.products.dao.mapper.ProductsMapper;
import com.products.model.Product;

@Repository
public class ProductsDaoImpl implements ProductsDao {
	@Autowired ProductsMapper proMapper;
	
	public List<Product> getProductList() {
		return proMapper.getProductList();
	}

	public int addProduct(Product product) {
		return proMapper.addProduct(product);
	}

	public int updateProduct(Product product) {
		return proMapper.updateProduct(product);
	}
	
	public int delProduct(String code) {
		return proMapper.delProduct(code);
	}

}
