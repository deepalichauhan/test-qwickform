package com.sabpaisa.qforms.controller;

import java.io.File;
import java.io.IOException;
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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanSubjectLookup;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.beans.SheetFillingBeanForBu;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.BurdDao;
import com.sabpaisa.qforms.services.BurdService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.PasswordEncryption;

@CrossOrigin
@Controller
@RequestMapping
public class BURDActionControllerNew {

	@Autowired
	private SampleFormService sampleFormService;
	
	@Autowired
	private BurdService burdService;

	@Autowired
	private CollegeService collegeService;
	
	@Autowired
	private LoginDAOService loginDAOService;
	
	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	@Autowired
	SessionFactory factory;

	static Logger log = LogManager.getLogger(BURDActionControllerNew.class.getName());

	SampleTransBean beanTransData;
	private BeanFormDetails formDetails = new BeanFormDetails();
	private CollegeBean colBean = new CollegeBean();
	
	private Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
	
	
	File fileUpload;
	
	private Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
	private Map<Integer, List<String>> optionsMap2 = new HashMap<Integer, List<String>>();
	public SampleFormBean form = new SampleFormBean();
	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();
	private LoginBean loginBean=new LoginBean();
	private ArrayList<SampleFormView> formViewData = new ArrayList();
	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	String formName = new String();
	ArrayList<String> columnNameList = new ArrayList<String>();
	private SampleFormBean beanFormData = new SampleFormBean();
	DBConnection connection = new DBConnection();

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String qFormsIP = properties.getProperty("qFormsIP");
	//cidForMaxFilledSeat1=2344
	String BU1014SeatFill=properties.getProperty("cidForMaxFilledSeat1");
	String uploadPath = properties.getProperty("qFormsImgFloderPath");
	
	@RequestMapping(value = { "/loginBUClient" }, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loginBUClient(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		ModelAndView mav = null;
		ses = request.getSession();

		mav = new ModelAndView("LoginDetailsForBUClient");

		return mav;
	}
	
	
	@RequestMapping(value = { "/clientLoginForBUClient" }, method = { RequestMethod.POST })
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public ModelAndView clientLoginForBUClient(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession httpSession, @ModelAttribute("loginBean") LoginBean loginbean) throws InvalidKeyException,
			NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException,
			UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {

		ModelAndView mav = null;
		loginBean = loginbean;
		
		log.debug("user Name is ::" + loginBean.getUserName());
		log.debug("Password is ::" + loginBean.getPassword());
		String encryptedPwd = null;
		mav = new ModelAndView("InvalidUserPage");
		// to Encrypt Password
		PasswordEncryption.encrypt(String.valueOf(loginBean.getPassword()));
		encryptedPwd = PasswordEncryption.encStr;
		loginBean.setPassword(encryptedPwd);
		log.debug("testing :" + encryptedPwd);
		String profile = null;
		try {
			profile = loginDAOService.getDetailsOfLoginUser(loginBean);
			log.debug("Profile is " + profile);
			if (profile == null) {
				httpSession.setAttribute("loginSuccess", false);
				httpSession.removeAttribute("loginUserBean");
				httpSession.removeAttribute("CollegeBean");
				request.setAttribute("msg", "Invalid Username or Password");
				return mav;
			}
		} catch (java.lang.IndexOutOfBoundsException e) {
			request.setAttribute("msg", "Invalid Username or Password");
			return mav;
		}
		try {

			if (null != profile) {
				log.debug("user Name is ::" + loginBean.getUserName());
				log.debug("Password is ::" + loginBean.getPassword());
				log.debug("valid User name and Password");
				httpSession.setAttribute("loginSuccess", true);
				Cookie usercookie = new Cookie("userName", loginBean.getUserName());
				usercookie.setMaxAge(60 * 1);
				response.addCookie(usercookie);
				httpSession.setAttribute("cart_init", 0);
				Object loginUserId = loginDAOService.getIdOFLoginUser(profile, loginBean);
				log.debug("loginUserId is in LoginActionController ::::::::::: " + loginUserId.toString()
						+ " :: and profile is :::::: " + profile.toString());
				
				colBean = collegeService.viewCollegeDetail(Integer.parseInt(loginUserId.toString()));
				mav = new ModelAndView("adminDashForBUClient");
				log.debug("Valid College");
				httpSession.setAttribute("sesProfile", "Institute");
				httpSession.setAttribute("CollegeId", colBean.getCollegeId());
				httpSession.setAttribute("CollegeBean", colBean);
				httpSession.setAttribute("loginUserBean", colBean.getLoginBean());
				log.debug("BEFORE GETTING BEAN ");
				return mav;
				
			}
		} catch (java.lang.NullPointerException e) {
			request.setAttribute("msg", "Session Time Out");

			return mav;
		}
		return mav;
	}
	
	@RequestMapping(value = "/adminDashForBUClien", method = RequestMethod.GET)
	public String adminDash(Model model) {
		return "adminDashForBUClient";
	}
	
	@RequestMapping(value = { "/logOutUserForBU" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String logOutUserForBU(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession,
			Model model) throws IOException {

		loginBean = (LoginBean) httpSession.getAttribute("loginUserBean");

		response.setHeader("Cache-Control", "no-cache, no-store");
		response.setDateHeader("Expires", 0);
		response.setHeader("Vary", "*");
		httpSession.removeAttribute("loginBean");
		httpSession.removeAttribute("sesProfile");
		httpSession.removeAttribute("dashLink");
		httpSession.removeAttribute("cart_init");
		httpSession.removeAttribute("CollegeBean");
		request.setAttribute("redirectLink", "LoginDetailsForBUClient.jsp");

		return "LoginDetailsForBUClient";
	}
	
	
		//BU Sheet filling process 25 May 2019 by Praveen
		//http://localhost:8081/QwikForms/buSheetFillingProcess1?formid=46&bid=1&cid=2344&PayeeProfile=payer
		
		@RequestMapping(value = "/buSheetFillingProcess1", method = { RequestMethod.POST, RequestMethod.GET })
		public String buSheetFillingProcess1(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) throws SQLException {
		
			Integer cid=null,bid=null;
			String payerProfile=null,formId=null;
			String formStatus = null, returnFlag = null;
			
			if(null!=ses.getAttribute("linkPassFieldNames")) {
				ses.removeAttribute("linkPassFieldNames");
			}
									
			if(null!=request.getParameter("cid") || null!=request.getParameter("bid") || null!=request.getParameter("formid")) {
			 cid = Integer.parseInt(request.getParameter("cid").toString());
			 bid = Integer.parseInt(request.getParameter("bid").toString());
			 payerProfile = request.getParameter("PayeeProfile");
			 formId = request.getParameter("formid");
			}else {
				request.setAttribute("errorMsg",
						"Please back to main page and refresh it for further process");
				return "errorPage";
			}

			if(null!=cid && null!=bid && null != formId) {
				CollegeBean colBean = collegeService.getClientDetailsBasedOnId(cid);
				if (null != colBean) {
					log.debug("colBean " + colBean.toString());
				}
				ses.setAttribute("CollegeBean", colBean);
				BeanFormDetails beanDataForm = sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
				String fieldForValidate = null;
				fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
				formStatus = beanDataForm.getStatus();
	
				if ((fieldForValidate != null && !fieldForValidate.equals("")) && formStatus.equals("APPROVED")) {
	
					returnFlag = "BUSheetFillingProcess";
				} else {
					request.setAttribute("errorMsg",
							"Form status is not approved for working. Please contact to your administrator for approving the form.");
					returnFlag = "errorPage";
				}
				ses.setAttribute("bid", bid);
				ses.setAttribute("cid", cid);
				ses.setAttribute("payerProfile", payerProfile);
				ses.setAttribute("beanDataForm", beanDataForm);
				return returnFlag;
			}else {
				request.setAttribute("errorMsg",
						"Please back to main page and refresh it for further process");
				return "errorPage";
			}
		}
		
		@RequestMapping(value = "/requestedForUpdatedSheet", method = { RequestMethod.POST, RequestMethod.GET })
		public String requestedForUpdatedSheet(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) throws ParseException, SQLException {
			log.debug("inside requestedClientDetailsForBURD() Method ");
			
			ArrayList<String> columnNameList = new ArrayList<String>();
			HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
			List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
			Map<String, Object> tableValueMap = new HashMap<String, Object>();
			ArrayList<String> nameOfFieldsForBU = new ArrayList<String>();
			List<String> list = new ArrayList<String>();
			String linkPass=null;
			String approvedCollegeName="NA",subject="NA",totalGradePoint="NA",studentRank="NA",college_category="NA";
			String returFlag = "";
			
			String dynFieldData = request.getParameter("values");
			
			Integer bid = (Integer) ses.getAttribute("bid");
			Integer cid = (Integer) ses.getAttribute("cid");

			String payeeProfile = (String) ses.getAttribute("payerProfile");
			log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "
					+ payeeProfile);
			
			BeanFormDetails beanDataForm = (BeanFormDetails) ses.getAttribute("beanDataForm");
			Integer formTempId = beanDataForm.getId();
			String clientCode = beanDataForm.getFormOwnerName();

			log.info("formTempId is ::::::::::::::: " + formTempId + " ::::: ClientCode is ::::::: " + clientCode);
			
			String[] formFields = dynFieldData.split(",");
			ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
			
			int i = 0;
			while (i < formFieldsList.size()) {
				String[] formFieldData = formFieldsList.get(i).split("~");
				if (formFieldData.length != 2) {
					log.debug(("Form Field at index " + i + " is corrupt or unreadable"));
				} else {
					fieldMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
				}
				++i;
			}
			log.debug("Before iteration values formDataMap >> " + fieldMap.toString());

			for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) {
				String[] b = temp.getValue().split("$");
				int k = b[0].indexOf('$');
				String proofresult = b[0].substring(0, k);
				nameOfFieldsForBU.add(proofresult);
				int l = proofresult.indexOf("=");
				linkPass = proofresult.substring(l + 2, proofresult.length() - 1);
				log.info("String is in linkPass= " + linkPass);
			}
			
			if (null != nameOfFieldsForBU) {
				aliasToValue = sampleFormService.colNameColValue(nameOfFieldsForBU, formTempId,clientCode,payeeProfile, ses);
				Boolean flag1 = false;
				flag1 = (Boolean) ses.getAttribute("listValueofMap");
				ses.removeAttribute("captchaValue");
				if (flag1 == true) {
					log.debug("Successful query and final result is by table ::::::::::: " + aliasToValue.toString());
					tableValueMap = aliasToValue.get(0);

					for (Map.Entry<String, Object> entry : tableValueMap.entrySet()) {
						log.debug("entry.getKey() ::::::::: "+entry.getKey());
							if (entry.getKey().equalsIgnoreCase("Student_Rank") && studentRank.equals("NA")){
								studentRank = entry.getValue().toString();
								log.debug("new studentRank is :::::: " + studentRank.toString());
							}
							if (entry.getKey().equalsIgnoreCase("Approved_College_Name") && approvedCollegeName.equals("NA")){
								approvedCollegeName = entry.getValue().toString();
								log.debug("new approvedCollegeName is :::::: " + approvedCollegeName.toString());
							}
							if (entry.getKey().equalsIgnoreCase("SELECT_METHOD_SUBJECT") && subject.equals("NA")) {
								subject = entry.getValue().toString();
								log.debug("new subject is :::::: " + subject.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("TOTAL_GRADE_POINT")) && (totalGradePoint.equalsIgnoreCase("NA"))) {
								totalGradePoint = entry.getValue().toString();
								log.debug("new totalGradePoint is :::::: " + totalGradePoint);
							}
							
						}
					}

					college_category=burdService.getCollegeCategoryForMain(nameOfFieldsForBU, formTempId);
					log.info("college Category for main form of bu :::: "+college_category);
				
					log.info(" approvedCollegeName {"+approvedCollegeName+"}, subject {"+subject
							+"}, totalGradePoint {"+totalGradePoint +"}, studentRank {"+studentRank 
							+"}, college_category {"+college_category +"}");
					
					Integer approvedCid=burdService.getApprovedCollegeCode(approvedCollegeName);

					log.info("approvedCid for given college name is :: " + approvedCid.toString());
					
					Integer selectSubjectId=burdService.getSelectSubjectId(subject);

					log.info("selectSubjectId for given subject name is :: " + selectSubjectId.toString());
					
					ses.setAttribute("approvedCid", approvedCid);
					ses.setAttribute("selectSubjectId", selectSubjectId);
					ses.setAttribute("college_category", college_category);
					
					SheetFillingBeanForBu sfBeanForBu=new SheetFillingBeanForBu();
					sfBeanForBu=burdService.getAllSubjectFilledSheetDetail(college_category, approvedCid, selectSubjectId);
					log.info("SheetFillingBeanForBu is :::::: "+sfBeanForBu.toString());
					log.info("SheetFillingBeanForBu is :::::: "+sfBeanForBu.getCollege_Category());
					ArrayList<String> idAndStatus = new ArrayList<String>();
					String transId = null;
					String transStatus = null;
					
					String fieldNames = String.join(" && ", nameOfFieldsForBU);

					//transId = sampleFormService.getFormTransId(fieldNames, formTempId);
					//transStatus = sampleFormService.getFormTransStatus(fieldNames, formTempId);

					//if ((null != transStatus || "" != transStatus) || (null != transId || "" != transId)) {
						//log.debug("Transation status is ::::: " + transStatus.toString());
						//log.debug("Transation ID is ::::: " + transId.toString());
					//}

					//if (transStatus.equalsIgnoreCase("[success]")) {
						//request.setAttribute("errorMsg", "Form is completed successfully.");
						//return "errorPage";
					//}
						ses.setAttribute("linkPassFieldNames", linkPass);
						ses.setAttribute("subject", subject);
						ses.setAttribute("approvedCollegeName", approvedCollegeName);
						ses.setAttribute("sfBeanForBu", sfBeanForBu);
						ses.setAttribute("cid", cid);
						ses.setAttribute("bid", bid);
						ses.setAttribute("PayeeProfile", payeeProfile);
						ses.setAttribute("formTempId", formTempId);
						ses.setAttribute("nameOfFieldForBU", nameOfFieldsForBU);
						return "BUSheetFillingProcess";
				} else {
					log.info("It is in else block and send errorpage.");
					request.setAttribute("errorMsg",
							"Field value is not matched please enter correct value in validated fields.");
					return "errorPage";
				}
		}
		
		
		@RequestMapping(value = "/requestedClientDetailsForBURD1", method = { RequestMethod.POST, RequestMethod.GET })
		public String requestedClientDetailsForBURD(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) throws ParseException, SQLException {
			log.debug("inside requestedClientDetailsForBURD1() Method ");
			String uName = "NA", uContact = "NA", uEmail = "NA", dobDate = "NA",approvedCollegeName="NA",subject="NA",totalGradePoint="NA";
			String returFlag = "";
			Double amount = 0.0;

			Integer bid = (Integer) ses.getAttribute("bid");
			Integer cid = (Integer) ses.getAttribute("cid");
			
			Integer approvedCid=null,subjectId=null;
			if(null!=ses.getAttribute("approvedCid") || null!=ses.getAttribute("selectSubjectId")) {
				approvedCid=(Integer) ses.getAttribute("approvedCid");
				subjectId=(Integer) ses.getAttribute("selectSubjectId");
				log.info("approvedCid {"+approvedCid+"} subjectId {"+subjectId+"}");
			}
			
			String payeeProfile = (String) ses.getAttribute("payerProfile");
			log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "+ payeeProfile);
			ArrayList<String> columnNameList = new ArrayList<String>();
			BeanFormDetails beanDataForm = (BeanFormDetails) ses.getAttribute("beanDataForm");
			Integer formTempId = beanDataForm.getId();
			String clientCode = beanDataForm.getFormOwnerName();
			String lifeCycle = beanDataForm.getLife_cycle();

			log.debug("formTempId is ::::::::::::::: " + formTempId + " ::::: ClientCode is ::::::: " + clientCode
					+ " ::::: lifeCycle is ::::::: " + lifeCycle);
			log.info("Table name for this formTempId is ::::::::::::::: " + "{zz_client_user_data_" + formTempId + "}");
			HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
			List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
			Map<String, Object> tableValueMap = new HashMap<String, Object>();
			ArrayList<String> nameOfFields =  (ArrayList<String>)ses.getAttribute("nameOfFieldForBU");
			List<String> list = new ArrayList<String>();

			if (null != nameOfFields) {
				log.info("Out of For Loop formFieldsList Field Value is" + nameOfFields);
				aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId,clientCode,payeeProfile, ses);

				Boolean flag1 = false;
				flag1 = (Boolean) ses.getAttribute("listValueofMap");
				// log.debug("flag1 value in controller ::::: "+flag1);
				ses.removeAttribute("captchaValue");
				if (flag1 == true) {
					log.debug("Successful query and final result is by table ::::::::::: " + aliasToValue.toString());
					tableValueMap = aliasToValue.get(0);
					// log.debug("tableValueMap :::::: " + tableValueMap.toString());
					columnNameList = (ArrayList<String>) ses.getAttribute("clientDisplayFieldsList");
					ArrayList<String> columnNameList1 = (ArrayList<String>) ses.getAttribute("clientDisplayField");
					ArrayList<String> listDataForm = new ArrayList<String>();

					String key = "";
					for (int j = 0; j < columnNameList.size(); j++) {
						String n = columnNameList.get(j);
						String m = columnNameList1.get(j);
						log.debug("columnNameList " + n + " >> columnNameList " + m);
						for (Map.Entry<String, Object> entry : tableValueMap.entrySet()) {
							if (n.equals(entry.getKey()) && !entry.getKey().equals("Notification")
									&& !entry.getKey().equals("Page_Title")) {
								key = m + "=" + entry.getValue() + "$" + j;
								listDataForm.add(key);
							}

							if ((entry.getKey().equalsIgnoreCase("APPLICANT_NAME") || entry.getKey().equalsIgnoreCase("STUDENT_NAME")
									|| entry.getKey().equalsIgnoreCase("NAME")) && (uName == "NA")) {

								uName = entry.getValue().toString();
								log.debug("new uName is :::::: " + uName.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("CONTACT_NUMBER") || entry.getKey().equalsIgnoreCase("MOBILE_NUMBER"))
									&& (uContact == "NA")) {

								uContact = entry.getValue().toString();
								log.debug("new uContact is :::::: " + uContact.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("DATE_OF_BIRTH") || entry.getKey().equalsIgnoreCase("DATE OF BIRTH")
									|| entry.getKey().equalsIgnoreCase("DOB") || entry.getKey().equalsIgnoreCase("dob")) && (dobDate == "NA")) {

								dobDate = entry.getValue().toString();
								log.debug("new DATE_OF_BIRTH is :::::: " + dobDate.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("EMAIL") || entry.getKey().equalsIgnoreCase("EMAIL_ID")) 
									&& (uEmail == "NA")) {

								uEmail = entry.getValue().toString();
								log.debug("new uEmail is :::::: " + uEmail.toString());
							}
							if ((entry.getKey().equalsIgnoreCase("AMOUNT") || entry.getKey().equalsIgnoreCase("TOTAL_AMOUNT")
									|| entry.getKey().equalsIgnoreCase("Total_Payable_Amount")) && (amount == 0.0)) {

								amount = Double.parseDouble(entry.getValue().toString());
								log.debug("new amount is :::::: " + amount.toString());
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
							+ uEmail + "}, Amount {" + amount + "}, approvedCollegeName {"+approvedCollegeName+"}, subject {"+subject
							+"}, totalGradePoint {"+totalGradePoint+"}");
					
					String listData = String.join(",", listDataForm);
					ArrayList<String> idAndStatus = new ArrayList<String>();
					
					Boolean flag = false;

					String fieldNames = String.join(" && ", nameOfFields);
				
					//String transId = null;
					//String transStatus = null;
					//transId = sampleFormService.getFormTransId(fieldNames, formTempId);
					//transStatus = sampleFormService.getFormTransStatus(fieldNames, formTempId);

					//if ((null != transStatus || "" != transStatus) || (null != transId || "" != transId)) {
						//log.debug("Transation status is ::::: " + transStatus.toString());
						//log.debug("Transation ID is ::::: " + transId.toString());
					//}

					//if (transStatus.equalsIgnoreCase("[success]")) {
						//request.setAttribute("errorMsg", "Form is completed successfully.");
						//return "errorPage";
					//} else {
						//transId = "";
						//flag = saveDataAsLPProcess(listData, beanDataForm, amount, cid, ses, transId, uName, uContact,
						//		uEmail, dobDate);
					//}

					//if (flag == true) {
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
						ses.setAttribute("subjectId", subjectId);
						ses.setAttribute("approvedCid", approvedCid);
						
						returFlag = showFormSummary(beanDataForm, listData, amount, cid.toString(), bid.toString(), payeeProfile, nameOfFields, ses,
								request);
						
						if (returFlag == "RequestedPayerFormRevivalForBU") {
							return returFlag;
						} else {
							request.setAttribute("errorMsg",
									"dose not matched form fild list for validation or form status is not approved.");
							return "errorPage";
						}
					//} else {
						//request.setAttribute("errorMsg",
							//	"Data is not saved properly please re-enter your validation values. Or Please contact to your administrator.");
						//return "errorPage";
					//}
				} else {
					log.debug("It is in else block and send errorpage.");
					request.setAttribute("errorMsg",
							"dose not matched related entered value in validated field. Please enter correct value.");
					return "errorPage";
				}

			} else {
				log.debug("It is in else block and send errorpage.");
				request.setAttribute("errorMsg", "Entered value or Captcha is not matched");
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
			log.debug("formDataValue is :::: " + formDataValue);
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
			log.debug("storable transaction amount is ::::: " + amt.toString());
			String code = "null";
			String formNumber = this.getGenerateFormNumber(formClientId, formTemplateId);
			String payerId = beanFormDetails.getPayer_type().toString();

			log.debug("all values are :::: " + formApplicantId + ", " + formData + ", " + formTemplateId + ", " + formFeeId
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
		
		private String getGenerateFormNumber(Integer client, Integer formTemplateId) {
			int randomInt = 0;
			Random randomGenerator = new Random();
			int idx = 1;
			while (idx <= 6) {
				randomInt = randomGenerator.nextInt(1000000);
				++idx;
			}
			String DateString = new SimpleDateFormat("MMddyyhhmmss").format(new Date());
			log.debug((" date digits are::" + DateString));
			String formNumber = formTemplateId + DateString + randomInt;
			log.debug((" form number is::" + formNumber));
			return formNumber;
		}
		
		public String showFormSummary(BeanFormDetails dataFormBean, String formData, Double amount, String cid1, String bid1, String payeeProfile, ArrayList<String> nameOfFields,
				HttpSession ses, HttpServletRequest request) {

			log.debug("inside getPayerForms1() Method ");
			String returnFlag = "";
			String formid = "";
			String cid = "";
			String bid = "";
			String payerProfile = "";
			formDetails = new BeanFormDetails();
			payerFormDataMap = new HashMap<Integer, String>();
			SampleFormBean formDataBean = new SampleFormBean();
			
			try {
				ses.setAttribute("authVerified", "data_enterd");
			
				cid = cid1;
				bid = bid1;
				payerProfile = payeeProfile;
				log.debug("cid is ::::::::::::::: {" + cid + "}, bid is ::::::::: {" + bid + "}, payerprofile is ::::::::: {"
						+ payerProfile + "}");

				//ses.setAttribute("bid", Integer.parseInt(bid));
				//ses.setAttribute("cid", Integer.parseInt(cid));

				colBean = collegeService.validateCollegeAndBank(Integer.valueOf(cid), Integer.valueOf(bid));
				colBean.setCollegeCode(colBean.getCollegeCode());
				ses.setAttribute("PayeeProfile", payerProfile);
				ses.setAttribute("CollegeId", colBean.getCollegeId());
				ses.setAttribute("CollegeBean", colBean);
				ses.setAttribute("BankId", colBean.getBankDetailsOTM().getBankId());
				//this.beanFormData = (SampleFormBean) ses.getAttribute("beanFormData");

				//formid = this.beanFormData.getFormId().toString();

				//log.debug(("formid is.." + formid));
				//ses.setAttribute("formInstanceId", formid);
				//formDataBean = sampleFormService.getFormData(Integer.valueOf(Integer.parseInt(formid)));
				
				Double paidAmount = amount;
				ses.setAttribute("feeAmt", amount);
				if (null == nameOfFields) {
					request.setAttribute("msg", "The detais provided are incorrect");
					returnFlag = "BUSheetFillingProcess";
					ses.invalidate();
				} else {
					ses.setAttribute("authVerified", "verified");
				
					//this.formsList = sampleFormService.getFormList(formid, "formid");
					//log.debug(("form id is:" + formid));
					//ses.setAttribute("formid", formid);
					//log.debug(("Form Data ::" + this.formsList.get(0).getFormData()));
					//this.form = this.formsList.get(0);

					String payerFormData = formData;
					log.info(("payerFormData is::" + payerFormData));
					int formtemplateid = dataFormBean.getId();
					log.info(("formtemplateid is" + formtemplateid));
				
					ses.setAttribute("currentFormId", formtemplateid);
					
						formDetails = sampleFormService.getFormDetails(formtemplateid);
						SetOptionsMap1(formDetails, ses);
						SetOptionsMapforPayer1(formDetails, ses);
						log.info(("form name is ::" + formDetails.getFormName()));
						ArrayList al = new ArrayList(formDetails.getFormStructure());
						Collections.sort(al);
						formDetails.setStructureList(al);
						log.debug(("structureList size is " + al.size()));
						int i = 0;
						while (i < formDetails.getStructureList().size()) {
							BeanFormStructure formStructure = (BeanFormStructure) formDetails.getStructureList()
									.get(i);
							log.debug(("formStructure id is::" + formStructure.getId()));
							log.debug(("formStructure field order is::" + formStructure.getFieldOrder()));
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
						log.debug(("genAlphaNu is::" + genAlphaNum));
						ses.setAttribute("genAlphaNum", genAlphaNum);
						
						payerFormDataMap = processFormData1(payerFormData, ses);
						
						Set<Integer> setOfKeys = payerFormDataMap.keySet();
						for (Integer key : setOfKeys) {
							String value = payerFormDataMap.get(key);
							log.debug(("Key: " + key + ", Value: " + value));

							String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
							log.debug(("Revised Value is: " + revisedValue));
							payerFormDataMap.put(key, revisedValue);
						}
						log.debug("After Iteration payerFormDataMap value is ::::: " + payerFormDataMap.toString() + "");

						ses.setAttribute("feeAmt", formDetails.getFormFee().getFeeBaseAmount());
						ses.setAttribute("currentFee", formDetails.getFormFee());
						ses.setAttribute("formDetails", formDetails);
						ses.setAttribute("payerFormDataMap", payerFormDataMap);
						ses.setAttribute("paidAmount", paidAmount);
						//ses.setAttribute("form", form);

						log.debug("after the call to getHistoricalFormsListForPayer");
						returnFlag = "RequestedPayerFormRevivalForBU";
						
						request.setAttribute("feeFieldCount", GetFeeFields1(formDetails));
					

				}
			} catch (NullPointerException e) {
				e.printStackTrace();

			}
			return returnFlag;
		}
		
		private Integer GetFeeFields1(BeanFormDetails formdetails) {
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
				log.debug(("optionsfieldcount is" + count));
				return count;
			} catch (Exception e) {
				return count;
			}
		}
		
		private void SetOptionsMapforPayer1(BeanFormDetails form, HttpSession ses) {
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

			optionsMap2 = optionMap;
			ses.setAttribute("optionsMap2", optionsMap2);
		}

		private void SetOptionsMap1(BeanFormDetails form, HttpSession ses) {
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
			optionsMap = optionMap;
			ses.setAttribute("OptionsMap", optionsMap);
		}
		
		public Map<Integer, String> processFormData1(String formDataRaw, HttpSession ses) {
			log.debug("Start of processFormData(), formDataRaw >> " + formDataRaw);
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
				log.debug("afetr spliting formFieldData values are ::::::::::::::::: " + formFieldData.toString());
				if (formFieldData.length != 2) {
					log.debug(("Form Field at index " + i + " is corrupt or unreadable"));
				} else {
					formDataMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
				}
				++i;
			}
			return formDataMap;
		}
		
		@RequestMapping(value = "/getFormsBasedOnClientReportForBUClient", method = { RequestMethod.POST, RequestMethod.GET })
		public String getFormsBasedOnClientReportForBUClient(Model model, HttpServletRequest request, HttpSession ses) {
			if(null!=ses.getAttribute("subjectName") || null!=ses.getAttribute("filledSeat")|| null!=ses.getAttribute("maxSeatN")) {
				ses.removeAttribute("subjectName");
				ses.removeAttribute("filledSeat");
				ses.removeAttribute("maxSeatN");
			}
			List<String> collegeNameList = new ArrayList<String>();
			loginBean = (LoginBean) ses.getAttribute("loginUserBean");
			Integer cid = (Integer) ses.getAttribute("CollegeId");
			log.debug("current College Id is :::: "+cid);
			loginBean = (LoginBean) ses.getAttribute("loginUserBean");
			log.debug((Object) ("testing user name:" + this.loginBean.getUserName()));
			
			
			if(cid==Integer.parseInt(BU1014SeatFill)) {
				log.debug("College Id by Property file is 1:::: "+Integer.parseInt(BU1014SeatFill));
				collegeNameList=burdService.getCollegeNameListByTempTable();
				log.debug("College Name list is ::::: "+collegeNameList.toString());
			}
			ses.setAttribute("collegeNameList", collegeNameList);
			log.debug("College Name list is ::::: "+collegeNameList.toString());
			List<BeanSubjectLookup> subjectList = new ArrayList<BeanSubjectLookup>();
			String forDownload = request.getParameter("ForDownLoad");
			String serviceId = request.getParameter("serviceId");
			log.debug("service id on getAllTransactionsReport " + serviceId);
			subjectList = new ArrayList<BeanSubjectLookup>(burdService.getAllSubjectNamesBasedOnClient());
			
			ses.setAttribute("subjectList",subjectList);
			if(cid==Integer.parseInt(BU1014SeatFill)) {
				log.debug("College Id by Property file is 2:::: "+Integer.parseInt(BU1014SeatFill));
				return "ReportsBURDMain";
			}
			return "ReportsBURD";
		}
		
		@RequestMapping(value = "/ApplicantReportsForAllClientsForBUClient", method = { RequestMethod.POST, RequestMethod.GET })
		public String ApplicantReportsForAllClientsForBUClient(Model model, HttpServletRequest request, HttpServletResponse response,
				HttpSession ses) throws ParseException, SQLException{
			
			if(null!=ses.getAttribute("subjectName") || null!=ses.getAttribute("filledSeat")|| null!=ses.getAttribute("maxSeatN")) {  
				ses.removeAttribute("subjectName");
				ses.removeAttribute("filledSeat");
				ses.removeAttribute("maxSeatN");
				
			}
			try {
				getFormsBasedOnClientReportForBUClient(model, request, ses);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String returnFlag=null;
			BeanSubjectLookup bSubjectDetail=new BeanSubjectLookup();
			List<SheetFillingBeanForBu> seatList=new ArrayList<SheetFillingBeanForBu>();
			List<BeanSubjectLookup> subjectList = new ArrayList<BeanSubjectLookup>();
			//CollegeBean cBeanForBU=new CollegeBean();
			Integer clientIdForBU=null;
			Integer filledSeat=null;
			Integer maxSeat=null;
			String subId = request.getParameter("subId");
			String colName = request.getParameter("colName");
			
			Integer cid = (Integer) ses.getAttribute("CollegeId");
			log.debug("college id for final report of bu is "+cid);
			
			if(cid!=Integer.parseInt(BU1014SeatFill)) {
				//SheetFillingBeanForBu
				request.setAttribute("reqFormId", (Object) subId);
				
				log.debug((Object) ("Choosen Subject ID is " + subId));
				
				bSubjectDetail=burdService.getSubjectData(Integer.valueOf(Integer.parseInt(subId)));
				log.debug("Form name is as subject :::::: "+bSubjectDetail.getSubject_name());
				filledSeat=burdService.getSeatDetailAsSubjectWise(Integer.valueOf(Integer.parseInt(subId)),cid,ses);
				maxSeat=(Integer)ses.getAttribute("maxSeat");
				
				ses.setAttribute("subjectName", bSubjectDetail.getSubject_name());
				ses.setAttribute("filledSeat", filledSeat);
				ses.setAttribute("maxSeatN", maxSeat);
				
				returnFlag = "ReportsBURD";
			}else {
				log.debug((Object) ("Choosen College Name is " + colName));
				clientIdForBU=burdService.getApprovedCollegeCode(colName);
				log.debug("ClientId for BU Client is ::::: "+clientIdForBU);
				seatList=burdService.getSubjectDetailSeatList(clientIdForBU);
				log.debug("getSubjectDetailSeatList for BU Client is ::::: "+seatList.toString());
				subjectList = new ArrayList<BeanSubjectLookup>(burdService.getAllSubjectNamesBasedOnClient());
				log.debug("BeanSubjectLookup for BU Client is ::::: "+subjectList.toString());
				ses.setAttribute("seatList", seatList);
				ses.setAttribute("subjectListForMainClient", subjectList);
				returnFlag = "ReportsBURDMain";
			}
			return returnFlag;
		}
		
}