package com.sabpaisa.qforms.servicesImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.ApplicantDAO;
import com.sabpaisa.qforms.services.ApplicantService;

@Service
public class ApplicantServiceImpl implements ApplicantService {

	@Autowired
	ApplicantDAO applicantDAO;
	
	@Override
	public List<String> getAllAplicantDetails() {
		
		return applicantDAO.getAllAplicantDetails();
	}

	@Override
	public List<SampleFormBean> getAllAplicantDetails1() {
		
		return applicantDAO.getAllAplicantDetails1();
	}

	@Override
	public List<SampleFormBean> getSuccessTransAplicantDetailsOfParticularClient(String feeType, String key,
			Object value) {
		
		return applicantDAO.getSuccessTransAplicantDetailsOfParticularClient(feeType, key, value);
	}

	@Override
	public List<Object[]> getSuccessTransAplicantDetailsOfParticularClientLatest(String feeType, String key,
			Object value, String cid) {
		
		return applicantDAO.getSuccessTransAplicantDetailsOfParticularClientLatest(feeType, key, value, cid);
	}

	@Override
	public List<String> getAllAplicantDetailsOfParticularClient(Integer collegeId, String feeType) {
		
		return applicantDAO.getAllAplicantDetailsOfParticularClient(collegeId, feeType);
	}

	@Override
	public List<String> getAllAplicantDetailsOfParticularClientForExcelDownlods(Integer collegeId) {
		
		return applicantDAO.getAllAplicantDetailsOfParticularClientForExcelDownlods(collegeId);
	}

}
