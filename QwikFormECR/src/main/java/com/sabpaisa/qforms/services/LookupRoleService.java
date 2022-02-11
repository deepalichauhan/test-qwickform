package com.sabpaisa.qforms.services;

import java.util.List;
import java.util.Map;

import com.sabpaisa.qforms.beans.LookupRoleBean;

public interface LookupRoleService {
	
	public Map<Integer,String> getRoleMap();

	public List<LookupRoleBean> getRoleList();
}
