package com.products.dao;

import java.util.List;

import com.products.model.MenuModel;

public interface MenuDao {
	
	public List<MenuModel> getMenuList();
	public int addMenu(MenuModel menu);
	public int updateMenu(MenuModel menu);
	public int delMenu(String treeNode);
}
