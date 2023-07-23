package com.products.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.products.model.MenuModel;

public interface MenuMapper {
	
	@Select("select * from Menu")
	public List<MenuModel> getMenuList();
	
	public int addMenu(MenuModel menu);
	
	public int updateMenu(MenuModel menu);
	
	public int delMenu(MenuModel menu);
	
	public Map<String, Object> getLastOrderNo(Map<String, Object> params);
}
