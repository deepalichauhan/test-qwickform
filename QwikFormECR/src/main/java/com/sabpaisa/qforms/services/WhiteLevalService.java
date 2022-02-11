package com.sabpaisa.qforms.services;

import java.util.List;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.StateBean;


public interface WhiteLevalService {
	
	public List<CollegeBean> getCollegeListOfBank(int bid);	
	public List<StateBean> getStateList(List<CollegeBean> collegelist);
	public List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId);
	//public String sendEnquiryMail(String fromMail,String toMail,String nameOfUser,String userMobile,String mailBodyContent,String btype);

}
