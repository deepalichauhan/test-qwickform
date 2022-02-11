package com.sabpaisa.qforms.services;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;

public interface LoginDAOService {
	public String getDetailsOfSuperAdmin(SuperAdminBean superAdmin);
	public List<CompanyBean> getcompanyList1();
	public CompanyBean getcompanyList(Integer id);
	public SuperAdminBean getLogin(String UserId, String Password);
	public void EditSupeAdminDetails(SuperAdminBean superAdmin);
	public SuperAdminBean saveUser(SuperAdminBean superAdmin);
	public SuperAdminBean getSuperAdminDetailsBasedOnId(String id);
	public String getLoginDetails(LoginBean loginBean);
	public List<SuperAdminBean> getAllSuperAdminDetails(String comId);
	public OperatorBean getDetailsOfCollegeOperator(String operatorUserName);
	public LoginBean getLoginUserDetail(String id, String profile);
	public CollegeBean getInstDetail(Integer instId);
	public OperatorBean getOperatorDetail(Integer operatorId);
	public void updateChangePwdDetails(LoginBean creds, String newPwd) throws InvalidKeyException, 
			NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException, 
			UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException;
	public Object getIdOFLoginUser(String profile, LoginBean bean);
	public String getDetailsOfLoginUser(LoginBean loginBean);
	public boolean checkUsername(String username);
	public LoginBean saveCreds(LoginBean saveData);
}
