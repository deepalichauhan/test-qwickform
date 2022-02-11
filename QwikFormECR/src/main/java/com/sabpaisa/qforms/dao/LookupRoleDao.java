package com.sabpaisa.qforms.dao;

import java.util.List;
import java.util.Map;

import com.sabpaisa.qforms.beans.LookupRoleBean;

public interface LookupRoleDao {
	public Map<Integer,String> getRoleMap();
	
	public List<LookupRoleBean> getRoleList();
}
