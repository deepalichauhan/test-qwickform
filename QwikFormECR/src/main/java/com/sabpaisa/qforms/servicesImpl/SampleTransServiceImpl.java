package com.sabpaisa.qforms.servicesImpl;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.FetchTransactionDetails;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.dao.SampleTransDao;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.util.ApplicationStatus;

@Service
public class SampleTransServiceImpl implements SampleTransService {

	@Autowired
	SampleTransDao sampleTransDao;

	@Autowired
	SessionFactory factory;

	@Override
	public FetchTransactionDetails fetchTxnDetailsByTxnId(String txnId) {
		SampleTransBean sampleTransBean = new SampleTransBean();
		FetchTransactionDetails txnDetail = null;
		try {
			sampleTransBean = sampleTransDao.getTransactionsBySabPaisaTxnId(txnId);
			if (null != sampleTransBean.getTransId()) {
				log.info("Transaction details is fetched properly.");
				txnDetail = new FetchTransactionDetails(sampleTransBean.getSpTransId(), sampleTransBean.getTransId(),
						sampleTransBean.getChallanNo(), sampleTransBean.getTransAmount().toString(),
						sampleTransBean.getTransDate(), sampleTransBean.getTransDate(),
						sampleTransBean.getTransStatus(), sampleTransBean.getName(), "NA", sampleTransBean.getContact(),
						sampleTransBean.getEmail(), sampleTransBean.getCollegeBean().getCollegeName(),
						sampleTransBean.getTransPaymode(), "NA", "NA", "NA");
			} else {
				log.info("Transaction details is not found properly.");
				// throw new NullPointerException();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("FetchTransactionDetails is : " + txnDetail.toString());

		return txnDetail;
	}

	public List<FetchTransactionDetails> fetchTxnDetailsAsGivenFormId(String formId) {
		List<SampleTransBean> listOfTxn = new ArrayList<SampleTransBean>();
		List<FetchTransactionDetails> fetchTransactionDetailList = new ArrayList<FetchTransactionDetails>();
		FetchTransactionDetails txnDetail = null;

		listOfTxn = sampleTransDao.fetchTxnDetailsAsFormId(formId);
		for (SampleTransBean spt : listOfTxn) {
			if (null != listOfTxn) {
				log.info("Transaction details is fetched properly.");
				txnDetail = new FetchTransactionDetails(spt.getSpTransId(), spt.getTransId(), spt.getChallanNo(),
						spt.getTransAmount().toString(), spt.getTransDate(), spt.getTransDate(), spt.getTransStatus(),
						spt.getName(), "NA", spt.getContact(), spt.getEmail(), spt.getCollegeBean().getCollegeName(),
						spt.getTransPaymode(), "NA", "NA", "NA");
				fetchTransactionDetailList.add(txnDetail);
			} else {
				log.info("Transaction details is not found properly.");
				// throw new NullPointerException();
			}
		}

		return fetchTransactionDetailList;
	}

	private static Logger log = LogManager.getLogger(SampleTransServiceImpl.class.getName());

	@Override
	public SampleTransBean saveTransaction(SampleTransBean beanTransData) {

		return sampleTransDao.saveTransaction(beanTransData);
	}

	@Override
	public ArrayList<SampleTransBean> getTransactions() {

		return sampleTransDao.getTransactions();
	}

	@Override
	public SampleTransBean getTransactions(Integer transId) {

		return sampleTransDao.getTransactions(transId);
	}

	@Override
	public SampleTransBean getLastTransactions() {

		return sampleTransDao.getLastTransactions();
	}

	@Override
	public SampleTransBean getTransactions(String transId) {

		return sampleTransDao.getTransactions(transId);
	}

	@Override
	public String fetchTransactionDetail(String clientTxnId, String spTxnId, String challanNumber, String transDate,
			String transStatus, String totalAmount, String transPayMode) {

		log.info("received request in fetchTransactionDetail()");
		SampleTransBean transBean = null;
		Integer formId = null;
		String resCode = "";
		Date dateOfTransaction = null;
		Session session = factory.openSession();
		// DateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			dateOfTransaction = sdf.parse(transDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		if (transStatus.equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())) {
			resCode = "0000";
		} else if (transStatus.equalsIgnoreCase(ApplicationStatus.FAILED.toString())) {
			resCode = "0300";
		} else if (transStatus.equalsIgnoreCase(ApplicationStatus.ABORTED.toString())) {
			resCode = "0400";
		} else {
			resCode = "0100";
		}

		try {
			transBean = sampleTransDao.getTransactions(clientTxnId);

			if (null != transBean) {
				log.info("sampleTransBean is found and comming id : " + transBean.getId() + " and qf id is : "
						+ transBean.getTransId());
				formId = transBean.getFormId();

				if ((null != transBean.getSpTransId() || !transBean.getSpTransId().isEmpty())
						&& (!transBean.getSpTransId().equalsIgnoreCase(spTxnId)
								|| transBean.getSpTransId() != spTxnId)) {
					log.info("Old spTxnId is : {" + transBean.getSpTransId() + "}, and new spTxnId is : {" + spTxnId
							+ "}");
					transBean.setSpTransId(spTxnId);
					transBean.setTransAmount(Double.parseDouble(totalAmount));
					transBean.setTransDate(dateOfTransaction);
					transBean.setChallanNo(challanNumber);
					transBean.setTransStatus(transStatus);
					transBean.setSpRespCode(resCode);

					if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null != transPayMode) {
						transBean.setTransPaymode(transPayMode);
					} else {
						transBean.setTransPaymode("Challan");
					}
					try {
						transBean = sampleTransDao.updateChalanTransaction(transBean);
					} catch (Exception e) {
						e.printStackTrace();
					}
					try {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
						String currentDate = df.format(new Date(System.currentTimeMillis()));
						String updatedDate = df.format(dateOfTransaction);
						String payMode = "Challan";
						if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null != transPayMode) {
							payMode = transPayMode;
						}
						String challnNo = transBean.getChallanNo();

						if (challnNo == null || "".equals(challnNo)) {
							challnNo = "N/A";
						}

						log.info("Going to udate update zz_client_user_data_" + formId + ", table for qcId {"
								+ clientTxnId + "}");
						Transaction tx = session.beginTransaction();

						String tableName = "zz_client_user_data_" + formId;

						session.createSQLQuery("update " + tableName + " set transStatus='" + transBean.getTransStatus()
								+ "',transPaymode='" + payMode + "',transDate='" + updatedDate + "',transAmount='"
								+ transBean.getTransAmount() + "',challanNo='" + challnNo + "',spTransId='" + spTxnId
								+ "',pgTransId='" + spTxnId + "',modifiedDate='" + currentDate + "' where  transId='"
								+ clientTxnId + "'").executeUpdate();
						tx.commit();
						return ApplicationStatus.SUCCESS.toString();
					} catch (Exception e) {
						log.info("Exception Occoured while updating Record Not Updated into zz_client_user_data_"
								+ formId + " while returning from SabPaisa");

						e.printStackTrace();
						return HttpStatus.BAD_REQUEST.toString();
					}
				} else if (null == transBean.getSpTransId() || transBean.getSpTransId().isEmpty()) {
					log.info("Old spTxnId is : {NULL}, and new spTxnId is : {" + spTxnId + "}");
					transBean.setSpTransId(spTxnId);
					transBean.setTransAmount(Double.parseDouble(totalAmount));
					transBean.setTransDate(dateOfTransaction);
					transBean.setChallanNo(challanNumber);
					transBean.setTransStatus(transStatus);
					transBean.setSpRespCode(resCode);

					if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null != transPayMode) {
						transBean.setTransPaymode(transPayMode);
					} else {
						transBean.setTransPaymode("Challan");
					}

					try {
						transBean = sampleTransDao.updateChalanTransaction(transBean);
					} catch (Exception e) {
						e.printStackTrace();
					}

					try {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
						String currentDate = df.format(new Date(System.currentTimeMillis()));
						String updatedDate = df.format(dateOfTransaction);
						String payMode = "Challan";
						if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null != transPayMode) {
							payMode = transPayMode;
						}
						String challnNo = transBean.getChallanNo();

						if (challnNo == null || "".equals(challnNo) || challnNo.isEmpty()) {
							challnNo = "N/A";
						}

						log.info("Going to udate update zz_client_user_data_" + formId + ", table for qcId {"
								+ clientTxnId + "}");
						Transaction tx = session.beginTransaction();

						String tableName = "zz_client_user_data_" + formId;

						session.createSQLQuery("update " + tableName + " set transStatus='" + transBean.getTransStatus()
								+ "',transPaymode='" + payMode + "',transDate='" + updatedDate + "',transAmount='"
								+ transBean.getTransAmount() + "',challanNo='" + challnNo + "',spTransId='" + spTxnId
								+ "',pgTransId='" + spTxnId + "',modifiedDate='" + currentDate + "' where  transId='"
								+ clientTxnId + "'").executeUpdate();

						tx.commit();
						return ApplicationStatus.SUCCESS.toString();
					} catch (Exception e) {
						log.info("Exception Occoured while updating Record Not Updated into zz_client_user_data_"
								+ formId + " while returning from SabPaisa");
						e.printStackTrace();
						return HttpStatus.BAD_REQUEST.toString();
					}
				} else {
					log.info("sampleTransBean is not find in DB for the given QFID : " + clientTxnId);
					return HttpStatus.NO_CONTENT.toString();
				}
			} else {
				log.info("sampleTransBean is not find in DB for the given QFID : " + clientTxnId);
				return HttpStatus.NO_CONTENT.toString();
			}

		} catch (Exception e1) {
			e1.printStackTrace();
			return HttpStatus.NO_CONTENT.toString();
		}
	}

	@Override
	public SampleTransBean getTransactionsBySabPaisaTxnId(String transId) {

		return sampleTransDao.getTransactionsBySabPaisaTxnId(transId);
	}

	@Override
	public ArrayList<SampleTransBean> getTransactionsOfCollege(Integer collegeId) {

		return sampleTransDao.getTransactionsOfCollege(collegeId);
	}

	@Override
	public ArrayList<SampleTransBean> getTransactionsForCash(Integer collegeId) {

		return sampleTransDao.getTransactionsForCash(collegeId);
	}

	@Override
	public String getsabPaisaChallanNo(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {

		return sampleTransDao.getsabPaisaChallanNo(sabPaisaTxnId);
	}

	@Override
	public String updateSabPaisaChallan(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {

		return sampleTransDao.updateSabPaisaChallan(sabPaisaTxnId);
	}

	@Override
	public String updateSabPaisaTransactionDetail(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {

		return sampleTransDao.updateSabPaisaTransactionDetail(sabPaisaTxnId);
	}

	@Override
	public List<SampleTransBean> getTransactionsDetails(String feeName, String fromDate, String toDate, String payMode,
			Integer clientId) throws ParseException {

		return sampleTransDao.getTransactionsDetails(feeName, fromDate, toDate, payMode, clientId);
	}

	@Override
	public SampleTransBean getTransactionDetailsBasedOnTransactionId(String txnId) {

		return sampleTransDao.getTransactionDetailsBasedOnTransactionId(txnId);
	}

	@Override
	public List<SampleTransBean> getOldTransacionDetail(String transId, String birthDate, String contactNo,
			String fromDate, String toDate, String clientId) throws ParseException {

		return sampleTransDao.getOldTransacionDetail(transId, birthDate, contactNo, fromDate, toDate, clientId);
	}

	@Override
	public String getFormDetail(Integer id) {

		return sampleTransDao.getFormDetail(id);
	}

	@Override
	public SampleFormBean getFormDetailByUsingTransId(String id) {

		return sampleTransDao.getFormDetailByUsingTransId(id);
	}

	@Override
	public List<SampleTransBean> getSuccessTransactionDetails(Integer collegeId, String feeType) {

		return sampleTransDao.getSuccessTransactionDetails(collegeId, feeType);
	}

	@Override
	public List<SampleTransBean> getTransactionDetailsForChallanMIS(Integer collegeId, String feeType) {

		return sampleTransDao.getTransactionDetailsForChallanMIS(collegeId, feeType);
	}

	@Override
	public List<SampleTransBean> getSuccessTransactionDetailsBasedOnDates(Integer collegeId, String feeType,
			String fromDate, String toDate) throws ParseException {

		return sampleTransDao.getSuccessTransactionDetailsBasedOnDates(collegeId, feeType, fromDate, toDate);
	}

	@Override
	public ArrayList<String> filterTheRecordBasedOnFormName(String formId, String fromDate, String toDate,
			String paymentMode, String transStatus) throws ParseException {

		return sampleTransDao.filterTheRecordBasedOnFormName(formId, fromDate, toDate, paymentMode, transStatus);
	}

	@Override
	public ArrayList<String> fetchTheRecordBasedOnFormName(String formId, String cCode, String payer)
			throws ParseException {

		return sampleTransDao.fetchTheRecordBasedOnFormName(formId, cCode, payer);
	}

	@Override
	public ArrayList<String> fetchTeRecordBasedOnFormName(String formId, String cCode, String payer,
			ArrayList<String> listofrecord, String cousreFlag) throws ParseException {

		String stre = "";
		for (int i = 0; i < listofrecord.size(); i++) {
			stre = stre + listofrecord.get(i) + ",";
		}
		stre = stre.substring(0, stre.lastIndexOf(','));

		return sampleTransDao.fetchTeRecordBasedOnFormName(formId, cCode, payer, stre, cousreFlag);
	}

	@Override
	public ArrayList<String> filterTheRecordBasedOnFormNameForBURD(String formId) throws ParseException, SQLException {

		return sampleTransDao.filterTheRecordBasedOnFormNameForBURD(formId);
	}

	@Override
	public ArrayList<String> getTableHeaderNames(String formId) {

		return sampleTransDao.getTableHeaderNames(formId);
	}

	@Override
	public ArrayList<String> getTabHeaderNames(String formId, String cCode, String payer) {

		return sampleTransDao.getTabHeaderNames(formId, cCode, payer);
	}

	@Override
	public String transformHeaderName(String originalHeaderName) {

		return sampleTransDao.transformHeaderName(originalHeaderName);
	}

	@Override
	public void updateSpotChallanTransactionDao(String spTransId) {

		sampleTransDao.updateSpotChallanTransactionDao(spTransId);
	}

	@Override
	public List<SampleFormBean> getFormDetailByUsingTransIds(Integer clientId) {
		// TODO Auto-generated method stub
		return sampleTransDao.getFormDetailByUsingTransIds(clientId);
	}

	@Override
	public void updateApplicantTransDataToReportingDB(HttpSession ses, ArrayList<String> nameOfFields, String transId,
			double transAmount, BeanFormDetails beanDataForm) {
		sampleTransDao.updateApplicantTransDataToReportingDB(ses, nameOfFields, transId, transAmount, beanDataForm);

	}

	@Override
	public void updateApplicantReportForMB(String cid, String transId, Integer formid) {

		sampleTransDao.updateApplicantReportForMB(cid, transId, formid);

	}

	@Override
	public void insertApplicantTransDataToReportingDB(HttpSession ses, String transStatus,
			SampleFormBean beanCurrentForm, String transId, double transAmount) {
		sampleTransDao.insertApplicantTransDataToReportingDB(ses, transStatus, beanCurrentForm, transId, transAmount);

	}

	@Override
	public String findFilledSheetForBU(String fotmID) throws SQLException {

		return sampleTransDao.findFilledSheetForBU(fotmID);
	}

	@Override
	public void updateTransDataToReportingDB(HttpSession ses, String transStatus, SampleFormBean beanCurrentForm,
			String transId, double transAmount) {
		sampleTransDao.updateTransDataToReportingDB(ses, transStatus, beanCurrentForm, transId, transAmount);
	}

	@Override
	public List<Map<String, Object>> getClientSpecificDataFromClientTable(String formId, String txnQfId) {

		return sampleTransDao.getClientSpecificDataFromClientTable(formId, txnQfId);
	}

	@Override
	public SampleTransBean updateChalanTransaction(SampleTransBean beanTransData) {

		return sampleTransDao.updateChalanTransaction(beanTransData);
	}

	@Override
	public String updateClientTableWithApproveUserData(String cCode, String payerType, String formId, String uniqueKey,
			String approvalKey) {
		// TODO Auto-generated method stub
		return sampleTransDao.updateClientTableWithApproveUserData(cCode, payerType, formId, uniqueKey, approvalKey);
	}

	@Override
	public String getApprovalStatusForGGUClient(String fieldNames, Integer formTempId, String clientCode, String payer)
			throws SQLException {

		return sampleTransDao.getApprovalStatusForGGUClient(fieldNames, formTempId, clientCode, payer);
	}
}
