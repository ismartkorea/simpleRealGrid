package com.products.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.products.model.Product;
import com.products.service.ProductsService;


@Controller
public class ProductsController {
	@Autowired ProductsService proService;
	
	@RequestMapping(value="/default.do", method=RequestMethod.GET)
	public void openPage(){	}
	
	@RequestMapping(value="/getProducts.do")
	public @ResponseBody List<Product> productlList(){
		System.out.println(">>>>> getProducts.do <<<");
		List<Product> product = proService.getProductList();
		System.out.println(">>>>> getProducts.do : product <<<");
		return product;
	}
	
	@RequestMapping(value="/insertProducts.do")
	public @ResponseBody int insertProduct(@ModelAttribute Product product){
		int num = proService.addProduct(product);
		return num;
	}
	
	@RequestMapping(value="/updateProducts.do")
	public @ResponseBody int updateProduct(@ModelAttribute Product product){
		return proService.updateProduct(product);
	}
	
	@RequestMapping(value="/deleteProducts.do")
	public @ResponseBody int delProduct(@RequestParam String code){
		return proService.delProduct(code);
	}
	
	@RequestMapping(value="/allSaveProducts.do",method=RequestMethod.POST)
	public @ResponseBody int allSave(@RequestBody String pdStringList){
		List<Product> pdList = new ArrayList<Product>();
		JSONArray productJson = JSONArray.fromObject(JSONSerializer.toJSON(pdStringList));
		
		for(int i = 0; i < productJson.size(); i++){
			Product pd = (Product)JSONObject.toBean(productJson.getJSONObject(i), Product.class);
			pdList.add(pd);
		}
		
		return proService.addAllProduct(pdList);
	}
	
	@RequestMapping(value="/getProducts2.do")
	public @ResponseBody Map<?,?> productlList(ModelMap model) {
	        model.put("results", proService.getProductList());
	        return model;
	}
}
