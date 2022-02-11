package com.sabpaisa.qforms.servicesImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.ResultBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.DaoFieldLookup;
import com.sabpaisa.qforms.services.DaoFieldLookupService;

@Service
public class DaoFieldLookupServiceImpl implements DaoFieldLookupService{

	
	@Autowired
	private DaoFieldLookup daoFieldLookup;
	
	@Override
	public ArrayList<BeanFieldLookup> getFieldLookups() {
		
		return daoFieldLookup.getFieldLookups();
	}

	@Override
	public BeanFormDetails getInstructionDetailsBasedOnId(String id) {

		return daoFieldLookup.getInstructionDetailsBasedOnId(id);
	}

	@Override
	public BeanPayerType getPayerLookups(String payerName) {

		return daoFieldLookup.getPayerLookups(payerName);
	}

	@Override
	public void saveInstructionDetailsDao(BeanFormDetails form) {
		
		daoFieldLookup.saveInstructionDetailsDao(form);
	}

	@Override
	public ArrayList<BeanFormDetails> getPendingFormsFromTemplate(Integer actor_id) {
		
		return daoFieldLookup.getPendingFormsFromTemplate(actor_id);
	}

	@Override
	public ArrayList<FormStateBean> getPendingFormsFromInstance(Integer actor_id) {

		return daoFieldLookup.getPendingFormsFromInstance(actor_id);
	}

	@Override
	public ArrayList<FormStateBean> getPendingFormsFromInstance(Integer actor_id, String Username) {
		
		return daoFieldLookup.getPendingFormsFromInstance(actor_id, Username);
	}

	@Override
	public ArrayList<SampleFormBean> getPendingFormsData(List<Integer> formIds) {

		return daoFieldLookup.getPendingFormsData(formIds);
	}

	@Override
	public ArrayList<BeanFieldLookup> getFieldLookups(ArrayList<Integer> lookupIds) {

		return daoFieldLookup.getFieldLookups(lookupIds);
	}

	@Override
	public BeanFormDetails getFormDetails(Integer formId) {

		return daoFieldLookup.getFormDetails(formId);
	}

	@Override
	public BeanFormDetails getFormDetails(String formid) {

		return daoFieldLookup.getFormDetails(formid);
	}

	@Override
	public BeanFormDetails saveForm(BeanFormDetails saveData) {

		return daoFieldLookup.saveForm(saveData);
	}

	@Override
	public void updateForm(Integer id, String status) {

		daoFieldLookup.updateForm(id,status);
	}

	@Override
	public BeanFieldLookup saveField(BeanFieldLookup saveData) throws ConstraintViolationException {

		return daoFieldLookup.saveField(saveData);
	}

	@Override
	public List<BeanFormDetails> getForms(String key, Object value) {

		return daoFieldLookup.getForms(key, value);
	}

	@Override
	public List<BeanFormDetails> getFormsForActors(String key, Object value) {
		
		return daoFieldLookup.getFormsForActors(key, value);
	}

	@Override
	public List<BeanFormDetails> getApprovedFormDetails(LoginBean loginBean) {
		
		return daoFieldLookup.getApprovedFormDetails(loginBean);
	}

	@Override
	public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClient(LoginBean loginBean) {
		
		return daoFieldLookup.getAllApprovedFormDetailsBasedOnClient(loginBean);
	}

	@Override
	public List<BeanPayerType> getPayerDetails(CollegeBean collegeBean, Integer bid) {

		return daoFieldLookup.getPayerDetails(collegeBean, bid);
	}

	@Override
	public BeanPayerType getPayerLookupsBasedOnClient(String payer, CollegeBean college) {
		
		return daoFieldLookup.getPayerLookupsBasedOnClient(payer, college);
	}

	@Override
	public CollegeBean getClientDetailsBasedOnClientCode(String formOwnerName) {
	
		return daoFieldLookup.getClientDetailsBasedOnClientCode(formOwnerName);
	}

	@Override
	public BeanPayerType getPayerLookupsBasedOnPayerId(Integer payer_type) {
	
		return daoFieldLookup.getPayerLookupsBasedOnPayerId(payer_type);
	}

	@Override
	public BeanFormDetails getInstructionDetailsBasedOnIds(Integer id) {
		
		return daoFieldLookup.getInstructionDetailsBasedOnIds(id);
	}

	@Override
	public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClientForChallanMIS(LoginBean loginBean) {
		
		return daoFieldLookup.getAllApprovedFormDetailsBasedOnClientForChallanMIS(loginBean);
	}

	@Override
	public List<BeanFormDetails> getAllPendingDetailstForSpotCash(LoginBean loginBean) {
		
		return daoFieldLookup.getAllPendingDetailstForSpotCash(loginBean);
	}

	@Override
	public ArrayList<BeanPayerType> getPayerLookups(LoginBean loginUser) {
		
		return daoFieldLookup.getPayerLookups(loginUser);
	}

	@Override
	public Boolean creatDynamicTable(String dynSQL, String clientTable) {
		
		return daoFieldLookup.creatDynamicTable(dynSQL, clientTable);
	}
	
	@Override
	public Boolean creatDynamicTableForOfflineForm(String dynSQL, String clientTable) {
		
		return daoFieldLookup.creatDynamicTableForOfflineForm(dynSQL, clientTable);
	}

	@Override
	public ResultBean saveEmilMobileList(ResultBean resultBean) {
		
		return daoFieldLookup.saveEmilMobileList(resultBean);
	}

	@Override
	public Map<Integer, String> getFormDataAsCollegeCode(String ccode) throws SQLException{
		
		return daoFieldLookup.getFormDataAsCollegeCode(ccode);
	}

	@Override
	public BeanPayerType getPayerLookupsById(Integer payerId) {
		
		return daoFieldLookup.getPayerLookupsById(payerId);
	}

	@Override
	public BeanLateFee saveLateFee(BeanLateFee lateFeeData) {
		
		return daoFieldLookup.saveLateFee(lateFeeData);
	}

	@Override
	public BeanLateFee getLateFeeOnId(Integer feeId) {
		
		return daoFieldLookup.getLateFeeOnId(feeId);
	}

	@Override
	public List<BeanFormDetails> fetchAllFomsByClientCode(String clientCode){
		return daoFieldLookup.fetchAllFomsByClientCode(clientCode);
	}
	
	@Override
	public List<BeanFormDetails> fetchFormDetailsAsListByPayerId(Integer payerId, String collegeCode) {
		
		return daoFieldLookup.fetchFormDetailsAsListByPayerId(payerId, collegeCode);
	}

}
