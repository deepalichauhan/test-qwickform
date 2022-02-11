package com.sabpaisa.qforms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.SampleFormBean;

public interface TesmToDeleteDao {
	public List<Map<String, Object>> colNameColValue1(ArrayList<String> nameOfFields, Integer formTempId, HttpSession ses);
	public String getFormTransId(String fieldNames, Integer formTempId);
	public SampleFormBean saveFormData(SampleFormBean saveData);
	public SampleFormBean getFormData(Integer id);
	public List<SampleFormBean> getFormList(String id, String idType);
	public BeanFormDetails getFormDetails(int id);
}
