package com.sabpaisa.qforms.dao;

import java.util.List;
import java.util.Map;

public interface UtilityTxnDao {

	public List<Map<String, Object>> fetchWACOEClientData(String PRNNum);
	
}
