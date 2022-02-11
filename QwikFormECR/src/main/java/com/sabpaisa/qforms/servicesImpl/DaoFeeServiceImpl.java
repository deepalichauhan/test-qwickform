package com.sabpaisa.qforms.servicesImpl;

import java.util.ArrayList;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.dao.DaoFee;
import com.sabpaisa.qforms.services.DaoFeeService;

@Service
public class DaoFeeServiceImpl implements DaoFeeService {

	@Autowired
	private DaoFee daoFee;
	
	
	@Override
	public ArrayList<BeanFeeLookup> getFeeLookups(String key, Object value) {
		
		return daoFee.getFeeLookups(key, value);
	}

	@Override
	public BeanFeeDetails getFeeDetails(String key, Object value) {
		
		return daoFee.getFeeDetails(key, value);
	}

	@Override
	public BeanFeeLookup saveFeeLookup(BeanFeeLookup lookupData) throws ConstraintViolationException {
		
		return daoFee.saveFeeLookup(lookupData);
	}

	@Override
	public Boolean checkFee(BeanFeeLookup lookupData) throws ConstraintViolationException {
		// TODO Auto-generated method stub
		return daoFee.checkFee(lookupData);
	}

}
