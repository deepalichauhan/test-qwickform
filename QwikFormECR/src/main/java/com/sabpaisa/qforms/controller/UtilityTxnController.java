package com.sabpaisa.qforms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sabpaisa.qforms.services.UtilityTxnService;



@CrossOrigin
@RestController
public class UtilityTxnController {
	
	private static Logger log = LogManager.getLogger(UtilityTxnController.class.getName());
	
	@Autowired
	UtilityTxnService utilityTxnService;
	
	@RequestMapping(value = "/fetchDataForWACOE", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody List<Map<String, Object>> fetchWACOEClientData(
			/* @RequestParam(value = "clientCode", required = true) String clientCode, */
			@RequestParam(value = "PRNNum", required = true) String PRNNum) {
		
		
		List<Map<String, Object>> wacoeList = new ArrayList<Map<String, Object>>();
		log.info("Start of fetchWACOEClientData(), PRNNum >> "+PRNNum);
		
		wacoeList = utilityTxnService.fetchWACOEClientData(PRNNum);
		
		log.info("End of fetchWACOEClientData(), "+wacoeList );
		return wacoeList ;
		
	}

}
