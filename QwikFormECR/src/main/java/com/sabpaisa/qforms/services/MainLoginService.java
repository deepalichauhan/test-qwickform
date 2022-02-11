package com.sabpaisa.qforms.services;

import org.hibernate.HibernateException;

import com.sabpaisa.qforms.beans.SuperAdminBean;

public interface MainLoginService {

	public SuperAdminBean getLogin(SuperAdminBean sLogin);
	public SuperAdminBean getLogin(/*SuperAdminBean sLogin*/String UserId,String Password, int roleId) throws HibernateException;
	public SuperAdminBean getLoginforCob(String UserId, String Password) throws HibernateException;
	
	
	
	
	
	
	
	
	/*public List<CompanyBean> getcompanyList1();
	
	public CompanyBean getcompanyList(Integer id);		
	
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
	
	
	
	*/

	
	
}
