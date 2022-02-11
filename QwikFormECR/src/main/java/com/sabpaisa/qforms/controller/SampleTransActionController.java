package com.sabpaisa.qforms.controller;

import java.io.IOException;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Set;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FetchTransactionDetails;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.beans.PayeerTargetMappingToClient;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.communication.ElasticSendMailer;
import com.sabpaisa.qforms.communication.EmailSessionBean;
import com.sabpaisa.qforms.communication.SendSMSs;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFeeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.util.ApplicationStatus;
import com.sabpaisa.qforms.util.SendMail;
import com.sabpaisa.qforms.util.SendSMS;
import com.sabpaisa.requestprocessing.Encryptor;

@CrossOrigin
@Controller
@RequestMapping
public class SampleTransActionController implements Serializable {

	@Autowired
	SessionFactory factory;
	
//	@Autowired
//	ApiBotController apiCalling;

	@Autowired
	SampleFormAction sampleFormAction;
	
	@Autowired
	private CollegeService collegeService;
	
	@Autowired
	private SampleTransService sampleTransService;
	
	@Autowired
	private SampleFormService sampleFormService;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;
	
	@Autowired
	private DaoFeeService daoFeeService;

	private static final long serialVersionUID = 1L;
	private static Logger log = LogManager.getLogger(SampleTransActionController.class.getName());
	private static final ObjectMapper mapper = new ObjectMapper();

	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	private ArrayList<String> fileterdRecordsHeaders = new ArrayList<String>();
	private ArrayList<String> fileterdRecordsVal = new ArrayList<String>();
	private List<ArrayList<String>> fullDataWithAl = new ArrayList<ArrayList<String>>();
	private List<SampleFormBean> sampleFormBeanList = new ArrayList<SampleFormBean>();
	private List<SampleFormBean> sampleFormBeanLists = new ArrayList<SampleFormBean>();
	static ArrayList<String> columnNameArray = new ArrayList<String>();
	private CollegeBean collegeBean = new CollegeBean();
	private ArrayList<ArrayList<String>> aplDetails;
	private List<BeanFormDetails> beanFormDetailsList = new ArrayList<BeanFormDetails>();
	private PayeerTargetMappingToClient payeerTargetMappingToClient = new PayeerTargetMappingToClient();
	private SampleTransBean beanTransData;
	private String toDate, fromDate, birthDate, transId, contactNo, clientId;
	private List<SampleTransBean> payerHistory = new ArrayList<SampleTransBean>();
	private BeanFeeDetails fee = new BeanFeeDetails();
	private BeanFeeLookup feeLookup = new BeanFeeLookup();
	private LoginBean loginUser = new LoginBean();
	private List<BeanFeeLookup> feeLookupList = new ArrayList<BeanFeeLookup>();
	private List<SampleTransBean> transData = new ArrayList<SampleTransBean>();
	private SampleFormBean beanCurrentForm = new SampleFormBean();
	private ArrayList<String> nameOfFields = new ArrayList<String>();
	private AppPropertiesConfig appProperties = new AppPropertiesConfig();
	private Properties properties = appProperties.getPropValues();

	private String cCodeForNPCI = properties.getProperty("cCodeForNPCI");
	private String cIdForNPCI = properties.getProperty("cIdForNPCI");
	private String cCodeForMagicBricks = properties.getProperty("cCodeForMagicBricks");
	private String cIdForMagicBricks = properties.getProperty("cIdForMagicBricks");
	private String cCodeForTVS = properties.getProperty("cCodeForTVS");
	private String cIdForTVS = properties.getProperty("cIdForTVS");
	private String qcAuthKey = properties.getProperty("qcAuthKey");
	private String qcAuthIV = properties.getProperty("qcAuthIV");
	private String editSubscription = properties.getProperty("editSubscription");

	private SendMail mail = new SendMail();
	private Double transAmounts = null;

	// use for first time payment process when user fill the dynamic form
	@RequestMapping(value = "/processTrans", method = { RequestMethod.POST, RequestMethod.GET })
	public String prepareTransaction(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		block7: {
			String formid = request.getParameter("formid").toString();
			if (null != formid) {
				log.info("upcoming formid is : " + formid);
			}
			SampleFormBean formBeanSample = new SampleFormBean();
			BeanPayerType beanPayerType = new BeanPayerType();
			HashMap<Integer, String> mapForFormData = new HashMap<Integer, String>();
			formBeanSample = (SampleFormBean) ses.getAttribute("form");
			String validCheckSum = "";

			if (null != formBeanSample) {
				log.info("process for coming data by SampleFormBean is ====> "
						+ formBeanSample.getFormData().toString());
				mapForFormData = processFormData(formBeanSample.getFormData());
				validCheckSum = mandetoryFieldCheckSum(formid, mapForFormData);

				if (validCheckSum.equalsIgnoreCase("true")) {
					try {
						log.info(
								"prepare Transaction Submitting Transactions in SampleTransActionController............");
						Double transAmountBySfB;
						HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
						Date transDate = new Date();
						Integer cid = Integer.parseInt(request.getParameter("cid").toString());
						String bid = collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM().getBankId()
								.toString();
						CollegeBean college = collegeService.viewInstDetail((Integer) cid);
						BeanFormDetails beanDataForm = sampleFormService
								.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));

						String lifeCycle = beanDataForm.getLife_cycle();
						Integer sesBid = (Integer) ses.getAttribute("BankId");
						Integer sesCid = (Integer) ses.getAttribute("CollegeId");

						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(beanDataForm.getPayer_type());

						if (null == ses.getAttribute("BankId") && null == ses.getAttribute("CollegeId")) {
							sesBid = Integer.parseInt(bid);
							sesCid = cid;
						}
						log.info("bid " + sesBid + "cid " + sesCid);
						String PayeeProfile = (String) ses.getAttribute("PayeeProfile");
						// log.info("PayeeProfile " + PayeeProfile);

						Double transAmountsByStB = null;
						String payerId;
						String transId;
						transId = GenerateTransactionId();
						log.info("transId:" + transId);
						log.info("It is in if block and validated filed are null");

						transAmountBySfB = formBeanSample.getTransAmount();
						formDataMap = (HashMap<Integer, String>) ses.getAttribute("sesCurrentFormMap");

						log.info("trans amount is " + transAmountBySfB);

						Double transactionAmount = transAmountsByStB;
						SampleTransBean beanCurrentTrans = new SampleTransBean();
						beanCurrentTrans.setTransDate(transDate);
						beanCurrentTrans.setTransStatus(ApplicationStatus.pending.toString());
						beanCurrentTrans.setCollegeBean(college);
						beanCurrentTrans.setContact(formBeanSample.getContact());
						beanCurrentTrans.setName(formBeanSample.getName());
						beanCurrentTrans.setEmail(formBeanSample.getEmail());
//						beanCurrentTrans.setDob(formBeanSample.getDobDate());
						beanCurrentTrans.setCid(cid.toString());
						beanCurrentTrans.setBid(bid);
						beanCurrentTrans.setFormId(formBeanSample.getFormTemplateId());
						formBeanSample.setFormClientId(cid.toString());
						log.info((Object) ("cid:----------:" + formBeanSample.getFormClientId()));
						payerId = (String) ses.getAttribute("PayerID");
						log.info((Object) ("payerId:----:" + payerId));
						if (payerId == null) {
							beanCurrentTrans.setPayerID("payerId");
						} else {
							beanCurrentTrans.setPayerID(ses.getAttribute("PayerID").toString());
							ses.removeAttribute("PayerID");
						}
						log.info(String.valueOf(beanCurrentTrans.getPayerID()) + ":--------:PayerId");

						beanCurrentTrans.setTransId(transId);
						log.info((Object) ("amt in transaction class:" + transAmountBySfB));
						if (transAmountsByStB == null) {
							beanCurrentTrans.setTransAmount(transAmountBySfB);
							beanCurrentTrans.setTransOgAmount(transAmountBySfB);
							beanCurrentTrans.setActAmount(transAmountBySfB);
						} else {
							beanCurrentTrans.setTransAmount(transAmountsByStB);
							beanCurrentTrans.setTransOgAmount(transAmountsByStB);
							beanCurrentTrans.setActAmount(transAmountsByStB);
						}

						formBeanSample.setFormTransId(transId);
						beanCurrentTrans.setTransForm(formBeanSample);
						feeLookup = null;
						feeLookup = daoFeeService
								.getFeeDetails("feeid", (Object) beanCurrentTrans.getTransForm().getFormFeeId())
								.getFeeLookup();
						if (feeLookup == null) {
							beanCurrentTrans.setFeeName("fee Name");
						} else {
							beanCurrentTrans.setFeeName(feeLookup.getFeeName());
							log.info((Object) ("fee Name is " + feeLookup.getFeeName()));
						}
						beanCurrentTrans.setTransPaymode(beanCurrentTrans.getTransPaymode());

						beanCurrentTrans = sampleTransService.saveTransaction(beanCurrentTrans);
						ses.setAttribute("sesCurrentTransData", (Object) beanCurrentTrans);
						if ("error".equals(beanCurrentTrans.getTransCreationErrorFlag()))
							break block7;
						beanTransData = new SampleTransBean();
						beanTransData = beanCurrentTrans;
						ses.setAttribute("beanTransData", beanTransData);
						beanCurrentForm = formBeanSample;
						
//						beanCurrentForm = getSetAllUploadedFilesName(beanCurrentForm);
						
						String transStatus = ApplicationStatus.pending.toString();

						if (transAmountsByStB == null) {
							transAmounts = transAmountBySfB;
							new Thread(() -> {
								sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
										beanCurrentForm, transId, transAmounts);
							}).start();
						} else {
							new Thread(() -> {
								sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
										beanCurrentForm, transId, transactionAmount);
							}).start();
						}

						try {
							NotifyPayerOfFormLink(beanCurrentForm, transId, false, request, cid, Integer.parseInt(bid),
									beanPayerType.getPayer_type());
						} catch (Exception e) {
							e.printStackTrace();
						}

						ses.setAttribute("transId", transId);
						ses.setAttribute("transAmounts", transAmounts.toString());
						ses.setAttribute("cid", cid.toString());
						ses.setAttribute("bid", bid);
						ses.setAttribute("feeName", feeLookup.getFeeName());
						return "ForwardTransaction";
					} catch (NullPointerException ex) {
						ex.printStackTrace();
						return "sessionFailurePage";
					}
				} else {
					log.info(
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					request.setAttribute("errorMsg",
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					return "errorPage";
				}
			}
		}
		log.info((Object) "Error in Creating QC transaction..");
		return "sessionFailurePage";
	}

	// use for payment process when user will come with form reviewed link
	@RequestMapping(value = "/processTransWithReviewedLink", method = { RequestMethod.POST, RequestMethod.GET })
	public String processTransWithReviewedLink(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info("Strat of processTransWithReviewedLink() method");
		block7: {
			SampleFormBean formBeanSample = new SampleFormBean();
			String validCheckSum = "";
			HashMap<Integer, String> mapForFormData = new HashMap<Integer, String>();
			String formid = request.getParameter("formid").toString();
			String forminstanceid = request.getParameter("forminstanceid").toString();
			BeanPayerType beanPayerType = new BeanPayerType();
			if (null != formid && null != forminstanceid) {
				log.info("upcoming formid is : " + formid);
				log.info("upcoming forminstanceid is : " + forminstanceid);
			}
			try {
				formBeanSample = sampleFormService.getFormData(Integer.parseInt(forminstanceid));

				if (null != formBeanSample) {
					log.info("process for coming data by SampleFormBean is ====> "
							+ formBeanSample.getFormData().toString());
					mapForFormData = processFormData(formBeanSample.getFormData());
					validCheckSum = mandetoryFieldCheckSum(formid, mapForFormData);

					if (validCheckSum.equalsIgnoreCase("true")) {
						try {
							log.info(
									"prepare Transaction Submitting Transactions in SampleTransActionController............");

							Double transAmountBySfB;
							HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
							Date transDate = new Date();
							Integer cid = Integer.parseInt(request.getParameter("cid").toString());
							log.info("college id in process trans is :::::::::::: " + cid.toString());

							log.info("formid id in process trans is :::::::::::: " + formid.toString());
							String bid = collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM()
									.getBankId().toString();
							log.info("Bank id in process trans is :::::::::::: " + bid);

							CollegeBean college = collegeService.viewInstDetail((Integer) cid);
							log.info("college :----------:" + college + " cid " + cid);

							BeanFormDetails beanDataForm = sampleFormService
									.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));

							beanPayerType = daoFieldLookupService
									.getPayerLookupsBasedOnPayerId(beanDataForm.getPayer_type());
							String lifeCycle = beanDataForm.getLife_cycle();

							log.info("formTemplateId for DataFormDetails table lifecycle is :::: " + lifeCycle);

							Integer sesBid = (Integer) ses.getAttribute("BankId");
							log.info("bid " + sesBid);
							Integer sesCid = (Integer) ses.getAttribute("CollegeId");
							log.info("cid " + sesCid);
							if (null == ses.getAttribute("BankId") && null == ses.getAttribute("CollegeId")) {
								sesBid = Integer.parseInt(bid);
								sesCid = cid;
							}
							log.info("bid " + sesBid + " cid " + sesCid);
							String PayeeProfile = (String) ses.getAttribute("PayeeProfile");

							Double transAmountsByStB = null;
							String payerId;
							/*
							 * String transId;
							 * 
							 * transId = formBeanSample.getFormTransId(); if (null == transId ||
							 * transId.equals(null)) { log.info("transId:" + transId);
							 */
							String transId = GenerateTransactionId();
							/* } else { */
							log.info("transId:" + transId);
							/* } */
							// log.info("transId:" + transId);

							log.info("It is in if block and validated filed are null");

							transAmountBySfB = formBeanSample.getTransAmount();
							formDataMap = (HashMap<Integer, String>) ses.getAttribute("sesCurrentFormMap");
							if (null != formDataMap) {
								log.info("formDataMap:--------: " + formDataMap);
							}
							log.info("trans amount is " + transAmountBySfB);

							Double transactionAmount = transAmountsByStB;
							SampleTransBean beanCurrentTrans = new SampleTransBean();
							beanCurrentTrans.setTransDate(transDate);
							beanCurrentTrans.setTransStatus(ApplicationStatus.pending.toString());
							beanCurrentTrans.setCollegeBean(college);
							beanCurrentTrans.setContact(formBeanSample.getContact());
							beanCurrentTrans.setName(formBeanSample.getName());
							beanCurrentTrans.setEmail(formBeanSample.getEmail());
//							beanCurrentTrans.setDob(formBeanSample.getDobDate());
							beanCurrentTrans.setCid(cid.toString());
							beanCurrentTrans.setBid(bid);
							beanCurrentTrans.setFormId(formBeanSample.getFormTemplateId());
							formBeanSample.setFormClientId(cid.toString());
							log.info((Object) ("cid:----------:" + formBeanSample.getFormClientId()));
							payerId = (String) ses.getAttribute("PayerID");
							log.info((Object) ("payerId:----:" + payerId));
							if (payerId == null) {
								beanCurrentTrans.setPayerID("payerId");
							} else {
								beanCurrentTrans.setPayerID(ses.getAttribute("PayerID").toString());
								ses.removeAttribute("PayerID");
							}
							log.info(String.valueOf(beanCurrentTrans.getPayerID()) + ":--------:PayerId");

							beanCurrentTrans.setTransId(transId);
							log.info((Object) ("amt in transaction class:" + transAmountBySfB));
							if (transAmountsByStB == null) {
								beanCurrentTrans.setTransAmount(transAmountBySfB);
								beanCurrentTrans.setTransOgAmount(transAmountBySfB);
								beanCurrentTrans.setActAmount(transAmountBySfB);
							} else {
								beanCurrentTrans.setTransAmount(transAmountsByStB);
								beanCurrentTrans.setTransOgAmount(transAmountsByStB);
								beanCurrentTrans.setActAmount(transAmountsByStB);
							}

							formBeanSample.setFormTransId(transId);
							beanCurrentTrans.setTransForm(formBeanSample);
							feeLookup = null;
							feeLookup = daoFeeService
									.getFeeDetails("feeid", (Object) beanCurrentTrans.getTransForm().getFormFeeId())
									.getFeeLookup();
							if (feeLookup == null) {
								beanCurrentTrans.setFeeName("fee Name");
							} else {
								beanCurrentTrans.setFeeName(feeLookup.getFeeName());
								log.info((Object) ("fee Name is " + feeLookup.getFeeName()));
							}
							beanCurrentTrans.setTransPaymode(beanCurrentTrans.getTransPaymode());

							beanCurrentTrans = sampleTransService.saveTransaction(beanCurrentTrans);
							ses.setAttribute("sesCurrentTransData", (Object) beanCurrentTrans);
							if ("error".equals(beanCurrentTrans.getTransCreationErrorFlag()))
								break block7;
							beanTransData = new SampleTransBean();
							beanTransData = beanCurrentTrans;
							ses.setAttribute("beanTransData", beanTransData);
							beanCurrentForm = formBeanSample;
							
//							beanCurrentForm = getSetAllUploadedFilesName(beanCurrentForm);
							
							String transStatus = ApplicationStatus.pending.toString();

							if (transAmountsByStB == null) {
								transAmounts = transAmountBySfB;
								new Thread(() -> {
									log.info("beanCurrentForm.getFormTransId() : ======> "
											+ beanCurrentForm.getFormTransId());
									sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
											beanCurrentForm, beanCurrentForm.getFormTransId(), transAmounts);
								}).start();
							} else {
								new Thread(() -> {
									sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
											beanCurrentForm, beanCurrentForm.getFormTransId(), transactionAmount);
								}).start();
							}

							try {
								NotifyPayerOfFormLink(beanCurrentForm, transId, false, request, cid,
										Integer.parseInt(bid), beanPayerType.getPayer_type());
							} catch (Exception e) {
								e.printStackTrace();
							}
							model.addAttribute("currentFormId", formid);
							ses.setAttribute("transId", transId);
							ses.setAttribute("transAmounts", transAmounts.toString());
							ses.setAttribute("cid", cid.toString());
							ses.setAttribute("bid", bid);
							ses.setAttribute("feeName", feeLookup.getFeeName());

							return "ForwardTransaction";
						} catch (NullPointerException ex) {
							ex.printStackTrace();
							return "sessionFailurePage";
						}
					} else {
						log.info(
								"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
						request.setAttribute("errorMsg",
								"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
						return "errorPage";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		log.info((Object) "Error in Creating QC transaction..");
		return "sessionFailurePage";
	}

	// use for LP process payment collectiion
	@RequestMapping(value = "/processTransRevivalNew", method = { RequestMethod.POST, RequestMethod.GET })
	public String processTransRevivalNew(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.info("prepare Transaction Submitting Transactions in SampleTransActionController............");
		block7: {
			beanCurrentForm = new SampleFormBean();
			beanTransData = new SampleTransBean();
			feeLookup = new BeanFeeLookup();
			nameOfFields = new ArrayList<String>();
			HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
			HashMap<Integer, String> mapForFormData = new HashMap<Integer, String>();
			SampleFormBean sampleDataForm = new SampleFormBean();
			String validCheckSum = "";

			String forminstanceid = request.getParameter("forminstanceid");
			log.info("forminstanceid id in process trans is :::::::::::: " + forminstanceid.toString());
			String formid = request.getParameter("formid").toString();
			log.info("formid id in process trans is :::::::::::: " + formid.toString());
			sampleDataForm = sampleFormService.getFormData(Integer.parseInt(forminstanceid));

			if (null != sampleDataForm) {
				log.info("process for coming data by SampleFormBean is ====> "
						+ sampleDataForm.getFormData().toString());

				String valuesByDataForm = sampleDataForm.getFormData();

				mapForFormData = processFormData(sampleDataForm.getFormData());
				validCheckSum = mandetoryFieldCheckSum(formid, mapForFormData);

				if (validCheckSum.equalsIgnoreCase("true")) {
					try {

						Double transAmountFromFormBean;

						ArrayList<String> dataFormFieldAndValue = new ArrayList<String>();
						Integer idForm = Integer.parseInt(formid);
						log.info("formid of DataForm file in table :::::: " + idForm);
						ses.setAttribute("formId", idForm.toString());

						if (null != valuesByDataForm) {
							log.info("Before Indexing Values for submitting the data ::::::: "
									+ valuesByDataForm.toString());
							// int idx = valuesByDataForm.lastIndexOf(",");
							// valuesByDataForm = valuesByDataForm.substring(0, idx);
							log.info("After Indexing Values for submitting the data ::::::: "
									+ valuesByDataForm.toString());

							String[] formFields = valuesByDataForm.split(",");
							// log.info(("formFields is ::::::::::::::: " + formFields.toString()));
							ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));

							// log.info(("formFieldsList is ::::::::::::::: " + formFieldsList.toString()));
							log.info(("formFieldsList size is ::::::::::::::: " + formFieldsList.size()));
							int i = 0;
							while (i < formFieldsList.size()) {
								String[] formFieldData = formFieldsList.get(i).split("~");
								if (formFieldData.length != 2) {
									log.info(("Form Field at index " + i + " is corrupt or unreadable"));
								} else {
									fieldMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
								}
								++i;
							}
							// log.info("Before iteration values formDataMap >> " + fieldMap.toString());

							for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) {
								String[] b = temp.getValue().split("$");
								int k = b[0].indexOf('$');
								String proofresult = b[0].substring(0, k);
								dataFormFieldAndValue.add(proofresult);
							}
							log.info("Out of For Loop nameOfFields Field Value is" + dataFormFieldAndValue);
						}

						ArrayList<String> formFieldsList1 = new ArrayList<String>();
						int j = 0;
						while (j < dataFormFieldAndValue.size()) {
							String[] formFieldData = dataFormFieldAndValue.get(j).split("=");

							if (formFieldData.length != 2) {
								System.out.println(("Form Field at index " + j + " is corrupt or unreadable"));
							} else {
								String string2 = formFieldData[0];
								string2 = string2.replaceAll("\\s", "_");
								string2 = StringUtils.removeEnd(string2, "_");
								string2 = StringUtils.removeStart(string2, "_");
								int ind = formFieldData[1].indexOf("*");
								if (ind != 0) {
									formFieldData[1] = formFieldData[1].substring(ind + 1, formFieldData[1].length());
								}
								formFieldsList1.add(string2 + "='" + formFieldData[1] + "'");
							}
							++j;
						}
						nameOfFields = formFieldsList1;
						log.info("Out of For Loop formFieldsList Field Value is" + nameOfFields);

						HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
						Date transDate = new Date();
						Integer cid = Integer.parseInt(request.getParameter("cid").toString());
						log.info("college id in process trans is :::::::::::: " + cid.toString());

						String bid = collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM().getBankId()
								.toString();
						log.info("Bank id in process trans is :::::::::::: " + bid);

						CollegeBean college = collegeService.viewInstDetail((Integer) cid);
						log.info("college :----------:" + college + " cid " + cid);

						BeanPayerType beanPayerType = new BeanPayerType();
						BeanFormDetails beanDataForm = sampleFormService
								.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));
						log.info("Current formid is in BeanFormDetails :::::: " + beanDataForm.getId());
						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(beanDataForm.getPayer_type());
						String fieldForValidate = null;
						fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
						String lifeCycle = beanDataForm.getLife_cycle();

						log.info("fieldForValidate for DataFormDetails table fieldForValidate is :::: "
								+ fieldForValidate);
						log.info("formTemplateId for DataFormDetails table lifecycle is :::: " + lifeCycle);

						Integer sesBid = (Integer) ses.getAttribute("BankId");
						log.info("bid " + sesBid);
						Integer sesCid = (Integer) ses.getAttribute("CollegeId");
						log.info("cid " + sesCid);
						if (null == ses.getAttribute("BankId") && null == ses.getAttribute("CollegeId")) {
							sesBid = Integer.parseInt(bid);
							sesCid = cid;
						}
						log.info("bid " + sesBid + "cid " + sesCid);
						String PayeeProfile = (String) ses.getAttribute("PayeeProfile");
						log.info("PayeeProfile " + PayeeProfile);

						String payerId;
						String transId;

						transId = GenerateTransactionId();
						log.info((Object) ("transId:" + transId));

						transAmountFromFormBean = sampleDataForm.getTransAmount();
						log.info("trans amount is " + transAmountFromFormBean);

						formDataMap = (HashMap<Integer, String>) ses.getAttribute("sesCurrentFormMap");
						log.info("hashmap " + formDataMap.size());

						SampleTransBean beanCurrentTrans = new SampleTransBean();
						beanCurrentTrans.setTransDate(transDate);
						beanCurrentTrans.setTransStatus(ApplicationStatus.pending.toString());
						beanCurrentTrans.setCollegeBean(college);
						beanCurrentTrans.setContact(sampleDataForm.getContact());
						beanCurrentTrans.setName(sampleDataForm.getName());
						beanCurrentTrans.setEmail(sampleDataForm.getEmail());
//						beanCurrentTrans.setDob(sampleDataForm.getDobDate());
						beanCurrentTrans.setCid(cid.toString());
						beanCurrentTrans.setBid(bid);
						beanCurrentTrans.setFormId(sampleDataForm.getFormTemplateId());
						sampleDataForm.setFormClientId(cid.toString());
						log.info((Object) ("cid:----------:" + sampleDataForm.getFormClientId()));
						payerId = (String) ses.getAttribute("PayerID");
						log.info((Object) ("payerId:----:" + payerId));
						if (payerId == null) {
							beanCurrentTrans.setPayerID("payer Deatil");
						} else {
							beanCurrentTrans.setPayerID(ses.getAttribute("PayerID").toString());
							ses.removeAttribute("PayerID");
						}
						log.info(String.valueOf(beanCurrentTrans.getPayerID() + ":--------:PayerId"));

						beanCurrentTrans.setTransId(transId);
						log.info(("amt in transaction class:" + transAmountFromFormBean));

						beanCurrentTrans.setTransAmount(transAmountFromFormBean);
						beanCurrentTrans.setTransOgAmount(transAmountFromFormBean);
						beanCurrentTrans.setActAmount(transAmountFromFormBean);

						sampleDataForm.setFormTransId(transId);
						beanCurrentTrans.setTransForm(sampleDataForm);

						feeLookup = daoFeeService.getFeeDetails("feeid", beanCurrentTrans.getTransForm().getFormFeeId()).getFeeLookup();
						
						if (feeLookup == null) {
							beanCurrentTrans.setFeeName("Payment form");
						} else {
							beanCurrentTrans.setFeeName(feeLookup.getFeeName());
							log.info((Object) ("fee Name is " + feeLookup.getFeeName()));
						}
						
						beanCurrentTrans.setTransPaymode(beanCurrentTrans.getTransPaymode());

						try {
							beanCurrentTrans = sampleTransService.saveTransaction(beanCurrentTrans);
						} catch (Exception e) {
							e.printStackTrace();
						}
						ses.setAttribute("sesCurrentTransData", (Object)beanCurrentTrans);

						if ("error".equals(beanCurrentTrans.getTransCreationErrorFlag()))
							break block7;

						beanTransData = beanCurrentTrans;
						ses.setAttribute("beanTransData", beanTransData);
						beanCurrentForm = sampleDataForm;
						
//						beanCurrentForm = getSetAllUploadedFilesName(beanCurrentForm);
						
						String transStatus = ApplicationStatus.pending.toString();
						new Thread(() -> {
							log.info("Adding to reporting Database in async thread in else Block.. " + transId + " "
									+ transAmounts);
							log.info("name of fields for update in database is ::::: " + nameOfFields.toString());

							sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus, beanCurrentForm,
									transId, transAmountFromFormBean);
						}).start();

						try {
							NotifyPayerOfFormLink(beanCurrentForm, transId, false, request, cid, Integer.parseInt(bid),
									beanPayerType.getPayer_type());
						} catch (InvalidKeyException | NumberFormatException | NoSuchAlgorithmException
								| InvalidKeySpecException | InvalidAlgorithmParameterException
								| UnsupportedEncodingException | IllegalBlockSizeException | BadPaddingException e) {
							e.printStackTrace();
						}

						ses.setAttribute("transId", transId);
						ses.setAttribute("transAmounts", transAmountFromFormBean.toString());
						ses.setAttribute("cid", cid.toString());
						ses.setAttribute("bid", bid);
						ses.setAttribute("feeName", feeLookup.getFeeName());

						return "ForwardTransaction";
					} catch (NullPointerException ex) {
						ex.printStackTrace();
						return "sessionFailurePage";
					}
				} else {
					log.info(
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					request.setAttribute("errorMsg",
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					return "errorPage";
				}
			} else {
				log.info("Wrong Data is fetched and store.Please reinsert your form again with mandatory field.");
				request.setAttribute("errorMsg",
						"Wrong Data is fetched and store.Please reinsert your form again with mandatory field.");
				return "errorPage";
			}
		}
		log.info((Object) "Error in Creating QF transaction..");
		return "sessionFailurePage";
	}

	@RequestMapping(value = "/SaveViewForm", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveViewForm(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException,
			BadPaddingException, InterruptedException {

		block7: {
			SampleFormBean formBeanSample = new SampleFormBean();
			SampleTransBean transBean = new SampleTransBean();
			HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
			Double amountDformBean;
			String formid = request.getParameter("formid").toString();
			formBeanSample = (SampleFormBean) ses.getAttribute("form");
			String validCheckSum = "";
			String requestStr = "";

			if (null != formBeanSample) {
				log.info("process for coming data by SampleFormBean is ====> "
						+ formBeanSample.getFormData().toString());
				formDataMap = processFormData(formBeanSample.getFormData());
				validCheckSum = mandetoryFieldCheckSum(formid, formDataMap);

				if (validCheckSum.equalsIgnoreCase("true")) {
					try {
						log.info("SaveViewForm() method in SampleTransActionController............");
						String linkPass = "";
						if (null != ses.getAttribute("linkPass")) {
							linkPass = (String) ses.getAttribute("linkPass");
							log.info("linkPass for saveing in tem table is :::: " + linkPass);
							ses.setAttribute("linkPass", linkPass);
						}
						Integer cid = Integer.parseInt(request.getParameter("cid").toString());
						log.info("college id in process trans is :::::::::::: " + cid.toString());

						log.info("formid id in process trans is :::::::::::: " + formid.toString());
						String bid = collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM().getBankId()
								.toString();
						log.info("Bank id in process trans is :::::::::::: " + bid);

						CollegeBean college = collegeService.viewInstDetail((Integer) cid);
						log.info((Object) ("college :----------:" + (Object) college) + " cid " + cid);
						BeanPayerType beanPayerType = new BeanPayerType();
						BeanFormDetails beanDataForm = sampleFormService
								.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));

						String lifeCycle = beanDataForm.getLife_cycle();

						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(beanDataForm.getPayer_type());

						log.info("formTemplateId for DataFormDetails table lifecycle is :::: " + lifeCycle);

						Integer sesBid = (Integer) ses.getAttribute("BankId");
						log.info("bid " + sesBid);
						Integer sesCid = (Integer) ses.getAttribute("CollegeId");
						log.info("cid " + sesCid);
						if (null == ses.getAttribute("BankId") && null == ses.getAttribute("CollegeId")) {
							sesBid = Integer.parseInt(bid);
							sesCid = cid;
						}
						log.info("bid " + sesBid + "cid " + sesCid);
						String PayeeProfile = (String) ses.getAttribute("PayeeProfile");
						log.info("PayeeProfile " + PayeeProfile);

						Double transBeanAmount = null;
						String payerId;
						String transId;

						transId = this.GenerateTransactionId();
						log.info((Object) ("transId:" + transId));

						log.info("It is in if block and validated filed are null");

						amountDformBean = formBeanSample.getTransAmount();

						// log.info((Object) ("beanCurrentForm current form id:--------:" +
						// formBeanSample.getFormId()));
						formBeanSample.setFormClientId(cid.toString());
						formBeanSample.setFormTransId(transId);

						sampleTransService.updateApplicantReportForMB(cid.toString(), transId,
								formBeanSample.getFormId());

						// formDataMap = (HashMap<Integer, String>)
						// ses.getAttribute("sesCurrentFormMap");
						if (null != amountDformBean) {
							log.info("trans amount is " + amountDformBean);
						}
						log.info("hashmap " + formDataMap.size());

						log.info("trans amounts " + transBeanAmount);

						payerId = (String) ses.getAttribute("PayerID");
						log.info((Object) ("payerId:----:" + payerId));
					
						Date transDate = new Date();
						transBean.setTransDate(transDate);
						transBean.setTransStatus(ApplicationStatus.pending.toString());
						transBean.setCollegeBean(college);
						transBean.setContact(formBeanSample.getContact());
						transBean.setName(formBeanSample.getName());
						transBean.setEmail(formBeanSample.getEmail());
						transBean.setCid(cid.toString());
						transBean.setBid(bid);
						transBean.setFormId(formBeanSample.getFormTemplateId());
						transBean.setTransId(transId);
						transBean.setTransForm(formBeanSample);
						
						beanCurrentForm = formBeanSample;
						
						transBean = sampleTransService.saveTransaction(transBean);
						
						String transStatus = ApplicationStatus.dataSaved.toString();

//						beanCurrentForm = getSetAllUploadedFilesName(beanCurrentForm);
							
						if (college.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks)
								|| college.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) {
							log.info("beanDataForm.getValidateFieldOfExcel() :: "
									+ beanDataForm.getValidateFieldOfExcel().toString());
							transAmounts = 0.0;

							log.info((Object) "Adding to reporting Database in async thread.. " + transId + " "
									+ transAmounts + " " + beanCurrentForm.toString());
							sampleTransService.updateTransDataToReportingDB(ses, transStatus, beanCurrentForm, transId,
									transAmounts);
						} else {
							if (transBeanAmount == null) {
								transAmounts = amountDformBean;

								log.info((Object) "Adding to reporting Database in async thread.. " + transId + " "
										+ transAmounts + " " + beanCurrentForm.toString());
								sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
										beanCurrentForm, transId, transAmounts);
							} else {
								transAmounts = 0.0;

								log.info((Object) "Adding to reporting Database in async thread.. " + transId + " "
										+ transAmounts + " " + beanCurrentForm.toString());
								sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus,
										beanCurrentForm, transId, transAmounts);
							}
						}

						if (college.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks)
								|| college.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) {
							log.info("FormId is :: { " + formid + " }, cid is { " + cid + " }, bid is { " + bid
									+ " }, payer profile { " + PayeeProfile + " }");
							log.info(linkPass + "and contact number is " + beanCurrentForm.getContact());

							NotifyPayerOfFormLink(beanCurrentForm, linkPass, false, request, cid, Integer.parseInt(bid),
									beanPayerType.getPayer_type());
						}

						ses.setAttribute("currentFormId", formid);
						ses.setAttribute("BankId", bid);
						ses.setAttribute("CollegeId", cid);
						ses.setAttribute("PayeeProfile", PayeeProfile);
						ses.setAttribute("CollegeBean", college);

						requestStr = "SuccessSaveResponceForMB";
					} catch (NullPointerException ex) {
						ex.printStackTrace();
						requestStr = "sessionFailurePage";
					}
				} else {
					log.info(
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					request.setAttribute("errorMsg",
							"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
					requestStr = "errorPage";
				}
			}
			return requestStr;
		}

	}
/*--- wrong code start ---*/
	public SampleFormBean getSetAllUploadedFilesName(SampleFormBean beanCurrentForm) {
		if(beanCurrentForm.getFile_Path1()!=null) {
			String nameValue=beanCurrentForm.getFile_Path1();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path1(nameValue);
		}if(beanCurrentForm.getFile_Path2()!=null) {
			String nameValue=beanCurrentForm.getFile_Path2();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path2(nameValue);
		}if(beanCurrentForm.getFile_Path3()!=null) {
			String nameValue=beanCurrentForm.getFile_Path3();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path3(nameValue);
		}if(beanCurrentForm.getFile_Path4()!=null) {
			String nameValue=beanCurrentForm.getFile_Path4();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path4(nameValue);
		}if(beanCurrentForm.getFile_Path5()!=null) {
			String nameValue=beanCurrentForm.getFile_Path5();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path5(nameValue);
		}if(beanCurrentForm.getFile_Path6()!=null) {
			String nameValue=beanCurrentForm.getFile_Path6();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path6(nameValue);
		}if(beanCurrentForm.getFile_Path7()!=null) {
			String nameValue=beanCurrentForm.getFile_Path7();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path7(nameValue);
		}if(beanCurrentForm.getFile_Path8()!=null) {
			String nameValue=beanCurrentForm.getFile_Path8();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path8(nameValue);
		}if(beanCurrentForm.getFile_Path9()!=null) {
			String nameValue=beanCurrentForm.getFile_Path9();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path9(nameValue);
		}if(beanCurrentForm.getFile_Path10()!=null) {
			String nameValue=beanCurrentForm.getFile_Path10();
			nameValue=getGeneratedStringValue(nameValue);
			beanCurrentForm.setFile_Path10(nameValue);
		}
		return beanCurrentForm;
	}
	
	public String getGeneratedStringValue(String oName) {
		String reGenerateValue="";
		reGenerateValue=oName.substring(oName.lastIndexOf("\\")+1,oName.length());
		int i=reGenerateValue.lastIndexOf("_");
		int j=reGenerateValue.lastIndexOf(".");
		String fname=reGenerateValue.substring(0, i);
		String ext=reGenerateValue.substring(j+1, reGenerateValue.length());
		reGenerateValue=fname+"."+ext;
		return reGenerateValue;
	}
	
	// Start Demo for NPCI on 28-11-2019
	@RequestMapping(value = "/SaveViewFormForNPCI", method = { RequestMethod.POST, RequestMethod.GET })
	public void SaveViewFormForNPCI(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException,
			BadPaddingException, InterruptedException {

		SampleFormBean formBeanSample = new SampleFormBean();
		HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
		Double amountDformBean;
		String formid = request.getParameter("formid").toString();
		formBeanSample = (SampleFormBean) ses.getAttribute("form");
		String validCheckSum = "";
		if (null != formBeanSample) {
			log.info("process for coming data by SampleFormBean is ====> " + formBeanSample.getFormData().toString());
			formDataMap = processFormData(formBeanSample.getFormData());
			validCheckSum = mandetoryFieldCheckSum(formid, formDataMap);

			if (validCheckSum.equalsIgnoreCase("true")) {
				try {
					log.info("SaveViewForm() method in SampleTransActionController............");
					String linkPass = "";
					if (null != ses.getAttribute("linkPass")) {
						linkPass = (String) ses.getAttribute("linkPass");
						log.info("linkPass for saveing in tem table is :::: " + linkPass);
						ses.setAttribute("linkPass", linkPass);
					}
					Integer cid = Integer.parseInt(request.getParameter("cid").toString());
					log.info("college id in process trans is :::::::::::: " + cid.toString());

					log.info("formid id in process trans is :::::::::::: " + formid.toString());
					String bid = collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM().getBankId()
							.toString();
					log.info("Bank id in process trans is :::::::::::: " + bid);

					CollegeBean college = collegeService.viewInstDetail((Integer) cid);
					log.info((Object) ("college :----------:" + (Object) college) + " cid " + cid);

					BeanFormDetails beanDataForm = sampleFormService
							.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));

					String lifeCycle = beanDataForm.getLife_cycle();

					log.info("formTemplateId for DataFormDetails table lifecycle is :::: " + lifeCycle);

					Integer sesBid = (Integer) ses.getAttribute("BankId");
					log.info("bid " + sesBid);
					Integer sesCid = (Integer) ses.getAttribute("CollegeId");
					log.info("cid " + sesCid);
					if (null == ses.getAttribute("BankId") && null == ses.getAttribute("CollegeId")) {
						sesBid = Integer.parseInt(bid);
						sesCid = cid;
					}
					log.info("bid " + sesBid + "cid " + sesCid);
					String PayeeProfile = (String) ses.getAttribute("PayeeProfile");
					log.info("PayeeProfile " + PayeeProfile);

					Double transBeanAmount = null;
					String payerId;
					String transId;

					transId = this.GenerateTransactionId();
					log.info((Object) ("transId:" + transId));

					log.info("It is in if block and validated filed are null");

					amountDformBean = formBeanSample.getTransAmount();
					formBeanSample.setFormClientId(cid.toString());
					formBeanSample.setFormTransId(transId);

					sampleTransService.updateApplicantReportForMB(cid.toString(), transId, formBeanSample.getFormId());

					if (null != amountDformBean) {
						log.info("trans amount is " + amountDformBean);
					}
					log.info("hashmap " + formDataMap.size());

					log.info("trans amounts " + transBeanAmount);

					payerId = (String) ses.getAttribute("PayerID");
					log.info((Object) ("payerId:----:" + payerId));

					beanCurrentForm = formBeanSample;
					
//					beanCurrentForm = getSetAllUploadedFilesName(beanCurrentForm);
					
					String transStatus = ApplicationStatus.dataSaved.toString();
					String subscriptionId = "";
					String tableName = "zz_client_user_data_" + beanCurrentForm.getFormFeeId();
					linkPass = sampleFormAction.autoGenerateLinkPassword(transStatus, transId);
					subscriptionId = getNumericString(4);
					log.info("subscriptionId are :::: " + subscriptionId);

					ses.setAttribute("linkPass", linkPass);
					ses.setAttribute("subscriptionId", subscriptionId);

					transAmounts = amountDformBean;
					log.info("Adding to reporting Database in async thread.. " + transId + " " + transAmounts + " "
							+ beanCurrentForm.toString());
					sampleTransService.insertApplicantTransDataToReportingDB(ses, transStatus, beanCurrentForm, transId,
							transAmounts);

					log.info("Name of table : " + tableName + " : transid is : " + transId + " : transstatus is : "
							+ transStatus);
//					try {
//						apiCalling.getApplicantDetailsForSubscription(tableName, transId, transStatus,
//								college.getCollegeCode(), request, response);
//					} catch (JsonProcessingException | ParseException e) {
//						e.printStackTrace();
//					}

					ses.setAttribute("currentFormId", formid);
					ses.setAttribute("BankId", bid);
					ses.setAttribute("CollegeId", cid);
					ses.setAttribute("PayeeProfile", PayeeProfile);
					ses.setAttribute("CollegeBean", college);
				} catch (NullPointerException ex) {
					ex.printStackTrace();
				}
			} else {
				log.info(
						"Mandatory fields are not filled properly.Please reinsert your form again with mandatory field.");
			}
		}
	}
	// End Demo for NPCI on 28-11-2019

	private void NotifyPayerOfFormLink(SampleFormBean beanCurrentForm, String trId, boolean payerCredRequired,
			HttpServletRequest request, Integer cid, Integer bid, String payerProfile) throws InvalidKeyException,
			NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException,
			UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
		log.info("notify form payer is  NotifyPayerOfFormLink :::::::::::: " + beanCurrentForm.toString()
				+ " and getdob on this form payer is :::::::::::::" + beanCurrentForm.getDob() + " and dob date is  "
				+ beanCurrentForm.getDobDate());
		StringBuffer url = request.getRequestURL();
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String urlPath = String.valueOf(url.substring(0, url.length() - uri.length() + ctx.length())) + "/";
		// log.info(("ctx::" + ctx));
		// log.info(("request url is::" + url));
		log.info(("urlPath :: >>> " + urlPath));

		String linkPass = trId;
		String urlFormLink;
		// log.info(linkPass + " ::::::: " + beanCurrentForm.getFormTemplateId() + "
		// ::::::::: " + cid + " :::::::::: "
		// + bid + " :::::: " + payerProfile);

		payerProfile = payerProfile.replaceAll(" ", "+");
		
		if (!cid.equals(cIdForNPCI) || !cid.equals(cIdForMagicBricks) || cid != Integer.parseInt(cIdForMagicBricks)) {
			// http://localhost:8081/QwikForms/getPayerFormsById1?formid=127&bid=4&cid=2313&PayeeProfile=RDVJ1_Payer&flag=1
			urlFormLink = String.valueOf(urlPath) + "getPayerFormsById1?formid=" + beanCurrentForm.getFormId() + "&bid="
					+ bid + "&cid=" + cid + "&PayeeProfile=" + payerProfile + "&flag=1";

			log.info(("urlFormLink :: >>> " + urlFormLink));
		} else {
			urlFormLink = String.valueOf(urlPath) + "validateFieldForMB?formid=" + beanCurrentForm.getFormTemplateId()
					+ "&bid=" + bid + "&cid=" + cid + "&PayeeProfile=" + payerProfile;

			log.info(("urlFormLink :: >>> " + urlFormLink));
		}

		// String msg = "Your Pending form password is -" + linkPass + " , and Link is
		// !";
		// SendSMSs.sendSmsUsingLinkPaisaTinyUrl(beanCurrentForm.getContact(), msg,
		// urlFormLink, beanCurrentForm.getEmail());

		String msg = "You have pending forms to complete. Your password is ! " + linkPass + " and Link is ! "
				+ urlFormLink;
		SendSMSs.sendSMS(beanCurrentForm.getContact(), msg);

		new Thread(() -> {
			ElasticSendMailer.Send(beanCurrentForm.getEmail(), "You have pending forms to complete!", urlFormLink,
					beanCurrentForm.getName(), beanCurrentForm.getEmail(), linkPass);
			log.info("mail sent ");
		}).start();

	}

	@RequestMapping(value = "/viewSavedFormInDashBoard", method = { RequestMethod.POST, RequestMethod.GET })
	public String viewSavedFormInDashBoard(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		block3: {
			try {
				loginUser = (LoginBean) ses.getAttribute("loginUserBean");
				log.info((Object) ("loginUser :" + loginUser.getUserName()));
				if (!loginUser.getProfile().contentEquals("Operator"))
					break block3;
				log.info((Object) "IF");
				OperatorBean operatorBean = (OperatorBean) ses.getAttribute("OperatorBean");
				beanFormDetailsList = collegeService.getBeanFormDetailsOfParticularClient(
						(Integer) operatorBean.getCollegeBean_fk().getLoginBean().getLoginId(),
						(String) operatorBean.getCollegeBean_fk().getCollegeName());

				log.info((Object) ("form details:" + beanFormDetailsList.size()));
				log.info("CollegeId is  " + String.valueOf(loginUser.getCollgBean().getCollegeId()));

				sampleFormBeanLists = (sampleTransService
						.getFormDetailByUsingTransIds((loginUser.getCollgBean().getCollegeId())));
				log.info("sample form list size issss " + sampleFormBeanList.size());
				for (int i = 0; i < 5; i++) {
					sampleFormBeanList.add(sampleFormBeanLists.get(i));
				}
				log.info("sample form list size iss " + sampleFormBeanList.size());
				ses.setAttribute("sampleFormBeanList", sampleFormBeanList);

				return "operator-SavedForms";
			} catch (NullPointerException e) {
				return "SessionTerminated";
			}
		}
		log.info((Object) "Else");
		log.info((Object) "testing");
		CollegeBean collegeBean = loginUser.getCollgBean();
		log.info((Object) ("collegeBean :" + collegeBean.getCollegeName()));
		collegeBean = collegeService.viewInstDetail((Integer) loginUser.getCollgBean().getCollegeId());
		beanFormDetailsList = collegeService.getBeanFormDetailsOfParticularClient((Integer) loginUser.getLoginId(),
				(String) loginUser.getCollgBean().getCollegeName());
		// log.info("beanFormDetailsList for View :::::::::::::::: " +
		// beanFormDetailsList.toString());
		ses.setAttribute("beanFormDetailsList", beanFormDetailsList);
		return "admin-SavedForms";
	}

	public String viewSavedFormInDashBoards(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		block3: {
			try {
				loginUser = (LoginBean) ses.getAttribute("loginUserBean");
				log.info((Object) ("loginUser :" + loginUser.getUserName()));
				if (!loginUser.getProfile().contentEquals("Operator"))
					break block3;
				log.info((Object) "IF");
				OperatorBean operatorBean = (OperatorBean) ses.getAttribute("OperatorBean");

				log.info("ddaa " + String.valueOf(loginUser.getCollgBean().getCollegeId()));
				sampleFormBeanList = sampleTransService
						.getFormDetailByUsingTransIds((loginUser.getCollgBean().getCollegeId()));
				return "operatorSaveFormsAtn";
			} catch (NullPointerException e) {
				return "error";
			}
		}
		log.info((Object) "Else");
		log.info((Object) "testing");
		CollegeBean collegeBean = loginUser.getCollgBean();
		log.info((Object) ("collegeBean :" + collegeBean.getCollegeName()));
		collegeBean = collegeService.viewInstDetail((Integer) loginUser.getCollgBean().getCollegeId());
		beanFormDetailsList = collegeService.getBeanFormDetailsOfParticularClient((Integer) loginUser.getLoginId(),
				(String) loginUser.getCollgBean().getCollegeName());
		return "success";
	}

	@RequestMapping(value = "/viewSavedFormInDashBoardPendingConfig", method = RequestMethod.GET)
	public String getFormsPendingConfig(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info("work on getFormsPendingConfig() method in ");
		block3: {
			try {
				loginUser = (LoginBean) ses.getAttribute("loginUserBean");
				// System.out.println("login user is " + this.loginUser);
				if (!loginUser.getProfile().contentEquals("Operator"))
					break block3;
				OperatorBean operatorBean = (OperatorBean) ses.getAttribute("OperatorBean");
				beanFormDetailsList = collegeService.getBeanFormDetailsOfParticularClient(
						(Integer) operatorBean.getCollegeBean_fk().getLoginBean().getLoginId(),
						(String) operatorBean.getCollegeBean_fk().getCollegeName());
				return "operator-SavedForms";
			} catch (NullPointerException e) {
				return "SessionTerminated";
			}
		}
		CollegeBean collegeBean = loginUser.getCollgBean();
		log.info((Object) ("collegeBean :" + collegeBean.getCollegeName()));
		collegeBean = collegeService.viewInstDetail((Integer) loginUser.getCollgBean().getCollegeId());
		beanFormDetailsList = collegeService.getBeanFormDetailsOfParticularClientForLC((Integer) loginUser.getLoginId(),
				(String) loginUser.getCollgBean().getCollegeName());

		ses.setAttribute("beanFormDetailsList", beanFormDetailsList);
		return "admin-FormsPendingConfig";
	}

	// Old configuration for decrypting data from sabpaisa
//	@SuppressWarnings("unused")
	@RequestMapping(value = "/DecryptQuery", method = { RequestMethod.POST, RequestMethod.GET })
	public String CaptureSpResponse(ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws UnsupportedEncodingException {
		log.info("Start of DecryptQuery(), testing the code:");
		SampleTransBean trans = (SampleTransBean) ses.getAttribute("sesCurrentTransData");
		CollegeBean colBean = new CollegeBean();
		beanTransData = new SampleTransBean();
		String query = request.getParameter("query");
		String subscriptionId = "";
		log.info("query:" + query);
//		log.info("qf id by sp transaction table ::::::::: "+trans.getTransId() + trans.getFormId());
		String qcAuthKey = "";
		String qcAuthIV = "";
		query = query.replaceAll("%2B", " ");
		query = query.replaceAll(" ", "+");
		if (null != request.getParameter("cliencode")) {
			log.info("request.Parameter(CollegeCode ) is >>>>>>>>>>>>>>> " + request.getParameter("cliencode"));
		}
		String clientCode = request.getParameter("cliencode");

		colBean = collegeService.getCollegeDetailsOnCode(clientCode);
		if (null == colBean) {
			log.info("client details by session.");
			colBean = (CollegeBean) ses.getAttribute("CollegeBean");
		}
		Integer cidBySes = colBean.getCollegeId();
		log.info("CollegeBean id is " + colBean.getCollegeCode() + " , and college id is :::: " + cidBySes);

		System.out.println("query:" + query);

		// for SP2.0
		if (null != colBean.getUserName() && null != colBean.getUserPassword() && null != colBean.getAuthKey()
				&& null != colBean.getAuthIV()) {
			log.info("Now user is configured with SP2.0");
			qcAuthKey = colBean.getAuthKey();
			qcAuthIV = colBean.getAuthIV();
		} else {
			log.info("Now user is not configured with SP2.0 and take all data from resource file.");
			qcAuthKey = this.qcAuthKey;
			qcAuthIV = this.qcAuthIV;
		}
		// for SP2.0
		log.info("----authKey---------- 1 " + qcAuthKey + "----authIV---------- 1 " + qcAuthIV);

		String decText = null;
		try {

			decText = Encryptor.decrypt(qcAuthKey, qcAuthIV, query);

			log.info("decText:" + decText);
		} catch (InvalidKeyException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {

			e.printStackTrace();
		}

		log.info("dec text :: for >>>>>>>>> " + decText);
		Map<String, String> querypair = new LinkedHashMap<String, String>();

		querypair = Encryptor.splitQuery(decText);

		log.info("Isssure ref No :" + querypair.get("issuerRefNo"));

		String resp = querypair.get("spRespCode");
		String qfTxnId = querypair.get("clientTxnId");
		log.info("resp return from Sabpaisa {" + resp + ", qfTxnId is >>> {" + qfTxnId + "}");
		String fotmID = "";

		fotmID = querypair.get("programId");

		if (fotmID.equalsIgnoreCase("") || null == fotmID || fotmID.isEmpty()) {
			fotmID = ses.getAttribute("formId").toString();
		} else {
			log.info("formid is comming from sabpaisa as programid ---->  " + fotmID);
		}
		log.info("formID >>> {" + fotmID + "} for qfId {" + qfTxnId + "}");

		if(trans==null) {
			trans=sampleTransService.getTransactionDetailsBasedOnTransactionId(qfTxnId);
		}
		
		try {
			
			String SPTransStatus = (null == querypair.get("spRespStatus")) ? ApplicationStatus.ABORTED.toString()
					: querypair.get("spRespStatus");
			// trans.setIssuerRefNo(querypair.get("issuerRefNo"));
			trans.setTransPaymode(querypair.get("payMode"));
			trans.setPgRespCode(querypair.get("pgRespCode"));
			trans.setPgTransId(querypair.get("PgTxnNo"));
			trans.setSpRespCode(querypair.get("spRespCode"));
			trans.setSpTransId(querypair.get("SabPaisaTxId"));
			if (null != querypair.get("spRespStatus")) {
				log.info("spRespStatus >> {" + SPTransStatus + "} for qcId {" + qfTxnId + "}");
				trans.setTransStatus(querypair.get("spRespStatus"));
			} else {
				log.info("spRespStatus is absent from sabpaisa response, so reading status instead");
				trans.setTransStatus(querypair.get("status"));
			}
			trans.setTransAmount(Double.parseDouble(querypair.get("amount")));
			trans.setTransOtherChrg(trans.getTransAmount() - trans.getTransOgAmount());

			Session session = factory.openSession();

			try {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
				String currentDate = df.format(new Date(System.currentTimeMillis()));
				String payMode = querypair.get("payMode");
				String challnNo = querypair.get("challanNo");
				String pgTxnId = querypair.get("PgTxnNo");
				if (payMode == null || "".equals(payMode)) {
					payMode = "N/A";

				}
				if (challnNo == null || "".equals(challnNo)) {
					challnNo = "N/A";

				}
				if (pgTxnId == null || "".equals(pgTxnId)) {
					pgTxnId = "N/A";

				}

				log.info("Going to udate update zz_client_user_data_" + fotmID + ", table for qcId {" + qfTxnId + "}");
				Transaction tx = session.beginTransaction();

				// String tId="`"+querypair.get("SabPaisaTxId");
				String tId = querypair.get("SabPaisaTxId");
				String tableName = "zz_client_user_data_" + fotmID;
				log.info("sptransid is for client table :::: " + tId);
				// log.info("sptransid is for cidForMaxFilledSeat1 :::: "+cidForMaxFilledSeat1);
				if (trans.getCid().equals(cIdForNPCI) || trans.getCid().equals(cIdForMagicBricks) || cidBySes.equals(cIdForMagicBricks)
						|| trans.getCid().equals(cIdForTVS)) {

					subscriptionId = getNumericString(4);
					log.info("subscriptionId are :::: " + subscriptionId);

					if (SPTransStatus.equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())
							|| SPTransStatus.equalsIgnoreCase(ApplicationStatus.FAILED.toString())) {
						log.info("SPTransStatus is :: " + SPTransStatus);
						session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
								+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
								+ querypair.get("amount") + "',challanNo='" + challnNo + "',spTransId='" + tId
								+ "',pgTransId='" + pgTxnId + "',subscriptionId='" + subscriptionId
								+ "' where  transId='" + qfTxnId + "'").executeUpdate();

					} else {
						log.info("SPTransStatus is :: " + SPTransStatus);
						session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
								+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
								+ querypair.get("amount") + "',challanNo='" + challnNo + "',spTransId='" + tId
								+ "',pgTransId='" + pgTxnId + "',subscriptionId='null' where  transId='" + qfTxnId
								+ "'").executeUpdate();
					}
				} else {
					session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
							+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
							+ querypair.get("amount") + "',challanNo='" + challnNo + "',spTransId='" + tId
							+ "',pgTransId='" + pgTxnId + "' where  transId='" + qfTxnId + "'").executeUpdate();
				}
				tx.commit();

				// http://localhost:8080/sabpaisaEnach/redirectToSubscription?getData=
				// and use for Magicbric subscription process
				if (trans.getCid().equals(cIdForNPCI) || trans.getCid().equals(cIdForMagicBricks) || cidBySes.equals(cIdForMagicBricks)
						|| trans.getCid().equals(cIdForTVS)) {

					if (SPTransStatus.equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())
							|| SPTransStatus.equalsIgnoreCase(ApplicationStatus.FAILED.toString())) {
						try {
							if (editSubscription.equalsIgnoreCase("Yes")) {
//								apiCalling.getApplicantDetailsForSubscription(tableName, qfTxnId, SPTransStatus,
//										colBean.getCollegeCode(), request, response);
							} else {
								log.info(
										"Currently subscription is not working. So data is not shared with Subscription api.");
							}
						} catch (Exception e) {
							e.printStackTrace();
						}

					}

				}

			} catch (Exception e) {
				log.info("Exception Occoured while updating Record Not Updated into zz_client_user_data_" + fotmID
						+ " while returning from SabPaisa");

				mail.sendConflictMail(
						"Record Not Updated into zz_client_user_data_" + fotmID + " while returning from SabPaisa",
						"sabpaisa@srslive.in", trans.getEmail(), trans.getContact(), trans.getName(), e.getMessage());

			} finally {
				// close session
				session.close();
			}

		} catch (Exception e) {
			// trans.setIssuerRefNo("0");
		}
		try {

			if ("0000".equals(resp)) {

				log.info("0000, 1 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0100".equals(resp)) {

				log.info("0100, 2 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans.setTransStatus("Subject to realization of Payment");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0200".equals(resp)) {

				log.info("0200, 2 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans.setTransStatus("Subject to realization of Payment");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0300".equals(resp)) {

				log.info("0300, 3 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0400".equals(resp)) {

				log.info("0400, 4 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else {

				log.info("5 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);
			}

		} catch (Exception e) {
			log.error("Exception in handelling response", e);
		}

		beanTransData = trans;
		
		ses.setAttribute("beanTransData", beanTransData);
		ses.setAttribute("CollegeBean", colBean);
		log.info("BeanTransData with txn id is ::::: " + beanTransData.getSpTransId());
		return "transEndPage";

	}

	// New configuration for decrypting data from sabpaisa

	@RequestMapping(value = "/DecryptQueryForNewSp", method = { RequestMethod.POST, RequestMethod.GET })
	public String CaptureSpResponseForNewSp(HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws UnsupportedEncodingException {
		log.info("Start of DecryptQueryForNewSp(), For SP2 ");
		SampleTransBean trans = (SampleTransBean) ses.getAttribute("sesCurrentTransData");
		CollegeBean colBean = new CollegeBean();
		beanTransData = new SampleTransBean();
		String query = request.getParameter("query");
		String subscriptionId = "";
		log.info("query:" + query);
		log.info("qf id by sp transaction table ::::::::: "+trans.getTransId() + trans.getFormId());
		query = query.replaceAll("%2B", " ");
		query = query.replaceAll(" ", "+");
		colBean = (CollegeBean) ses.getAttribute("CollegeBean");
		Integer cidBySes = colBean.getCollegeId();
		log.info("CollegeBean id is " + colBean.getCollegeCode() + " , and college id is :::: " + cidBySes);

		qcAuthKey = colBean.getAuthKey();
		qcAuthIV = colBean.getAuthIV();
		log.info("AuthKey : " + qcAuthKey + " : AuthVi : " + qcAuthIV + " : Clientcode : " + colBean.getCollegeCode());

		log.info("query:" + query);

		String decText = null;
		try {

			decText = Encryptor.decrypt(qcAuthKey, qcAuthIV, query);

			log.info("decText:" + decText);
		} catch (InvalidKeyException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {

			e.printStackTrace();
		}

		log.info("dec text :: for >>>>>>>>> " + decText);
		Map<String, String> querypair = new LinkedHashMap<String, String>();

		querypair = Encryptor.splitQuery(decText);

		log.info("Isssure ref No :" + querypair.get("issuerRefNo"));

		String resp = querypair.get("responseCode");
		String qfTxnId = querypair.get("clientTxnId");
		log.info("resp return from Sabpaisa {" + resp + ", qfTxnId is >>> {" + qfTxnId + "}");
		String fotmID = "";

		fotmID = querypair.get("programId");

		if (fotmID.equalsIgnoreCase("") || null == fotmID || fotmID.isEmpty()) {
			fotmID = ses.getAttribute("formId").toString();
		} else {
			log.info("formid is comming from sabpaisa as programid ---->  " + fotmID);
		}
		log.info("formID >>> {" + fotmID + "} for qfId {" + qfTxnId + "}");

		try {

			String SPTransStatus = (null == querypair.get("spRespStatus")) ? ApplicationStatus.ABORTED.toString()
					: querypair.get("spRespStatus");
			// trans.setIssuerRefNo(querypair.get("issuerRefNo"));
			trans.setTransPaymode(querypair.get("payMode"));
			trans.setPgRespCode(querypair.get("responseCode"));
			trans.setPgTransId(querypair.get("PgTxnNo"));
			trans.setSpRespCode(querypair.get("responseCode"));
			trans.setSpTransId(querypair.get("spTxnid"));
			if (null != querypair.get("spRespStatus")) {
				log.info("spRespStatus >> {" + SPTransStatus + "} for qcId {" + qfTxnId + "}");
				trans.setTransStatus(querypair.get("spRespStatus"));
			} else {
				log.info("spRespStatus is absent from sabpaisa response, so reading status instead");
				trans.setTransStatus(querypair.get("status"));
			}
			trans.setTransAmount(Double.parseDouble(querypair.get("paidAmount")));
			trans.setTransOtherChrg(trans.getTransAmount() - trans.getTransOgAmount());

			Session session = factory.openSession();

			try {

				DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
				String currentDate = df.format(new Date(System.currentTimeMillis()));
				String payMode = querypair.get("payMode");
				String challnNo = querypair.get("challanNo");
				String pgTxnId = querypair.get("PgTxnNo");
				if (payMode == null || "".equals(payMode)) {
					payMode = "N/A";
				}
				if (challnNo == null || "".equals(challnNo)) {
					challnNo = "N/A";
				}
				if (pgTxnId == null || "".equals(pgTxnId)) {
					pgTxnId = "N/A";
				}

				log.info("Going to udate update zz_client_user_data_" + fotmID + ", table for qcId {" + qfTxnId + "}");
				Transaction tx = session.beginTransaction();

				// String tId="`"+querypair.get("SabPaisaTxId");
				String tId = querypair.get("spTxnid");
				String tableName = "zz_client_user_data_" + fotmID;
				log.info("sptransid is for client table :::: " + tId);
				// log.info("sptransid is for cidForMaxFilledSeat1 :::: "+cidForMaxFilledSeat1);
				if (trans.getCid().equals(cIdForNPCI) || trans.getCid().equals(cIdForMagicBricks) || cidBySes.equals(cIdForMagicBricks)
						|| trans.getCid().equals(cIdForTVS)) {

					subscriptionId = getNumericString(4);
					log.info("subscriptionId are :::: " + subscriptionId);

					if (SPTransStatus.equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())
							|| SPTransStatus.equalsIgnoreCase(ApplicationStatus.FAILED.toString())) {
						log.info("SPTransStatus is :: " + SPTransStatus);

						session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
								+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
								+ querypair.get("paidAmount") + "',challanNo='" + challnNo + "',spTransId='" + tId
								+ "',pgTransId='" + pgTxnId + "',subscriptionId='" + subscriptionId
								+ "' where  transId='" + qfTxnId + "'").executeUpdate();

					} else {
						log.info("SPTransStatus is :: " + SPTransStatus);

						session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
								+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
								+ querypair.get("paidAmount") + "',challanNo='" + challnNo + "',spTransId='" + tId
								+ "',pgTransId='" + pgTxnId + "',subscriptionId='null' where  transId='" + qfTxnId
								+ "'").executeUpdate();
					}
				} else {
					session.createSQLQuery("update " + tableName + " set transStatus='" + SPTransStatus
							+ "',transPaymode='" + payMode + "',transDate='" + currentDate + "',transAmount='"
							+ querypair.get("paidAmount") + "',challanNo='" + challnNo + "',spTransId='" + tId
							+ "',pgTransId='" + pgTxnId + "' where  transId='" + qfTxnId + "'").executeUpdate();
				}
				tx.commit();

				// http://localhost:8080/sabpaisaEnach/redirectToSubscription?getData= // and
				// use
				// for Magicbric subscription process
				if (trans.getCid().equals(cIdForNPCI) || trans.getCid().equals(cIdForMagicBricks) || cidBySes.equals(cIdForMagicBricks)
						|| trans.getCid().equals(cIdForTVS)) {

					if (SPTransStatus.equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())
							|| SPTransStatus.equalsIgnoreCase(ApplicationStatus.FAILED.toString())) {
						try {
							if (editSubscription.equalsIgnoreCase("Yes")) {
//								apiCalling.getApplicantDetailsForSubscription(tableName, qfTxnId, SPTransStatus,
//										colBean.getCollegeCode(), request, response);
							} else {
								log.info(
										"Currently subscription is not working. So data is not shared with Subscription api.");
							}
						} catch (Exception e) {
							e.printStackTrace();
						}

					}

				}

			} catch (Exception e) {
				log.error("Exception Occoured while updating Record Not Updated into zz_client_user_data_" + fotmID
						+ " while returning from SabPaisa");

				mail.sendConflictMail(
						"Record Not Updated into zz_client_user_data_" + fotmID + " while returning from SabPaisa",
						"sabpaisa@srslive.in", trans.getEmail(), trans.getContact(), trans.getName(), e.getMessage());

			} finally {

				session.close();
			}

		} catch (Exception e) {
			// trans.setIssuerRefNo("0");

		}
		try {

			if ("0000".equals(resp)) {

				log.info("0000, 1 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0100".equals(resp)) {

				log.info("0100, 2 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans.setTransStatus("Subject to realization of Payment");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0200".equals(resp)) {

				log.info("0200, 2 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans.setTransStatus("Subject to realization of Payment");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0300".equals(resp)) {

				log.info("0300, 3 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else if ("0400".equals(resp)) {

				log.info("0400, 4 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);

			} else {

				log.info("5 ::: resp is " + resp
						+ ", going to save transaction to data_transaction table for qfId >>> {" + qfTxnId + "}");
				trans = sampleTransService.saveTransaction(trans);
			}

		} catch (Exception e) {
			log.error("Exception in handelling response", e);
		}

		beanTransData = trans;
		log.info("BeanTransData with txn id is ::::: " + beanTransData.getSpTransId());
		ses.setAttribute("beanTransData", beanTransData);
		ses.setAttribute("CollegeBean", colBean);

		return "transEndPage";

	}

	@RequestMapping(value = "/completeTransaction", method = { RequestMethod.POST, RequestMethod.GET })
	public String completeTransaction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		SampleTransBean beanCurrentTrans = new SampleTransBean();
		beanCurrentTrans = (SampleTransBean) ses.getAttribute("sesCurrentTransData");
		String status = request.getParameter("status");
		if (status.contentEquals("Ok")) {
			beanCurrentTrans.setTransStatus("Successful");
		} else {
			beanCurrentTrans.setTransStatus("Failed");
		}
		beanTransData = beanCurrentTrans = sampleTransService.saveTransaction(beanCurrentTrans);
		return "transEndPage";
	}

	@RequestMapping(value = "/viewPreviousTxn", method = { RequestMethod.POST, RequestMethod.GET })
	public String getPreviousTxn() throws ParseException, IOException {

		payerHistory = sampleTransService.getOldTransacionDetail(transId, birthDate, contactNo, fromDate, toDate,
				clientId);
		return "payer_History_Ajax";

	}

	@RequestMapping(value = "/getTransactions", method = { RequestMethod.POST, RequestMethod.GET })
	public String getAllTransactions(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		if (null != ses.getAttribute("transData")) {
			ses.removeAttribute("transData");
		}
		/* this.transData=new ArrayList<SampleTransBean>(); */
		String jsp1 = "downloadTransReportDetails";
		String jsp2 = "admin-Reports";
		String returnVal = "";
		log.info("get all transactions() ");
		String serviceId = request.getParameter("serviceId");
		// log.info("service id is " + serviceId);

		String forDownload = request.getParameter("ForDownLoad");
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		Integer cid = (Integer) ses.getAttribute("CollegeId");
		// log.info("college id is " + cid);
		if (null != loginUser) {
			try {
				ArrayList transList = new ArrayList();
				/* this.transData = sampleTransService.getTransactionsOfCollege(cid); */
				/* ses.setAttribute("transData", transData); */
				for (SampleTransBean sampleTransBean : transData) {
					// log.info((Object) ("sampleTransBean of transaction Id:" +
					// sampleTransBean.getTransId()));
					SampleFormBean sampleFormData = sampleTransService
							.getFormDetailByUsingTransId(sampleTransBean.getTransId());
					sampleTransBean.setFeeName(sampleTransService.getFormDetail(sampleFormData.getFormFeeId()));
				}
				feeLookupList = daoFeeService.getFeeLookups("ALL", null);
				ses.setAttribute("feeLookupList", feeLookupList);
				// log.info("forDownload value is :::::: "+forDownload);
				String result = forDownload != null && forDownload.contentEquals("True") ? jsp1 : jsp2;
				// log.info((Object) ("result is ::::: " + result));
				forms = new ArrayList<BeanFormDetails>(
						daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));

				// ses.setAttribute("transData", this.transData);
				ses.setAttribute("forms", forms);
				returnVal = result;
			} catch (NullPointerException e) {
				returnVal = "sessionFailurePage";
			}
		} else {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}

	@RequestMapping(value = "/getCashTransactions", method = { RequestMethod.POST, RequestMethod.GET })
	public String getAllSpotCashTransactions(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		String jsp1 = "downloadTransReportDetails";
		String jsp2 = "admin-PendingSpotPamentReports";

		String forDownload = request.getParameter("ForDownLoad");
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		Integer cid = (Integer) ses.getAttribute("CollegeId");
		try {
			ArrayList transList = new ArrayList();
			transData = sampleTransService.getTransactionsForCash(cid);
			for (SampleTransBean sampleTransBean : transData) {
				log.info((Object) ("sampleTransBean of transaction Id:" + sampleTransBean.getTransId()));
				SampleFormBean sampleFormData = sampleTransService
						.getFormDetailByUsingTransId(sampleTransBean.getTransId());
				sampleTransBean.setFeeName(sampleTransService.getFormDetail(sampleFormData.getFormFeeId()));
			}
			feeLookupList = daoFeeService.getFeeLookups("ALL", (Object) null);
			String result = forDownload != null && forDownload.contentEquals("True") ? jsp1 : jsp2;
			// log.info((Object) ("result is" + result));
			forms = new ArrayList<BeanFormDetails>(
					daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));
			return result;
		} catch (NullPointerException e) {
			return "sessionFailurePage";
		}
	}

	@RequestMapping(value = "/getTransactions1", method = { RequestMethod.POST, RequestMethod.GET })
	public String getAllTransactionsUsingOPTLogin(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		String jsp1 = "operator-Reports";
		String jsp2 = "admin-ReportsExcel";

		String forDownload = request.getParameter("ForDownLoad");
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		ArrayList transList = new ArrayList();
		transData = sampleTransService
				.getTransactionsOfCollege(loginUser.getOperatorBean().getCollegeBean_fk().getCollegeId());
		ses.setAttribute("TransData", transData);
		Iterator<SampleTransBean> itr = transData.iterator();
		feeLookupList = daoFeeService.getFeeLookups("ALL", (Object) null);
		ses.setAttribute("feeLookupList", feeLookupList);
		String result = forDownload != null && forDownload.contentEquals("True") ? jsp2 : jsp1;
		log.info((Object) ("result is ::" + result));
		return result;
	}

	private String GenerateTransactionId() {
		String transId = "QF";
		Random rnd = new Random();
		int i = 100000 + rnd.nextInt(900000);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMddHHmmss");
		LocalDateTime now = LocalDateTime.now();
		String formattedDaterTime = dtf.format(now);
		transId = String.valueOf(transId) + formattedDaterTime + String.valueOf(i);
		return transId;

	}

	private String GenerateSubscriptionIdForMB() {
		String subscriptionId = "SRS";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMddHHmmss");
		LocalDateTime now = LocalDateTime.now();
		String formattedDaterTime = dtf.format(now);
		subscriptionId = String.valueOf(subscriptionId) + formattedDaterTime + getNumericString(4);
		return subscriptionId;

	}

	private String getNumericString(int n) {

		// chose a Character random from this String
		String AlphaNumericString = "0123456789";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(n);

		for (int i = 0; i < n; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		String subscriptionId = "SRS";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMddHHmmss");
		LocalDateTime now = LocalDateTime.now();
		String formattedDaterTime = dtf.format(now);
		// 1143358846
		formattedDaterTime = formattedDaterTime.substring(0, 6);
		subscriptionId = String.valueOf(subscriptionId) + formattedDaterTime + sb.toString();
		return subscriptionId;

		// return sb.toString();
	}

	private String getAlphaNumericString(int n) {

		// chose a Character random from this String
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(n);

		for (int i = 0; i < n; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

	@RequestMapping(value = "/viewReceiptDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public String viewReceiptDetailsAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		beanTransData = new SampleTransBean();
		log.info((Object) request.getParameter("tid"));
		beanTransData = sampleTransService.getTransactions(request.getParameter("tid").trim());
		request.setAttribute("status", (Object) beanTransData.getTransStatus());
		feeLookup = daoFeeService.getFeeDetails("feeid", (Object) beanTransData.getTransForm().getFormFeeId())
				.getFeeLookup();
		return "Receipt";
	}

	private boolean checkStaleSession(String bid, String cid, String formtempid, String forminstanceid,
			HttpSession ses) {
		boolean checkResult = true;
		Integer sesBid = (Integer) ses.getAttribute("BankId");
		Integer sesCid = (Integer) ses.getAttribute("CollegeId");
		Integer formTemplateIdFromSession = (Integer) ses.getAttribute("currentFormId");
		String formInstanceIdFromSession = ses.getAttribute("formInstanceId") == null ? ""
				: (String) ses.getAttribute("formInstanceId");

		if (sesBid != null && !String.valueOf(sesBid).equals(bid)) {
			checkResult = false;
			log.info(
					(Object) "ummmm, the session is not valid, courtesy the user having started a new session...bids do not match");
		}
		if (sesCid != null && !String.valueOf(sesCid).equals(cid)) {
			checkResult = false;
			log.info(
					(Object) "ummmm, the session is not valid, courtesy the user having started a new session...cids do not match");
		}
		if (formtempid != null && !String.valueOf(formTemplateIdFromSession).equals(formtempid)) {
			checkResult = false;
			log.info(
					(Object) "ummmm, the session is not valid, courtesy the user having continued with the form template in the expired session...form templates do not match");
		}
		if (!(forminstanceid == null || forminstanceid.equals("") || forminstanceid.equals("null")
				|| "".equals(formInstanceIdFromSession) || formInstanceIdFromSession.equals(forminstanceid))) {
			checkResult = false;
			log.info(
					(Object) "ummmm, the session is not valid, courtesy the user having continued with the form instance in the expired session...form instance ids do not match");
		}
		if (checkResult) {
			log.info((Object) "all is well, the session is active...");
		}
		return checkResult;

	}

	public HashMap<Integer, String> processFormData(String formDataRaw) {

		log.info("Start of processFormData(), formDataRaw >> " + formDataRaw);
		HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
		String[] formFields = formDataRaw.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		log.info(("formFieldsList is ::::::::::::::: " + formFieldsList.toString()));

		int i = 0;
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split("~");
			// log.info("after splitting formFieldData values are ::::::::::::::::: " +
			// formFieldData.toString());
			if (formFieldData.length != 2) {
				log.info(("Form Field at index " + i + " is corrupt or unreadable"));
			} else {

				formDataMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
			}
			++i;
		}

		log.info("End of processFormData(), formDataMap >> " + formDataMap.toString());
		return formDataMap;
	}

	@SuppressWarnings("unused")
	private void NotifyPayerOfBooking(String to, String subject, String URL, String Name, String contact,
			HttpServletRequest request) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException,
			BadPaddingException {

		String toMail = to;
		String subjectMail = subject;
		String URLMail = URL;
		String NameMail = Name;
		String contactMail = contact;
		StringBuffer url = request.getRequestURL();

		EmailSessionBean mailSender = new EmailSessionBean();
		mailSender.sendEMailtoPayerOPD(toMail, subjectMail, URLMail, NameMail, contactMail);

		SendSMS send = new SendSMS();
		send.sendSMSIPD(contact, URLMail);

	}

	// use for mandatory Field CheckSum
	public String mandetoryFieldCheckSum(String formId, HashMap<Integer, String> mapForFormData) {
		log.info("Start of mandetoryFieldCheckSum() method for checking mandatory field");
		BeanFormDetails findMandetoryFieldsOfForm = new BeanFormDetails();
		Set<String> allFieldSetOfForm = new HashSet<String>();
		Set<String> setOfMandetoryFields = new HashSet<String>();
		Set<String> mandetoryFieldSet = new HashSet<String>();
		Set<String> normalFieldSet = new HashSet<String>();
		Integer forId = Integer.parseInt(formId);
		String returnString = "true";

		try {
			findMandetoryFieldsOfForm = daoFieldLookupService.getFormDetails(forId);
			if (null != findMandetoryFieldsOfForm) {
				log.info("formdetails.getFormOwnerId() ===========> 1"
						+ findMandetoryFieldsOfForm.getFormOwnerId().toString());

				log.info("filed names are ==========> 2" + findMandetoryFieldsOfForm.getFormStructure().size());
				for (BeanFormStructure bs : findMandetoryFieldsOfForm.getFormStructure()) {
					bs.getFormField().getLookup_name();
					bs.getIsMandatory();
					if (bs.getIsMandatory() == 1) {
						mandetoryFieldSet.add(bs.getFormField().getLookup_name().trim());
					}
					if (!bs.getFormField().getLookup_name().equalsIgnoreCase("Page Title")) {
						normalFieldSet.add(bs.getFormField().getLookup_name().trim());
					}
				}
				log.info("return normalFieldSet is ==============> 3" + normalFieldSet.toString());
				log.info("return mandetoryfileldSet is ==============> 4" + mandetoryFieldSet.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (null != mapForFormData || !mapForFormData.isEmpty()) {
			for (Map.Entry<Integer, String> temp : mapForFormData.entrySet()) {
				String[] b = temp.getValue().split("$");
				int k = b[0].indexOf('$');
				String proofresult = b[0].substring(0, k);
				int m = proofresult.indexOf("=");
				String val = proofresult.substring(m + 1, k);
				String col = proofresult.substring(0, m);
				log.info("column = " + col + ", value = " + val);
				if (null == val || val.isEmpty() || val.equalsIgnoreCase("null") || val.equalsIgnoreCase("na")
						|| val.equalsIgnoreCase("n/a")) {
					setOfMandetoryFields.add(col.trim());
				}
				allFieldSetOfForm.add(col.trim());
			}
			log.info("Set of mandetory fields is =========> 5" + setOfMandetoryFields.toString());
			log.info("allFieldSetOfForm of fields is =========> 6" + allFieldSetOfForm.toString());
		}

		if (null != setOfMandetoryFields || !setOfMandetoryFields.isEmpty()) {
			log.info("Set of mandetory fields is =========> 7" + setOfMandetoryFields.toString());
			Iterator<String> setMandItr = setOfMandetoryFields.iterator();
			while (setMandItr.hasNext()) {
				String str = setMandItr.next();

				if (mandetoryFieldSet.contains(str)) {
					returnString = "false";
				}
			}
		} else {
			log.info("Set of upcoming fields is empty or null.");
		}
		log.info("allFieldSetOfForm of fields is =========> 8" + allFieldSetOfForm.toString());
		Iterator<String> normalFieldItr = normalFieldSet.iterator();
		while (normalFieldItr.hasNext()) {
			String str = normalFieldItr.next();
			log.info("normal field string is ::::::: "+str);
			if (!allFieldSetOfForm.contains(str)) {
				log.info("It is for finding field is in the upcoming set of all fields.");
				returnString = "false";
			}
		}

		return returnString;
	}

	// Use for Challan Process updation
	
	@RequestMapping(value = "/challanTxnStatusFromChallanSystem", method = { RequestMethod.POST, RequestMethod.GET })
	
	public @ResponseBody String challanTxnStatusFromChallanSystem(HttpServletRequest request)
			throws ParseException {
		log.info("received request ");

		String challanNumber = "NA";
		String spTxnId=null;
		String clientTxnId=null;
		String transStatus=null;
		String transDate=null;
		String totalAmount=null;
		String transPayMode="NA";
		
		if (null != request.getParameter("challanNumber")) {
			challanNumber = request.getParameter("challanNumber");
		}
		if (null != request.getParameter("spTxnId")) {
			spTxnId = request.getParameter("spTxnId");
		}
		if (null != request.getParameter("transStatus")) {
			transStatus = request.getParameter("transStatus");
		}
		if (null != request.getParameter("clientTxnId")) {
			clientTxnId = request.getParameter("clientTxnId");
		}
		if (null != request.getParameter("transDate")) {
			transDate = request.getParameter("transDate");
		}
		if (null != request.getParameter("totalAmount")) {
			totalAmount = request.getParameter("totalAmount");
		}
		if (null != request.getParameter("transPayMode")) {
			transPayMode = request.getParameter("transPayMode");
		}
		

		String returnResponse = "";
		log.info("open challanTxnStatusFromChallanSystem() method with all parameters sent by Challan system");
		try {
			if (spTxnId == null || clientTxnId == null || transStatus == null || transDate == null
					|| totalAmount == null || spTxnId.isEmpty() || clientTxnId.isEmpty() || transStatus.isEmpty()
					|| transDate.isEmpty() || totalAmount.isEmpty()) {

				log.info("Data have null or empty value please provide some data as per requirement");

				returnResponse = HttpStatus.NOT_ACCEPTABLE.toString();

			} else {
				log.info("clientTxnID is {" + clientTxnId + "}, spTxnId is {" + spTxnId + "}, challanNumber is {"
						+ challanNumber + "}, challan Payment Date is {" + transDate + "}, challanStatus is {"
						+ transStatus + "}, total paid amount is {" + totalAmount + "}");

				returnResponse = sampleTransService.fetchTransactionDetail(clientTxnId, spTxnId, challanNumber,
						transDate, transStatus, totalAmount, transPayMode);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			returnResponse = HttpStatus.UNPROCESSABLE_ENTITY.toString();
		}
		log.info("Returned response is for updation : " + returnResponse);
		return returnResponse;
	}

	// updateSpotChallanTransaction
	@RequestMapping(value = "/updateSpotChallanTransaction", method = { RequestMethod.POST, RequestMethod.GET })
	public String updateSpotChallanTransaction(HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info("spTransId=" + request.getParameter("spTransId"));
		sampleTransService.updateSpotChallanTransactionDao(request.getParameter("spTransId"));
		return "Success";
	}

	@RequestMapping(value = "/fetchTxnDataByTxnId", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String fetchTxnDataByTxnId(@RequestParam String txnId) {

		log.info("txnId is :::: " + txnId);
		String responce = "";
		FetchTransactionDetails fetchTxnDetail = new FetchTransactionDetails();
		try {
			fetchTxnDetail = sampleTransService.fetchTxnDetailsByTxnId(txnId);
			if (null != fetchTxnDetail) {
				responce = mapper.writeValueAsString(fetchTxnDetail);
			} else {
				responce = HttpStatus.NOT_FOUND.toString();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return responce;
	}

	public List<ArrayList<String>> getFullDataWithAl() {
		return fullDataWithAl;
	}

	public void setFullDataWithAl(List<ArrayList<String>> fullDataWithAl) {
		this.fullDataWithAl = fullDataWithAl;
	}

	public ArrayList<String> getFileterdRecordsVal() {
		return fileterdRecordsVal;
	}

	public void setFileterdRecordsVal(ArrayList<String> fileterdRecordsVal) {
		this.fileterdRecordsVal = fileterdRecordsVal;
	}

	public List<BeanFormDetails> getForms() {
		return forms;
	}

	public void setForms(List<BeanFormDetails> forms) {
		this.forms = forms;
	}

	public ArrayList<ArrayList<String>> getAplDetails() {
		return aplDetails;
	}

	public void setAplDetails(ArrayList<ArrayList<String>> aplDetails) {
		this.aplDetails = aplDetails;
	}

	public PayeerTargetMappingToClient getPayeerTargetMappingToClient() {
		return payeerTargetMappingToClient;
	}

	public void setPayeerTargetMappingToClient(PayeerTargetMappingToClient payeerTargetMappingToClient) {
		this.payeerTargetMappingToClient = payeerTargetMappingToClient;
	}

	public List<BeanFormDetails> getBeanFormDetailsList() {
		return beanFormDetailsList;
	}

	public void setBeanFormDetailsList(List<BeanFormDetails> beanFormDetailsList) {
		this.beanFormDetailsList = beanFormDetailsList;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getTransId() {
		return transId;
	}

	public void setTransId(String transId) {
		this.transId = transId;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public List<SampleTransBean> getPayerHistory() {
		return payerHistory;
	}

	public void setPayerHistory(List<SampleTransBean> payerHistory) {
		this.payerHistory = payerHistory;
	}

	public ArrayList<String> getFileterdRecordsHeaders() {
		return fileterdRecordsHeaders;
	}

	public void setFileterdRecordsHeaders(ArrayList<String> fileterdRecordsHeaders) {
		this.fileterdRecordsHeaders = fileterdRecordsHeaders;
	}

	public SampleTransBean getBeanTransData() {
		return beanTransData;
	}

	public void setBeanTransData(SampleTransBean beanTransData) {
		this.beanTransData = beanTransData;
	}

	public List<SampleTransBean> getTransData() {
		return transData;
	}

	public void setTransData(List<SampleTransBean> transData) {
		this.transData = transData;
	}

	public BeanFeeDetails getFee() {
		return fee;
	}

	public void setFee(BeanFeeDetails fee) {
		this.fee = fee;
	}

	public BeanFeeLookup getFeeLookup() {
		return feeLookup;
	}

	public void setFeeLookup(BeanFeeLookup feeLookup) {
		this.feeLookup = feeLookup;
	}

	public LoginBean getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(LoginBean loginUser) {
		this.loginUser = loginUser;
	}

	public List<BeanFeeLookup> getFeeLookupList() {
		return feeLookupList;
	}

	public void setFeeLookupList(List<BeanFeeLookup> feeLookupList) {
		this.feeLookupList = feeLookupList;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

}
