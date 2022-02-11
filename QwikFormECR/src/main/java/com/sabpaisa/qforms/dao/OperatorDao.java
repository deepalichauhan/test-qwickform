package com.sabpaisa.qforms.dao;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;

import com.sabpaisa.qforms.beans.OperatorBean;

public interface OperatorDao {

	public String registerCollegeOperatorDao(OperatorBean operatorBean);
	public List<OperatorBean> getAllRecordsOfCollegeOperator(Integer cid);
	public Integer getRowCount();
	
	public OperatorBean validateTheForgetPwdDetails(String profile, String emailId) throws InvalidKeyException,
	NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException,
	UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException;
	
	public Integer getCollegeIdOfOperator(Integer operatorId);
	public void updatePersonalRecordOfCollegeOperatorDetail(OperatorBean operatorBean);
	public OperatorBean getOperatorDetails(int id);
	public void deleteOperatorDetails(int parseInt);
	public OperatorBean viewOperatorDetail(int loginId);
	
	
}
