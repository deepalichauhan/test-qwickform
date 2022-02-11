package com.sabpaisa.qforms.servicesImpl;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.dao.OperatorDao;
import com.sabpaisa.qforms.services.OperatorDaoService;

@Service
public class OperatorDaoServiceImpl implements OperatorDaoService{
	
	@Autowired
	OperatorDao operatorDao;
	
	@Override
	public String registerCollegeOperatorDao(OperatorBean operatorBean) {
		// TODO Auto-generated method stub
		return operatorDao.registerCollegeOperatorDao(operatorBean);
	}

	@Override
	public List<OperatorBean> getAllRecordsOfCollegeOperator(Integer cid) {
		// TODO Auto-generated method stub
		return operatorDao.getAllRecordsOfCollegeOperator(cid);
	}

	@Override
	public Integer getRowCount() {
		// TODO Auto-generated method stub
		return operatorDao.getRowCount();
	}

	@Override
	public OperatorBean validateTheForgetPwdDetails(String profile, String emailId) throws InvalidKeyException,
			NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException,
			UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
		// TODO Auto-generated method stub
		return operatorDao.validateTheForgetPwdDetails(profile, emailId);
	}

	@Override
	public Integer getCollegeIdOfOperator(Integer operatorId) {
		// TODO Auto-generated method stub
		return operatorDao.getCollegeIdOfOperator(operatorId);
	}

	@Override
	public void updatePersonalRecordOfCollegeOperatorDetail(OperatorBean operatorBean) {
		// TODO Auto-generated method stub
		operatorDao.updatePersonalRecordOfCollegeOperatorDetail(operatorBean);
	}

	@Override
	public OperatorBean getOperatorDetails(int id) {
		// TODO Auto-generated method stub
		return operatorDao.getOperatorDetails(id);
	}

	@Override
	public void deleteOperatorDetails(int parseInt) {
		// TODO Auto-generated method stub
		operatorDao.deleteOperatorDetails(parseInt);
	}

	@Override
	public OperatorBean viewOperatorDetail(int loginId) {
		// TODO Auto-generated method stub
		return operatorDao.viewOperatorDetail(loginId);
	}
	

}
