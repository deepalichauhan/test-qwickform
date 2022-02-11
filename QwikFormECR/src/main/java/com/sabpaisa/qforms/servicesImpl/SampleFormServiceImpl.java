package com.sabpaisa.qforms.servicesImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.SampleFormDao;
import com.sabpaisa.qforms.services.SampleFormService;

@Service
public class SampleFormServiceImpl implements SampleFormService {

	@Autowired
	SampleFormDao sampleFormDao;
	
	@Override
	public BeanPayerType saveTargetPayerDao(BeanPayerType beanPayerType) {
		
		return sampleFormDao.saveTargetPayerDao(beanPayerType);
	}

	@Override
	public ArrayList<BeanPayerType> getAllPayersTargetData(Integer cid, Integer bid) {

		return sampleFormDao.getAllPayersTargetData(cid, bid);
	}

	@Override
	public SampleFormBean saveFormData(SampleFormBean saveData) {

		return sampleFormDao.saveFormData(saveData);
	}
	
	@Override
	public SampleFormBean saveFormDataForLp(SampleFormBean saveData) {

		return sampleFormDao.saveFormDataForLp(saveData);
	}

	@Override
	public SampleFormBean fetchEndUserData(int id) {
		
		return sampleFormDao.fetchEndUserData(id);
	}
	
	@Override
	public SampleFormBean getFormData(Integer id) {
		
		return sampleFormDao.getFormData(id);
	}
	
	@Override
	public List<SampleFormBean> getFormList(String id, String idType) {

		return sampleFormDao.getFormList(id, idType);
	}

	@Override
	public BeanFormDetails getFormDetails(int id) {

		return sampleFormDao.getFormDetails(id);
	}

	@Override
	public void deleteFormData(SampleFormBean beanFormData) {

		sampleFormDao.deleteFormData(beanFormData);
	}

	@Override
	public String getFormNameByFormId(Integer id) {
		
		return sampleFormDao.getFormNameByFormId(id);
	}

	@Override
	public BeanFormDetails getFormTempId(Integer id) {
		
		return sampleFormDao.getFormTempId(id);
	}

	@Override
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields, Integer formTempId,
			String clientCode,String payerName,HttpSession ses) {
		
		return sampleFormDao.colNameColValue(nameOfFields, formTempId,clientCode,payerName, ses);
	}

	@Override
	public Integer updateFormData(String listData, String transId, Integer formId, Integer cid) {
		
		return sampleFormDao.updateFormData(listData, transId, formId, cid);
	}

	@Override
	public String getFormTransStatus(String fieldNames,Integer formTempId) {
		
		return sampleFormDao.getFormTransStatus(fieldNames, formTempId);
	}

	@Override
	public ArrayList<String> getFormEmail(Integer formTempId) {
		// TODO Auto-generated method stub
		return sampleFormDao.getFormEmail(formTempId);
	}
	
	@Override
	public ArrayList<String> getFormMobileNumber(Integer formTempId) {
		// TODO Auto-generated method stub
		return sampleFormDao.getFormMobileNumber(formTempId);
	}

	@Override
	public String getFormTransId(String fieldNames, Integer formTempId) {
		// TODO Auto-generated method stub
		return sampleFormDao.getFormTransId(fieldNames, formTempId);
	}

	@Override
	public SampleFormBean getFormDetailsByQfId(String qcId) throws Exception{
		// TODO Auto-generated method stub
		return sampleFormDao.getFormDetailsByQfId(qcId);
	}

	@Override
	public String getQfId(String linkPass, Integer formTempId) throws Exception{
		// TODO Auto-generated method stub
		return sampleFormDao.getQfId(linkPass, formTempId);
	}

	@Override
	public String getFileUploadLink(String fieldKey, Integer formId) throws Exception {
		// TODO Auto-generated method stub
		return sampleFormDao.getFileUploadLink(fieldKey,formId);
	}
	
	@Override
	public String getFileUploadLink1(String fieldKey, Integer formId) throws Exception {
		// TODO Auto-generated method stub
		return sampleFormDao.getFileUploadLink1(fieldKey,formId);
	}
}
