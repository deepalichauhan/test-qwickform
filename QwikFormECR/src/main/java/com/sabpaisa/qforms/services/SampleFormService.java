package com.sabpaisa.qforms.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.SampleFormBean;

public interface SampleFormService {
	public BeanPayerType saveTargetPayerDao(BeanPayerType beanPayerType);
	public ArrayList<BeanPayerType> getAllPayersTargetData(Integer cid, Integer bid) ;
	public SampleFormBean saveFormData(SampleFormBean saveData);
	public SampleFormBean saveFormDataForLp(SampleFormBean saveData);
	public SampleFormBean fetchEndUserData(int id);
	public SampleFormBean getFormData(Integer id);
	public List<SampleFormBean> getFormList(String id, String idType);
	public BeanFormDetails getFormDetails(int id);
	public void  deleteFormData(SampleFormBean beanFormData);
	public String getFormNameByFormId(Integer id);
	public BeanFormDetails getFormTempId(Integer id);
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields,Integer formTempId,
			String clientCode,String payerName,HttpSession ses);
	public Integer updateFormData(String listData, String transId, Integer formId, Integer cid);
	public String getFormTransStatus(String fieldNames,Integer formTempId);
	public String getFormTransId(String fieldNames,Integer formTempId);
	public ArrayList<String> getFormEmail(Integer formTempId);
	public ArrayList<String> getFormMobileNumber(Integer formTempId);
	public SampleFormBean getFormDetailsByQfId(String qcId) throws Exception;
	public String getQfId(String linkPass, Integer formTempId) throws Exception;
	public String getFileUploadLink(String fieldKey,Integer formId) throws Exception;
	public String getFileUploadLink1(String fieldKey,Integer formId) throws Exception;
}
