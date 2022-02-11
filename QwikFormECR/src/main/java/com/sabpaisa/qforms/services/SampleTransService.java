package com.sabpaisa.qforms.services;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.FetchTransactionDetails;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;

public interface SampleTransService {
	public SampleTransBean saveTransaction(SampleTransBean beanTransData);

	public SampleTransBean updateChalanTransaction(SampleTransBean beanTransData);

	public ArrayList<SampleTransBean> getTransactions();

	public List<SampleFormBean> getFormDetailByUsingTransIds(Integer clientId);

	public SampleTransBean getTransactions(Integer transId);

	public SampleTransBean getLastTransactions();

	public SampleTransBean getTransactions(String transId);

	public String fetchTransactionDetail(String clientTxnId, String spTxnId, String challanNumber, String transDate,
			String transStatus, String totalAmount, String transPayMode);

	public SampleTransBean getTransactionsBySabPaisaTxnId(String transId);

	public ArrayList<SampleTransBean> getTransactionsOfCollege(Integer collegeId);

	public ArrayList<SampleTransBean> getTransactionsForCash(Integer collegeId);

	public String getsabPaisaChallanNo(String sabPaisaTxnId) throws ClassNotFoundException, SQLException;

	public String updateSabPaisaChallan(String sabPaisaTxnId) throws ClassNotFoundException, SQLException;

	public String updateSabPaisaTransactionDetail(String sabPaisaTxnId) throws ClassNotFoundException, SQLException;

	public List<SampleTransBean> getTransactionsDetails(String feeName, String fromDate, String toDate, String payMode,
			Integer clientId) throws ParseException;

	public SampleTransBean getTransactionDetailsBasedOnTransactionId(String txnId);

	public List<SampleTransBean> getOldTransacionDetail(String transId, String birthDate, String contactNo,
			String fromDate, String toDate, String clientId) throws ParseException;

	public String getFormDetail(Integer id);

	public SampleFormBean getFormDetailByUsingTransId(String id);

	public List<SampleTransBean> getSuccessTransactionDetails(Integer collegeId, String feeType);

	public List<SampleTransBean> getTransactionDetailsForChallanMIS(Integer collegeId, String feeType);

	public List<SampleTransBean> getSuccessTransactionDetailsBasedOnDates(Integer collegeId, String feeType,
			String fromDate, String toDate) throws ParseException;

	public ArrayList<String> filterTheRecordBasedOnFormName(String formId, String fromDate, String toDate,
			String paymentMode, String transStatus) throws ParseException;

	public ArrayList<String> fetchTheRecordBasedOnFormName(String formId, String cCode, String payer)
			throws ParseException;

	public ArrayList<String> fetchTeRecordBasedOnFormName(String formId, String cCode, String payer,
			ArrayList<String> listofrecord, String cousreFlag) throws ParseException;

	public ArrayList<String> getTableHeaderNames(String formId);

	public ArrayList<String> getTabHeaderNames(String formId, String cCode, String payer);

	public String transformHeaderName(String originalHeaderName);

	public void updateSpotChallanTransactionDao(String spTransId);

	public void updateApplicantTransDataToReportingDB(HttpSession ses, ArrayList<String> nameOfFields, String transId,
			double transAmount, BeanFormDetails beanDataForm);

	public void insertApplicantTransDataToReportingDB(HttpSession ses, String transStatus,
			SampleFormBean beanCurrentForm, String transId, double transAmount);

	public String findFilledSheetForBU(String fotmID) throws SQLException;

	public ArrayList<String> filterTheRecordBasedOnFormNameForBURD(String formId) throws ParseException, SQLException;

	public void updateApplicantReportForMB(String cid, String transId, Integer formid);

	public void updateTransDataToReportingDB(HttpSession ses, String transStatus, SampleFormBean beanCurrentForm,
			String transId, double transAmount);

	public List<Map<String, Object>> getClientSpecificDataFromClientTable(String formId, String txnQfId);

	public FetchTransactionDetails fetchTxnDetailsByTxnId(String txnId);

	public List<FetchTransactionDetails> fetchTxnDetailsAsGivenFormId(String formId);

	public String updateClientTableWithApproveUserData(String cCode, String payerType, String formId, String uniqueKey,
			String approvalKey);

	public String getApprovalStatusForGGUClient(String fieldNames, Integer formTempId, String clientCode, String payer)
			throws SQLException;

}
