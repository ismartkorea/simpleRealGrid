package com.products.service;

import java.util.List;

import com.products.model.ProcessModel;

public interface ProcessService {

	public List<ProcessModel> getProcessList();
	
	public int addAllProcess(List<ProcessModel> processList);
	
	public int addProcess(ProcessModel product);
	public int updateProcess(ProcessModel product);
	public int delProcess(String process);
}
