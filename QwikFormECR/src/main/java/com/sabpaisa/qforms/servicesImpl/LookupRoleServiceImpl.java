package com.sabpaisa.qforms.servicesImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.LookupRoleBean;
import com.sabpaisa.qforms.dao.LookupRoleDao;
import com.sabpaisa.qforms.services.LookupRoleService;

@Service
public class LookupRoleServiceImpl implements LookupRoleService {

	@Autowired
	LookupRoleDao lookupRoleDao;
	
	@Override
	public List<LookupRoleBean> getRoleList() {
	
		return lookupRoleDao.getRoleList();
	}

	@Override
	public Map<Integer, String> getRoleMap() {
		
		return lookupRoleDao.getRoleMap();
	}

}
