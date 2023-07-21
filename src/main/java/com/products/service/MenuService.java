package com.products.service;

import java.util.List;

import com.products.model.MenuModel;

public interface MenuService {

	public List<MenuModel> getMenuList();
	
	public int addAllMenu(List<MenuModel> menuList);
	
	public int addMenu(MenuModel menu);
	public int updateMenu(MenuModel menu);
	public int delMenu(String treeNode);
}
