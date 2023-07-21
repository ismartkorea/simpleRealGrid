package com.products.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.products.model.MenuModel;
import com.products.service.MenuService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;


@Controller
public class MenuController {
	@Autowired MenuService menuService;
	
	@RequestMapping(value="/menu.do", method=RequestMethod.GET)
	public String menu(){
		return "menu";
	}
	
	@RequestMapping(value="/getMenu.do")
	public @ResponseBody List<MenuModel> menuList(){
		System.out.println(">>>>> getMenu.do <<<");
		List<MenuModel> menu = menuService.getMenuList();
		System.out.println(">>>>> getMenu.do : menu <<<");
		return menu;
	}
	
	@RequestMapping(value="/insertMenu.do")
	public @ResponseBody int insertMenu(@ModelAttribute MenuModel menu){
		System.out.println(">>>>> insertMenu.do <<<");
		int num = menuService.addMenu(menu);
		System.out.println(">>>>> insertMenu.do num : " + num + " <<<");
		return num;
	}
	
	@RequestMapping(value="/updateMenu.do")
	public @ResponseBody int updateMenu(@ModelAttribute MenuModel menu){
		return menuService.updateMenu(menu);
	}
	
	@RequestMapping(value="/deleteMenu.do")
	public @ResponseBody int delMenu(@RequestParam String treeNode){
		return menuService.delMenu(treeNode);
	}
	
	@RequestMapping(value="/allSaveMenu.do",method=RequestMethod.POST)
	public @ResponseBody int allSave(@RequestBody String menuStringList){
		List<MenuModel> menuList = new ArrayList<MenuModel>();
		JSONArray menuJson = JSONArray.fromObject(JSONSerializer.toJSON(menuStringList));
		
		for(int i = 0; i < menuJson.size(); i++){
			MenuModel menu = (MenuModel)JSONObject.toBean(menuJson.getJSONObject(i), MenuModel.class);
			menuList.add(menu);
		}
		
		return menuService.addAllMenu(menuList);
	}
}
