package com.sabpaisa.qforms.servicesImpl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.AdmitCardBean;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.AdmitCardDAO;
import com.sabpaisa.qforms.services.AdmitCardService;

@Service
public class AdmitCardServiceImpl implements AdmitCardService{

	@Autowired
	AdmitCardDAO admitCardDAO;

	@Override
	public AdmitCardBean getAdmitCard(String id) {
		
		return admitCardDAO.getAdmitCard(id);
	}

	@Override
	public SampleFormBean getAdmitCardByApplicationNo(String applicationFormNumber) {
		
		return admitCardDAO.getAdmitCardByApplicationNo(applicationFormNumber);
	}
	
	@Override
	public String saveSingleStudentlist(AdmitCardBean admitBean) {
		
		return admitCardDAO.saveSingleStudentlist(admitBean);
	}
	
	@Override
	public String updateSingleStudentlist(AdmitCardBean admitBean) {
		
		return admitCardDAO.updateSingleStudentlist(admitBean);
	}

	@Override
	public String generateTempTable(File fileUpload, String sendLink, String serviceId, String productId,
			String sheetName, HttpSession ses) throws IOException {
		
		return admitCardDAO.generateTempTable(fileUpload, sendLink, serviceId, productId, sheetName, ses);
	}

	@Override
	public AdmitCardBean editAdmitCardDetailsID(String parameter) {
		
		return admitCardDAO.editAdmitCardDetailsID(parameter);
	}

	@Override
	public CollegeBean getCollegedetails(String id) {
		
		return admitCardDAO.getCollegedetails(id);
	}

	@Override
	public List<AdmitCardBean> getAdmitCardList() {
		
		return admitCardDAO.getAdmitCardList();
	}
	
	
}
