package com.sabpaisa.qforms.dao;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.AdmitCardBean;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;

public interface AdmitCardDAO {

	public AdmitCardBean getAdmitCard(String id);
	public SampleFormBean getAdmitCardByApplicationNo(String applicationFormNumber);
	public String saveSingleStudentlist(AdmitCardBean admitBean);
	public String updateSingleStudentlist(AdmitCardBean admitBean);
	public String generateTempTable(File fileUpload, String sendLink, String serviceId, String productId,
			String sheetName, HttpSession ses) throws IOException;
	public AdmitCardBean editAdmitCardDetailsID(String parameter);
	public CollegeBean getCollegedetails(String id);
	public List<AdmitCardBean> getAdmitCardList();
}
