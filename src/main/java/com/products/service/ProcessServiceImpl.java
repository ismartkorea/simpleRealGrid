package com.products.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.products.dao.ProductsDao;
import com.products.model.Product;

@Service
public class ProcessServiceImpl implements ProductsService {
	@Autowired ProductsDao proDao;
	
	@Transactional
	public int addAllProduct(List<Product> pdList) {
		
		int num = 0;
		
		for(Product product : pdList){
			if(product.getState().equals("created"))
				num += proDao.addProduct(product);
			else if(product.getState().equals("updated"))
				num += proDao.updateProduct(product);
			else if(product.getState().equals("deleted"))
				num += proDao.delProduct(product.getCode());
		}
		return num;
	}
	
	public List<Product> getProductList() {
		return proDao.getProductList();
	}

	public int addProduct(Product product) {
		return proDao.addProduct(product);
	}

	public int updateProduct(Product product) {
		return proDao.updateProduct(product);
	}

	public int delProduct(String code) {
		return proDao.delProduct(code);
	}
}
