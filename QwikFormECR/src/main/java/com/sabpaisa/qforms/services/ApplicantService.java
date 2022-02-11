package com.sabpaisa.qforms.services;

import java.util.List;

import com.sabpaisa.qforms.beans.SampleFormBean;

public interface ApplicantService {

	public List<String> getAllAplicantDetails();
	public List<SampleFormBean> getAllAplicantDetails1();
	public List<SampleFormBean> getSuccessTransAplicantDetailsOfParticularClient(String feeType, String key, Object value);
	public List<Object[]> getSuccessTransAplicantDetailsOfParticularClientLatest(String feeType, String key,
			Object value, String cid);
	public List<String> getAllAplicantDetailsOfParticularClient(Integer collegeId, String feeType);
	public List<String> getAllAplicantDetailsOfParticularClientForExcelDownlods(Integer collegeId);
}
