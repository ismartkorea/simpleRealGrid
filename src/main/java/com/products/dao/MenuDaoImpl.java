package com.products.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.products.dao.mapper.MenuMapper;
import com.products.model.MenuModel;

@Repository
public class MenuDaoImpl implements MenuDao {
	@Autowired MenuMapper menuMapper;
	
	public List<MenuModel> getMenuList() {
		return menuMapper.getMenuList();
	}

	public int addMenu(MenuModel menu) {
		return menuMapper.addMenu(menu);
	}

	public int updateMenu(MenuModel menu) {
		return menuMapper.updateMenu(menu);
	}
	
	public int delMenu(MenuModel menu) {
		return menuMapper.delMenu(menu);
	}
	
	public Map<String, Object> getLastOrderNo(Map<String, Object> params) {
		return menuMapper.getLastOrderNo(params);
	}	

}
