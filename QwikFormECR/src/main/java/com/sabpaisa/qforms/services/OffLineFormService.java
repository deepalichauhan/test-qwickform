package com.sabpaisa.qforms.services;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.BeanPayerType;

public interface OffLineFormService {
	public String generateTempTable(ArrayList<String> columnListOfFirstRow, String tempTableName, HttpSession ses, String formName, String cCode) throws Exception;
	public ArrayList<String> generateColumnList(File fileUpload, HttpSession ses) throws Exception;
	public BeanPayerType getPayerDetails(Integer id);
	public String saveDataInToTempTable(ArrayList<String>columnListOfFirstRow,String insertParam,String tempTableNameForFileUpload,String formName, String cCode);
	public ArrayList<String> fetchListOfFieldsAsFieldName(String fieldName);
	public Map<String,ArrayList<String>> fetchListOfFieldsAsColumnList(ArrayList<String> columnListOfFirstRow);
	public Map<String,ArrayList<String>> fetchListOfValidationAsColumnList(ArrayList<String> columnListOfFirstRow);
}
