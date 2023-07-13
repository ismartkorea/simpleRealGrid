package com.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestViewController {
	
	@RequestMapping("/test/view/treeGrid.do")
	public String treeGrid(){

		return "test/treeGrid";
	}
}