package com.products.dao;

import java.util.List;

import com.products.model.ProcessModel;

public interface ProcessDao {
	
	public List<ProcessModel> getProcessList();
	public int addProcess(ProcessModel process);
	public int updateProcess(ProcessModel process);
	public int delProcess(String code);
}
