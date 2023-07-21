package com.products.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.products.model.MenuModel;

public interface MenuMapper {
	
	@Select("select * from Menu")
	public List<MenuModel> getMenuList();
	
	public int addMenu(MenuModel menu);
	
	public int updateMenu(MenuModel menu);
	
	public int delMenu(String treeNode);
}
