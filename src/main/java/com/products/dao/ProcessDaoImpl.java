package com.products.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.products.dao.mapper.ProcessMapper;
import com.products.model.ProcessModel;

@Repository
public class ProcessDaoImpl implements ProcessDao {
	@Autowired ProcessMapper processMapper;
	
	public List<ProcessModel> getProcessList() {
		return processMapper.getProcessList();
	}

	public int addProcess(ProcessModel process) {
		return processMapper.addProcess(process);
	}

	public int updateProcess(ProcessModel process) {
		return processMapper.updateProcess(process);
	}
	
	public int delProcess(String process) {
		return processMapper.delProcess(process);
	}

}
