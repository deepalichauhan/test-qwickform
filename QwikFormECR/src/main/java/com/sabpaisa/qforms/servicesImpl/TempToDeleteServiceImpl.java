package com.sabpaisa.qforms.servicesImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.TesmToDeleteDao;
import com.sabpaisa.qforms.services.TempToDeleteService;

@Service
public class TempToDeleteServiceImpl implements TempToDeleteService{
   
	@Autowired
	TesmToDeleteDao tempToDeleteDao;
	
	@Override
	public List<Map<String, Object>> colNameColValue1(ArrayList<String> nameOfFields, Integer formTempId,
			HttpSession ses) {
		
		return tempToDeleteDao.colNameColValue1(nameOfFields, formTempId, ses);
	}

	@Override
	public String getFormTransId(String fieldNames, Integer formTempId) {
		
		return tempToDeleteDao.getFormTransId(fieldNames, formTempId);
	}

	@Override
	public SampleFormBean saveFormData(SampleFormBean saveData) {
		
		return tempToDeleteDao.saveFormData(saveData);
	}

	@Override
	public SampleFormBean getFormData(Integer id) {
		
		return tempToDeleteDao.getFormData(id);
	}

	@Override
	public List<SampleFormBean> getFormList(String id, String idType) {
		
		return tempToDeleteDao.getFormList(id, idType);
	}

	@Override
	public BeanFormDetails getFormDetails(int id) {
		
		return tempToDeleteDao.getFormDetails(id);
	}

}
