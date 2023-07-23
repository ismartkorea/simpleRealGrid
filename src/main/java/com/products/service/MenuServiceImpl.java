package com.products.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.products.dao.MenuDao;
import com.products.model.MenuModel;
import com.products.model.ProcessModel;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	@Autowired MenuDao menuDao;
	
	@Transactional
	public int addAllMenu(List<MenuModel> menuList) {
		
		int num = 0;
		
		for(MenuModel menu : menuList){
			if(menu.getState().equals("created"))
				num += menuDao.addMenu(menu);
			else if(menu.getState().equals("updated"))
				num += menuDao.updateMenu(menu);
			else if(menu.getState().equals("deleted"))
				num += menuDao.delMenu(menu);
		}
		return num;
	}
	
	public List<MenuModel> getMenuList() {
		return menuDao.getMenuList();
	}

	public int addMenu(MenuModel menu) {
		return menuDao.addMenu(menu);
	}

	public int updateMenu(MenuModel menu) {
		return menuDao.updateMenu(menu);
	}

	public int delMenu(MenuModel menu) {
		return menuDao.delMenu(menu);
	}
	
	public Map<String, Object> getLastOrderNo(Map<String, Object> params) {
		return menuDao.getLastOrderNo(params);
	}
	
}
