package com.sabpaisa.qforms.servicesImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanSubjectLookup;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SheetFillingBeanForBu;
import com.sabpaisa.qforms.dao.BurdDao;
import com.sabpaisa.qforms.services.BurdService;

@Service
public class BurdServiceImpl implements BurdService {

	@Autowired
	BurdDao burdDao;

	@Override
	public BeanFormDetails getFormDetails(int id) {
		
		return burdDao.getFormDetails(id);
	}

	@Override
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields, Integer formTempId,
			HttpSession ses) {

		return burdDao.colNameColValue(nameOfFields, formTempId, ses);
	}

	@Override
	public String getFormTransId(String fieldNames, Integer formTempId) {
		
		return burdDao.getFormTransId(fieldNames, formTempId);
	}

	@Override
	public String getFormTransStatus(String fieldNames, Integer formTempId) {
		// TODO Auto-generated method stub
		return burdDao.getFormTransStatus(fieldNames, formTempId);
	}

	@Override
	public SampleFormBean saveFormData(SampleFormBean saveData) {
		// TODO Auto-generated method stub
		return burdDao.saveFormData(saveData);
	}

	@Override
	public BeanSubjectLookup getSubjectData(Integer id) {
		// TODO Auto-generated method stub
		return burdDao.getSubjectData(id);
	}

	@Override
	public List<SampleFormBean> getFormList(String id, String idType) {
		// TODO Auto-generated method stub
		return burdDao.getFormList(id, idType);
	}

	@Override
	public Integer getApprovedCollegeCode(String collegeName) throws SQLException {
		// TODO Auto-generated method stub
		return burdDao.getApprovedCollegeCode(collegeName);
	}

	@Override
	public Integer getSelectSubjectId(String subjectName) throws SQLException{
		// TODO Auto-generated method stub
		return burdDao.getSelectSubjectId(subjectName);
	}

	@Override
	public SheetFillingBeanForBu getAllSubjectFilledSheetDetail(String college_category, Integer cid, Integer sid) throws SQLException{
		// TODO Auto-generated method stub
		return burdDao.getAllSubjectFilledSheetDetail(college_category, cid, sid);
	}

	@Override
	public String getClientTableNameFromMainTable(String tableName,String qcTxnId,HttpSession ses)throws SQLException {
		// TODO Auto-generated method stub
		return burdDao.getClientTableNameFromMainTable(tableName,qcTxnId,ses);
	}

	@Override
	public List<BeanSubjectLookup> getAllSubjectNamesBasedOnClient() {
		// TODO Auto-generated method stub
		return burdDao.getAllSubjectNamesBasedOnClient();
	}

	@Override
	public Integer getSeatDetailAsSubjectWise(Integer sid, Integer cid, HttpSession ses) throws SQLException {
		// TODO Auto-generated method stub
		return burdDao.getSeatDetailAsSubjectWise(sid, cid, ses);
	}

	@Override
	public List<SheetFillingBeanForBu> getSubjectDetailSeatList(Integer clientIdForBU) {
		// TODO Auto-generated method stub
		return burdDao.getSubjectDetailSeatList(clientIdForBU);
	}

	@Override
	public List<String> getCollegeNameListByTempTable() {
		// TODO Auto-generated method stub
		return burdDao.getCollegeNameListByTempTable();
	}

	@Override
	public String getCollegeCategoryForMain(ArrayList<String> nameOfFieldsForBU, Integer formTempId) throws SQLException {
		// TODO Auto-generated method stub
		return burdDao.getCollegeCategoryForMain(nameOfFieldsForBU, formTempId);
	}

}