package com.products.service;

import java.util.List;
import java.util.Map;

import com.products.model.MenuModel;

public interface MenuService {

	public List<MenuModel> getMenuList();
	
	public int addAllMenu(List<MenuModel> menuList);
	
	public int addMenu(MenuModel menu);
	public int updateMenu(MenuModel menu);
	public int delMenu(MenuModel menu);
	
	public Map<String, Object> getLastOrderNo(Map<String, Object> params);
}
