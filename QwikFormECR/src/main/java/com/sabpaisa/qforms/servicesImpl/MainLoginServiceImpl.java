package com.sabpaisa.qforms.servicesImpl;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.dao.MainLoginDao;
import com.sabpaisa.qforms.services.MainLoginService;


@Service

public class MainLoginServiceImpl implements MainLoginService{

	
	@Autowired
	private MainLoginDao loginDao;
	

	@Override
	public SuperAdminBean getLogin(SuperAdminBean sLogin) {
		
		return loginDao.getLogin(sLogin);

	}

	@Override
	public SuperAdminBean getLogin(String UserId, String Password, int roleId) throws HibernateException {
		// TODO Auto-generated method stub
		return loginDao.getLogin(UserId, Password, roleId);
	}
	
	@Override
	public SuperAdminBean getLoginforCob(String UserId, String Password) throws HibernateException {
		// TODO Auto-generated method stub
		return loginDao.getLoginforCob(UserId, Password);
	}
	
}
