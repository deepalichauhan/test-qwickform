package com.sabpaisa.qforms.servicesImpl;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.dao.WhiteLevalDao;
import com.sabpaisa.qforms.services.WhiteLevalService;

@Service("whiteLevalService")
public class WhiteLevalServiceImpl implements WhiteLevalService{
	
	@Autowired
	private WhiteLevalDao whiteLevalDao;
	
	private static Logger log = LogManager.getLogger(WhiteLevalServiceImpl.class.getName());
	
	@Override
	public List<CollegeBean> getCollegeListOfBank(int bid) {
		// TODO Auto-generated method stub
		return whiteLevalDao.getCollegeListOfBank(bid);
	}
	
	
	@Override
	public List<StateBean> getStateList(List<CollegeBean> collegelist) {
		// TODO Auto-generated method stub
		log.info("Start of getStateList() method, Size of CollegeList is "+collegelist);
		
		Set<StateBean> statesHashSet =new LinkedHashSet<StateBean>();
		List<StateBean> statesListBean =new ArrayList<>();
			
		for(int i=0; i< collegelist.size(); i++ ) {
			log.info("State Name >> "+collegelist.get(i).getCollegeName());
			statesHashSet.add(collegelist.get(i).getStateBean());
			//log.info("State Name >> "+StatesListBean.get(i).getStateName());
		}
		
		log.info("State list size >> "+statesHashSet.size());
		statesListBean.addAll(statesHashSet);
		//return whiteLevalDao.getStateList();
		return statesListBean;
	}
	
	@Override
	public List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId) {
		// TODO Auto-generated method stub
		return whiteLevalDao.getCollegeDetailsBasedOnStateId(stateId, bankId);
	}
	

}
