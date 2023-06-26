package com.products.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.products.dao.ProcessDao;
import com.products.model.ProcessModel;

@Service("processService")
public class ProcessServiceImpl implements ProcessService {
	@Autowired ProcessDao proDao;
	
	@Transactional
	public int addAllProcess(List<ProcessModel> pdList) {
		
		int num = 0;
		
		for(ProcessModel process : pdList){
			if(process.getState().equals("created"))
				num += proDao.addProcess(process);
			else if(process.getState().equals("updated"))
				num += proDao.updateProcess(process);
			else if(process.getState().equals("deleted"))
				num += proDao.delProcess(process.getProcess1());
		}
		return num;
	}
	
	public List<ProcessModel> getProcessList() {
		return proDao.getProcessList();
	}

	public int addProcess(ProcessModel process) {
		return proDao.addProcess(process);
	}

	public int updateProcess(ProcessModel process) {
		return proDao.updateProcess(process);
	}

	public int delProcess(String process) {
		return proDao.delProcess(process);
	}
}
