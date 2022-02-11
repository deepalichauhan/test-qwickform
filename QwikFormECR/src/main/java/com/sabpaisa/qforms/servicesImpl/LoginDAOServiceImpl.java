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

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.dao.LoginDAO;
import com.sabpaisa.qforms.services.LoginDAOService;

@Service
public class LoginDAOServiceImpl implements LoginDAOService {

	@Autowired
	LoginDAO loginDAO;
	
	@Override
	public String getDetailsOfSuperAdmin(SuperAdminBean superAdmin) {
		
		return loginDAO.getDetailsOfSuperAdmin(superAdmin);
	}

	@Override
	public List<CompanyBean> getcompanyList1() {
		return loginDAO.getcompanyList1();
	}

	@Override
	public CompanyBean getcompanyList(Integer id) {
		
		return loginDAO.getcompanyList(id);
	}

	@Override
	public SuperAdminBean getLogin(String UserId, String Password) {
		
		return loginDAO.getLogin(UserId, Password);
	}

	@Override
	public void EditSupeAdminDetails(SuperAdminBean superAdmin) {
		
		loginDAO.EditSupeAdminDetails(superAdmin);
	}

	@Override
	public SuperAdminBean saveUser(SuperAdminBean superAdmin) {
		
		return loginDAO.saveUser(superAdmin);
	}

	@Override
	public SuperAdminBean getSuperAdminDetailsBasedOnId(String id) {
		
		return loginDAO.getSuperAdminDetailsBasedOnId(id);
	}

	@Override
	public String getLoginDetails(LoginBean loginBean) {
		
		return loginDAO.getLoginDetails(loginBean);
	}

	@Override
	public List<SuperAdminBean> getAllSuperAdminDetails(String comId) {
		
		return loginDAO.getAllSuperAdminDetails(comId);
	}

	@Override
	public OperatorBean getDetailsOfCollegeOperator(String operatorUserName) {
		
		return loginDAO.getDetailsOfCollegeOperator(operatorUserName);
	}

	@Override
	public LoginBean getLoginUserDetail(String id, String profile) {
		
		return loginDAO.getLoginUserDetail(id, profile);
	}

	@Override
	public CollegeBean getInstDetail(Integer instId) {
		
		return loginDAO.getInstDetail(instId);
	}

	@Override
	public OperatorBean getOperatorDetail(Integer operatorId) {
		
		return loginDAO.getOperatorDetail(operatorId);
	}

	@Override
	public void updateChangePwdDetails(LoginBean creds, String newPwd) throws InvalidKeyException,
			NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException,
			UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
		
		loginDAO.updateChangePwdDetails(creds, newPwd);
	}

	@Override
	public Object getIdOFLoginUser(String profile, LoginBean bean) {
		
		return loginDAO.getIdOFLoginUser(profile, bean);
	}

	@Override
	public String getDetailsOfLoginUser(LoginBean loginBean) {
		
		return loginDAO.getDetailsOfLoginUser(loginBean);
	}

	@Override
	public boolean checkUsername(String username) {
		
		return loginDAO.checkUsername(username);
	}

	@Override
	public LoginBean saveCreds(LoginBean saveData) {
		
		return loginDAO.saveCreds(saveData);
	}

}
