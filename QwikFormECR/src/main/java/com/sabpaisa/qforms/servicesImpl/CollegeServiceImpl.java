package com.sabpaisa.qforms.servicesImpl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.PayeerTargetMappingToClient;
import com.sabpaisa.qforms.beans.ServicesBean;
import com.sabpaisa.qforms.beans.SpConfigBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.beans.SubInstitute;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.beans.WhiteLableTempBean;
import com.sabpaisa.qforms.controller.CollegeDetailsController;
import com.sabpaisa.qforms.dao.CollegeDao;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.util.ApplicationStatus;

@Service
public class CollegeServiceImpl implements CollegeService {

	@Autowired
	private CollegeDao collegeDao;

	private static Logger log = LogManager.getLogger(CollegeServiceImpl.class.getName());

	@Override
	public List<CollegeBean> getAllClientDetails(SuperAdminBean sABean) {

		return collegeDao.getAllClientDetails(sABean);
	}

	@Override
	public CollegeBean viewInstDetail(Integer collegeId) {

		return collegeDao.viewInstDetail(collegeId);
	}

	@Override
	public String saveMappingCodeOfSabPaisaDetails(ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa) {

		return collegeDao.saveMappingCodeOfSabPaisaDetails(mappingCodeOfSabPaisa);
	}

	@Override
	public List<SubInstitute> getSubInstituteList(String code, String cid) {

		return collegeDao.getSubInstituteList(code, cid);
	}

	@Override
	public SubInstitute getSubInstituteDetailsOfCollegeBasedOnID(Integer id) {

		return collegeDao.getSubInstituteDetailsOfCollegeBasedOnID(id);
	}

	@Override
	public CollegeBean validateCollegeAndBank(Integer cid, Integer bid) {

		return collegeDao.validateCollegeAndBank(cid, bid);
	}

	@Override
	public CollegeBean viewCollegeDetail(int loginId) {

		return collegeDao.viewCollegeDetail(loginId);
	}

	@Override
	public List<BeanFormDetails> getBeanFormDetailsOfParticularClient(Integer collegeId, String collegeName) {

		return collegeDao.getBeanFormDetailsOfParticularClient(collegeId, collegeName);
	}

	@Override
	public List<BeanFormDetails> getBeanFormDetailsOfParticularClientForLC(Integer collegeId, String collegeName) {

		return collegeDao.getBeanFormDetailsOfParticularClientForLC(collegeId, collegeName);
	}

	@Override
	public CollegeBean getInstDetailUsingCidAndBid(String bidString, String cidString) {

		return collegeDao.getInstDetailUsingCidAndBid(bidString, cidString);
	}

	@Override
	public List<BeanPayerType> getBeanPayerListDetails(CollegeBean collegeBean) {

		return collegeDao.getBeanPayerListDetails(collegeBean);
	}

	@Override
	public CollegeBean getClientDetailsBasedOnId(int id) {

		return collegeDao.getClientDetailsBasedOnId(id);
	}

	@Override
	public Boolean saveSabPaisaClientMappingDetailsDao(CollegeBean collegeBean,
			ClientMappingCodeOfSabPaisa clientMappingBean) {

		return collegeDao.saveSabPaisaClientMappingDetailsDao(collegeBean, clientMappingBean);
	}

	@Override
	public CollegeBean saveClientDetails(CollegeBean collegeBean) {

		return collegeDao.saveClientDetails(collegeBean);
	}

	@Override
	public List<ClientMappingCodeOfSabPaisa> getSabPaisaClientDetailsDAO(String id) {

		return collegeDao.getSabPaisaClientDetailsDAO(id);
	}

	@Override
	public void updateClientlogoDetails(CollegeBean collegeBean) {

		collegeDao.updateClientlogoDetails(collegeBean);

	}

	@Override
	public List<SuperAdminBean> getcompantList() {

		return collegeDao.getcompantList();
	}

	@Override
	public List<ServicesBean> getServicesList() {

		return collegeDao.getServicesList();
	}

	@Override
	public List<StateBean> getStateList() {

		return collegeDao.getStateList();
	}

	@Override
	public List<BankDetailsBean> getBankDetails(SuperAdminBean sABean) {

		return collegeDao.getBankDetails(sABean);
	}

	@Override
	public String EditBankDetails(BankDetailsBean bankDetailsBean) {

		return collegeDao.EditBankDetails(bankDetailsBean);
	}

	@Override
	public List<CollegeBean> getCollegeListOfBank() {

		return collegeDao.getCollegeListOfBank();
	}

	@Override
	public List<BankDetailsBean> getAllBankDetails(SuperAdminBean saBean) {

		return collegeDao.getAllBankDetails(saBean);
	}

	@Override
	public List<CollegeBean> getCollegeListOfBank(int bid) {

		return collegeDao.getCollegeListOfBank(bid);
	}

	@Override
	public List<CollegeBean> getCollegeListOfBankForSabPaisa() {

		return collegeDao.getCollegeListOfBankForSabPaisa();
	}

	@Override
	public List<CollegeBean> getCollegeDetailsBasedOnCode(String collegeCode) {

		return collegeDao.getCollegeDetailsBasedOnCode(collegeCode);
	}

	@Override
	public List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId, Integer serviceId) {

		return collegeDao.getCollegeDetailsBasedOnStateId(stateId, bankId, serviceId);
	}

	@Override
	public List<CollegeBean> getCollegeDetailsBasedOnStateIdForSabPaisa(Integer stateId) {

		return collegeDao.getCollegeDetailsBasedOnStateIdForSabPaisa(stateId);
	}

	@Override
	public SubInstitute getSubInstituteDetailsOfCollegeBasedOnCode(String code, String cid) {

		return collegeDao.getSubInstituteDetailsOfCollegeBasedOnCode(code, cid);
	}

	@Override
	public PayeerTargetMappingToClient getClientMappingDetails(String bid, String cid, String payeeProfile) {

		return collegeDao.getClientMappingDetails(bid, cid, payeeProfile);
	}

	@Override
	public PayeerTargetMappingToClient getClientMappingDetailsBasedOnPayee(String sbClientCode, String payeeProfile) {

		return collegeDao.getClientMappingDetailsBasedOnPayee(sbClientCode, payeeProfile);
	}

	@Override
	public ClientMappingCodeOfSabPaisa getClientMappingCode(String bid, String cid, String payeeProfile) {

		return collegeDao.getClientMappingCode(bid, cid, payeeProfile);
	}

	@Override
	public BankDetailsBean getBankDetailsBasedOnId(String bankId) {

		return collegeDao.getBankDetailsBasedOnId(bankId);
	}

	@Override
	public Integer getRowCount() {

		return collegeDao.getRowCount();
	}

	@Override
	public String saveBankDetailsDao(BankDetailsBean bankDetailsBean) {

		return collegeDao.saveBankDetailsDao(bankDetailsBean);
	}

	@Override
	public void saveAndUpdateClientlogoDetails(CollegeBean collegeBean) {

		collegeDao.saveAndUpdateClientlogoDetails(collegeBean);
	}

	@Override
	public ClientMappingCodeOfSabPaisa updateSabPaisaClientDetailsDAO(String cMId, String cMProfile, String cMCode,
			String cMClientUrl) {

		return collegeDao.updateSabPaisaClientDetailsDAO(cMId, cMProfile, cMCode, cMClientUrl);
	}

	@Override
	public byte[] getImageInBytes(CollegeBean user) {

		return collegeDao.getImageInBytes(user);
	}

	@Override
	public void updateBanklogoDetails(BankDetailsBean bankDetailsBean) {

		collegeDao.updateBanklogoDetails(bankDetailsBean);
	}

	@Override
	public StateBean getStateBean(Integer stateId) {

		return collegeDao.getStateBean(stateId);
	}

	@Override
	public void saveServicesBean(ServicesBean servicesBean) {

		collegeDao.saveServicesBean(servicesBean);
	}

	@Override
	public CompanyBean getCompany(Integer id) {

		return collegeDao.getCompany(id);
	}

	@Override
	public ServicesBean getServicesBean(Integer serviceId) {

		return collegeDao.getServicesBean(serviceId);
	}

	@Override
	public List<WhiteLableTempBean> getWhiteLableClientlist(Integer stateId, Integer bid, Integer serviceId) {

		return collegeDao.getWhiteLableClientlist(stateId, bid, serviceId);
	}

	@Override
	public ClientMappingCodeOfSabPaisa viewSabPaisaClientDetailsDAO(String id) {

		return collegeDao.viewSabPaisaClientDetailsDAO(id);
	}

	@Override
	public void updateClientMappingCodeOfSabPaisa(BeanPayerType beanPayerType, LoginBean loginUser) {

		collegeDao.updateClientMappingCodeOfSabPaisa(beanPayerType, loginUser);
	}

	@Override
	public CollegeBean viewCollegeDetail(String idForFL) {

		return collegeDao.viewCollegeDetail(idForFL);
	}

	@Override
	public String updateClientConfigDetailWithSp(SpConfigBean spConBean) {
		log.info("Open updateClientConfigDetailWithSp() method " + spConBean.toString());
		CollegeBean cBean = new CollegeBean();
		String returnStatus=null;
		try {
			// cBean.setCollegeCode(spConBean.getClientCode());
			cBean = collegeDao.getCollegeDetailsOnCode(spConBean.getClientCode());

			if (null != cBean) {

				if ((null == cBean.getAuthKey() || cBean.getAuthKey().isEmpty())
						&& (null == cBean.getAuthIV() || cBean.getAuthIV().isEmpty())
						&& (null == cBean.getUserName() || cBean.getUserName().isEmpty())
						&& (null == cBean.getUserPassword() || cBean.getUserPassword().isEmpty())) {

					log.info("College Code in Controller is : 1 ===========> " + cBean.getCollegeCode()
							+ " : and College ID is 1 : " + cBean.getCollegeId());
					
					cBean.setAuthIV(spConBean.getSpAuthIV());
					cBean.setAuthKey(spConBean.getSpAuthKey());
					cBean.setUserName(spConBean.getSpUserName());
					cBean.setUserPassword(spConBean.getSpUserPassword());
					
					cBean = collegeDao.saveAndUpdateClientDetails(cBean);
										
					if (null != cBean.getAuthIV() && null != cBean.getAuthKey() 
							&& null!=cBean.getUserName() && null!=cBean.getUserPassword()) {
						
						log.info("----authKey---------- 1 " + cBean.getAuthKey() + "----authIV---------- 1 "
								+ cBean.getAuthIV());
						log.info("----UserName---------- 1 " + cBean.getUserName() + "----UserPassword---------- 1 "
								+ cBean.getUserPassword());	
						
						returnStatus = ApplicationStatus.Created.toString();
					
					}
					
				} else {
					log.info("College Code in Controller is : 0 ===========> " + cBean.getCollegeCode()
					+ " : and College ID is 0 : " + cBean.getCollegeId());

					
					
					returnStatus = ApplicationStatus.AlreadyCreated.toString();
				}
			} else {
				returnStatus = ApplicationStatus.NotCreated.toString();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStatus;
	}

	@Override
	public CollegeBean getCollegeDetailsOnCode(String collegeCode) {

		return collegeDao.getCollegeDetailsOnCode(collegeCode);
	}

	@Override
	public CollegeBean saveAndUpdateClientDetailsAs(CollegeBean collegeBean) {

		return collegeDao.saveAndUpdateClientDetails(collegeBean);
	}

}

