package com.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestViewController {
	
	@RequestMapping(value="/treeGrid.do", method=RequestMethod.GET)
	public String treeGrid(){

		return "test/treeGrid";
	}
}