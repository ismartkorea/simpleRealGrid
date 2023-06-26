package com.products.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.products.model.ProcessModel;

public interface ProcessMapper {
	
	@Select("select * from Process")
	public List<ProcessModel> getProcessList();
	
	public int addProcess(ProcessModel process);
	
	public int updateProcess(ProcessModel process);
	
	public int delProcess(String process);
}
