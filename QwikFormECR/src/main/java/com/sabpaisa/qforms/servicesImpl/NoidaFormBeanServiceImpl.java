package com.sabpaisa.qforms.servicesImpl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.NoidaFormBean;
import com.sabpaisa.qforms.dao.NoidaFormBeanDAO;
import com.sabpaisa.qforms.services.NoidaFormBeanService;

@Service
public class NoidaFormBeanServiceImpl implements NoidaFormBeanService{

	@Autowired
	private NoidaFormBeanDAO noidaFormBeanDAO;
	
	@Override
	public ArrayList<NoidaFormBean> getDetailsOfDataSumaryAnd(Integer clientId) {
		
		return noidaFormBeanDAO.getDetailsOfDataSumaryAnd(clientId);
	}

}
