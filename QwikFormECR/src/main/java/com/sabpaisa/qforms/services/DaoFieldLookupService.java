package com.sabpaisa.qforms.services;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.ResultBean;
import com.sabpaisa.qforms.beans.SampleFormBean;

public interface DaoFieldLookupService {

	public ArrayList<BeanFieldLookup> getFieldLookups();
	public BeanFormDetails getInstructionDetailsBasedOnId(String id);
	public BeanPayerType getPayerLookupsById(Integer payerId);
	public BeanPayerType getPayerLookups(String payerName);
	public void saveInstructionDetailsDao(BeanFormDetails form);
	public ArrayList<BeanFormDetails>getPendingFormsFromTemplate(Integer actor_id);
	public ArrayList<FormStateBean>getPendingFormsFromInstance(Integer actor_id);
	public ArrayList<FormStateBean>getPendingFormsFromInstance(Integer actor_id,String Username);
	public ArrayList<SampleFormBean> getPendingFormsData(List<Integer> formIds);
	public ArrayList<BeanFieldLookup> getFieldLookups(ArrayList<Integer> lookupIds);
	public BeanFormDetails getFormDetails(Integer formId);
	public BeanFormDetails getFormDetails(String formid);
	public BeanFormDetails saveForm(BeanFormDetails saveData);
	public BeanLateFee saveLateFee(BeanLateFee lateFeeData);
	public void updateForm(Integer id, String status);
	
	public BeanLateFee getLateFeeOnId(Integer feeId);
	
	public ResultBean saveEmilMobileList(ResultBean resultBean);
	public BeanFieldLookup saveField(BeanFieldLookup saveData)
			throws org.hibernate.exception.ConstraintViolationException;
	
	public List<BeanFormDetails> getForms(String key, Object value);
	public List<BeanFormDetails> getFormsForActors(String key, Object value);
	public List<BeanFormDetails> getApprovedFormDetails(LoginBean loginBean);
	public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClient(LoginBean loginBean);
	
	
	public List<BeanPayerType> getPayerDetails(CollegeBean collegeBean, Integer bid);
	public BeanPayerType getPayerLookupsBasedOnClient(String payer, CollegeBean college);
	public CollegeBean getClientDetailsBasedOnClientCode(String formOwnerName);
	public BeanPayerType getPayerLookupsBasedOnPayerId(Integer payer_type);
	
	public BeanFormDetails getInstructionDetailsBasedOnIds(Integer id);
	public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClientForChallanMIS(LoginBean loginBean);
	public List<BeanFormDetails> getAllPendingDetailstForSpotCash(LoginBean loginBean);
	public ArrayList<BeanPayerType> getPayerLookups(LoginBean loginUser);
	public Boolean creatDynamicTable(String dynSQL,String clientTable);
	public Boolean creatDynamicTableForOfflineForm(String dynSQL,String clientTable);
	public Map<Integer,String> getFormDataAsCollegeCode(String ccode) throws SQLException;
	public List<BeanFormDetails> fetchAllFomsByClientCode(String clientCode);
	public List<BeanFormDetails> fetchFormDetailsAsListByPayerId(Integer payerId,String collegeCode);
	
}
