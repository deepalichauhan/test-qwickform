package com.sabpaisa.qforms.services;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanSubjectLookup;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SheetFillingBeanForBu;

public interface BurdService {
	public BeanFormDetails getFormDetails(int id);
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields,Integer formTempId,HttpSession ses);
	public String getFormTransId(String fieldNames,Integer formTempId);
	public String getFormTransStatus(String fieldNames,Integer formTempId);
	public SampleFormBean saveFormData(SampleFormBean saveData);
	public BeanSubjectLookup getSubjectData(Integer id);
	public List<SampleFormBean> getFormList(String id, String idType);
	public Integer getApprovedCollegeCode(String collegeName) throws SQLException;
	public Integer getSelectSubjectId(String subjectName)throws SQLException;
	public SheetFillingBeanForBu getAllSubjectFilledSheetDetail(String college_category, Integer cid, Integer sid)throws SQLException;
	public String getClientTableNameFromMainTable(String tableName,String qcTxnId,HttpSession ses)throws SQLException;
	public List<BeanSubjectLookup> getAllSubjectNamesBasedOnClient();
	public Integer getSeatDetailAsSubjectWise(Integer sid,Integer cid, HttpSession ses) throws SQLException;
	public List<SheetFillingBeanForBu> getSubjectDetailSeatList(Integer clientIdForBU);
	public List<String> getCollegeNameListByTempTable(); 
	public String getCollegeCategoryForMain(ArrayList<String> nameOfFieldsForBU, Integer formTempId)throws SQLException ;
}