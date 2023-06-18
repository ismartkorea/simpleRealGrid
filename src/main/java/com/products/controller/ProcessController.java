package com.products.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.products.model.ProcessModel;
import com.products.service.ProcessService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;


@Controller
public class ProcessController {
	@Autowired ProcessService processService;
	
	@RequestMapping(value="/process.do", method=RequestMethod.GET)
	public void openPage(){	}
	
	@RequestMapping(value="/getProcess.do")
	public @ResponseBody List<ProcessModel> processList(){
		System.out.println(">>>>> getProcess.do <<<");
		List<ProcessModel> process = processService.getProcessList();
		System.out.println(">>>>> getProcess.do : process <<<");
		return process;
	}
	
	@RequestMapping(value="/insertProcess.do")
	public @ResponseBody int insertProcess(@ModelAttribute ProcessModel process){
		System.out.println(">>>>> insertProcess.do <<<");
		int num = processService.addProcess(process);
		System.out.println(">>>>> insertProcess.do num : " + num + " <<<");
		return num;
	}
	
	@RequestMapping(value="/updateProcess.do")
	public @ResponseBody int updateProcess(@ModelAttribute ProcessModel process){
		return processService.updateProcess(process);
	}
	
	@RequestMapping(value="/deleteProcess.do")
	public @ResponseBody int delProcess(@RequestParam String code){
		return processService.delProcess(code);
	}
	
	@RequestMapping(value="/allSaveProcess.do",method=RequestMethod.POST)
	public @ResponseBody int allSave(@RequestBody String pdStringList){
		List<ProcessModel> pdList = new ArrayList<ProcessModel>();
		JSONArray processJson = JSONArray.fromObject(JSONSerializer.toJSON(pdStringList));
		
		for(int i = 0; i < processJson.size(); i++){
			ProcessModel pd = (ProcessModel)JSONObject.toBean(processJson.getJSONObject(i), ProcessModel.class);
			pdList.add(pd);
		}
		
		return processService.addAllProcess(pdList);
	}
	
	@RequestMapping(value="/getProcess2.do")
	public @ResponseBody Map<?,?> processlList(ModelMap model) {
	        model.put("results", processService.getProcessList());
	        return model;
	}
}
