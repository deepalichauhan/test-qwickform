package com.sabpaisa.qforms.servicesImpl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.controller.TempToDeleteController;
import com.sabpaisa.qforms.dao.OffLineFormDao;
import com.sabpaisa.qforms.services.OffLineFormService;

@Service
public class OffLineFormServiceImpl implements OffLineFormService{
	
	@Autowired
	private OffLineFormDao offLineFormDao;

	private static Logger log = LogManager.getLogger(OffLineFormServiceImpl.class.getName());
	
	@Override
	public String generateTempTable(ArrayList<String> columnListOfFirstRow, String tempTableName, HttpSession ses, String formName, String cCode) throws Exception {
		
		return offLineFormDao.generateTempTable(columnListOfFirstRow,tempTableName, ses, formName, cCode);
	}

	@Override
	public ArrayList<String> generateColumnList(File fileUpload, HttpSession ses) throws Exception {
		
		return offLineFormDao.generateColumnList(fileUpload, ses);
	}

	@Override
	public BeanPayerType getPayerDetails(Integer id) {
		
		return offLineFormDao.getPayerDetails(id);
	}

	@Override
	public String saveDataInToTempTable(ArrayList<String> columnListOfFirstRow, String insertParam, String tempTableNameForFileUpload,
			String formName, String cCode) {
		
		return offLineFormDao.saveDataInToTempTable(columnListOfFirstRow, insertParam, tempTableNameForFileUpload, formName, cCode);
	}

	@Override
	public ArrayList<String> fetchListOfFieldsAsFieldName(String fieldName) {
		
		return offLineFormDao.fetchListOfFieldsAsFieldName(fieldName);
	}

	@Override
	public Map<String, ArrayList<String>> fetchListOfFieldsAsColumnList(ArrayList<String> columnListOfFirstRow) {
		Map<String,ArrayList<String>> mappedFieldList=new HashMap<String,ArrayList<String>>();
		ArrayList<String> fieldList = new ArrayList<String>();
		
		for (int i = 0; i < columnListOfFirstRow.size(); i++) {
			log.info(i + " value of columnListOf FirstRow is :::::::: "	+ columnListOfFirstRow.get(i).toString());
			String fieldName=columnListOfFirstRow.get(i).toString();
			
			fieldList=offLineFormDao.fetchListOfFieldsAsFieldName(fieldName);
			if(fieldList.size()>0) {
				mappedFieldList.put(fieldName, fieldList);
			}else {
				ArrayList<String> newfieldLookupList = new ArrayList<String>();
				newfieldLookupList.add(fieldName);
				mappedFieldList.put(fieldName, newfieldLookupList);
			}			
		}
		log.info("mappedList is For : "+mappedFieldList.toString());
		return mappedFieldList;
	}

	@Override
	public Map<String, ArrayList<String>> fetchListOfValidationAsColumnList(ArrayList<String> columnListOfFirstRow) {
		Map<String,ArrayList<String>> mappedValidationList=new HashMap<String,ArrayList<String>>();
		ArrayList<String> validationList = new ArrayList<String>();
		
		for (int i = 0; i < columnListOfFirstRow.size(); i++) {
			log.info(i + " value of columnListOf FirstRow is :::::::: "	+ columnListOfFirstRow.get(i).toString());
			String fieldName=columnListOfFirstRow.get(i).toString();
			
			validationList=offLineFormDao.fetchListOfValidationAsFieldName(fieldName);
			if(validationList.size()>0) {
				mappedValidationList.put(fieldName, validationList);
			}else {
				ArrayList<String> newfieldLookupList = new ArrayList<String>();
				newfieldLookupList.add("No Validation");
				mappedValidationList.put(fieldName, newfieldLookupList);
			}
		}
		log.info("mappedList is For : "+mappedValidationList.toString());
		return mappedValidationList;
	}
}
