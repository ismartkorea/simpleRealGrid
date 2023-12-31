package com.products.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.products.dao.ProductsDao;
import com.products.model.ProductModel;

@Service("productsService")
public class ProductsServiceImpl implements ProductsService {
	@Autowired ProductsDao productsDao;
	
	@Transactional
	public int addAllProduct(List<ProductModel> pdList) {
		
		int num = 0;
		
		for(ProductModel product : pdList){
			if(product.getState().equals("created"))
				num += productsDao.addProduct(product);
			else if(product.getState().equals("updated"))
				num += productsDao.updateProduct(product);
			else if(product.getState().equals("deleted"))
				num += productsDao.delProduct(product.getCode());
		}
		return num;
	}
	
	public List<ProductModel> getProductList() {
		return productsDao.getProductList();
	}

	public int addProduct(ProductModel product) {
		return productsDao.addProduct(product);
	}

	public int updateProduct(ProductModel product) {
		return productsDao.updateProduct(product);
	}

	public int delProduct(String code) {
		return productsDao.delProduct(code);
	}
}
