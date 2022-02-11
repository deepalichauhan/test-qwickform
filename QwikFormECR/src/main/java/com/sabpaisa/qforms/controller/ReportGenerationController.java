package com.sabpaisa.qforms.controller;

import java.io.Serializable;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FetchTransactionDetails;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.ApplicantService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.util.CommonsUtil;

@CrossOrigin
@Controller
@RequestMapping
public class ReportGenerationController implements Serializable {

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	@Autowired
	CollegeService collegeService;

	@Autowired
	private ApplicantService applicantService;

	@Autowired
	private SampleTransService sampleTransService;

	@Autowired
	private SampleFormService sampleFormService;

	private static final long serialVersionUID = 1L;
	private static Logger log = LogManager.getLogger(ReportGenerationController.class.getName());
	private static final ObjectMapper mapper = new ObjectMapper();

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String formLinkImgFloderPath = properties.getProperty("qFormsLandingPageFloderPath");
	String cCodeForApproval = properties.getProperty("cCodeForApproval");
	String cIdForApproval = properties.getProperty("cIdForApproval");
	String userDetailApproved = properties.getProperty("userDetailApproved");
	String useableFormId = properties.getProperty("useableFormId");

	private ArrayList<String> fileterdRecordsHeaders = new ArrayList<String>();
	private ArrayList<String> fileterdRecordsVal = new ArrayList<String>();
	ArrayList<ArrayList<String>> aplDetails;
	Set<String> headerSet = new LinkedHashSet<String>();

	String reqFormId;

	private List<BeanFormDetails> listOfFormsForReport = new ArrayList<BeanFormDetails>();
	ArrayList<Integer> excelFieldList = new ArrayList<Integer>();
	ArrayList<Integer> fieldIds = new ArrayList<Integer>();
	private LoginBean loginUser = new LoginBean();

	@RequestMapping(value = "/getFormsBasedOnClientReport", method = { RequestMethod.POST, RequestMethod.GET })
	public String getAllTransactionsReport(ModelMap model, HttpServletRequest request, HttpSession ses) {
		if (null != ses.getAttribute("forms") || null != ses.getAttribute("fileterdRecordsHeaders")
				|| null != ses.getAttribute("fullDataWithAl")) {
			ses.removeAttribute("forms");
			ses.removeAttribute("fileterdRecordsHeaders");
			ses.removeAttribute("fullDataWithAl");
		}
		String forDownload = request.getParameter("ForDownLoad");
		String serviceId = request.getParameter("serviceId");
		String flag = request.getParameter("flag");
//		String approve = request.getParameter("flag");
		if (flag == null) {
			flag = (String) model.get("flag");
		}
		String returnVal = "";
		log.info("service id on getAllTransactionsReport " + serviceId);
		Integer cid = (Integer) ses.getAttribute("CollegeId");
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");

		if (null != loginUser) {
			listOfFormsForReport = new ArrayList<BeanFormDetails>(
					daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));

			for (BeanFormDetails bean : listOfFormsForReport) {
				log.info(("testing the form Name:" + bean.getFormName()));
			}
			log.info(("testing the size:" + listOfFormsForReport.size()));
			ses.setAttribute("forms", listOfFormsForReport);
			if (loginUser.getProfile().contentEquals("Operator")) {
				return "Applicant-Operator-Reports";
			}
//			if (null != flag || null != flag) {
//				if (flag.equalsIgnoreCase("pending")) {
//					return "PendingFormList";
//				} else if (flag.equalsIgnoreCase("approve")) {
//					return "ApprovedFormList";
//				}
//			}
			return "Reports";
		} else {
			return "SessionTerminated";
		}

	}

	@RequestMapping(value = "/ApplicantReportsForAllClients", method = { RequestMethod.POST, RequestMethod.GET })
	public String getAllApplicantClientsReports(ModelMap model, HttpServletRequest request,
			HttpServletResponse response, HttpSession ses) throws ParseException {
		String returnVal = "";
		fileterdRecordsHeaders = new ArrayList<String>();
		fileterdRecordsVal = new ArrayList<String>();
		try {
			returnVal = getAllTransactionsReport(model, request, ses);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (returnVal == "Reports") {
			log.info("I am in filter ");
			List<ArrayList<String>> fullDataWithAl = new ArrayList<ArrayList<String>>();
//			String forDownLoad = request.getParameter("ForDownLoad");
//			Object checkval = null;
//			boolean sequenceCount = false;
			String formId = request.getParameter("formId");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String payMode = request.getParameter("payMode");
			String transStatus = request.getParameter("transStatus");
			request.setAttribute("reqFormId", formId);
			request.setAttribute("reqFromDate", fromDate);
			request.setAttribute("reqToDate", toDate);
			request.setAttribute("reqpayMode", payMode);
			request.setAttribute("reqtransStatus", transStatus);
			log.info(("Choosen Form iD is " + formId));
			// this.fullDataWithAl=null;
			fileterdRecordsHeaders = sampleTransService.getTableHeaderNames(formId);
			fileterdRecordsVal = sampleTransService.filterTheRecordBasedOnFormName(formId, fromDate, toDate, payMode,
					transStatus);
			// log.info("fileterdRecordsHeaders: " + fileterdRecordsHeaders.toString());
			log.info("val: " + fileterdRecordsVal.size());
			Iterator<String> iterator = fileterdRecordsVal.iterator();
			while (iterator.hasNext()) {
				String[] alVal;
				String arrayList = iterator.next();
				ArrayList<String> commSpVal = new ArrayList<String>();
				// log.info("data al val:" + arrayList);
				arrayList = arrayList.substring(1, arrayList.length() - 1);
				String[] arrstring = alVal = arrayList.split(",");
				int n = arrstring.length;
				int n2 = 0;
				while (n2 < n) {
					String string = arrstring[n2];
					commSpVal.add(string);
					// log.info("Single val:" + string);
					++n2;
				}
				fullDataWithAl.add(commSpVal);
			}
			ses.setAttribute("fileterdRecordsHeaders", fileterdRecordsHeaders);
			ses.setAttribute("fullDataWithAl", fullDataWithAl);

			// log.info("final full:" + fullDataWithAl);
			returnVal = "Reports";
		} else if (returnVal == "SessionTerminated") {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}

	@RequestMapping(value = "/getFormsBasedOnClientForChallanMIS", method = RequestMethod.GET)
	public String getFormsBasedOnClientForChallanMIS(Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession ses) {

		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		log.info("testing user name:" + loginUser.getUserName());
		listOfFormsForReport = new ArrayList<BeanFormDetails>(
				daoFieldLookupService.getAllApprovedFormDetailsBasedOnClientForChallanMIS(loginUser));
		log.info(("testing the size:" + listOfFormsForReport.size()));
		if (loginUser.getProfile().contentEquals("Operator")) {
			return "Applicant-Operator-Reports";
		}
		ses.setAttribute("forms", listOfFormsForReport);

		return "Applicant-MIS-ReportsForAllClients";
	}

	@RequestMapping(value = "/ApplicantReportsAllClientsForChallanMIS", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String viewAllApplicantAllClientsForChallanMIS(HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");
		String checkval = null;
		int sequenceCount = 0;
		ApplicantActionController appController = new ApplicantActionController();
		String feeType = request.getParameter("feeType");
		request.setAttribute("feeType", feeType);
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		String result = "";
		try {
			BeanFormDetails form = daoFieldLookupService.getFormDetails(Integer.parseInt(feeType));
			log.info(form.getId() + ": form id Is");
			log.info(form.getFormFee().getFeeLookup().getFeeName() + ": fee name");
			listOfFormsForReport = new ArrayList<BeanFormDetails>(
					daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));

			List<String> successTransDetailsIds = new ArrayList<String>();
			log.info("college Id:" + loginUser.getCollgBean().getCollegeId() + ": Fee Name="
					+ form.getFormFee().getFeeLookup().getFeeName());
			List<SampleTransBean> successTransDetails = sampleTransService.getTransactionDetailsForChallanMIS(
					loginUser.getCollgBean().getCollegeId(), form.getFormFee().getFeeLookup().getFeeName());
			log.info(successTransDetails.size() + " :the sduccess transation details");
			SampleTransBean stransBean = null;
			for (SampleTransBean sampleTransBean : successTransDetails) {
				successTransDetailsIds.add(sampleTransBean.getTransId());
			}
			List<SampleFormBean> tempApplicantDetailsAll = applicantService
					.getSuccessTransAplicantDetailsOfParticularClient(feeType, "transIds", successTransDetailsIds);

			List<String> tempApplicantDetails = new ArrayList<String>();
			String formDataTrans = null;
			for (SampleFormBean sform : tempApplicantDetailsAll) {

				stransBean = sampleTransService.getTransactions(sform.getFormTransId());

				formDataTrans = "1`Category Name=" + stransBean.getFeeName() + "," + "1`Payment Mode="
						+ stransBean.getTransPaymode() + "," + "2`SabPaisaTxnId=" + stransBean.getSpTransId() + ","
						+ "3`Transaction Date=" + stransBean.getTransDate() + "," + "4`Amount="
						+ stransBean.getTransAmount() + "," + "5`Status=" + stransBean.getTransStatus() + ","
						+ "6`Receipt Number=" + stransBean.getTransId() + "," + sform.getFormData();
				// log.info("String values:" + formDataTrans);
				tempApplicantDetails.add(formDataTrans);

			}

			// log.info("tempApplicantDetails:---:" + tempApplicantDetails);
			headerSet = appController.getHeader(tempApplicantDetails.get(0));
			log.info(headerSet.size() + ":header counter is");
			aplDetails = appController.getValueOfApplicant(tempApplicantDetails);
			ArrayList<Integer> sizeOfHeaders = new ArrayList<Integer>();
			for (int k = 0; k <= headerSet.size(); k++) {
				sizeOfHeaders.add(k);
			}

			ArrayList<ArrayList<String>> aplDetailsrmspl = new ArrayList<ArrayList<String>>();

			ArrayList<String> dataAplDetails = null;
			String str1 = null;
			ArrayList<String> dataAplDetails1 = new ArrayList<String>();
			int i = 0;

			for (ArrayList<String> formData : aplDetails) {
				dataAplDetails = new ArrayList<String>();

				for (String formDataStr : formData) {
					try {
						log.info(formDataStr + ":-----:actual data");

						if (formDataStr.contains("$")) {

							checkval = formDataStr.substring(formDataStr.length() - 1);
							sequenceCount = Integer.parseInt(checkval);

							formDataStr = formDataStr.substring(0, formDataStr.indexOf('$'));

						}

						if (formDataStr.contains("*")) {
							formDataStr = formDataStr.substring(formDataStr.lastIndexOf('*') + 1);

						}

						dataAplDetails.add(formDataStr);

						dataAplDetails1 = dataAplDetails;
						log.info(dataAplDetails1 + " finding the roots");

					} catch (java.lang.StringIndexOutOfBoundsException ex) {
						log.info(" catching the exception-:-" + ex);
					}
					i++;
				}
				aplDetailsrmspl.add(dataAplDetails);

				// log.info(aplDetailsrmspl + ":testing value");
			}
			aplDetails = aplDetailsrmspl;

			result = forDownLoad != null && forDownLoad.contentEquals("True") ? "ForDown" : "success";
		} catch (Exception ex) {
			ex.printStackTrace();
			return "Applicant-MIS-ReportsForAllClients";
		}

		return result;

	}

	@RequestMapping(value = "/searchBasedOnCriteria", method = { RequestMethod.POST, RequestMethod.GET })
	public String searchBasedOnCriteriaAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws ParseException {
		log.info("Start searchBasedOnCriteriaAction() method in Sampletransactioncontroller.");
		BeanFormDetails form = new BeanFormDetails();
		List<SampleTransBean> transData = new ArrayList<SampleTransBean>();
		block4: {
			String formId = request.getParameter("formId");
			String toDate = request.getParameter("toDate");
			String payMode = request.getParameter("payMode");
			String fromDate = request.getParameter("fromDate");
			log.info("Going to find Formdetails, formId >> {" + formId + "}, fromDate >> {" + fromDate.toString()
					+ "}, toDate >> {" + toDate.toString() + "}, payMode {" + payMode + "}");

			form = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));

			log.info("beanformdetails is ::::::::: " + form.toString() + " and form id is :::: "
					+ form.getId().toString());
			loginUser = (LoginBean) ses.getAttribute("loginUserBean");
			Integer cid = (Integer) ses.getAttribute("CollegeId");

			log.info(("College ID :: " + cid + " : form.getFormFee().getFeeLookup().getFeeName() :: "
					+ form.getFormFee().getFeeLookup().getFeeName() + " : request.getParameter(fromDate) :: "
					+ request.getParameter("fromDate") + " : request.getParameter(toDate) :: "
					+ request.getParameter("toDate") + " : request.getParameter(payMode) :: "
					+ request.getParameter("payMode")));
			try {
				transData = sampleTransService.getTransactionsDetails(formId, request.getParameter("fromDate"),
						request.getParameter("toDate"), request.getParameter("payMode"), cid);
				log.info(("transaction size:" + transData.size()));
				for (SampleTransBean dataBean : transData) {
					log.info(("Transation Id:" + dataBean.getTransId()));
				}
				if (!loginUser.getProfile().contentEquals("Operator"))
					break block4;
				return "operator-Reports";
			} catch (NullPointerException ex) {
				ex.printStackTrace();
				return "sessionFailurePage";
			}
		}
		ses.setAttribute("formName", form.getFormName());
		ses.setAttribute("transData", transData);
		listOfFormsForReport = new ArrayList<BeanFormDetails>(
				daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));
		return "admin-ReportsWithFilter";
	}

	@RequestMapping(value = "/fetchClientDetailsList", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String fetchClientDetailsForFindData() {

		log.info("Start fetchClientDetailsForFindData() Method");
		String responce = "";
		List<CollegeBean> listOfClients = new ArrayList<CollegeBean>();
		Map<Integer, String> mapForClientDetails = new HashMap<>();
		try {
			listOfClients = collegeService.getCollegeListOfBankForSabPaisa();

			for (CollegeBean cBean : listOfClients) {
				mapForClientDetails.put(cBean.getCollegeId(), cBean.getCollegeName());
			}

			responce = mapper.writeValueAsString(mapForClientDetails);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return responce;
	}

	@RequestMapping(value = "/fetcFormCategoryList", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String fetcFormCategoryList(@RequestParam(required = true) String clientId) {

		log.info("Start fetcFormCategoryList() Method");
		CollegeBean collegeBean = new CollegeBean();
		Map<Integer, String> mapForClientDetails = new HashMap<>();
		String responce = "";
		try {
			collegeBean = collegeService.viewInstDetail(Integer.parseInt(clientId));
			log.info("return back to LoginController and valule of collegeBean is ::::::::::: "
					+ collegeBean.toString());

			List<BeanFormDetails> beanFormDetailList = daoFieldLookupService
					.fetchAllFomsByClientCode(collegeBean.getCollegeCode());
			log.info("return back to LoginController and valule of beanFormDetailList is ::::::::::: "
					+ beanFormDetailList.size());

			for (BeanFormDetails form : beanFormDetailList) {
				mapForClientDetails.put(form.getId(), form.getFormName());
			}
			log.info("map of form is : " + mapForClientDetails);
			responce = mapper.writeValueAsString(mapForClientDetails);
		} catch (Exception e) {

			e.printStackTrace();
		}

		return responce;
	}

	@RequestMapping(value = "/fetchTxnDetailsAsGivenRequestedList", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String fetchTxnDetailsAsGivenRequestedList(@RequestParam(required = true) String formId) {

		log.info("Start of getFormDetailsList() method");
		String responce = "";
		BeanFormDetails formDetail = new BeanFormDetails();
		List<FetchTransactionDetails> txnDetailsList = new ArrayList<FetchTransactionDetails>();

		formDetail = daoFieldLookupService.getFormDetails(formId);
		log.info("Client Code is for this form :::: " + formDetail.getFormOwnerName());

		txnDetailsList = sampleTransService.fetchTxnDetailsAsGivenFormId(formId);
		try {
			responce = mapper.writeValueAsString(txnDetailsList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return responce;
	}

	@RequestMapping(value = "/ApplicantReportsForApprovalProcess", method = { RequestMethod.POST, RequestMethod.GET })
	public String getApplicantReportsForApprovalProcess(ModelMap model, HttpServletRequest request,
			HttpServletResponse response, HttpSession ses) throws ParseException {
		String returnVal = "";
		BeanFormDetails formDetail = new BeanFormDetails();
		BeanPayerType payerType = new BeanPayerType();
		CollegeBean cBean = new CollegeBean();
		fileterdRecordsHeaders = new ArrayList<String>();
		ArrayList<String> pendingRecordsHeaders = new ArrayList<String>();
		ArrayList<String> approvedRecordsHeaders = new ArrayList<String>();
		ArrayList<String> pendingRecordVal = new ArrayList<String>();
		ArrayList<String> approvedRecordVal = new ArrayList<String>();
		List<ArrayList<String>> pendingFullDataWithAl = new ArrayList<ArrayList<String>>();
		List<ArrayList<String>> approveFullDataWithAl = new ArrayList<ArrayList<String>>();

		String formId = useableFormId;
		String cid = cIdForApproval;
		request.setAttribute("reqFormId", formId);
		String flag = request.getParameter("flag");
		String approveFlag = request.getParameter("approveFlag");
		String disApproveFlag = request.getParameter("disApproveFlag");
		String uniqueKey = request.getParameter("uniqueKey");
		String courseFlag = request.getParameter("course");
		// log.info("I am in filter " + flag);
		formDetail = daoFieldLookupService.getFormDetails(Integer.parseInt(formId));
		payerType = daoFieldLookupService.getPayerLookupsBasedOnPayerId(formDetail.getPayer_type());
		cBean = collegeService.viewInstDetail(Integer.parseInt(cid));

		// use for second time update the approval value
		if (approveFlag != null) {
			if (approveFlag.equalsIgnoreCase("yes") && uniqueKey != null) {
//				log.info("Request for Approve ::::: formId=" + formId + " : cid=" + cid + " : uniqueKey=" + uniqueKey
//						+ " : flag=" + flag + " : approveFlag=" + approveFlag);
				String approvalKey = userDetailApproved;
				String msg = sampleTransService.updateClientTableWithApproveUserData(cBean.getCollegeCode(),
						payerType.getPayer_type(), formId, uniqueKey, approvalKey);
			}
		}

		// use for second time update the disapproval value
		if (disApproveFlag != null) {
			if (disApproveFlag.equalsIgnoreCase("yes") && uniqueKey != null) {
//				log.info("Request for DisApprove ::::: formId=" + formId + " : cid=" + cid + " : uniqueKey=" + uniqueKey
//						+ " : flag=" + flag + " : disApproveFlag=" + disApproveFlag);
				String approvalKey = "NA";
				String msg = sampleTransService.updateClientTableWithApproveUserData(cBean.getCollegeCode(),
						payerType.getPayer_type(), formId, uniqueKey, approvalKey);
			}
		}

		fileterdRecordsHeaders = sampleTransService.getTabHeaderNames(formId, cBean.getCollegeCode(),
				payerType.getPayer_type());
		log.info("fileterdRecordsHeaders: " + fileterdRecordsHeaders.toString());
		Iterator<String> itr = fileterdRecordsHeaders.iterator();
		while (itr.hasNext()) {
			String header = itr.next();
			if (header.equalsIgnoreCase("id") || header.equalsIgnoreCase("fileUploadDate")
					|| header.equalsIgnoreCase("Notification") || header.equalsIgnoreCase("form_Name")) {
				log.debug("not used");
			} else {
				pendingRecordsHeaders.add(header);
			}
			if (header.equalsIgnoreCase("id") || header.equalsIgnoreCase("fileUploadDate")
					|| header.equalsIgnoreCase("Notification") || header.equalsIgnoreCase("Amount_to_Pay")
					|| header.equalsIgnoreCase("form_Name")) {
				log.debug("not used");
			} else {
				approvedRecordsHeaders.add(header);
			}
		}

//		log.info("pendingRecordsHeaders: " + pendingRecordsHeaders.toString());
//		log.info("approvedRecordsHeaders: " + approvedRecordsHeaders.toString());
		if (flag.equalsIgnoreCase("pending")) {
			if (null != courseFlag) {
				pendingRecordVal = sampleTransService.fetchTeRecordBasedOnFormName(formId, cBean.getCollegeCode(),
						payerType.getPayer_type(), pendingRecordsHeaders, courseFlag);
			} else {
				pendingRecordVal = sampleTransService.fetchTeRecordBasedOnFormName(formId, cBean.getCollegeCode(),
						payerType.getPayer_type(), pendingRecordsHeaders, "pending");
			}
			Iterator<String> itrator = pendingRecordVal.iterator();
			while (itrator.hasNext()) {
				String[] alVal;
				String arrayList = itrator.next();
				ArrayList<String> commSpVal = new ArrayList<String>();
				// log.info("data al val:" + arrayList);
				arrayList = arrayList.substring(1, arrayList.length() - 1);
				String[] arrstring = alVal = arrayList.split(",");
				int n = arrstring.length;
				int n2 = 0;
				while (n2 < n) {
					String string = arrstring[n2];
					commSpVal.add(string);
					// log.info("Single val:" + string);
					++n2;
				}
				pendingFullDataWithAl.add(commSpVal);
			}
			model.put("pendingRecordsHeaders", pendingRecordsHeaders);
			model.put("pendingRecordVal", pendingFullDataWithAl);
		}
		if (flag.equalsIgnoreCase("approve")) {
			approvedRecordVal = sampleTransService.fetchTeRecordBasedOnFormName(formId, cBean.getCollegeCode(),
					payerType.getPayer_type(), approvedRecordsHeaders, "approve");
			Iterator<String> itertor = approvedRecordVal.iterator();
			while (itertor.hasNext()) {
				String[] alVal;
				String arrayList = itertor.next();
				ArrayList<String> commSpVal = new ArrayList<String>();
				// log.info("data al val:" + arrayList);
				arrayList = arrayList.substring(1, arrayList.length() - 1);
				String[] arrstring = alVal = arrayList.split(",");
				int n = arrstring.length;
				int n2 = 0;
				while (n2 < n) {
					String string = arrstring[n2];
					commSpVal.add(string);
					// log.info("Single val:" + string);
					++n2;
				}
				approveFullDataWithAl.add(commSpVal);
			}
			model.put("approvedRecordsHeaders", approvedRecordsHeaders);
			model.put("approvedRecordVal", approveFullDataWithAl);
		}

		model.put("currentFormId", formId);
		model.put("cCodeForApproval", cCodeForApproval);
		if (flag.equalsIgnoreCase("approve")) {
			returnVal = "PendingApprovedFormList";
		} else if (flag.equalsIgnoreCase("pending") && courseFlag.equalsIgnoreCase("Others")) {
			returnVal = "PendingOthersFormListForGGU";
		} else if (flag.equalsIgnoreCase("pending") && courseFlag.equalsIgnoreCase("BA_BCOM")) {
			returnVal = "PendingBABComFormListForGGU";
		} else if (flag.equalsIgnoreCase("pending") && courseFlag.equalsIgnoreCase("BPharma_Bed")) {
			returnVal = "PendingBphBEDFormListForGGU";
		} else if (flag.equalsIgnoreCase("pending") && courseFlag.equalsIgnoreCase("BSC")) {
			returnVal = "PendingBSCFormListForGGU";
		} else if (flag.equalsIgnoreCase("pending") && courseFlag.equalsIgnoreCase("MSC_MA")) {
			returnVal = "PendingMSCFormListForGGU";
		} else {
			returnVal = "PendingMSCFormListForGGU";
		}
		return returnVal;
	}

	@RequestMapping(value = "/clickForVerification", method = { RequestMethod.POST, RequestMethod.GET })
	public String clickForVerification(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		String returnVal = "";
		BeanFormDetails formDetail = new BeanFormDetails();
		BeanPayerType payerType = new BeanPayerType();
		CollegeBean cBean = new CollegeBean();
		CommonsUtil cu = new CommonsUtil();
		String formId = request.getParameter("formId");
		String cid = request.getParameter("cid");
		String uniqueKey = request.getParameter("uniqueKey");
		log.info("formId=" + formId + " : cid=" + cid + " : uniqueKey=" + uniqueKey);
		String approvalKey = userDetailApproved;

		try {
			formDetail = daoFieldLookupService.getFormDetails(Integer.parseInt(formId));
			payerType = daoFieldLookupService.getPayerLookupsBasedOnPayerId(formDetail.getPayer_type());
			cBean = collegeService.viewInstDetail(Integer.parseInt(cid));
			String msg = sampleTransService.updateClientTableWithApproveUserData(cBean.getCollegeCode(),
					payerType.getPayer_type(), formId, uniqueKey, approvalKey);

			if (msg.equalsIgnoreCase("true")) {
				model.put("msgData", "Record Update Successfully");
				request.setAttribute("msgData", "Record Uploaded Successfully");
			} else {
				model.put("msgData", "Record not updated.");
				request.setAttribute("msgData", "Record not updated");
			}

			returnVal = "Success";
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return returnVal;
	}

}
