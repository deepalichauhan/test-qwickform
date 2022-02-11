package com.sabpaisa.qforms.services;

import java.util.ArrayList;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;

public interface DaoFeeService {

	public ArrayList<BeanFeeLookup> getFeeLookups(String key,Object value);
	public BeanFeeDetails getFeeDetails(String key,Object value);	
	public BeanFeeLookup saveFeeLookup(BeanFeeLookup lookupData) throws org.hibernate.exception.ConstraintViolationException;
	public Boolean checkFee(BeanFeeLookup lookupData) throws org.hibernate.exception.ConstraintViolationException;
}
