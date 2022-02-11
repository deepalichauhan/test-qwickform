package com.sabpaisa.qforms.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Set;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.communication.ElasticSendMailer;
import com.sabpaisa.qforms.communication.EmailSessionBean;
import com.sabpaisa.qforms.communication.SendSMSs;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.util.DBConnection;

@CrossOrigin
@Controller
@RequestMapping
public class BURDActionController {

	@Autowired
	private SampleFormService sampleFormService;

	@Autowired
	private SampleTransService sampleTransService;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	@Autowired
	private CollegeService collegeService;

	@Autowired
	SessionFactory factory;

	static Logger log = LogManager.getLogger(BURDActionController.class.getName());

	SampleTransBean beanTransData;
	private BeanFormDetails formDetails = new BeanFormDetails();
	private CollegeBean colBean = new CollegeBean();
	private LoginBean loginUser = new LoginBean();
	private Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
	private ArrayList<String> fileterdRecordsHeaders = new ArrayList<String>();
	private ArrayList<String> fileterdRecordsVal = new ArrayList<String>();
	File fileUpload;
	
	private Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
	private Map<Integer, List<String>> optionsMap2 = new HashMap<Integer, List<String>>();
	private List<String> txtfield = new ArrayList<String>();
	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	public SampleFormBean form = new SampleFormBean();
	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();
	
	ArrayList<SampleFormView> formViewData = new ArrayList();
	
	String formName = new String();
	ArrayList<String> columnNameList = new ArrayList<String>();
	private SampleFormBean beanFormData = new SampleFormBean();
	DBConnection connection = new DBConnection();

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String qFormsIP = properties.getProperty("qFormsIP");
	
	String uploadPath = properties.getProperty("qFormsImgFloderPath");
	
	
	@RequestMapping(value = "/processFormNewForBURD", method = RequestMethod.GET)
	public String prepareFormNewForBURD(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.info("bid {" + request.getParameter("bid") + "}, cid {" + request.getParameter("cid") + "}, formId {"
				+ request.getParameter("formid") + "}, " + "forminstanceid {" + request.getParameter("forminstanceid")
				+ "}, isFormBeingRevived {" + request.getParameter("isFormBeingRevived") + "}, formrevivalinstanceid {"
				+ request.getParameter("formrevivalinstanceid"));
		
		boolean staleCheckResult = checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
				request.getParameter("formid"), request.getParameter("forminstanceid"), ses);

		BeanPayerType beanPayerTypeN = new BeanPayerType();

		if (staleCheckResult) {

			block33: {
				log.info("staleCheckResult passes...");
				String isFormBeingRevived = request.getParameter("isFormBeingRevived") == null ? "N"
						: request.getParameter("isFormBeingRevived");
				String forminstanceid = request.getParameter("forminstanceid");
				String formInstanceIdFromRevivalRequest = request.getParameter("formrevivalinstanceid") == null ? ""
						: request.getParameter("formrevivalinstanceid");
				//log.info(("formInstanceIdFromRevivalRequest is::" + formInstanceIdFromRevivalRequest));
				ses.setAttribute("lpFlag", 1);
				String payerID = "";
				Date formSubmitDate = new Date();
				Date dobDate = new Date();
				try {
					SampleFormBean beanFormData = null;
					beanFormData = (SampleFormBean) ses.getAttribute("beanFormData");
					//log.info("Sampleformbean id for new filled data is :::::: " + beanFormData.getFormId());

					BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
					String formData = request.getParameter("values");
					//log.info("form data before Specific Chars removal, which found from view is:>" + formData);
					ses.setAttribute("FormDataForTrans", formData);
					int idx = formData.lastIndexOf(",");
					formData = formData.substring(0, idx);
					formData = formData.replaceAll("'", " ");
					formData = formData.replaceAll("/", "_");
					formData = formData.replaceAll("\\\\", "_");
					formData = formData.replaceAll("\\(", "-");
					formData = formData.replaceAll("\\)", "-");
					//log.info(("form data after Specific Chars removal is:>" + formData));
					Integer formTemplateId = (Integer) ses.getAttribute("currentFormId");
					formDetails = daoFieldLookupService.getFormDetails(formTemplateId);
					log.info("varification flag is ::: " + formDetails.getMoveToPg());
					ses.setAttribute("veriflag", formDetails.getMoveToPg());
					ses.setAttribute("veriflag1", formDetails.getHasInstructions());

					Integer formInstId = Integer.parseInt(ses.getAttribute("CollegeId").toString());
					Integer formFeeId = fee != null ? fee.getId() : null;
					Integer formApplicantId = 0;

					String code = request.getParameter("rccode");
					String name = beanFormData.getName();
					String email = beanFormData.getEmail();
					String contact = beanFormData.getContact();
					String dob = beanFormData.getDob();

					String payeeProfile = request.getParameter("payeeProfile");
					beanPayerTypeN = daoFieldLookupService.getPayerLookups(payeeProfile);
					payerID = beanPayerTypeN.getPayer_id().toString();
					
					log.info((":--PayerID--:" + payerID));
					Double amount = (Double) ses.getAttribute("feeAmt");
					log.info(("amount is::" + amount));
					String formFeeName = String.valueOf(formFeeId);
					log.info(("formFeeName after copying value from formFeeId is::" + formFeeName));

					String startDate = request.getParameter("rcStartDate");
					String endDate = request.getParameter("rcEndDate");
					if (amount == null && amount == 0.0) {
						amount = Double.parseDouble(ses.getAttribute("amt").toString());
					}
					log.info("Trans Amount is :::: " + amount.toString());
					
					dobDate = beanFormData.getDobDate();
					boolean payerVitalContactInfoRevised = false;
					try {
						if (formData != null && !"".equals(formData)) {
							formData = formData.replaceAll("[^\\p{ASCII}]", " ");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					String existingFormData = (beanFormData = (SampleFormBean) ses
							.getAttribute("sesCurrentFormData")) == null || beanFormData.getFormData() == null ? ""
									: beanFormData.getFormData();
					// log.info(("existing FormData is::" + existingFormData));
					if ("".equals(forminstanceid)) {
						log.info("case of first submission from client, either in regular flow or revival flow");
						if ("".equals(formInstanceIdFromRevivalRequest)) {
							log.info("case of regular flow first server hit");

							// Start 13 March 2019
							Map<Integer, String> formDataMap = new HashMap();
							// log.info(("Initial form is 1:-------------:" + formData.toString()));
							formDataMap = this.processFormData(formData, ses);
							for (Map.Entry<Integer, String> temp : formDataMap.entrySet()) {
								String[] b = temp.getValue().split("$");
								int k = b[0].indexOf('$');
								String proofresult = b[0].substring(0, k);
								int m = proofresult.indexOf("=");
								String val = proofresult.substring(m + 1, k);
								String col = proofresult.substring(0, m);

								if ((col.equals("AMOUNT") || col.equals("TOTAL AMOUNT")
										|| col.equals("Total_Payable_Amount")
										|| col.equals("TOTAL_PAYABLE_AMOUNT") || col.equals("Total Amount"))
										&& amount == 0.0) {
									// log.info("amount field values is 0.0 in if block and it set by amount new
									// field. ");
									amount = Double.parseDouble(val.toString());
									// log.info("new amount is :::::: "+amount.toString());
								}
							}

							// log.info(("form data after processForm is 2:-------------:" +
							// formDataMap.toString()));

							this.formViewData = this.processFormView(formDataMap, ses);

							// End 13 Mar 2019
							String formNumber = this.getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
									formTemplateId);

							beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
									formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
									startDate, endDate, code, payerID, formNumber);
							log.info("first server hit, saving forminstanceid to session ");
						} else {
							log.info("case of revival flow first server hit");

							beanFormData = sampleFormService
									.getFormData(Integer.valueOf(Integer.parseInt(formInstanceIdFromRevivalRequest)));
							beanFormData.setTransAmount(amount);
							log.info("updating formbean if details changed on the first screen");
							if (!beanFormData.getEmail().equals(email)) {
								payerVitalContactInfoRevised = true;
								beanFormData.setEmail(email);
							}
							if (!beanFormData.getContact().equals(contact)) {
								payerVitalContactInfoRevised = true;
								beanFormData.setContact(contact);
							}
							// log.info(("beanFormData.getDobDate() is::" + beanFormData.getDobDate()));
							// log.info(("dob from request is::" + dob));
							SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
							String formatted_date = formatter1.format(beanFormData.getDobDate());
							// log.info(("formatted_date from DB is::" + formatted_date));
							if (!dob.contentEquals(formatted_date)) {
								payerVitalContactInfoRevised = true;
								beanFormData.setDob(dob);
								if (!dobDate.equals("")) {
									beanFormData.setDobDate(dobDate);
								}
							}
							if (payerVitalContactInfoRevised) {
								String formNumber = this.getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
										formTemplateId);
								sampleFormService.deleteFormData((SampleFormBean) beanFormData);
								beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
										formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
										startDate, endDate, code, payerID, formNumber);
							}
						}
					} else {
						log.info("case of subsequent hits regular or revival flow");
						this.form.setFormData(formData);
						beanFormData = this.form;
						//log.info("beanFormData.getFormData(); :::::::::::::::::: " + beanFormData.getFormData());

						Map<Integer, String> formDataMap1 = new HashMap<Integer, String>();
						// log.info(("Initial form is 1:-------------:" + formData.toString()));
						formDataMap1 = this.processFormData(formData, ses);
						//log.info(("form data after processForm is 2:-------------:" + formDataMap1.toString()));

						ses.setAttribute("sesCurrentFormMap", formDataMap1);
						this.formViewData = this.processFormView(formDataMap1, ses);
						//log.info(("formViewData after processFormView is 2:-------------:" + formViewData.toString()));

						if (amount == null || amount == 0.0) {
							log.info("it is in if block for updating amoount field.");
							amount = Double.parseDouble(ses.getAttribute("amountField").toString());
						}
						log.info("Trans Amount is :::: " + amount.toString());

						if (!beanFormData.getEmail().equals(email)) {
							payerVitalContactInfoRevised = true;
							beanFormData.setEmail(email);
						}
						if (!beanFormData.getContact().equals(contact)) {
							payerVitalContactInfoRevised = true;
							beanFormData.setContact(contact);
						}
						// log.info(("beanFormData.getDobDate() is::" + beanFormData.getDobDate()));
						log.info(("dob from request is::" + dob));
						SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
						String formatted_date = formatter1.format(beanFormData.getDobDate());
						log.info(("formatted_date from DB is::" + formatted_date));
						
						beanFormData.setCode(code);
						beanFormData.setName(name);
						beanFormData.setTransAmount(amount);
						if (payerVitalContactInfoRevised) {
							String formNumber = this.getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
									formTemplateId);
							sampleFormService.deleteFormData((SampleFormBean) beanFormData);
							beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
									formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
									startDate, endDate, code, payerID, formNumber);
						}
						// log.info(("this.formviewdata after isempty checking :-------------:" +
						// this.formViewData));
					}
					//log.info("beanFormData >>>>>>>>>>>>>>>>>>>>>>>>>> {" + beanFormData.getFormData().toString() + "}");

					Map<Integer, String> formDataMap = new HashMap();

					if (this.formViewData.isEmpty()) {

						// log.info(("Initial form is 1:-------------:" + formData.toString()));
						formDataMap = this.processFormData(formData, ses);
						// log.info(("form data after processForm is 2:-------------:" +
						// formDataMap.toString()));

						this.formViewData = this.processFormView(formDataMap, ses);
					} else {
						log.info(("formViewData after processForm is 2:-------------:" + formViewData.toString()));
					}
					ses.setAttribute("sesCurrentFormMap", formDataMap);
					// log.info(("this.formviewdata after isempty checking :-------------:" +
					// this.formViewData));

					String photoExt = (String) ses.getAttribute("currentPhotoExt");
					byte[] pic = (byte[]) ses.getAttribute("currentPhoto");
					String signExt = (String) ses.getAttribute("currentSignatureExt");
					byte[] sign = (byte[]) ses.getAttribute("currentSignature");

					if (null != photoExt || null != signExt) {
						log.info("it is in if block for setup of photo and signature");
						beanFormData.setPhotograph(pic);
						beanFormData.setPhoto_ext(photoExt);
						beanFormData.setSignature(sign);
						beanFormData.setSignature_ext(signExt);
					} else {
						log.info("photo and signature is not uploaded.");
					}

					beanFormData = sampleFormService.saveFormData((SampleFormBean) beanFormData);
					ses.setAttribute("formViewData", formViewData);
					ses.setAttribute("sesCurrentFormData", beanFormData);
					ses.setAttribute("formInstanceId", String.valueOf(beanFormData.getFormId()));
					// log.info(("form instance id set to session with value::" +
					// beanFormData.getFormId()));
					String needToSendEmailToPayer = "N";
					if ("N".equals(isFormBeingRevived) && request.getParameter("submitShot").equals("fresh")) {
						needToSendEmailToPayer = "Y";
					}
					if ("Y".equals(isFormBeingRevived) && payerVitalContactInfoRevised) {
						needToSendEmailToPayer = "Y";
					}
					if ("Y".equals(needToSendEmailToPayer)) {
						try {
							this.NotifyPayerOfFormLink(beanFormData, false, request, ses);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					this.form = beanFormData;
					//log.info(("revival indicator is.::" + isFormBeingRevived));
					if (!"Y".equals(isFormBeingRevived))
						break block33;
					log.info("returning revivalsuccess");
					ses.setAttribute("formViewData", formViewData);
					ses.setAttribute("form", form);
					ses.setAttribute("formDetails", this.formDetails);
					return "formSummaryNewForLPProcessBURD";
				} catch (NullPointerException e) {
					e.printStackTrace();
					return "PaySessionOut";
				}
			}
		}
		log.info("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}
	
	
	
		//BU College Choice updation as subject wise 11 June 2019 by Praveen
		//http://localhost:8081/QwikForms/buCollegeChoiceUpdate?formid=4&bid=32&cid=2107&PayeeProfile=TestPayer9Feb
		
		@RequestMapping(value = "/buCollegeChoiceUpdate", method = { RequestMethod.POST, RequestMethod.GET })
		public String buCollegeChoiceUpdate(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) throws SQLException {
		
		
			log.info("inside buCollegeChoiceUpdate() Method ");
			String returnFlag = "";
			Integer cid = Integer.parseInt(request.getParameter("cid").toString());
			Integer bid = Integer.parseInt(request.getParameter("bid").toString());
			String payerProfile = request.getParameter("PayeeProfile");
	
			String dataForm_FormId = request.getParameter("formid");
	
			// log.info("DataForm FormId is :::::::::: " + dataForm_FormId.toString());
			// log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + "
			// ::::: payeeProfile is ::::::: "+ payerProfile);
			CollegeBean colBean = collegeService.getClientDetailsBasedOnId(cid);
			if (null != colBean) {
				log.info("colBean " + colBean.toString());
			}
			ses.setAttribute("CollegeBean", colBean);
			BeanFormDetails beanDataForm = sampleFormService
					.getFormDetails(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
			String fieldForValidate = null;
			fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
			String formStatus = beanDataForm.getStatus();
			// log.info("formTemplateId for DataFormDetails table :::::::::::::::: " +
			// fieldForValidate);
	
			if ((fieldForValidate != null && !fieldForValidate.equals("")) && formStatus.equals("APPROVED")) {
	
				returnFlag = "BUCollegeChoiceUpdate";
				//returnFlag = "Testingfile";
				log.info("first visit for validation");
				char[] symbolsString1 = new char[] {};
				StringBuilder tmp = new StringBuilder();
				char ch = 'a';
				while (ch <= 'g') {
					tmp.append(ch);
					char ch1 = 'a';
					while (ch1 <= 'd') {
						tmp.append(ch1);
						symbolsString1 = tmp.toString().toCharArray();
						ch1 = (char) (ch1 + '\u0001');
					}
					ch = (char) (ch + '\u0001');
				}
				double captNumber = 5.0 + Math.random() * 5.0;
				String genCapt = String.valueOf(captNumber).substring(2, 4);
				String ranGenString = symbolsString1.toString().substring(3, 7);
				String genAlphaNum = String.valueOf(ranGenString) + genCapt;
				log.info(("genAlphaNu is::" + genAlphaNum));
				ses.setAttribute("genAlphaNum", genAlphaNum);
			} else {
				request.setAttribute("errorMsg",
						"dose not matched form fild list for validation or form status is not approved. Please contact to your administrator.");
				returnFlag = "errorPage";
			}
			ses.setAttribute("bid", bid);
			ses.setAttribute("cid", cid);
			ses.setAttribute("payerProfile", payerProfile);
			ses.setAttribute("beanDataForm", beanDataForm);
			return returnFlag;
		}
		
		@RequestMapping(value = "/requestForUpdatedCollegeList", method = { RequestMethod.POST, RequestMethod.GET })
		public String requestForUpdatedCollegeList(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) throws ParseException, SQLException {
			
			log.info("inside requestForUpdatedCollegeList() Method ");
			String dynFieldData = request.getParameter("values");
			String captcha = request.getParameter("captchaByJsp");
			// String captcha=(String) ses.getAttribute("captchaValue");
			String matchCaptcha = (String) ses.getAttribute("captchaValue");
			String uName = "NA", spTxnId = "NA", sub = "NA",currentFormIdForSubject="NA",validateValue="NA";
			log.info("captcha value is :: " + request.getParameter("captchaByJsp") + " and hjvhh " + matchCaptcha);

			// log.info("dynFieldData is ::::::::::::::: " + dynFieldData);
			String returFlag = "";
			String returnFlag = "";
			Double amount = 0.0;

			Integer bid = (Integer) ses.getAttribute("bid");
			Integer cid = (Integer) ses.getAttribute("cid");

			String payeeProfile = (String) ses.getAttribute("payerProfile");
			log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "
					+ payeeProfile);
			ArrayList<String> columnNameList = new ArrayList<String>();
			BeanFormDetails beanDataForm = (BeanFormDetails) ses.getAttribute("beanDataForm");
			Integer formTempId = beanDataForm.getId();
			String clientCode = beanDataForm.getFormOwnerName();
			String lifeCycle = beanDataForm.getLife_cycle();

			log.info("formTempId is ::::::::::::::: " + formTempId + " ::::: ClientCode is ::::::: " + clientCode
					+ " ::::: lifeCycle is ::::::: " + lifeCycle);
			log.info("Table name for this formTempId is ::::::::::::::: " + "{zz_client_user_data_" + formTempId + "}");
			HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
			List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
			Map<String, Object> tableValueMap = new HashMap<String, Object>();
			String[] formFields = dynFieldData.split(",");
			// log.info(("formFields is ::::::::::::::: " + formFields.toString()));
			ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
			ArrayList<String> nameOfFields = new ArrayList<String>();
			List<String> list = new ArrayList<String>();
			// log.info(("formFieldsList is ::::::::::::::: " + formFieldsList.toString()));
			// log.info(("formFieldsList size is ::::::::::::::: " +
			// formFieldsList.size()));
			int i = 0;
			while (i < formFieldsList.size()) {
				String[] formFieldData = formFieldsList.get(i).split("~");
				// log.info("afetr spliting formFieldData values are ::::::::::::::::: " +
				// formFieldData[i].toString());
				if (formFieldData.length != 2) {
					log.info(("Form Field at index " + i + " is corrupt or unreadable"));
				} else {
					fieldMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
				}
				++i;
			}
			log.info("Before iteration values formDataMap >> " + fieldMap.toString());

			for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) {
				// log.info("Field Key is" + temp.getKey());
				// log.info("Field Value is" + temp.getValue());

				String[] b = temp.getValue().split("$");
				// log.info("value of b is " + b.toString());
				int k = b[0].indexOf('$');
				// log.info("value of k is " + k);
				String proofresult = b[0].substring(0, k);
				 log.info("String is in proofresult= " + proofresult);
				nameOfFields.add(proofresult);
				int l = proofresult.indexOf("=");
				validateValue = proofresult.substring(l + 2, proofresult.length() - 1);
				//log.info("String is in validateValue= " + validateValue);
			}

			if (null != nameOfFields && matchCaptcha.equals(request.getParameter("captchaByJsp"))) {
				log.info("Out of For Loop formFieldsList Field Value is" + nameOfFields + " ::::: CAPTCHA :::: " + captcha);
				aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId,clientCode,payeeProfile, ses);

				Boolean flag1 = false;
				flag1 = (Boolean) ses.getAttribute("listValueofMap");
				// log.info("flag1 value in controller ::::: "+flag1);
				ses.removeAttribute("captchaValue");
				if (flag1 == true) {
					log.info("Successful query and final result is by table ::::::::::: " + aliasToValue.toString());

					// flag1=true;
					tableValueMap = aliasToValue.get(0);
					// log.info("tableValueMap :::::: " + tableValueMap.toString());

					columnNameList = (ArrayList<String>) ses.getAttribute("clientDisplayFieldsList");
					ArrayList<String> columnNameList1 = (ArrayList<String>) ses.getAttribute("clientDisplayField");
					// log.info("columnNameList :::::: " + columnNameList.toString());
					// log.info("columnNameList1 :::::: " + columnNameList1.toString());

					ArrayList<String> listDataForm = new ArrayList<String>();

					String key = "";
					
						for (Map.Entry<String, Object> entry : tableValueMap.entrySet()) {
							
							if ((entry.getKey().equalsIgnoreCase("APPLICANT_NAME") || entry.getKey().equalsIgnoreCase("STUDENT_NAME")
									|| entry.getKey().equalsIgnoreCase("NAME"))	&& (uName == "NA")) {

								// log.info("Name field values is NA in if block and it set by name new field. ");
								uName = entry.getValue().toString();
								log.info("new uName is :::::: " + uName.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("SP_TXN_ID"))
									&& (spTxnId == "NA")) {

								// log.info("Name field values is NA in if block and it set by name new field. ");
								spTxnId = entry.getValue().toString();
								log.info("new uContact is :::::: " + spTxnId.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("SUBJECT")) && (sub == "NA")) {

								// log.info("dobDate field values is NA in if block and it set by name new field. ");
								sub = entry.getValue().toString();
								log.info("new DATE_OF_BIRTH is :::::: " + sub.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("CurrentFormIdForSubject")) 
									&& (currentFormIdForSubject == "NA")) {

								// log.info("Email field values is NA in if block and it set by name new field. ");
								currentFormIdForSubject = entry.getValue().toString();
								log.info("new uEmail is :::::: " + currentFormIdForSubject.toString());
							}
						}
					log.info("ApplicantName {" + uName + "}, SP_TXN_ID {" + spTxnId + "}, SUBJECT {" + sub + "}, CurrentFormIdForSubject {"
							+ currentFormIdForSubject + "}");

						returFlag = this.studentDetailForUpdation(nameOfFields, cid, bid, payeeProfile, currentFormIdForSubject, ses, request);
						if (returFlag == "RequestedsummaryForBURD") {
							return returFlag;
						} else {
							request.setAttribute("errorMsg",
									"Returned status is not matched as per given value. Please reenter your value and try again");
							return "errorPage";
						}
					} else {
						request.setAttribute("errorMsg",
								"Data is not saved properly please re-enter your validation values. Or Please contact to your administrator.");
						return "errorPage";
					}
				} else {
					log.info("It is in else block and send errorpage.");
					request.setAttribute("errorMsg",
							"Validate value is not matched or form status is not approved. Please contact to your administrator.");
					return "errorPage";
				}

		}
		
		//@RequestMapping(value = "/requestForUpdatedCollegeList", method = { RequestMethod.POST, RequestMethod.GET })
		public String studentDetailForUpdation(ArrayList<String> nameOfFields, Integer colId, Integer bankId, 
				String payerProfile, String currentFormIdForSubject, HttpSession ses, HttpServletRequest request) throws ParseException, SQLException {
			
			log.info("inside requestForUpdatedCollegeList() Method ");
			String uName = "NA", uContact = "NA", uEmail = "NA", dobDate = "NA";
			String returFlag = "";
			Double amount = 0.0;
			Integer bid = bankId;
			Integer cid = colId;
			String payeeProfile = payerProfile;
			log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "
					+ payeeProfile+" :::::::::: currentFormIdForSubject :::::::::::: "+currentFormIdForSubject);
			BeanFormDetails newFormBean = sampleFormService
					.getFormDetails(Integer.valueOf(Integer.parseInt(currentFormIdForSubject)));
			Integer formTempId = newFormBean.getId();
			String clientCode = newFormBean.getFormOwnerName();
			String lifeCycle = newFormBean.getLife_cycle();
			log.info("formTempId is ::::::::::::::: " + formTempId + " ::::: ClientCode is ::::::: " + clientCode
					+ " ::::: lifeCycle is ::::::: " + lifeCycle);
			log.info("Table name for this formTempId is ::::::::::::::: " + "{zz_client_user_data_" + formTempId + "}");
			ArrayList<String> columnNameList = new ArrayList<String>();
			HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
			List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
			Map<String, Object> tableValueMap = new HashMap<String, Object>();
			List<String> list = new ArrayList<String>();

			if (null != nameOfFields) {
				log.info("Out of For Loop formFieldsList Field Value is" + nameOfFields);
				aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId,clientCode,payeeProfile, ses);

				Boolean flag1 = false;
				flag1 = (Boolean) ses.getAttribute("listValueofMap");
				// log.info("flag1 value in controller ::::: "+flag1);
				ses.removeAttribute("captchaValue");
				if (flag1 == true) {
					log.info("Successful query and final result is by table ::::::::::: " + aliasToValue.toString());

					// flag1=true;
					tableValueMap = aliasToValue.get(0);
					// log.info("tableValueMap :::::: " + tableValueMap.toString());

					columnNameList = (ArrayList<String>) ses.getAttribute("clientDisplayFieldsList");
					ArrayList<String> columnNameList1 = (ArrayList<String>) ses.getAttribute("clientDisplayField");
					// log.info("columnNameList :::::: " + columnNameList.toString());
					// log.info("columnNameList1 :::::: " + columnNameList1.toString());

					ArrayList<String> listDataForm = new ArrayList<String>();

					String key = "";
					for (int j = 0; j < columnNameList.size(); j++) {
						String n = columnNameList.get(j);
						String m = columnNameList1.get(j);
						log.info("columnNameList " + n + " >> columnNameList " + m);
						for (Map.Entry<String, Object> entry : tableValueMap.entrySet()) {
							if (n.equals(entry.getKey()) && !entry.getKey().equals("Notification")
									&& !entry.getKey().equals("Page_Title")) {
								key = m + "=" + entry.getValue() + "$" + j;
								listDataForm.add(key);
							}
							// log.info("entry key >> "+entry.getKey().toString()+", entry value >>>
							// "+entry.getValue().toString());

							if ((entry.getKey().equalsIgnoreCase("APPLICANT_NAME") || entry.getKey().equalsIgnoreCase("STUDENT_NAME")
									|| entry.getKey().equalsIgnoreCase("NAME"))	&& (uName == "NA")) {

								// log.info("Name field values is NA in if block and it set by name new field.
								// ");
								uName = entry.getValue().toString();
								log.info("new uName is :::::: " + uName.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("CONTACT_NUMBER") || entry.getKey().equalsIgnoreCase("MOBILE_NUMBER"))
									&& (uContact == "NA")) {

								// log.info("Name field values is NA in if block and it set by name new field.
								// ");
								uContact = entry.getValue().toString();
								log.info("new uContact is :::::: " + uContact.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("DATE_OF_BIRTH") || entry.getKey().equalsIgnoreCase("DATE OF BIRTH")
									|| entry.getKey().equalsIgnoreCase("DOB")) && (dobDate == "NA")) {

								// log.info("dobDate field values is NA in if block and it set by name new
								// field. ");
								dobDate = entry.getValue().toString();
								log.info("new DATE_OF_BIRTH is :::::: " + dobDate.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("EMAIL") || entry.getKey().equalsIgnoreCase("EMAIL_ID")) 
									&& (uEmail == "NA")) {

								// log.info("Email field values is NA in if block and it set by name new field.
								// ");
								uEmail = entry.getValue().toString();
								log.info("new uEmail is :::::: " + uEmail.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("AMOUNT") || entry.getKey().equalsIgnoreCase("TOTAL_AMOUNT")
									|| entry.getKey().equalsIgnoreCase("Total_Payable_Amount")) && (amount == 0.0)) {

								// log.info("amount field values is 0.0 in if block and it set by amount new
								// field. ");
								amount = Double.parseDouble(entry.getValue().toString());
								log.info("new amount is :::::: " + amount.toString());
							}

						}
					}

					if (uName.equalsIgnoreCase("NA")) {
						uName = "Applicant";
					}
					if (uContact.equalsIgnoreCase("NA")) {
						uContact = "";
					}
					if (dobDate.equalsIgnoreCase("NA")) {
						dobDate = "01-02-2000";
					}
					if (uEmail.equalsIgnoreCase("NA")) {
						uEmail = "";
					}
					log.info("ApplicantName {" + uName + "}, Contact {" + uContact + "}, dobDate {" + dobDate + "}, EMAIL {"
							+ uEmail + "}, Amount {" + amount + "}");

					// log.info("listDataForm result is :: " + listDataForm.toString());
					String listData = String.join(",", listDataForm);
					// log.info("listData as String result is :: " + listData.toString());
					ArrayList<String> idAndStatus = new ArrayList<String>();
					String transId = null;
					String transStatus = null;
					Boolean flag = false;

					String fieldNames = String.join(" && ", nameOfFields);
					// log.info("fieldNames in form of string Field Value is" + fieldNames);

					transId = sampleFormService.getFormTransId(fieldNames, formTempId);
					transStatus = sampleFormService.getFormTransStatus(fieldNames, formTempId);

					if ((null != transStatus || "" != transStatus) || (null != transId || "" != transId)) {
						log.info("Transation status is ::::: " + transStatus.toString());
						log.info("Transation ID is ::::: " + transId.toString());
					}

					if (transStatus.equalsIgnoreCase("[success]")) {
						// log.info("now transid is "+transId.toString());
						request.setAttribute("errorMsg", "Form is completed successfully.");
						return "errorPage";
					} else {
						transId = "";
						flag = saveDataAsLPProcess(listData, newFormBean, amount, cid, ses, transId, uName, uContact,
								uEmail, dobDate);
					}

					if (flag == true) {
						ses.setAttribute("columnNameList", columnNameList);
						ses.setAttribute("columnNameList1", columnNameList1);
						ses.setAttribute("validateFieldNames", nameOfFields);
						ses.setAttribute("payerBeanMap", tableValueMap);
						ses.setAttribute("CollegeCode", clientCode);
						ses.setAttribute("lifeCycle", lifeCycle);
						ses.setAttribute("cid", cid);
						ses.setAttribute("bid", bid);
						ses.setAttribute("PayeeProfile", payeeProfile);
						ses.setAttribute("formTempId", formTempId);

						returFlag = this.showFormSummary(cid.toString(), bid.toString(), payeeProfile, nameOfFields, ses,
								request);
						if (returFlag == "RequestedsummaryForBURD") {
							return returFlag;
						} else {
							request.setAttribute("errorMsg",
									"dose not matched form fild list for validation or form status is not approved.");
							return "errorPage";
						}
					} else {
						request.setAttribute("errorMsg",
								"Data is not saved properly please re-enter your validation values. Or Please contact to your administrator.");
						return "errorPage";
					}
				} else {
					log.info("It is in else block and send errorpage.");
					request.setAttribute("errorMsg",
							"dose not matched form fild list for validation or form status is not approved. Please contact to your administrator.");
					return "errorPage";
				}

			} else {
				log.info("It is in else block and send errorpage.");
				request.setAttribute("errorMsg", "Captcha is not matched");
				return "errorPage";
			}
		}
		
		public Boolean saveDataAsLPProcess(String formData, BeanFormDetails beanFormDetails, Double amount, Integer cid,
				HttpSession ses, String transId, String uName, String uContact, String uEmail, String dobDate)
				throws ParseException {

			SampleFormBean beanFormData = new SampleFormBean();
			Integer formApplicantId = 0;
			Date formDate = new Date();
			String formDataValue = formData;
			log.info("formDataValue is :::: " + formDataValue);
			Integer formTemplateId = beanFormDetails.getId();
			Integer formFeeId = beanFormDetails.getFormFee().getId();
			Integer formInstId = beanFormDetails.getFormOwnerId();
			String formTransId = null;
			if (transId != null) {
				formTransId = transId;
			}
			Integer formClientId = cid;
			String formFeeName = formFeeId.toString();
			String contact = "NA";
			if (uContact != null) {
				contact = uContact;
			}
			Date udobDate = null;
			if (dobDate != null) {
				udobDate = new SimpleDateFormat("dd-MM-yyyy").parse(dobDate);
				;
			}
			String email = "NA";
			if (uEmail != null) {
				email = uEmail;
			}
			String formEndDate = "";
			String formStartDate = "";

			String name = "NA";
			if (uName != null) {
				name = uName;
			}
			Double amt = 0.0;

			if (amount != 0.0) {
				amt = amount;
			}
			log.info("storable transaction amount is ::::: " + amt.toString());
			String code = "null";
			String formNumber = this.getGenerateFormNumber(formClientId, formTemplateId);
			String payerId = beanFormDetails.getPayer_type().toString();

			log.info("all values are :::: " + formApplicantId + ", " + formData + ", " + formTemplateId + ", " + formFeeId
					+ ", " + formClientId + ", " + formFeeName + ", " + formEndDate + ", " + formStartDate + ", "
					+ formNumber);
			try {
				beanFormData = new SampleFormBean(formData, formTemplateId, formDate, formInstId, formApplicantId,
						formFeeId, name, udobDate, email, contact, amt, formFeeName, formStartDate, formEndDate, code,
						payerId, formNumber);
				this.beanFormData = sampleFormService.saveFormData((SampleFormBean) beanFormData);
				ses.setAttribute("beanFormData", this.beanFormData);
				if (null != this.beanFormData) {
					return true;
				} else {
					return false;
				}
			} catch (NullPointerException np) {
				np.printStackTrace();
				return false;
			}

		}

		public String showFormSummary(String cid1, String bid1, String payeeProfile, ArrayList<String> nameOfFields,
				HttpSession ses, HttpServletRequest request) {

			log.info("inside getPayerForms1() Method ");
			String returnFlag = "";
			
			String revisedEntereddob = "";
			String formid = "";
			String cid = "";
			String bid = "";
			String payerProfile = ""; // request.getParameter("PayeeProfile")

			SampleFormBean formDataBean = new SampleFormBean();

			try {
				ses.setAttribute("authVerified", "data_enterd");
			
				cid = cid1;
				bid = bid1;
				payerProfile = payeeProfile;
				log.info("cid is ::::::::::::::: {" + cid + "}, bid is ::::::::: {" + bid + "}, payerprofile is ::::::::: {"
						+ payerProfile + "}");

				ses.setAttribute("bid", Integer.parseInt(bid));
				ses.setAttribute("cid", Integer.parseInt(cid));

				this.colBean = collegeService.validateCollegeAndBank(Integer.valueOf(cid), Integer.valueOf(bid));
				this.colBean.setCollegeCode(this.colBean.getCollegeCode());
				ses.setAttribute("PayeeProfile", payerProfile);
				ses.setAttribute("CollegeId", this.colBean.getCollegeId());
				ses.setAttribute("CollegeBean", this.colBean);
				ses.setAttribute("BankId", this.colBean.getBankDetailsOTM().getBankId());
				this.beanFormData = (SampleFormBean) ses.getAttribute("beanFormData");

				formid = this.beanFormData.getFormId().toString();

				log.info(("formid is.." + formid));
				ses.setAttribute("formInstanceId", formid);
				this.form = sampleFormService.getFormData(Integer.valueOf(Integer.parseInt(formid)));
				Double amount = this.form.getTransAmount();
				ses.setAttribute("feeAmt", amount);
				log.info(("amount set to session deriving from original form is::" + ses.getAttribute("feeAmt")));

				if (null != this.form.getFormNumber() && null != nameOfFields) {
					log.info("usr provided correct dob , mobile");
					log.info("The detais provided are correct");
					ses.setAttribute("authVerified", "verified");

				} else {
					request.setAttribute("msg", "The detais provided are incorrect");
					log.info("The detais provided are incorrect");
					ses.setAttribute("authVerified", "authentication_failed");
				}
				if (ses.getAttribute("authVerified").equals("authentication_failed")) {
					request.setAttribute("msg", "The detais provided are incorrect");
					returnFlag = "PayerFormForLP";
					log.info("The detais provided are incorrect");
					ses.invalidate();
				} else {
					log.info("usr provided correct dob , mobile");
					log.info("The detais provided are correct");
					ses.setAttribute("authVerified", "verified");

					this.formsList = sampleFormService.getFormList(formid, "formid");
					log.info(("form id is:" + formid));
					ses.setAttribute("formid", formid);
					log.info(("Form Data ::" + this.formsList.get(0).getFormData()));
					this.form = this.formsList.get(0);

					String payerFormData = this.form.getFormData();
					log.info(("payerFormData is::" + payerFormData));
					int formtemplateid = this.form.getFormTemplateId();
					log.info(("formtemplateid is" + formtemplateid));
					ses.setAttribute("currentFormId", formtemplateid);
					if (this.form.getFormTransId() != null && !"".equals(this.form.getFormTransId())) {
						log.info("form was submitted earlier, so expired");
						request.setAttribute("msg", "The Form Link has expired since the form was submitted!");
						returnFlag = "PayerFormBasedAuthentication";
					} else {
						this.formDetails = sampleFormService.getFormDetails(formtemplateid);
						this.SetOptionsMap(this.formDetails, ses);
						this.SetOptionsMapforPayer(this.formDetails, ses);
						log.info(("form name is ::" + this.formDetails.getFormName()));
						ArrayList al = new ArrayList(this.formDetails.getFormStructure());
						Collections.sort(al);
						this.formDetails.setStructureList(al);
						log.info(("structureList size is " + al.size()));
						int i = 0;
						while (i < this.formDetails.getStructureList().size()) {
							BeanFormStructure formStructure = (BeanFormStructure) this.formDetails.getStructureList()
									.get(i);
							log.info(("formStructure id is::" + formStructure.getId()));
							log.info(("formStructure field order is::" + formStructure.getFieldOrder()));
							++i;
						}
						char[] symbolsString1 = new char[] {};
						StringBuilder tmp = new StringBuilder();
						char ch = 'a';
						while (ch <= 'g') {
							tmp.append(ch);
							char ch1 = 'a';
							while (ch1 <= 'd') {
								tmp.append(ch1);
								symbolsString1 = tmp.toString().toCharArray();
								ch1 = (char) (ch1 + '\u0001');
							}
							ch = (char) (ch + '\u0001');
						}
						double captNumber = 5.0 + Math.random() * 5.0;
						String genCapt = String.valueOf(captNumber).substring(2, 4);
						String ranGenString = symbolsString1.toString().substring(3, 7);
						String genAlphaNum = String.valueOf(ranGenString) + genCapt;
						log.info(("genAlphaNu is::" + genAlphaNum));
						ses.setAttribute("genAlphaNum", genAlphaNum);
						this.payerFormDataMap = this.processFormData(this.formsList.get(0).getFormData(), ses);
						log.info("Before Iteration payerFormDataMap " + payerFormDataMap.toString() + "");
						Set<Integer> setOfKeys = this.payerFormDataMap.keySet();
						for (Integer key : setOfKeys) {
							String value = this.payerFormDataMap.get(key);
							log.info(("Key: " + key + ", Value: " + value));

							String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
							log.info(("Revised Value is: " + revisedValue));
							this.payerFormDataMap.put(key, revisedValue);
						}
						log.info("After Iteration payerFormDataMap value is ::::: " + payerFormDataMap.toString() + "");

						ses.setAttribute("feeAmt", this.formDetails.getFormFee().getFeeBaseAmount());
						ses.setAttribute("currentFee", this.formDetails.getFormFee());
						ses.setAttribute("formDetails", this.formDetails);
						ses.setAttribute("payerFormDataMap", this.payerFormDataMap);
						ses.setAttribute("form", this.form);

						log.info("after the call to getHistoricalFormsListForPayer");
						if (this.colBean.getCollegeCode().equals("PCI99")) {
							returnFlag = "temptoDelete";
						} else {
							returnFlag = "RequestedsummaryForBURD";
						}
						request.setAttribute("feeFieldCount", this.GetFeeFields(this.formDetails));
					}

				}
			} catch (NullPointerException e) {
				e.printStackTrace();

			}
			return returnFlag;
		}

		private String getGenerateFormNumber(Integer client, Integer formTemplateId) {
			int randomInt = 0;
			Random randomGenerator = new Random();
			int idx = 1;
			while (idx <= 6) {
				randomInt = randomGenerator.nextInt(1000000);
				++idx;
			}
			String DateString = new SimpleDateFormat("MMddyyhhmmss").format(new Date());
			log.info((" date digits are::" + DateString));
			String formNumber = formTemplateId + DateString + randomInt;
			log.info((" form number is::" + formNumber));
			return formNumber;
		}

		private Integer GetFeeFields(BeanFormDetails formdetails) {
			Integer count = 0;
			ArrayList struct = new ArrayList();
			try {
				struct = new ArrayList(formdetails.getFormStructure());
				int i = 0;
				while (i < struct.size()) {
					String fieldtype = ((BeanFormStructure) struct.get(i)).getFormField().getLookup_type();
					if (fieldtype.contentEquals("Radio Button Group") || fieldtype.contentEquals("Select Box")
							|| fieldtype.contentEquals("Multiplier")) {
						count = count + 1;
					}
					++i;
				}
				log.info(("optionsfieldcount is" + count));
				return count;
			} catch (Exception e) {
				return count;
			}
		}
		
		private void SetOptionsMapforPayer(BeanFormDetails form, HttpSession ses) {
			HashMap<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
			BeanFieldLookup field = new BeanFieldLookup();
			if (form.getId() == null) {
				return;
			}
			ArrayList structures = new ArrayList(form.getFormStructure());
			int i = 0;
			while (i < structures.size()) {
				field = ((BeanFormStructure) structures.get(i)).getFormField();
				if (field.getLookup_type().contentEquals("Select Box") || field.getLookup_type().contentEquals("Multiplier")
						|| field.getLookup_type().contentEquals("Radio Button Group")) {
					ArrayList<String> options = new ArrayList<String>();
					String optionsStr = ((BeanFormStructure) structures.get(i)).getFieldValues();
					String[] optionsArr = optionsStr.split(",");
					int j = 0;
					while (j < optionsArr.length) {
						options.add(optionsArr[j].split("=")[0]);
						++j;
					}
					optionMap.put(((BeanFormStructure) structures.get(i)).getId(), options);
				}
				++i;
			}

			this.optionsMap2 = optionMap;
			ses.setAttribute("optionsMap2", this.optionsMap2);
		}

		private void SetOptionsMap(BeanFormDetails form, HttpSession ses) {
			HashMap<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
			BeanFieldLookup field = new BeanFieldLookup();
			if (form.getId() == null) {
				return;
			}
			ArrayList structures = new ArrayList(form.getFormStructure());
			int i = 0;
			while (i < structures.size()) {
				field = ((BeanFormStructure) structures.get(i)).getFormField();
				if (field.getLookup_type().contentEquals("Select Box") || field.getLookup_type().contentEquals("Multiplier")
						|| field.getLookup_type().contentEquals("Radio Button Group")) {
					ArrayList<String> options = new ArrayList<String>();
					String optionsStr = ((BeanFormStructure) structures.get(i)).getFieldValues();
					String[] optionsArr = optionsStr.split(",");
					int j = 0;
					while (j < optionsArr.length) {
						options.add(optionsArr[j]);
						++j;
					}
					optionMap.put(((BeanFormStructure) structures.get(i)).getId(), options);
				}
				++i;
			}
			this.optionsMap = optionMap;
			ses.setAttribute("OptionsMap", this.optionsMap);
		}
		
		public Map<Integer, String> processFormData(String formDataRaw, HttpSession ses) {
			log.info("Start of processFormData(), formDataRaw >> " + formDataRaw);
			String[] remValOfequal = null;
			String[] remVal = null;
			String remtst = null;
			CollegeBean nitjbean = (CollegeBean) ses.getAttribute("CollegeBean");
			Map<Integer, String> formDataMap = new HashMap<Integer, String>();
			String[] formFields = formDataRaw.split(",");
			ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		

			int i = 0;
			while (i < formFieldsList.size()) {
				String[] formFieldData = formFieldsList.get(i).split("~");
				log.info("afetr spliting formFieldData values are ::::::::::::::::: " + formFieldData.toString());
				if (formFieldData.length != 2) {
					log.info(("Form Field at index " + i + " is corrupt or unreadable"));
				} else {
					if (nitjbean.getCollegeCode().contentEquals("NITJS")
							&& ((remValOfequal = formFieldData[1].split("="))[0].contentEquals("Department")
									|| remValOfequal[0].contentEquals("Semester")
									|| remValOfequal[0].contentEquals("Roll Number"))) {
						remVal = remValOfequal[1].split("$");
						remtst = remValOfequal[1].split("\\$")[0];
						try {
							ses.setAttribute(remValOfequal[0], remtst);
							log.info(("Department/Sem value:" + remVal[0] + ":--:" + remtst));
						} catch (NullPointerException ex) {
							ex.printStackTrace();
						}
					}
					if (nitjbean.getCollegeCode().contentEquals("SSNC1")
							&& ((remValOfequal = formFieldData[1].split("="))[0].contentEquals("College Roll Number")
									|| remValOfequal[0].contentEquals("Course"))) {
						remVal = remValOfequal[1].split("$");
						remtst = remValOfequal[1].split("\\$")[0];
						try {
							ses.setAttribute(remValOfequal[0], remtst);
							log.info(("Department/Sem value:" + remVal[0] + ":--:" + remtst));
						} catch (NullPointerException ex) {
							ex.printStackTrace();
						}
					}
					if (nitjbean.getCollegeCode().contentEquals("CHSE")
							&& ((remValOfequal = formFieldData[1].split("="))[0].contentEquals("Category")
									|| remValOfequal[0].contentEquals("Regn. No. (for office use only) "))) {
						remVal = remValOfequal[1].split("$");
						remtst = remValOfequal[1].split("\\$")[0];
						try {
							ses.setAttribute(remValOfequal[0], remtst);
							log.info((String.valueOf(remtst) + ":------------------: values is"));
							if (formFieldData[1].contentEquals("Category=Empty$0")) {
								formFieldData[1] = "Category=Readmission in Correspondence Course - 2nd Year$0";
							}
							if (formFieldData[1].contentEquals("Regn. No. (for office use only) =Empty$24")) {
								formFieldData[1] = "Regn. No. (for office use only)=CHSE BBSR/BER/SBP/BPD__________________________/16$24";
							}
							log.info((String.valueOf(formFieldData[0]) + " :-------: " + formFieldData[1]));
						} catch (NullPointerException ex) {
							ex.printStackTrace();
						}
					}
					formDataMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
				}
				++i;
			}

		
			return formDataMap;
		}
		
		@RequestMapping(value = "/getFormsBasedOnClientReportForBURD", method = { RequestMethod.POST, RequestMethod.GET })
		public String getAllTransactionsReportForBURD(Model model, HttpServletRequest request, HttpSession ses) {

			String forDownload = request.getParameter("ForDownLoad");
			String serviceId = request.getParameter("serviceId");
			log.info("service id on getAllTransactionsReport " + serviceId);
			this.loginUser = (LoginBean) ses.getAttribute("loginUserBean");
			Integer cid = (Integer) ses.getAttribute("CollegeId");
			this.loginUser = (LoginBean) ses.getAttribute("loginUserBean");
			log.info((Object) ("testing user name:" + this.loginUser.getUserName()));
			this.forms = new ArrayList<BeanFormDetails>(
					this.daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(this.loginUser));
			for (BeanFormDetails bean : this.forms) {
				log.info((Object) ("testing the form Name:" + bean.getFormName()));
			}
			log.info((Object) ("testing the size:" + this.forms.size()));
			ses.setAttribute("forms",this.forms);
			if (this.loginUser.getProfile().contentEquals("Operator")) {
				return "Applicant-Operator-Reports";
			}
			return "ReportsBURD";

		}
		
		@RequestMapping(value = "/ApplicantReportsForAllClientsForBURD", method = { RequestMethod.POST, RequestMethod.GET })
		public String getAllApplicantClientsReportsForBURD(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) throws ParseException, SQLException

		{
			try {
				getAllTransactionsReportForBURD(model, request, ses);
			} catch (Exception e) {
				e.printStackTrace();
			}
			log.info((Object) "I am in filter ");
			List<ArrayList<String>> fullDataWithAl = new ArrayList<ArrayList<String>>();
			String forDownLoad = request.getParameter("ForDownLoad");
			Object checkval = null;
			boolean sequenceCount = false;
			String formId = request.getParameter("formId");
			
			request.setAttribute("reqFormId", (Object) formId);
			
			log.info((Object) ("Choosen Form iD is " + formId));
			BeanFormDetails bFormDetail=new BeanFormDetails();
			bFormDetail=sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
			
			log.info("Form name is as subject :::::: "+bFormDetail.getFormName());
			this.fileterdRecordsVal = sampleTransService.filterTheRecordBasedOnFormNameForBURD(formId);
			
			log.info((Object) ("val: " + this.fileterdRecordsVal.size()+", Its resulting value is ::::: "+this.fileterdRecordsVal.toString()));
			
			ses.setAttribute("formName", bFormDetail.getFormName());
			ses.setAttribute("fileterdRecordsHeaders", this.fileterdRecordsHeaders);
			ses.setAttribute("fullDataWithAl", this.fileterdRecordsVal);
			
			log.info((Object) ("final full:" + fullDataWithAl));
			return "ReportsBURD";
		}
		
		@RequestMapping(value = "/validateFieldFormForBURD", method = { RequestMethod.POST, RequestMethod.GET })
		public String callValidationFormForBurd(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) {

			log.info("inside callValidationForm() Method ");
			String returnFlag = "";
			
			Integer cid = Integer.parseInt(request.getParameter("cid").toString());
			Integer bid = Integer.parseInt(request.getParameter("bid").toString());
			String payerProfile = request.getParameter("PayeeProfile");

			String dataForm_FormId = request.getParameter("formid");

			
			CollegeBean colBean = collegeService.getClientDetailsBasedOnId(cid);
			if (null != colBean) {
				log.info("colBean " + colBean.toString());
			}
			ses.setAttribute("CollegeBean", colBean);
			BeanFormDetails beanDataForm = sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
			String fieldForValidate = null;
			fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
			String formStatus = beanDataForm.getStatus();
			

			if ((fieldForValidate != null && !fieldForValidate.equals("")) && formStatus.equals("APPROVED")) {

				returnFlag = "PayerFormForLP";
				log.info("first visit for validation");
				char[] symbolsString1 = new char[] {};
				StringBuilder tmp = new StringBuilder();
				char ch = 'a';
				while (ch <= 'g') {
					tmp.append(ch);
					char ch1 = 'a';
					while (ch1 <= 'd') {
						tmp.append(ch1);
						symbolsString1 = tmp.toString().toCharArray();
						ch1 = (char) (ch1 + '\u0001');
					}
					ch = (char) (ch + '\u0001');
				}
				double captNumber = 5.0 + Math.random() * 5.0;
				String genCapt = String.valueOf(captNumber).substring(2, 4);
				String ranGenString = symbolsString1.toString().substring(3, 7);
				String genAlphaNum = String.valueOf(ranGenString) + genCapt;
				log.info(("genAlphaNu is::" + genAlphaNum));
				ses.setAttribute("genAlphaNum", genAlphaNum);
			} else {
				request.setAttribute("errorMsg",
						"dose not matched form fild list for validation or form status is not approved. Please contact to your administrator.");
				returnFlag = "errorPage";
			}
			ses.setAttribute("bid", bid);
			ses.setAttribute("cid", cid);
			ses.setAttribute("payerProfile", payerProfile);
			ses.setAttribute("beanDataForm", beanDataForm);
			return returnFlag;
		}
		
		private boolean checkStaleSession(String bid, String cid, String formtempid, String forminstanceid,
				HttpSession ses) {
			boolean checkResult = true;
			Integer sesBid = (Integer) ses.getAttribute("BankId");
			Integer sesCid = (Integer) ses.getAttribute("CollegeId");
			Integer formTemplateIdFromSession = (Integer) ses.getAttribute("currentFormId");
			String formInstanceIdFromSession = ses.getAttribute("formInstanceId") == null ? ""
					: (String) ses.getAttribute("formInstanceId");

			
			log.info(("formTemplateIdFromSession is" + formTemplateIdFromSession));
			log.info(("formInstanceIdFromSession is" + formInstanceIdFromSession));
			log.info(("String.valueOf(sesBid) is evaluated to" +
			String.valueOf(sesBid))); log.info(("String.valueOf(sesCid) is evaluated to"
			+ String.valueOf(sesCid))); log.info(("cid from client request is:---:" +
			cid)); log.info(("bid from client request is:---:" + bid));
			log.info(("form template id from client request is:--:" + formtempid));
			log.info(("form instance id from client request is:---:" + forminstanceid));
			 

			if (sesBid != null && !String.valueOf(sesBid).equals(bid)) {
				checkResult = false;
				log.info(
						"ummmm, the session is not valid, courtesy the user having started a new session...bids do not match");
			}
			if (sesCid != null && !String.valueOf(sesCid).equals(cid)) {
				checkResult = false;
				log.info(
						"ummmm, the session is not valid, courtesy the user having started a new session...cids do not match");
			}
			if (formtempid != null && !String.valueOf(formTemplateIdFromSession).equals(formtempid)) {
				checkResult = false;
				log.info(
						"ummmm, the session is not valid, courtesy the user having continued with the form template in the expired session...form templates do not match");
			}
			if (!(forminstanceid == null || forminstanceid.equals("") || forminstanceid.equals("null")
					|| "".equals(formInstanceIdFromSession) || formInstanceIdFromSession.equals(forminstanceid))) {
				checkResult = false;
				log.info(
						"ummmm, the session is not valid, courtesy the user having continued with the form instance in the expired session...form instance ids do not match");
			}
			if (checkResult) {
				log.info("all is well, the session is active...");
			}
			return checkResult;
		}
		
		private ArrayList<SampleFormView> processFormView(Map<Integer, String> formDataMap, HttpSession ses) {
			ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
			Double amount = 0.0;
			log.info("processing form");
			ArrayList<Integer> keySet = new ArrayList<Integer>(formDataMap.keySet());

			int i = 0;
			// log.info("key set is :: "+keySet.toString());
			while (i < keySet.size()) {
				String[] formFieldValue = formDataMap.get(keySet.get(i)).split("=");

				String fieldKey = keySet.get(i).toString();
				String fieldValue = formFieldValue[0].toString();
				String str = "Amount", str1 = "Total Amount";
				// log.info("fieldKey in loop is ::: "+fieldKey);
				// log.info("formFieldValue[0].toString() in loop is ::: "+fieldValue+",
				// formFieldValue[1].toString()"+formFieldValue[1].toString());
				if (formFieldValue.length != 2) {
					log.info("Form Field Value corrupt or Unreadable");
				} else {
					SampleFormView formViewData = new SampleFormView();
					String[] valueAndOrder = formFieldValue[1].split("\\$");
					// log.info(("value is " + formFieldValue[1] + "and next array is " +
					// valueAndOrder[0]));

					// log.info("fieldValue is "+fieldValue);

					if (fieldValue.equals("AMOUNT") || fieldValue.equals("Total Amount") || fieldValue == "Total Amount"
							|| fieldValue == "AMOUNT" || fieldValue.equals("Total_Payable_Amount")
							|| fieldValue.equals("TOTAL_PAYABLE_AMOUNT")) {
						// if(fieldValue=="Total Amount" || fieldValue=="AMOUNT"){ 
						log.info("It is in for Final Amount is for payment");
						amount = Double.parseDouble(valueAndOrder[0].toString());
					}
					log.info("Final Amount is for payment :::: " + amount.toString());
					formViewData.setLabel(formFieldValue[0]);
					formViewData.setValue(valueAndOrder[0]);
					try {
						formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim())));
					} catch (ArrayIndexOutOfBoundsException e) {
						formViewData.setOrder(Integer.valueOf(i));
					}
					formViewList.add(formViewData);
				}
				++i;
			}
			log.info("Final Amount is for payment :::: " + amount.toString());
			ses.setAttribute("amountField", amount);
			Collections.sort(formViewList);
			return formViewList;
		}
		
		private void NotifyPayerOfFormLink(SampleFormBean beanCurrentForm, boolean payerCredRequired,
				HttpServletRequest request, HttpSession ses) throws InvalidKeyException, NoSuchAlgorithmException,
				InvalidKeySpecException, InvalidAlgorithmParameterException, UnsupportedEncodingException,
				IllegalBlockSizeException, BadPaddingException {
			
			StringBuffer url = request.getRequestURL();
			//log.info(("request url is::" + url));
			String uri = request.getRequestURI();
			String ctx = request.getContextPath();
			//log.info(("ctx::" + ctx));
			String urlPath = String.valueOf(url.substring(0, url.length() - uri.length() + ctx.length())) + "/";
			//log.info(("urlPath :: >>> " + urlPath));

			String urlFormLink = String.valueOf(urlPath) + "getPayerFormsById?formid=" + beanCurrentForm.getFormId()
					+ "&bid=" + ses.getAttribute("BankId") + "&cid=" + ses.getAttribute("CollegeId") + "&PayeeProfile="
					+ ses.getAttribute("PayeeProfile");
			log.info(("urlFormLink :: >>> " + urlFormLink));

			EmailSessionBean mailSender = new EmailSessionBean();
			String msg = "You have pending forms to complete! " + urlFormLink;
			SendSMSs.sendSMS(beanCurrentForm.getContact(), msg);
			new Thread(() -> {
				log.info("Sending Email to Payer " + beanCurrentForm.getEmail() + "  " + beanCurrentForm.getDob() + " "
						+ beanCurrentForm.getDobDate());
				
				ElasticSendMailer.Send(beanCurrentForm.getEmail(), "You have pending forms to complete!", urlFormLink,
						beanCurrentForm.getName(), beanCurrentForm.getEmail(), beanCurrentForm.getContact());
				log.info("mail sent ");
			}).start();
		}
		
}