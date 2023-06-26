package com.products.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.products.dao.ProcessDao;
import com.products.model.ProcessModel;

@Service("processService")
public class ProcessServiceImpl implements ProcessService {
	@Autowired ProcessDao processDao;
	
	@Transactional
	public int addAllProcess(List<ProcessModel> pdList) {
		
		int num = 0;
		
		for(ProcessModel process : pdList){
			if(process.getState().equals("created"))
				num += processDao.addProcess(process);
			else if(process.getState().equals("updated"))
				num += processDao.updateProcess(process);
			else if(process.getState().equals("deleted"))
				num += processDao.delProcess(process.getProcess1());
		}
		return num;
	}
	
	public List<ProcessModel> getProcessList() {
		return processDao.getProcessList();
	}

	public int addProcess(ProcessModel process) {
		return processDao.addProcess(process);
	}

	public int updateProcess(ProcessModel process) {
		return processDao.updateProcess(process);
	}

	public int delProcess(String process) {
		return processDao.delProcess(process);
	}
}
