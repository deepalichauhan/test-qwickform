package com.sabpaisa.qforms.dao;

import java.util.List;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.StateBean;

public interface WhiteLevalDao {
	
	public List<CollegeBean> getCollegeListOfBank(int bid);
	public List<StateBean> getStateList();
	public List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId);

}
