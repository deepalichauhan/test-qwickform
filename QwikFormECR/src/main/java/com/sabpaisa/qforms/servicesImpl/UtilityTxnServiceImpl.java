package com.sabpaisa.qforms.servicesImpl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.dao.UtilityTxnDao;
import com.sabpaisa.qforms.services.UtilityTxnService;

@Service
public class UtilityTxnServiceImpl implements UtilityTxnService{
	
	private static Logger log = LogManager.getLogger(UtilityTxnServiceImpl.class.getName());
	
	@Autowired
	UtilityTxnDao utilityTxnDao;
	
	@Override
	public List<Map<String, Object>> fetchWACOEClientData(String PRNNum){		
		
		log.info("Start of fetchWACOEClientData(), PRNNum >> "+PRNNum);
				
		return utilityTxnDao.fetchWACOEClientData(PRNNum); 
	}

}
