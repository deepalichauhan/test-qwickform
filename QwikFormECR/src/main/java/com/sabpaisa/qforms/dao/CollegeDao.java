package com.sabpaisa.qforms.dao;

import java.util.List;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.PayeerTargetMappingToClient;
import com.sabpaisa.qforms.beans.ServicesBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.beans.SubInstitute;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.beans.WhiteLableTempBean;




public interface CollegeDao {

	public CollegeBean saveClientDetails(CollegeBean collegeBean);
	public CollegeBean saveAndUpdateClientDetails(CollegeBean collegeBean);
	public CollegeBean getCollegeDetailsOnCode(String collegeCode);
	public List<CollegeBean> getCollegeDetailsBasedOnCode(String collegeCode);
	public CollegeBean getClientDetailsBasedOnId(int id);
	
	public List<CollegeBean> getAllClientDetails(SuperAdminBean sABean);
	public CollegeBean viewInstDetail(Integer collegeId);
	public String saveMappingCodeOfSabPaisaDetails(ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa);
	public List<SubInstitute> getSubInstituteList(String code, String cid);
	public SubInstitute getSubInstituteDetailsOfCollegeBasedOnID(Integer id);
	public CollegeBean validateCollegeAndBank(Integer cid, Integer bid);
	public CollegeBean viewCollegeDetail(int loginId);
	public List<BeanFormDetails> getBeanFormDetailsOfParticularClient(Integer collegeId, String collegeName);
	public List<BeanFormDetails> getBeanFormDetailsOfParticularClientForLC(Integer collegeId, String collegeName);
	public CollegeBean getInstDetailUsingCidAndBid(String bidString, String cidString);
	public List<BeanPayerType> getBeanPayerListDetails(CollegeBean collegeBean);
	
	public Boolean saveSabPaisaClientMappingDetailsDao(CollegeBean collegeBean, ClientMappingCodeOfSabPaisa clientMappingBean);
	
	public List<ClientMappingCodeOfSabPaisa> getSabPaisaClientDetailsDAO(String id);
	public void updateClientlogoDetails(CollegeBean collegeBean);
	public List<SuperAdminBean> getcompantList();
	public List<ServicesBean> getServicesList();
	public List<StateBean> getStateList();
	public List<BankDetailsBean> getBankDetails(SuperAdminBean sABean);
	
	public ClientMappingCodeOfSabPaisa viewSabPaisaClientDetailsDAO(String id);
	public String EditBankDetails(BankDetailsBean bankDetailsBean);
	public List<CollegeBean> getCollegeListOfBank();
	public List<BankDetailsBean> getAllBankDetails(SuperAdminBean saBean);
	public List<CollegeBean> getCollegeListOfBank(int bid);
	public List<CollegeBean> getCollegeListOfBankForSabPaisa();
	
	public List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId, Integer serviceId);
	public List<CollegeBean> getCollegeDetailsBasedOnStateIdForSabPaisa(Integer stateId);
	public SubInstitute getSubInstituteDetailsOfCollegeBasedOnCode(String code, String cid);
	public PayeerTargetMappingToClient getClientMappingDetails(String bid, String cid, String payeeProfile);
	public PayeerTargetMappingToClient getClientMappingDetailsBasedOnPayee(String sbClientCode, String payeeProfile);
	public ClientMappingCodeOfSabPaisa getClientMappingCode(String bid, String cid, String payeeProfile);
	public BankDetailsBean getBankDetailsBasedOnId(String bankId);
	public Integer getRowCount();
	public String saveBankDetailsDao(BankDetailsBean bankDetailsBean);
	public void saveAndUpdateClientlogoDetails(CollegeBean collegeBean);
	public ClientMappingCodeOfSabPaisa updateSabPaisaClientDetailsDAO(String cMId, String cMProfile,
			String cMCode, String cMClientUrl);
	public byte[] getImageInBytes(CollegeBean user);
	public void updateBanklogoDetails(BankDetailsBean bankDetailsBean);
	public StateBean getStateBean(Integer stateId);
	public void saveServicesBean(ServicesBean servicesBean);
	public CompanyBean getCompany(Integer id);
	public ServicesBean getServicesBean(Integer serviceId);
	public List<WhiteLableTempBean> getWhiteLableClientlist(Integer stateId, Integer bid, Integer serviceId);
	public  void updateClientMappingCodeOfSabPaisa(BeanPayerType beanPayerType, LoginBean loginUser);
	public CollegeBean viewCollegeDetail(String idForQC);
	
	
	
	
}
