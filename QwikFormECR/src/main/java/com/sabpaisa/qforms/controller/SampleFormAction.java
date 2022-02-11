package com.sabpaisa.qforms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
import java.util.Iterator;
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

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormActionsBean;
import com.sabpaisa.qforms.beans.FormFileBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.FormStateHistoryBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.beans.SubInstitute;
import com.sabpaisa.qforms.communication.ElasticSendMailer;
import com.sabpaisa.qforms.communication.EmailSessionBean;
import com.sabpaisa.qforms.communication.SendSMSs;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.ActorService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFeeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LifeCycleService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.test.ImageUpload;
import com.sabpaisa.qforms.util.ApplicationStatus;
import com.sabpaisa.qforms.util.BrowserVersion;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.LateFeeCalculator;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.RandomPasswordGenerator;

@CrossOrigin
@Controller
@RequestMapping
public class SampleFormAction {

	@Autowired
	private SampleFormService sampleFormService;

	@Autowired
	private SampleTransService sampleTransService;

	@Autowired
	private LifeCycleService lifeCycleService;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	@Autowired
	private ActorService actorService;

	@Autowired
	private DaoFeeService daoFeeService;

	@Autowired
	private LoginDAOService loginDAOService;

	@Autowired
	private CollegeService collegeService;

	@Autowired
	SessionFactory factory;

	static Logger log = LogManager.getLogger(SampleFormAction.class.getName());
	private LateFeeCalculator lateFeeCalculator = new LateFeeCalculator();
	private SampleTransBean beanTransData = new SampleTransBean();
	private BeanFormDetails formDetails = new BeanFormDetails();
	private CollegeBean colBean = new CollegeBean();
	private Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
	private String tempFileTypeValue;
	private File userImage;
	private String userImageContentType;
	private String userImageFileName;
	private FormFileBean formfile;
	private Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
	private Map<Integer, List<String>> optionsMap2 = new HashMap<Integer, List<String>>();
	private List<String> txtfield = new ArrayList<String>();
	private SampleFormBean formDataBean = new SampleFormBean();
	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();
	private List<BeanFormStructure> structureList = new ArrayList<BeanFormStructure>();
	private ArrayList<SampleFormView> formViewData = new ArrayList<SampleFormView>();
	private BeanFeeLookup feeLookupDetails = new BeanFeeLookup();
	private ArrayList<String> columnNameList = new ArrayList<String>();
	private SampleFormBean beanFormData = new SampleFormBean();

	File fileUpload;
	String formName = new String();
	DBConnection connection = new DBConnection();

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String qFormsIP = properties.getProperty("qFormsIP");
	String imageFileURL = properties.getProperty("cobImage");
	String uploadPath = properties.getProperty("qFormsImgFloderPath");
	String cCodeForMagicBricks = properties.getProperty("cCodeForMagicBricks");
	String cCodeForTVS = properties.getProperty("cCodeForTVS");
	String cCodeForApproval = properties.getProperty("cCodeForApproval");
	String cIdForApproval = properties.getProperty("cIdForApproval");
	String userDetailApproved = properties.getProperty("userDetailApproved");
	
	// Check the browser(Chrome, Mozilla, IE, Opera, Safari) details, it is updated
	// or not.
	public String browserDetail(HttpServletRequest request) {

		HttpSession ses = request.getSession();

		if (null != ses.getAttribute("browserName")) {
			ses.removeAttribute("browserName");
		}
		if (null != ses.getAttribute("brVer")) {
			ses.removeAttribute("brVer");
		}

		BrowserVersion bv = new BrowserVersion();
		String os = bv.getOperatingSystem(request);
		String browser = bv.getBrowserAndVersion(request);
		String browserStatus = "";
		String osVer = "";
		Integer brVer = null;
		String browserName = "";

//		log.info("bv.getOperatingSystem() :::::::::: 1 : " + os);
//		log.info("bv.getBrowserAndVersion() :::::::::::: 3 : " + browser);

		if (os.indexOf("_") > 0) {
			osVer = os.substring(os.indexOf("_") + 1, os.length());
		}
//		log.info("bv.getOperatingSystem() ::: version ::::::: 1 : " + osVer);

		if (browser.indexOf("-") > 0) {
			String str = "";
			str = browser.substring(browser.indexOf("-") + 1, browser.length());
			brVer = Integer.parseInt(str.substring(0, str.indexOf(".")));
			browserName = browser.substring(0, browser.indexOf("-"));
		}
//		log.info("bv.getBrowserAndVersion() ::: version ::::::: 2 : " + brVer);

		if (browserName.equalsIgnoreCase("Firefox") && brVer < 60 && osVer != null) {
			browserStatus = "no";
//			log.info("Browser status for move to form if it is required status 1 ::::::: " + browserStatus);
		} else if (browserName.equalsIgnoreCase("Chrome") && brVer < 70 && osVer != null) {
			browserStatus = "no";
//			log.info("Browser status for move to form if it is required status 2 ::::::: " + browserStatus);
		} else if (browserName.equalsIgnoreCase("Opera") && brVer < 50 && osVer != null) {
			browserStatus = "no";
//			log.info("Browser status for move to form if it is required status 3 ::::::: " + browserStatus);
		} else if (browserName.equalsIgnoreCase("IE") && brVer < 11 && osVer != null) {
			browserStatus = "yes";
//			log.info("Browser status for move to form if it is required status 4 ::::::: " + browserStatus);
		} else if (browserName.equalsIgnoreCase("safari") && brVer < 11 && osVer != null) {
			browserStatus = "yes";
//			log.info("Browser status for move to form if it is required status 5 ::::::: " + browserStatus);
		}

		ses.setAttribute("browserName", browserName);
		ses.setAttribute("brVer", brVer);

		return browserStatus;
	}

	// <<Praveen StartUrl Development>>. Start the payer select page,
	// Where user can select the payer and proceed to fill the form
	@RequestMapping(value = "/StartUrl", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView startUrl(HttpServletRequest request) {
		log.info("Open StartUrl() method for configuration");
		HttpSession ses = request.getSession();
		CollegeBean cBean = new CollegeBean();
		ModelAndView mav = null;
		String BankId = null;
		String clientId = null;
		Integer bankIds = null;
		Integer clientIds = null;
		Integer brVer = null;
		String browserName = "";

		BankId = request.getParameter("bid");
		clientId = request.getParameter("cid");

		String browserStatus = "";
		browserStatus = browserDetail(request);
		// log.info("Browser status for move to form if it is required status 2 :::::::
		// " + browserStatus);

		if (null != ses.getAttribute("browserName") || null != ses.getAttribute("brVer")) {
			browserName = (String) ses.getAttribute("browserName");
			brVer = (Integer) ses.getAttribute("brVer");
			// log.info("Browser name : " + browserName + " : browser version : " + brVer);
		}

		if (null != BankId && null != clientId) {

			if (clientId.equalsIgnoreCase("ALL") || BankId.equalsIgnoreCase("ALL")) {
				log.info("BankId is ::::: " + BankId);
				log.info("CollegeId is ::::: " + clientId);
			} else {
				// log.info("BankId is ::::: " + BankId);
				// log.info("CollegeId is ::::: " + clientId);
				bankIds = Integer.parseInt(BankId);
				clientIds = Integer.parseInt(clientId);
				cBean = collegeService.getClientDetailsBasedOnId(clientIds);
			}
		}
		if (null != ses.getAttribute("form")) {
			ses.removeAttribute("form");
		}

		if (browserStatus != null && !browserStatus.isEmpty() && browserStatus.equalsIgnoreCase("no")) {

			if (browserName.equalsIgnoreCase("Firefox")) {
				ses.setAttribute("downloadLink", "https://www.mozilla.org/en-US/firefox/new/");
			} else if (browserName.equalsIgnoreCase("Chrome")) {
				ses.setAttribute("downloadLink",
						"https://www.glog.info(\"work in StartUrl() for configuration\");oogle.com/chrome/?brand=CHBD&gclid=EAIaIQobChMI04SKg-bF5AIVhIRwCh0X0QB9EAAYASAAEgJdWfD_BwE&gclsrc=aw.ds#campaign-promo");
			} else if (browserName.equalsIgnoreCase("Opera")) {
				ses.setAttribute("downloadLink", "https://www.opera.com/hi");
			} else if (browserName.equalsIgnoreCase("IE")) {
				ses.setAttribute("downloadLink",
						"https://www.microsoft.com/en-in/download/Internet-Explorer-11-for-Windows-7-details.aspx");
			} else if (browserName.equalsIgnoreCase("safari")) {
				ses.setAttribute("downloadLink", "https://safari.en.softonic.com/download?ex=DSK-1697.0");
			}

			ses.setAttribute("msgData", "Oops!! : Your Browser (" + browserName + ") Version (" + brVer
					+ ") seems too old. Kindly update." + "from the given download link in this page.");

			mav = new ModelAndView("BrowserMissmatchIssue/browser_mismatch_issue");

		} else {
			mav = new ModelAndView("Start");
		}
		ses.setAttribute("BankId", bankIds);
		ses.setAttribute("CollegeId", clientIds);
		ses.setAttribute("CollegeBean", cBean);
		log.info("End StartUrl() methhod for configuration");
		return mav;
	}

	// <<Praveen DuplicateSession Development>>. Use for checking old session of
	// form filling process
	@RequestMapping(value = "/DuplicateSession")
	public String duplicateSession(Map<String, Object> model, HttpServletRequest request) {
		log.info("Open duplicateSession() method for configuration");
		HttpSession ses = request.getSession();
		String returnUrl = "";
		String browserStatus = "";
		Integer brVer = null;
		String browserName = "";
		Integer clientIds = null;
		CollegeBean cBean = new CollegeBean();
		String BankId = null;
		String clientId = null;
		BankId = request.getParameter("bid");
		clientId = request.getParameter("cid");

		if (null != BankId && null != clientId) {

			if (clientId.equalsIgnoreCase("ALL") || BankId.equalsIgnoreCase("ALL")) {
				log.info("BankId is ::::: " + BankId);
				log.info("CollegeId is ::::: " + clientId);
			} else {
				// log.info("BankId is ::::: " + BankId);
				// log.info("CollegeId is ::::: " + clientId);
				clientIds = Integer.parseInt(clientId);
				try {
					cBean = collegeService.getClientDetailsBasedOnId(clientIds);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		browserStatus = browserDetail(request);

		if (null != ses.getAttribute("browserName") || null != ses.getAttribute("brVer")) {
			browserName = (String) ses.getAttribute("browserName");
			brVer = (Integer) ses.getAttribute("brVer");
			// log.info("Browser name : " + browserName + " : browser version : " + brVer);
		}

		// log.debug("Browser status for move to form if it is required status 2 :::::::
		// " + browserStatus);
		if (browserStatus != null && !browserStatus.isEmpty() && browserStatus.equalsIgnoreCase("No")) {
			if (browserName.equalsIgnoreCase("Firefox")) {
				ses.setAttribute("downloadLink", "https://www.mozilla.org/en-US/firefox/new/");
			} else if (browserName.equalsIgnoreCase("Chrome")) {
				ses.setAttribute("downloadLink",
						"https://www.google.com/chrome/?brand=CHBD&gclid=EAIaIQobChMI04SKg-bF5AIVhIRwCh0X0QB9EAAYASAAEgJdWfD_BwE&gclsrc=aw.ds#campaign-promo");
			} else if (browserName.equalsIgnoreCase("Opera")) {
				ses.setAttribute("downloadLink", "https://www.opera.com/hi");
			} else if (browserName.equalsIgnoreCase("IE")) {
				ses.setAttribute("downloadLink",
						"https://www.microsoft.com/en-in/download/Internet-Explorer-11-for-Windows-7-details.aspx");
			} else if (browserName.equalsIgnoreCase("safari")) {
				ses.setAttribute("downloadLink", "https://safari.en.softonic.com/download?ex=DSK-1697.0");
			}

			ses.setAttribute("msgData", "Oops!! : Your Browser (" + browserName + ") Version (" + brVer
					+ ") seems too old. Kindly update." + "from the given download link in this page.");

			returnUrl = "BrowserMissmatchIssue/browser_mismatch_issue";
		} else {
			model.put("message", "You are in new page !!");
			returnUrl = "DuplicateSession";
		}
		ses.setAttribute("BankId", BankId);
		ses.setAttribute("CollegeId", clientIds);
		ses.setAttribute("CollegeBean", cBean);
		log.info("End duplicateSession() method for configuration");
		return returnUrl;
	}

	// <<Praveen GetForms List Development>> get all forms list as per the selected
	// payer name of a particular client
	@RequestMapping(value = "/GetForms", method = RequestMethod.GET)
	public String getFormsforPayer(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info("Start of getFormsforPayer() method ");
		CollegeBean colleges = new CollegeBean();
		List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
		List<SubInstitute> subcolleges = new ArrayList<SubInstitute>();
		if (null != ses.getAttribute("formsList")) {
			ses.removeAttribute("formsList");
		}
		boolean staleCheckResult = true;
		Integer compID = (Integer) ses.getAttribute("sesCID");
		Integer bankID = (Integer) ses.getAttribute("BankId");
//		log.info(("Bank id is::" + bankID));
		if (compID == null) {
			log.info("null cid from session, so reassigning..");
			compID = (Integer) ses.getAttribute("CollegeId");
		}
//		log.info(("client id is::" + compID));
		if (staleCheckResult || (Integer) ses.getAttribute("BankId") == null) {
			boolean isActor = false;
			try {
				Integer cid = Integer.parseInt(ses.getAttribute("CollegeId").toString());
				// log.debug(("College id is::" + cid));
				String actorFlag = "";
				String payer = "";
				try {
					payer = request.getParameter("PayeeProfile") == null ? (String) ses.getAttribute("PayeeProfile")
							: request.getParameter("PayeeProfile");
					ses.setAttribute("PayeeProfile", payer);
					if (payer == null) {
						payer = ses.getAttribute("PayeeProfile").toString();
					}
				} catch (Exception exception) {
					// empty catch block
				}
				try {
					actorFlag = request.getParameter("isActor");
					if (actorFlag == null) {
						actorFlag = ses.getAttribute("sesActorFlag") == null ? ""
								: (String) ses.getAttribute("sesActorFlag");
					} else {
						ses.setAttribute("sesActorFlag", actorFlag);
					}
				} catch (Exception exception) {
					// empty catch block
				}
				// log.debug(("Cid :" + cid));
				// log.debug(("Actor Flag :" + actorFlag));
				// log.debug(("Payer :" + payer));
				if (actorFlag.contentEquals("Y")) {
					isActor = true;
				}
				colleges = collegeService.viewInstDetail((Integer) cid);
				// log.debug("return back to FormBuilderController and collgeBean is
				// :::::::::::: " + colleges.toString());
				Integer ownerId = colleges.getLoginBean().getLoginId();
				// log.debug(("ownerId is:" + ownerId));

				if (isActor) {
					payer = payer.split("\\$")[0];
					// log.debug(("Payer id is " + payer));
				}
				BeanPayerType payerbean = daoFieldLookupService.getPayerLookupsBasedOnClient(payer, colleges);
				// log.debug("return back to FormBuilderController and payerbean is ::::::::::::
				// " + payerbean.toString());
				ArrayList<Integer> filters = new ArrayList<Integer>();
				filters.add(ownerId);
				if (isActor) {
					filters.add(Integer.parseInt(payer));
					forms = new ArrayList<BeanFormDetails>(
							daoFieldLookupService.getFormsForActors("relevant", filters));
				} else {
					filters.add(payerbean.getPayer_id());
					// log.debug(("payer id is::" + payerbean.getPayer_id()));
					forms = new ArrayList<BeanFormDetails>(daoFieldLookupService.getForms("relevant", filters));
				}
				// log.debug(
				// "return back to FormBuilderController and BeanFormDetail is :::::::::::: " +
				// forms.toString());
				if (payer.contentEquals("Institute")) {
					log.debug("case of institute paying..");
					String verFlag = (String) ses.getAttribute("reqVerFlag");
					// log.debug(("reqVerFlag at this time is::" + verFlag));
					if (verFlag == null) {
						verFlag = "0";
						ses.removeAttribute("msg");
						// log.debug(("reqVerFlag has been set to::" + verFlag + " ...since it was
						// null"));
						request.setAttribute("verified", "0");
						ses.setAttribute("reqVerFlag", "0");
					}
					if (verFlag.contentEquals("1")) {
						request.setAttribute("verified", "1");
						ses.setAttribute("reqVerFlag", "1");
					} else if (verFlag.contentEquals("2")) {
						request.setAttribute("verified", "2");
						ses.setAttribute("reqVerFlag", "2");
						subcolleges = (List) ses.getAttribute("CollegeList");
						ses.removeAttribute("CollegeList");
					} else {
						request.setAttribute("verified", "0");
						ses.setAttribute("reqVerFlag", "0");
					}
				} else {
					log.info("case of individuals paying...");
					request.setAttribute("verified", "1");
					ses.setAttribute("PayerID", "Individual");
				}
				ses.setAttribute("CollegeBean", colleges);
				ses.setAttribute("formsList", forms);
				log.info(("Forms list ::" + forms.size()));
				return "PayerFormListNew";
			} catch (NullPointerException e) {
				log.error("Exception in getting form ::", (Throwable) e);
				return "error";
			}
		}
		log.info("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		log.info("End of getFormsforPayer() method ");
		return "SessionTerminated";
	}

	// <<Praveen ProcessForm Development>>. used for processing the filled Dynamic
	// form at any page process
	@RequestMapping(value = "/processForm", method = RequestMethod.GET)
	public String prepareForm(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws Exception {
		log.info("Start of prepareForm() method ");
		ArrayList<SampleFormView> formViewData = new ArrayList();
		SampleFormBean loclFormBean = new SampleFormBean();
		Set<BeanFormStructure> formStructureBeanSet = null;
		if (null != ses.getAttribute("formdetails") || null != ses.getAttribute("linkPass")) {
			ses.removeAttribute("formdetails");
			ses.removeAttribute("linkPass");
		}

		Double lateFeeAmount = 0.0;
		boolean staleCheckResult = checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
				request.getParameter("formid"), request.getParameter("forminstanceid"), ses);
		if (staleCheckResult) {
			block34: {
				block33: {
					String payerID = "";
					Date formSubmitDate = new Date();
					Date dobDate = new Date();
					String formNumber = null;
					String name = "";
					String email = "";
					String contact = "";
					int flag=0;
					ses.setAttribute("lpFlag", 1);
					CollegeBean colBean = new CollegeBean();
					String isFormBeingRevived = request.getParameter("isFormBeingRevived") == null ? "N"
							: request.getParameter("isFormBeingRevived");

					String forminstanceid = request.getParameter("forminstanceid");

					String formInstanceIdFromRevivalRequest = request.getParameter("formrevivalinstanceid") == null ? ""
							: request.getParameter("formrevivalinstanceid");
					colBean = (CollegeBean) ses.getAttribute("CollegeBean");
					log.info("College Id is :::: " + colBean.getCollegeId());
					ses.setAttribute("CollegeBean", colBean);

					try {
						BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
						String formData = request.getParameter("values");
						formData = formData.replaceAll("'", " ");
						formData = formData.replaceAll("/", "_");
						formData = formData.replaceAll("\\\\", "_");
						formData = formData.replaceAll("\\(", "-");
						formData = formData.replaceAll("\\)", "-");
//						log.info(("form data after Specific Chars removal is:>" + formData));

						Integer formTemplateId = (Integer) ses.getAttribute("currentFormId");
						formDetails = daoFieldLookupService.getFormDetails(formTemplateId);

						Map<Integer, Integer> mapForMandFieldForSp = new HashMap<Integer, Integer>();
						formStructureBeanSet = formDetails.getFormStructure();
						if (null != formStructureBeanSet) {
							Iterator<BeanFormStructure> itrStr = formStructureBeanSet.iterator();
							while (itrStr.hasNext()) {
								BeanFormStructure bfs = itrStr.next();
								if (null != bfs.getIsMandName() && bfs.getIsMandName() == 1) {
									mapForMandFieldForSp.put(1, bfs.getId());
									// log.info("list for SP Mandatory value : " + mapForMandFieldForSp.toString());
								} else if (null != bfs.getIsMandMobileNumber() && bfs.getIsMandMobileNumber() == 2) {
									mapForMandFieldForSp.put(2, bfs.getId());
									// log.info("list for SP Mandatory value : " + mapForMandFieldForSp.toString());
								} else if (null != bfs.getIsMandEmail() && bfs.getIsMandEmail() == 3) {
									mapForMandFieldForSp.put(3, bfs.getId());
									// log.info("list for SP Mandatory value : " + mapForMandFieldForSp.toString());
								} else if (null != bfs.getIsMandAmount() && bfs.getIsMandAmount() == 4) {
									mapForMandFieldForSp.put(4, bfs.getId());
									// log.info("list for SP Mandatory value : " + mapForMandFieldForSp.toString());
								} else {
									// log.info("It is not use for name, mobile number, email, and amount.");
								}
							}
						}
						// log.debug("varification flag is ::: " + formDetails.getMoveToPg());
						ses.setAttribute("veriflag", formDetails.getMoveToPg());
						ses.setAttribute("veriflag1", formDetails.getHasInstructions());

						lateFeeAmount = lateFeeCalculator.calculateLateFee(formDetails);
						if (0.0 != lateFeeAmount) {
							log.info("Now late fee details is for this form =========> " + lateFeeAmount);
						}
						Integer formInstId = Integer.parseInt(ses.getAttribute("CollegeId").toString());
						Integer formFeeId = fee != null ? fee.getId() : null;
						Integer formApplicantId = 0;
						String code = request.getParameter("rccode");

						String dob = request.getParameter("rcdob");
						if (request.getParameter("rcPayerID") != null) {
							payerID = request.getParameter("rcPayerID");
							ses.setAttribute("Roll Number", payerID);
						}

						String linkPass = "";

						// generate rendom value
						if (colBean.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks)
								|| colBean.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) {

							linkPass = autoGenerateLinkPassword(name, contact);
							log.info("linkPassword for MagicBricks ::::: " + linkPass);
							ses.setAttribute("linkPass", linkPass);
						}

						// log.debug((":----:" + dob));
						Double amount = (Double) ses.getAttribute("feeAmt");
						// log.debug(("amount is::" + amount));
						String formFeeName = String.valueOf(formFeeId);

						String startDate = request.getParameter("rcStartDate");
						String endDate = request.getParameter("rcEndDate");
						if (amount == null && amount == 0.0) {
							amount = Double.parseDouble(ses.getAttribute("amt").toString());
						}
						log.info("Trans Amount is :::: " + amount.toString());
						SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
						try {
							if (dob != null && !"".equalsIgnoreCase(dob)) {
								// log.debug(("dob from request::" + dob));
								dobDate = formatter.parse(dob);
								// log.debug(("dobDate after formatting is::" + dobDate));
							} else {
								log.info("dob from request is null");
							}
						} catch (ParseException e) {
							e.printStackTrace();
						}
						boolean payerVitalContactInfoRevised = false;
						try {
							if (formData != null && !"".equalsIgnoreCase(formData)) {
								formData = formData.replaceAll("[^\\p{ASCII}]", " ");
								// log.info("formData is in Replacing special cahr : =========> "+formData);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						log.info("it is in");
						// log.info(("existing FormData is::" + ses.getAttribute("form")));

						if (null != ses.getAttribute("form")) {
							loclFormBean = (SampleFormBean) ses.getAttribute("form");
							// log.debug("Second time loclFormBean with new formid is :::: " +
							// loclFormBean.getFormData());
						}

						String existingFormData = loclFormBean.getFormData() == null ? "" : loclFormBean.getFormData();
						log.info(("existing FormData is::" + existingFormData));
						/* if ("".equalsIgnoreCase(forminstanceid)) { */
						if ("".equalsIgnoreCase(existingFormData)) {
							log.info("case of first submission from client, either in regular flow or revival flow");

							if ("".equalsIgnoreCase(formInstanceIdFromRevivalRequest)) {
								log.info("case of regular flow first server hit");

								// Start 13 March 2019
								Map<Integer, String> formDataMap = new HashMap<Integer, String>();
								formDataMap = processFormData(formData, ses);
								for (Map.Entry<Integer, String> temp : formDataMap.entrySet()) {
									Integer formKey = temp.getKey();
									// log.debug("formKey value is : ====> " + formKey.toString());
									String[] b = temp.getValue().split("$");
									int k = b[0].indexOf('$');
									String proofresult = b[0].substring(0, k);
									int m = proofresult.indexOf("=");
									String val = proofresult.substring(m + 1, k);
									// log.debug("value is : ====> " + val.toString());
									String col = proofresult.substring(0, m);
									if ((!val.isEmpty() || "" != val || null != val) && val.length() > 0) {
										for (Map.Entry<Integer, Integer> mapMand : mapForMandFieldForSp.entrySet()) {
											Integer key = mapMand.getKey();
											Integer value = mapMand.getValue();
											// log.debug("Mand value is : ====> " + key.toString());
											// log.debug("Key value is : ====> " + value.toString());
											if (key == 1 && formKey.equals(value) && "" == name) {
												// log.debug("use for sp name : " + val.toString());
												name = val.toString();
											} else if (key == 2 && formKey.equals(value) && "" == contact) {
												// log.debug("use for sp contact : " + val.toString());
												contact = val.toString();
											} else if (key == 3 && formKey.equals(value) && "" == email) {
												// log.debug("use for sp email : " + val.toString());
												email = val.toString();
											} else if (key == 4 && formKey.equals(value) && 0.0 == amount) {
												// log.debug("use for sp amount : " + val.toString());
												amount = Double.parseDouble(val.toString());
											} else {
												log.info("It is not use for name, mobile number, email, and amount.");
											}
										}
									}
								}

								// End 13 Mar 2019
								formNumber = getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
										formTemplateId);
								code = "NA";
								loclFormBean = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
										formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
										startDate, endDate, code, payerID, formNumber);

								//formViewData = processFormForView(formDataMap, ses,loclFormBean,flag);
								log.info("first server hit, saving forminstanceid to session ");
							} else {
								log.info("case of revival flow first server hit");

								loclFormBean = sampleFormService.getFormData(
										Integer.valueOf(Integer.parseInt(formInstanceIdFromRevivalRequest)));
								loclFormBean.setTransAmount(amount);
								log.info("updating formbean if details changed on the first screen");
								if (!loclFormBean.getEmail().equalsIgnoreCase(email)) {
									payerVitalContactInfoRevised = true;
									loclFormBean.setEmail(email);
								}
								if (!loclFormBean.getContact().equalsIgnoreCase(contact)) {
									payerVitalContactInfoRevised = true;
									loclFormBean.setContact(contact);
								}
								SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
								String formatted_date = formatter1.format(loclFormBean.getDobDate());
								if (!dob.contentEquals(formatted_date)) {
									payerVitalContactInfoRevised = true;
									loclFormBean.setDob(dob);
									if (!dobDate.equals("")) {
										loclFormBean.setDobDate(dobDate);
									}
								}
								if (payerVitalContactInfoRevised) {
									formNumber = getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
											formTemplateId);
									sampleFormService.deleteFormData((SampleFormBean) loclFormBean);
									code = "NA";
									loclFormBean = new SampleFormBean(formData, formTemplateId, formSubmitDate,
											formInstId, formApplicantId, formFeeId, name, dobDate, email, contact,
											amount, formFeeName, startDate, endDate, code, payerID, formNumber);
								}
							}
						} else {
							log.info("case of subsequent hits regular or revival flow");
							flag=1;
							loclFormBean.setFormData(formData);
							log.info("loclFormBean.getformid() " + loclFormBean.getFormId());
							Map<Integer, String> formDataMap1 = new HashMap<Integer, String>();
							formDataMap1 = processFormData(formData, ses);
//							formViewData = processFormForView(formDataMap1, ses, loclFormBean,flag);
							// log.debug(("formViewData after processFormView is 2:-------------: "
							// + formViewData.toString()));
							ses.setAttribute("sesCurrentFormMap", formDataMap1);

							if ((null == name || "" == name) || (null == contact || "" == contact)
									|| (null == email || "" == email) || (null == amount || 0.0 == amount)) {
								for (Map.Entry<Integer, String> temp : formDataMap1.entrySet()) {
									Integer formKey = temp.getKey();
									// log.debug("formKey value is : ====> " + formKey.toString());
									String[] b = temp.getValue().split("$");
									int k = b[0].indexOf('$');
									String proofresult = b[0].substring(0, k);
									int m = proofresult.indexOf("=");
									String val = proofresult.substring(m + 1, k);
									// log.debug("value is : ====> " + val.toString());
									String col = proofresult.substring(0, m);
									if ((!val.isEmpty() || "" != val || null != val) && val.length() > 0) {
										for (Map.Entry<Integer, Integer> mapMand : mapForMandFieldForSp.entrySet()) {
											Integer key = mapMand.getKey();
											Integer value = mapMand.getValue();
											// log.debug("Mand value is : ====> " + key.toString());
											// log.debug("Key value is : ====> " + value.toString());
											if (key == 1 && formKey.equals(value) && "" == name) {
												// log.debug("use for sp name : " + val.toString());
												name = val.toString();
											} else if (key == 2 && formKey.equals(value) && "" == contact) {
												// log.debug("use for sp contact : " + val.toString());
												contact = val.toString();
											} else if (key == 3 && formKey.equals(value) && "" == email) {
												// log.debug("use for sp email : " + val.toString());
												email = val.toString();
											} else if (key == 4 && formKey.equals(value) && 0.0 == amount) {
												// log.debug("use for sp amount : " + val.toString());
												amount = Double.parseDouble(val.toString());
											} else {
												log.info("It is not use for name, mobile number, email, and amount.");
											}
										}
									}
								}
							}

							if (amount == null || amount == 0.0) {
								log.info("it is in if block for updating amoount field.");
								amount = Double.parseDouble(ses.getAttribute("amountField").toString());
							}
							log.info("Trans Amount is :::: " + amount.toString());

							if (!loclFormBean.getEmail().equalsIgnoreCase(email)) {
								payerVitalContactInfoRevised = true;
								loclFormBean.setEmail(email);
							}

							if (!loclFormBean.getContact().equalsIgnoreCase(contact)) {
								payerVitalContactInfoRevised = true;
								loclFormBean.setContact(contact);
							}
							// log.info(("beanFormData.getDobDate() is::" + beanFormData.getDobDate()));

							SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
							String formatted_date = formatter1.format(loclFormBean.getDobDate());
							if (!dob.contentEquals(formatted_date)) {
								payerVitalContactInfoRevised = true;
								loclFormBean.setDob(dob);
								if (!dobDate.equals("")) {
									loclFormBean.setDobDate(dobDate);
								}
							}
							code = "NA";
							loclFormBean.setCode(code);
							loclFormBean.setName(name);
							loclFormBean.setTransAmount(amount);
							if (payerVitalContactInfoRevised) {
								formNumber = getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
										formTemplateId);
								sampleFormService.deleteFormData((SampleFormBean) loclFormBean);
								code = "NA";
								loclFormBean = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
										formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
										startDate, endDate, code, payerID, formNumber);
							}
							// log.debug(("formviewdata after isempty checking :-------------:" +
							// formViewData));
						}
						
						String doc1 = (String) ses.getAttribute("Document1");
						String doc2 = (String) ses.getAttribute("Document2");
						String doc3 = (String) ses.getAttribute("Document3");
						String doc4 = (String) ses.getAttribute("Document4");
						String doc5 = (String) ses.getAttribute("Document5");
						String doc6 = (String) ses.getAttribute("Document6");
						String doc7 = (String) ses.getAttribute("Document7");
						String doc8 = (String) ses.getAttribute("Document8");
						String doc9 = (String) ses.getAttribute("Document9");
						String doc10 = (String) ses.getAttribute("Document10");
						
						if (null != doc1) {
							log.info("file path1 : "+doc1);
							flag=2;
							loclFormBean.setFile_Path1(doc1);
							ses.removeAttribute("Document1");
						}if (null != doc2) {
							flag=2;
							log.info("file path2 : "+doc2);
							loclFormBean.setFile_Path2(doc2);
							ses.removeAttribute("Document2");
						}if (null != doc3) {
							log.info("file path3 : "+doc3);
							flag=2;
							loclFormBean.setFile_Path3(doc3);
							ses.removeAttribute("Document3");
						}if (null != doc4) {
							log.info("file path4 : "+doc4);
							flag=2;
							loclFormBean.setFile_Path4(doc4);
							ses.removeAttribute("Document4");
						}if (null != doc5) {
							log.info("file path5 : "+doc5);
							flag=2;
							loclFormBean.setFile_Path5(doc5);
							ses.removeAttribute("Document5");
						}if (null != doc6) {
							log.info("file path6 : "+doc6);
							flag=2;
							loclFormBean.setFile_Path6(doc6);
							ses.removeAttribute("Document6");
						}if (null != doc7) {
							log.info("file path7 : "+doc7);
							flag=2;
							loclFormBean.setFile_Path7(doc7);
							ses.removeAttribute("Document7");
						}if (null != doc8) {
							log.info("file path8 : "+doc8);
							flag=2;
							loclFormBean.setFile_Path8(doc8);
							ses.removeAttribute("Document8");
						}if (null != doc9) {
							log.info("file path9 : "+doc9);
							flag=2;
							loclFormBean.setFile_Path9(doc9);
							ses.removeAttribute("Document9");
						}if (null != doc10) {
							log.info("file path10 : "+doc10);
							flag=2;
							loclFormBean.setFile_Path10(doc10);
							ses.removeAttribute("Document10");
						}
						
						String photoExt = (String) ses.getAttribute("currentPhotoExt");
						byte[] pic = (byte[]) ses.getAttribute("currentPhoto");
						String signExt = (String) ses.getAttribute("currentSignatureExt");
						byte[] sign = (byte[]) ses.getAttribute("currentSignature");

						if (null != photoExt) {
//							log.debug("it is in if block for setup of photo");
							loclFormBean.setPhotograph(pic);
							loclFormBean.setPhoto_ext(photoExt);
							ses.removeAttribute("currentPhotoExt");
							ses.removeAttribute("currentPhoto");
						}
						if (null != signExt) {
//							log.debug("it is in if block for setup of signature");
							loclFormBean.setSignature(sign);
							loclFormBean.setSignature_ext(signExt);
							ses.removeAttribute("currentSignatureExt");
							ses.removeAttribute("currentSignature");
						}
						
						Map<Integer, String> formDataMap = new HashMap();

						if (formViewData.isEmpty()) {
							formDataMap = processFormData(formData, ses);
							formViewData = processFormForView(formDataMap, ses, loclFormBean,flag);
						} else {
							log.debug(("formViewData after processForm is 2:-------------:" + formViewData.toString()));
						}
						ses.setAttribute("sesCurrentFormMap", formDataMap);
					
						formDataBean = sampleFormService.saveFormData((SampleFormBean) loclFormBean);
						Integer curFormId = formDataBean.getFormId();
						formDataBean = sampleFormService.getFormData(curFormId);

						ses.setAttribute("formViewData", formViewData);
						ses.setAttribute("formInstanceId", String.valueOf(formDataBean.getFormId()));
						model.addAttribute("formInstanceIdForFile", String.valueOf(formDataBean.getFormId()));
						ses.setAttribute("formnumber", formNumber);
						ses.setAttribute("form", formDataBean);
						model.addAttribute("lateFeeAmount", lateFeeAmount);
						log.info("Now late fee details is for this form =========> " + lateFeeAmount);

						String needToSendEmailToPayer = "N";
						if ("N".equalsIgnoreCase(isFormBeingRevived)
								&& request.getParameter("submitShot").equalsIgnoreCase("fresh")) {
							needToSendEmailToPayer = "Y";
						}
						if ("Y".equalsIgnoreCase(isFormBeingRevived) && payerVitalContactInfoRevised) {
							needToSendEmailToPayer = "Y";
						}
						/*
						 * Block the mail sending process as find some issue on sending payment link to
						 * gateway 23/May/2019 by Praveen
						 */

						// if ("Y".equalsIgnoreCase(needToSendEmailToPayer)
						// && !colBean.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks)
						// && !colBean.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) {
						// try {
						// NotifyPayerOfFormLink(formDataBean, false, request, ses);
						// } catch (Exception e) {
						// e.printStackTrace();
						// }
						// }

						// form = loclFormBean;
						log.debug(("revival indicator is.::" + isFormBeingRevived));
						if (!"Y".equalsIgnoreCase(isFormBeingRevived))
							break block33;
						log.info("returning revivalsuccess");
						return "formSummaryRevival";
					} catch (NullPointerException e) {
						e.printStackTrace();
						return "PaySessionOut";
					}
				}
				if (request.getParameter("actorFlow") == null
						|| !"Y".equalsIgnoreCase(request.getParameter("actorFlow")))
					break block34;
				log.info("returning actorsuccess as this is the case of internal form submission");
				return "formSummaryInternal";
			}
			log.info("returning regular success");
			// ses.setAttribute("formViewData", formViewData);

			if (formDetails.getMoveToPg().contentEquals("yes")
					&& formDetails.getHasInstructions().contentEquals("yes")) {
				return "FormSummaryNewWithoutPG";
			}
			return "formSummaryNew";
		}
		log.info("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	// New for preparing form summary report as LP process
	@RequestMapping(value = "/processFormNew", method = RequestMethod.GET)
	public String prepareFormNew(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws Exception {

		log.info("Open processFormNew() method");
		log.info("bid {" + request.getParameter("bid") + "}, cid {" + request.getParameter("cid") + "}, formId {"
				+ request.getParameter("formid") + "}, " + "forminstanceid {" + request.getParameter("forminstanceid")
				+ "}, isFormBeingRevived {" + request.getParameter("isFormBeingRevived") + "}, formrevivalinstanceid {"
				+ request.getParameter("formrevivalinstanceid"));
		Set<BeanFormStructure> formStructureBeanSet = null;
		BeanPayerType beanPayerTypeN = new BeanPayerType();
		formDetails = new BeanFormDetails();
		beanFormData = new SampleFormBean();
		formViewData = new ArrayList<SampleFormView>();
		String uName = "NA", uContact = "NA", uEmail = "NA";
		if (null != ses.getAttribute("form")) {
			ses.removeAttribute("form");
		}

		Double lateFeeAmount = 0.0;
		block33: {
			log.info("in block 33:");
			String isFormBeingRevived = request.getParameter("isFormBeingRevived");
			// formId in dataformdetails
			String formInstanceIdFromRevivalRequest = request.getParameter("formrevivalinstanceid") == null ? ""
					: request.getParameter("formrevivalinstanceid");
			log.info(("formId in dataformdetails :: formInstanceIdFromRevivalRequest is::"
					+ formInstanceIdFromRevivalRequest));
			ses.setAttribute("lpFlag", 1);
			String payerID = "";
			Date formSubmitDate = new Date();
			Date dobDate = new Date();
			try {

				BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
				// log.debug("fee base amount is " + fee.getFeeBaseAmount() + ", and fee id " +
				// fee.getId());

				String formData = request.getParameter("values");
				// log.debug("form data before Specific Chars removal, which found from view
				// is:>" + formData);
				ses.setAttribute("FormDataForTrans", formData);
				int idx = formData.lastIndexOf(",");

				formData = formData.substring(0, idx);

				// log.debug(
				// "form data after removing last index of ',' and before Specific Chars
				// removal, which found from view is:> ::: "
				// + formData);

				formData = formData.replaceAll("'", " ");
				formData = formData.replaceAll("/", "_");
				formData = formData.replaceAll("\\\\", "_");
				formData = formData.replaceAll("\\(", "-");
				formData = formData.replaceAll("\\)", "-");
				// log.info(("form data after Specific Chars removal is:>" + formData));
				Integer formTemplateId = Integer.parseInt(request.getParameter("formid"));

				formDetails = daoFieldLookupService.getFormDetails(formTemplateId);
				// log.info("varification flag for getMoveToPg is ::: " +
				// formDetails.getMoveToPg());
				// log.info("varification flag for getHasInstructions is ::: " +
				// formDetails.getHasInstructions());

				ses.setAttribute("veriflag", formDetails.getMoveToPg());
				ses.setAttribute("veriflag1", formDetails.getHasInstructions());

				Map<Integer, Integer> mapForMandFieldForSp = new HashMap<Integer, Integer>();
				formStructureBeanSet = formDetails.getFormStructure();
				if (null != formStructureBeanSet) {
					Iterator<BeanFormStructure> itrStr = formStructureBeanSet.iterator();
					while (itrStr.hasNext()) {
						BeanFormStructure bfs = itrStr.next();
						if (null != bfs.getIsMandName() && bfs.getIsMandName() == 1) {
							mapForMandFieldForSp.put(1, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandMobileNumber() && bfs.getIsMandMobileNumber() == 2) {
							mapForMandFieldForSp.put(2, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandEmail() && bfs.getIsMandEmail() == 3) {
							mapForMandFieldForSp.put(3, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandAmount() && bfs.getIsMandAmount() == 4) {
							mapForMandFieldForSp.put(4, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else {
							log.info("It is not use for name, mobile number, email, and amount.");
						}
					}
				}

				Integer formInstId = Integer.parseInt(ses.getAttribute("CollegeId").toString());
				Integer formFeeId = fee != null ? fee.getId() : null;
				Integer formApplicantId = 0;

				String code = request.getParameter("rccode");

				String payeeProfile = request.getParameter("payeeProfile");
				beanPayerTypeN = daoFieldLookupService.getPayerLookups(payeeProfile);
				payerID = beanPayerTypeN.getPayer_id().toString();
				log.info((":--PayerID--:" + payerID));

				lateFeeAmount = lateFeeCalculator.calculateLateFee(formDetails);
				Double amount = 0.0;
				if (null != request.getParameter("paidAmount")) {
					amount = Double.parseDouble(request.getParameter("paidAmount"));
					log.info(("Trans Amount is :: " + amount));
				}
				if (null != request.getParameter("feeDetails")) {
					lateFeeAmount = Double.parseDouble(request.getParameter("feeDetails"));
					log.info(("Late Fee Amount is :: " + lateFeeAmount));
				}
				if (amount == 0.0 && null != ses.getAttribute("feeAmt")) {
					// lateFeeAmount = lateFeeCalculator.calculateLateFee(formDetails);
					if (lateFeeAmount != 0.0) {
						amount = (Double) ses.getAttribute("feeAmt") + lateFeeAmount;
						log.info("Amount by ses.getAttribute(feeAmt) with Late Fee final amount {" + amount
								+ "}, and latefee amount {" + lateFeeAmount + "}");
					} else {
						amount = (Double) ses.getAttribute("feeAmt");
						log.info("Amount by ses.getAttribute(feeAmt) {" + amount + "}");
					}

				}

				// log.info(("Trans Amount is::" + amount));

				String formFeeName = String.valueOf(formFeeId);
				// log.info(("formFeeName after copying value from formFeeId is::" +
				// formFeeName));

				String startDate = request.getParameter("rcStartDate");
				String endDate = request.getParameter("rcEndDate");

				boolean payerVitalContactInfoRevised = false;
				try {
					if (formData != null && !"".equalsIgnoreCase(formData)) {
						formData = formData.replaceAll("[^\\p{ASCII}]", " ");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				log.info(("existing FormData is::" + formData));
				// Start 13 March 2019
				Map<Integer, String> formDataMap = new HashMap();
				// log.info(("Initial form is 1:-------------:" + formData.toString()));
				formDataMap = processFormData(formData, ses);
				for (Map.Entry<Integer, String> temp : formDataMap.entrySet()) {

					Integer formKey = temp.getKey();
					// log.debug("formKey value is : ====> " + formKey.toString());

					String[] b = temp.getValue().split("$");
					int k = b[0].indexOf('$');
					String proofresult = b[0].substring(0, k);
					int m = proofresult.indexOf("=");
					String val = proofresult.substring(m + 1, k);
					// log.debug("value is : ====> " + val.toString());
					String col = proofresult.substring(0, m);
					if ((!val.isEmpty() || "" != val || null != val) && val.length() > 0) {
						for (Map.Entry<Integer, Integer> mapMand : mapForMandFieldForSp.entrySet()) {
							Integer key = mapMand.getKey();
							Integer value = mapMand.getValue();
							// log.debug("Mand value is : ====> " + key.toString());
							// log.debug("Key value is : ====> " + value.toString());
							if (key == 1 && formKey.equals(value) && "NA" == uName) {
								// log.debug("use for sp name : " + val.toString());
								uName = val.toString();
							} else if (key == 3 && formKey.equals(value) && "NA" == uEmail) {
								// log.debug("use for sp contact : " + val.toString());
								uEmail = val.toString();
							} else if (key == 2 && formKey.equals(value) && "NA" == uContact) {
								// log.debug("use for sp email : " + val.toString());
								uContact = val.toString();
							} else if (key == 4 && formKey.equals(value) && 0.0 == amount) {
								// log.debug("use for sp amount : " + val.toString());
								amount = Double.parseDouble(val.toString());
							} else {
								log.info("It is not use for name, mobile number, email, and amount.");
							}
						}
					}
				}

				if (uContact.equalsIgnoreCase("NA")) {
					uContact = "";
				}
				if (uEmail.equalsIgnoreCase("NA")) {
					uEmail = "";
				}
				log.info("ApplicantName {" + uName + "}, Contact {" + uContact + "} EMAIL {" + uEmail + "}, Amount {"
						+ amount + "}");

				// End 13 Mar 2019
				String formNumber = getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"), formTemplateId);
				code = "NA";
				beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId, formApplicantId,
						formFeeId, uName, dobDate, uEmail, uContact, amount, formFeeName, startDate, endDate, code,
						payerID, formNumber);
				// log.debug("beanFormData : " + beanFormData.toString());

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
				
				/**/
				int flag=0;
				String doc1 = (String) ses.getAttribute("Document1");
				String doc2 = (String) ses.getAttribute("Document2");
				String doc3 = (String) ses.getAttribute("Document3");
				String doc4 = (String) ses.getAttribute("Document4");
				String doc5 = (String) ses.getAttribute("Document5");
				String doc6 = (String) ses.getAttribute("Document6");
				String doc7 = (String) ses.getAttribute("Document7");
				String doc8 = (String) ses.getAttribute("Document8");
				String doc9 = (String) ses.getAttribute("Document9");
				String doc10 = (String) ses.getAttribute("Document10");
				
				if (null != doc1) {
					log.info("file path1 : "+doc1);
					flag=2;
					beanFormData.setFile_Path1(doc1);
					ses.removeAttribute("Document1");
				}if (null != doc2) {
					flag=2;
					log.info("file path2 : "+doc2);
					beanFormData.setFile_Path2(doc2);
					ses.removeAttribute("Document2");
				}if (null != doc3) {
					log.info("file path3 : "+doc3);
					flag=2;
					beanFormData.setFile_Path3(doc3);
					ses.removeAttribute("Document3");
				}if (null != doc4) {
					log.info("file path4 : "+doc4);
					flag=2;
					beanFormData.setFile_Path4(doc4);
					ses.removeAttribute("Document4");
				}if (null != doc5) {
					log.info("file path5 : "+doc5);
					flag=2;
					beanFormData.setFile_Path5(doc5);
					ses.removeAttribute("Document5");
				}if (null != doc6) {
					log.info("file path6 : "+doc6);
					flag=2;
					beanFormData.setFile_Path6(doc6);
					ses.removeAttribute("Document6");
				}if (null != doc7) {
					log.info("file path7 : "+doc7);
					flag=2;
					beanFormData.setFile_Path7(doc7);
					ses.removeAttribute("Document7");
				}if (null != doc8) {
					log.info("file path8 : "+doc8);
					flag=2;
					beanFormData.setFile_Path8(doc8);
					ses.removeAttribute("Document8");
				}if (null != doc9) {
					log.info("file path9 : "+doc9);
					flag=2;
					beanFormData.setFile_Path9(doc9);
					ses.removeAttribute("Document9");
				}if (null != doc10) {
					log.info("file path10 : "+doc10);
					flag=2;
					beanFormData.setFile_Path10(doc10);
					ses.removeAttribute("Document10");
				}
				/**/

				beanFormData = sampleFormService.saveFormData(beanFormData);
				log.info("updated formid in data form is " + beanFormData.getFormId());
				formViewData = processFormViewForLP(formDataMap, ses, beanFormData.getFormId());
				// log.info(("formviewdata after isempty checking :-------------:" +
				// formViewData));

				/*
				 * String needToSendEmailToPayer = "N"; if
				 * ("N".equalsIgnoreCase(isFormBeingRevived) &&
				 * request.getParameter("submitShot").equalsIgnoreCase("fresh")) {
				 * needToSendEmailToPayer = "Y"; } if ("Y".equalsIgnoreCase(isFormBeingRevived)
				 * && payerVitalContactInfoRevised) { needToSendEmailToPayer = "Y"; } if
				 * ("Y".equalsIgnoreCase(needToSendEmailToPayer)) { try {
				 * NotifyPayerOfFormLink(beanFormData, false, request, ses); } catch (Exception
				 * e) { e.printStackTrace(); } }
				 */

				// log.info(("revival indicator is.::" + isFormBeingRevived));
				if (!"Y".equalsIgnoreCase(isFormBeingRevived))
					break block33;
				log.info("returning revivalsuccess");
				ses.setAttribute("formInstanceId", String.valueOf(beanFormData.getFormId()));
				ses.setAttribute("formViewData", formViewData);
				ses.setAttribute("sampleFormBean", beanFormData);
				ses.setAttribute("form", beanFormData);
				ses.setAttribute("formDetails", formDetails);
				ses.setAttribute("sesCurrentFormMap", formDataMap);
				model.addAttribute("lateFeeAmount", lateFeeAmount);
				return "formSummaryNewForLPProcess";
			} catch (NullPointerException e) {
				e.printStackTrace();
				return "PaySessionOut";
			}
		}
		log.info("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	// <<Praveen processFormForReFetch Development>>. used for processing the For
	// ReFetch by User FormId
	// form at any page process
	@RequestMapping(value = "/processFormForReFetch", method = RequestMethod.GET)
	public String prepareFormForReFetch(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws Exception {

		ArrayList<SampleFormView> formViewData = new ArrayList();
		SampleFormBean loclFormBean = new SampleFormBean();
		Set<BeanFormStructure> formStructureBeanSet = null;
		formDetails = new BeanFormDetails();
		int flag=0;
		BeanPayerType beanPayerTypeN = new BeanPayerType();
		if (null != ses.getAttribute("formdetails") || null != ses.getAttribute("linkPass")) {
			ses.removeAttribute("formdetails");
			ses.removeAttribute("linkPass");
		}

		Double lateFeeAmount = 0.0;
		if (null != request.getParameter("bid") && null != request.getParameter("cid")
				&& null != request.getParameter("formid") && null != request.getParameter("forminstanceid")) {

			String payerID = "";
			// Date formSubmitDate = new Date();
			// Date dobDate = new Date();
			String formNumber = null;
			String name = "";
			String email = "";
			String contact = "";
			ses.setAttribute("lpFlag", 1);
			CollegeBean colBean = new CollegeBean();
			String isFormBeingRevived = request.getParameter("isFormBeingRevived") == null ? "N"
					: request.getParameter("isFormBeingRevived");

			String forminstanceid = request.getParameter("forminstanceid");

			String formInstanceIdFromRevivalRequest = request.getParameter("formrevivalinstanceid") == null ? ""
					: request.getParameter("formrevivalinstanceid");
			colBean = (CollegeBean) ses.getAttribute("CollegeBean");
			log.info("College Id is :::: " + colBean.getCollegeId());
			ses.setAttribute("CollegeBean", colBean);

			try {
				BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
				String formData = request.getParameter("values");
				formData = formData.replaceAll("'", " ");
				formData = formData.replaceAll("/", "_");
				formData = formData.replaceAll("\\\\", "_");
				formData = formData.replaceAll("\\(", "-");
				formData = formData.replaceAll("\\)", "-");
				// log.info(("form data after Specific Chars removal is:>" + formData));

				Integer formTemplateId = Integer.parseInt(request.getParameter("formid"));
				formDetails = daoFieldLookupService.getFormDetails(formTemplateId);

				beanPayerTypeN = daoFieldLookupService.getPayerLookupsById(formDetails.getPayer_type());

				Map<Integer, Integer> mapForMandFieldForSp = new HashMap<Integer, Integer>();
				formStructureBeanSet = formDetails.getFormStructure();
				if (null != formStructureBeanSet) {
					Iterator<BeanFormStructure> itrStr = formStructureBeanSet.iterator();
					while (itrStr.hasNext()) {
						BeanFormStructure bfs = itrStr.next();
						if (null != bfs.getIsMandName() && bfs.getIsMandName() == 1) {
							mapForMandFieldForSp.put(1, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandMobileNumber() && bfs.getIsMandMobileNumber() == 2) {
							mapForMandFieldForSp.put(2, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandEmail() && bfs.getIsMandEmail() == 3) {
							mapForMandFieldForSp.put(3, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else if (null != bfs.getIsMandAmount() && bfs.getIsMandAmount() == 4) {
							mapForMandFieldForSp.put(4, bfs.getId());
							// log.debug("list for SP Mandatory value : " +
							// mapForMandFieldForSp.toString());
						} else {
							log.info("It is not use for name, mobile number, email, and amount.");
						}
					}
				}
				// log.info("varification flag is ::: " + formDetails.getMoveToPg());
				request.setAttribute("veriflag", formDetails.getMoveToPg());
				request.setAttribute("veriflag1", formDetails.getHasInstructions());

				lateFeeAmount = lateFeeCalculator.calculateLateFee(formDetails);
				if (0.0 != lateFeeAmount) {
					log.info("Now late fee details is for this form =========> " + lateFeeAmount);
				}
				Integer formInstId = Integer.parseInt(ses.getAttribute("CollegeId").toString());
				Integer formFeeId = fee != null ? fee.getId() : null;
				Integer formApplicantId = 0;
				// String code = request.getParameter("rccode");

				// String dob = request.getParameter("rcdob");
				if (request.getParameter("rcPayerID") != null) {
					payerID = request.getParameter("rcPayerID");
					ses.setAttribute("Roll Number", payerID);
				}

				String linkPass = "";

				// generate rendom value
				if (colBean.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks)
						|| colBean.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) {

					linkPass = autoGenerateLinkPassword(name, contact);
					log.info("linkPassword for MagicBricks ::::: " + linkPass);
					ses.setAttribute("linkPass", linkPass);
				}

				// log.debug((":----:" + dob));
				Double amount = (Double) ses.getAttribute("feeAmt");
				log.debug(("amount is::" + amount));
				String formFeeName = String.valueOf(formFeeId);

				// String startDate = request.getParameter("rcStartDate");
				// String endDate = request.getParameter("rcEndDate");
				if (amount == null && amount == 0.0) {
					amount = Double.parseDouble(ses.getAttribute("amt").toString());
				}
				log.info("Trans Amount is :::: " + amount.toString());
				// SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
				// try {
				// if (dob != null && !"".equalsIgnoreCase(dob)) {
				// log.debug(("dob from request::" + dob));
				// dobDate = formatter.parse(dob);
				// log.debug(("dobDate after formatting is::" + dobDate));
				// } else {
				// log.info("dob from request is null");
				// }
				// } catch (ParseException e) {
				// e.printStackTrace();
				// }
				// boolean payerVitalContactInfoRevised = false;
				try {
					if (formData != null && !"".equalsIgnoreCase(formData)) {
						log.debug("formData is in Replacing special cahr 1 : =========> " + formData);
						formData = formData.replaceAll("[^\\p{ASCII}]", " ");
						Integer l = formData.lastIndexOf(",");
						formData = formData.substring(0, l);
						log.info("formData is in Replacing special cahr 2 : =========> " + formData);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				log.info("it is in");
				// log.info(("existing FormData is::" + ses.getAttribute("form")));

				if (null != forminstanceid || "" != forminstanceid) {
					loclFormBean = sampleFormService.getFormData(Integer.parseInt(forminstanceid));
					log.debug("Second time loclFormBean with new formid is :::: " + loclFormBean.getFormData());
				}

				String existingFormData = loclFormBean.getFormData() == null ? "" : loclFormBean.getFormData();
				log.info(("existing FormData is::" + existingFormData));

				if ("".equalsIgnoreCase(existingFormData)) {
					flag=1;
					log.info("case of first submission from client, either in regular flow or revival flow");
					request.setAttribute("msg",
							"Data is not matched Please try again or fill the fresh form for process.");
					return "SessionTerminated";
				} else {
					log.info("case of subsequent hits regular or revival flow");
					flag=2;
					loclFormBean.setFormData(formData);
					// log.info("loclFormBean.getformid() " + loclFormBean.getFormId());
					Map<Integer, String> formDataMap1 = new HashMap<Integer, String>();
					formDataMap1 = processFormData(formData, ses);
//					formViewData = processFormForView(formDataMap1, ses, loclFormBean,flag);
					// log.debug(("formViewData after processFormView is 2:-------------: " +
					// formViewData.toString()));
					ses.setAttribute("sesCurrentFormMap", formDataMap1);

					if ((null == name || "" == name) || (null == contact || "" == contact)
							|| (null == email || "" == email) || (null == amount || 0.0 == amount)) {
						for (Map.Entry<Integer, String> temp : formDataMap1.entrySet()) {
							Integer formKey = temp.getKey();
							// log.debug("formKey value is : ====> " + formKey.toString());
							String[] b = temp.getValue().split("$");
							int k = b[0].indexOf('$');
							String proofresult = b[0].substring(0, k);
							int m = proofresult.indexOf("=");
							String val = proofresult.substring(m + 1, k);
							// log.debug("value is : ====> " + val.toString());
							String col = proofresult.substring(0, m);
							if ((!val.isEmpty() || "" != val || null != val) && val.length() > 0) {
								for (Map.Entry<Integer, Integer> mapMand : mapForMandFieldForSp.entrySet()) {
									Integer key = mapMand.getKey();
									Integer value = mapMand.getValue();
									// log.debug("Mand value is : ====> " + key.toString());
									// log.debug("Key value is : ====> " + value.toString());
									if (key == 1 && formKey.equals(value) && "" == name) {
										// log.info("use for sp name : " + val.toString());
										name = val.toString();
									} else if (key == 2 && formKey.equals(value) && "" == contact) {
										// log.info("use for sp contact : " + val.toString());
										contact = val.toString();
									} else if (key == 3 && formKey.equals(value) && "" == email) {
										// log.info("use for sp email : " + val.toString());
										email = val.toString();
									} else if (key == 4 && formKey.equals(value) && 0.0 == amount) {
										// log.info("use for sp amount : " + val.toString());
										amount = Double.parseDouble(val.toString());
									} else {
										log.info("It is not use for name, mobile number, email, and amount.");
									}
								}
							}
						}
					}

					if (amount == null || amount == 0.0) {
						log.info("it is in if block for updating amoount field.");
						amount = Double.parseDouble(ses.getAttribute("amountField").toString());
					}
					log.info("Trans Amount is :::: " + amount.toString());
					loclFormBean.setCode("NA");
					loclFormBean.setName(name);
					loclFormBean.setContact(contact);
					loclFormBean.setEmail(email);
					loclFormBean.setTransAmount(amount);
				}
				// log.debug("beanFormData >>>>>>>>>>>>>>>>>>>>>>>>>> {" +
				// loclFormBean.getFormData().toString() + "}");

				String doc1 = (String) ses.getAttribute("Document1");
				String doc2 = (String) ses.getAttribute("Document2");
				String doc3 = (String) ses.getAttribute("Document3");
				String doc4 = (String) ses.getAttribute("Document4");
				String doc5 = (String) ses.getAttribute("Document5");
				String doc6 = (String) ses.getAttribute("Document6");
				String doc7 = (String) ses.getAttribute("Document7");
				String doc8 = (String) ses.getAttribute("Document8");
				String doc9 = (String) ses.getAttribute("Document9");
				String doc10 = (String) ses.getAttribute("Document10");
				
				if (null != doc1) {
					log.info("file path1 : "+doc1);
					flag=2;
					loclFormBean.setFile_Path1(doc1);
					ses.removeAttribute("Document1");
				}if (null != doc2) {
					flag=2;
					log.info("file path2 : "+doc2);
					loclFormBean.setFile_Path2(doc2);
					ses.removeAttribute("Document2");
				}if (null != doc3) {
					log.info("file path3 : "+doc3);
					flag=2;
					loclFormBean.setFile_Path3(doc3);
					ses.removeAttribute("Document3");
				}if (null != doc4) {
					log.info("file path4 : "+doc4);
					flag=2;
					loclFormBean.setFile_Path4(doc4);
					ses.removeAttribute("Document4");
				}if (null != doc5) {
					log.info("file path5 : "+doc5);
					flag=2;
					loclFormBean.setFile_Path5(doc5);
					ses.removeAttribute("Document5");
				}if (null != doc6) {
					log.info("file path6 : "+doc6);
					flag=2;
					loclFormBean.setFile_Path6(doc6);
					ses.removeAttribute("Document6");
				}if (null != doc7) {
					log.info("file path7 : "+doc7);
					flag=2;
					loclFormBean.setFile_Path7(doc7);
					ses.removeAttribute("Document7");
				}if (null != doc8) {
					log.info("file path8 : "+doc8);
					flag=2;
					loclFormBean.setFile_Path8(doc8);
					ses.removeAttribute("Document8");
				}if (null != doc9) {
					log.info("file path9 : "+doc9);
					flag=2;
					loclFormBean.setFile_Path9(doc9);
					ses.removeAttribute("Document9");
				}if (null != doc10) {
					log.info("file path10 : "+doc10);
					flag=2;
					loclFormBean.setFile_Path10(doc10);
					ses.removeAttribute("Document10");
				}
				
				
				String photoExt = (String) ses.getAttribute("currentPhotoExt");
				byte[] pic = (byte[]) ses.getAttribute("currentPhoto");
				String signExt = (String) ses.getAttribute("currentSignatureExt");
				byte[] sign = (byte[]) ses.getAttribute("currentSignature");

				if (null != photoExt) {
					log.debug("it is in if block for setup of photo");
					loclFormBean.setPhotograph(pic);
					loclFormBean.setPhoto_ext(photoExt);
					ses.removeAttribute("currentPhotoExt");
					ses.removeAttribute("currentPhoto");
				}
				if (null != signExt) {
					log.debug("it is in if block for setup of signature");
					loclFormBean.setSignature(sign);
					loclFormBean.setSignature_ext(signExt);
					ses.removeAttribute("currentSignatureExt");
					ses.removeAttribute("currentSignature");
				}
				
				formDataBean = sampleFormService.saveFormData((SampleFormBean) loclFormBean);
				// log.debug("current form id is :::::::::: " + formDataBean.getFormId());

				Integer curFormId = formDataBean.getFormId();
				formDataBean = sampleFormService.getFormData(curFormId);
				
				Map<Integer, String> formDataMap = new HashMap();

				if (formViewData.isEmpty()) {
					formDataMap = processFormData(formData, ses);
					formViewData = processFormForView(formDataMap, ses, loclFormBean,flag);
				} else {
					log.info(("formViewData after processForm is 2:-------------:" + formViewData.toString()));
				}
				ses.setAttribute("sesCurrentFormMap", formDataMap);
				
				// log.debug("After fetching current form bean dta with current form id is
				// :::::::::: "
				// + formDataBean.getFormId());
				request.setAttribute("BankId", colBean.getBankDetailsOTM().getBankId());
				request.setAttribute("CollegeId", colBean.getCollegeId());
				ses.setAttribute("PayeeProfile", beanPayerTypeN.getPayer_type());
				request.setAttribute("currentFormId", formDetails.getId());
				ses.setAttribute("formViewData", formViewData);
				// ses.setAttribute("sesCurrentFormData", form);
				request.setAttribute("formInstanceId", String.valueOf(formDataBean.getFormId()));
				ses.setAttribute("formnumber", formNumber);
				request.setAttribute("form", formDataBean);
				model.addAttribute("lateFeeAmount", lateFeeAmount);
				log.info("Now late fee details is for this form =========> " + lateFeeAmount);

				/*
				 * String needToSendEmailToPayer = "N"; if
				 * ("N".equalsIgnoreCase(isFormBeingRevived) &&
				 * request.getParameter("submitShot").equalsIgnoreCase("fresh")) {
				 * needToSendEmailToPayer = "Y"; } if ("Y".equalsIgnoreCase(isFormBeingRevived))
				 * { needToSendEmailToPayer = "Y"; }
				 */
				/*
				 * Block the mail sending process as find some issue on sending payment link to
				 * gateway 23/May/2019 by Praveen
				 */

				/*
				 * if ("Y".equalsIgnoreCase(needToSendEmailToPayer) &&
				 * !colBean.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks) &&
				 * !colBean.getCollegeCode().equalsIgnoreCase(cCodeForTVS)) { try {
				 * NotifyPayerOfFormLink(formDataBean, false, request, ses); } catch (Exception
				 * e) { e.printStackTrace(); } }
				 */

				// form = loclFormBean;
				log.info("upload a jsp formSummaryRevival ");
				return "formSummaryRevival";
			} catch (NullPointerException e) {
				e.printStackTrace();
				return "PaySessionOut";
			}

		} else {
			log.info("staleCheckResult fails...terminated user session");
			request.setAttribute("staleCheckResult", "fail");
			return "SessionTerminated";
		}
	}

	public Map<Integer, String> processFormData(String formDataRaw, HttpSession ses) {
		log.info("Start of processFormData(), formDataRaw >> " + formDataRaw);

		Map<Integer, String> formDataMap = new HashMap<Integer, String>();
		String[] formFields = formDataRaw.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		log.info(("formFieldsList size is ::::::::::::::: " + formFieldsList.size()));

		int i = 0;
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split("~");
			log.debug("afetr spliting formFieldData values are ::::::::::::::::: " + formFieldData.toString());
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

	@RequestMapping(value = "/viewForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewForm(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws Exception {
		formViewData = new ArrayList<SampleFormView>();
		try {
			int flag=2;
			SampleTransBean beanTransData = new SampleTransBean();
			Integer transID = Integer.parseInt(request.getParameter("transId"));
			beanTransData = sampleTransService.getTransactions(transID);
			Integer id = beanTransData.getTransForm().getFormFeeId();
			log.debug(("form ID is ::" + id));
			formName = sampleTransService.getFormDetail(id);
			Map<Integer, String> formDataMap = new HashMap();
			// log.info(("Form Name ::" + this.formName));
			ses.setAttribute("formName", formName);
			// log.info(("Form Data ::" + beanTransData.getTransForm().getFormData()));
			formDataMap = processFormData(beanTransData.getTransForm().getFormData(), ses);

			ses.setAttribute("sesCurrentFormMap", formDataMap);
			formViewData = processFormView(formDataMap, ses, beanTransData.getTransForm().getFormId());
			ses.setAttribute("formViewData", formViewData);

			return "formDetails";
		} catch (ArrayIndexOutOfBoundsException ex) {
			return "formDetails";
		}
	}

	@RequestMapping(value = "/viewFormData", method = RequestMethod.POST)
	public String viewFormData(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws Exception {
		try {
			SampleTransBean beanTransData = new SampleTransBean();
			formDataBean = new SampleFormBean();
			Integer formdataId = (Integer) ses.getAttribute("sesFormdata_id");
			formDataBean = (SampleFormBean) ses.getAttribute("sesFormDataBean");
			ses.setAttribute("sesCurrentFormData", formDataBean);
			FormStateBean formstate = (FormStateBean) ses.getAttribute("sesFormStateBean");
			formName = sampleTransService.getFormDetail(formstate.getForm_id());
			ses.setAttribute("formName", formName);
			Map<Integer, String> formDataMap = new HashMap();
			formDataMap = processFormData(formDataBean.getFormData(), ses);
			ses.setAttribute("sesCurrentFormMap", formDataMap);
			int flag=2;
			formViewData = processFormView(formDataMap, ses, formDataBean.getFormId());
			ses.setAttribute("formViewData", formViewData);
			return "formDetails-Actor";
		} catch (ArrayIndexOutOfBoundsException ex) {
			return "formDetails-Actor";
		}
	}

	@RequestMapping(value = { "/ViewFormlst" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String viewReceipetDetails(ModelMap model, HttpServletRequest request, HttpSession ses) throws Exception {

		SampleTransBean beanTransData = new SampleTransBean();
		String formName = new String();
		ArrayList<SampleFormView> formViewData = new ArrayList();
		BeanFeeLookup feeLookupDetails = new BeanFeeLookup();
		SampleFormBean sampleFormData = new SampleFormBean();
		int flag=0;
		if (ses.getAttribute("sampleFormForView") != null) {
			ses.removeAttribute("sampleFormForView");
		}
		try {

			log.info("id :::::::" + request.getParameter("id") + "transId :::::::" + request.getParameter("transId"));
			Integer transIDOfFormId = Integer.parseInt(request.getParameter("id"));

			beanTransData = sampleTransService.getTransactions(request.getParameter("transId").trim());
			Integer id = beanTransData.getTransForm().getFormFeeId();
			log.info("current form ID is ::" + id);

			formName = sampleTransService.getFormDetail(id);
			log.info("current form Name is ::" + formName);

			HashMap<Integer, String> formDataMap = new HashMap();

			formDataMap = (HashMap<Integer, String>) processFormData(beanTransData.getTransForm().getFormData(), ses);
			log.debug("form data map is : ========> " + formDataMap.toString());
			ses.setAttribute("sesCurrentFormMap", formDataMap);
			//flag=2;
			formViewData = processFormView(formDataMap, ses, beanTransData.getTransForm().getFormId());
			log.debug("formViewData :" + formViewData.toString());

			log.info("transationId :" + beanTransData.getTransId());
			sampleFormData = sampleTransService.getFormDetailByUsingTransId(beanTransData.getTransId());
			log.info("sampleFormData :" + sampleFormData.toString());

			beanTransData.setFeeName(sampleTransService.getFormDetail(sampleFormData.getFormFeeId()));
			feeLookupDetails = daoFeeService.getFeeDetails("feeid", beanTransData.getTransForm().getFormFeeId())
					.getFeeLookup();

			request.setAttribute("status", beanTransData.getTransStatus());
			ses.setAttribute("sampleFormForView", sampleFormData);
			model.put("beanTransData", beanTransData);
			model.put("formViewData", formViewData);
			return "consolidatedViewAndReceipt";
		} catch (Exception ex) {
			ex.printStackTrace();

			return "consolidatedViewAndReceipt";
		}
	}
	
	@RequestMapping(value = { "/ViewFormlstForApplicantReport" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String ViewFormlstForApplicantReport(ModelMap model, HttpServletRequest request, HttpSession ses) throws Exception {

		SampleTransBean beanTransData = new SampleTransBean();
		String formName = new String();
		ArrayList<SampleFormView> formViewData = new ArrayList();
		BeanFeeLookup feeLookupDetails = new BeanFeeLookup();
		SampleFormBean sampleFormData = new SampleFormBean();
		BeanFormDetails formDetails=new BeanFormDetails();
		CollegeBean cBean = new CollegeBean();
		int flag=0;
		if (ses.getAttribute("sampleFormForView") != null) {
			ses.removeAttribute("sampleFormForView");
		} /*
			 * if (ses.getAttribute("CollegeBean") != null) {
			 * ses.removeAttribute("CollegeBean"); }
			 */
		try {

			beanTransData = sampleTransService.getTransactions(request.getParameter("transId").trim());
			Integer id = beanTransData.getTransForm().getFormFeeId();
			formDetails=sampleFormService.getFormDetails(id);
			formName = formDetails.getFormName();
			cBean=collegeService.getCollegeDetailsOnCode(formDetails.getFormOwnerName());
			HashMap<Integer, String> formDataMap = new HashMap();
			formDataMap = (HashMap<Integer, String>) processFormData(beanTransData.getTransForm().getFormData(), ses);
			log.debug("form data map is : ========> " + formDataMap.toString());
			ses.setAttribute("sesCurrentFormMap", formDataMap);
			formViewData = processFormView(formDataMap, ses, beanTransData.getTransForm().getFormId());
			log.debug("formViewData :" + formViewData.toString());

			sampleFormData = sampleTransService.getFormDetailByUsingTransId(beanTransData.getTransId());
	
			beanTransData.setFeeName(sampleTransService.getFormDetail(sampleFormData.getFormFeeId()));
			feeLookupDetails = daoFeeService.getFeeDetails("feeid", beanTransData.getTransForm().getFormFeeId())
					.getFeeLookup();

			request.setAttribute("status", beanTransData.getTransStatus());
			ses.setAttribute("sampleFormForView", sampleFormData);
			ses.setAttribute("CollegeBean",cBean);
			model.put("beanTransData", beanTransData);
			model.put("formViewData", formViewData);
			return "ViewAndReceiptForApplicant";
		} catch (Exception ex) {
			ex.printStackTrace();

			return "ViewAndReceiptForApplicant";
		}
	}
	
	@RequestMapping(value = "/submitFormDataDis", method = RequestMethod.POST)
	public String submitFormDataDissapprove(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info(" start submitFormDataDissapprove() method ");
		FormActionsBean formActionBean = new FormActionsBean();
		try {
			String formAction;
			SampleFormBean beanCurrentForm = (SampleFormBean) ses.getAttribute("sesCurrentFormData");

			beanCurrentForm = sampleFormService.saveFormData((SampleFormBean) beanCurrentForm);
			ses.setAttribute("sesCurrentFormData", beanCurrentForm);
			FormStateBean formLatestState = lifeCycleService.getLatestState(beanCurrentForm.getFormId());
			if (formLatestState.getState_id() == null) {
				FormLifeCycleBean currentStage = lifeCycleService.getFormCycle((Integer) 0,
						(Integer) beanCurrentForm.getFormTemplateId());
				FormLifeCycleBean nextStage = lifeCycleService.getFormCycle((Integer) 1,
						(Integer) beanCurrentForm.getFormTemplateId());
				FormStateBean currentState = populateStateBean(currentStage, beanCurrentForm, nextStage);
				currentState.setSequence_no(Integer.valueOf(0));
				currentState = lifeCycleService.saveFormState(currentState);
				formAction = currentState.getForm_action();
				formActionBean = lifeCycleService.getFormAction((String) formAction);
				NotifyPayer(currentState, beanCurrentForm, request);
				if (formActionBean.getAction_id() == null) {
					return "PaySessionOut";
				}
				formAction = formActionBean.getAction_type();
			} else {
				boolean isLast = false;
				formAction = formLatestState.getForm_action();
				formActionBean = lifeCycleService.getFormAction((String) formAction);
				if (formActionBean.getAction_id() == null) {
					return "PaySessionOut";
				}
				formAction = formActionBean.getAction_type();
				archiveState(formLatestState);

				FormLifeCycleBean nextStage = new FormLifeCycleBean();
				FormLifeCycleBean currentStage = lifeCycleService.getFormCycle(
						(Integer) formLatestState.getForm_stage(), (Integer) formLatestState.getForm_id());
				nextStage = lifeCycleService.getFormCycle((Integer) currentStage.getStage_number(),
						(Integer) formLatestState.getForm_id());
				FormStateBean currentState = this.populateStateBean(currentStage, beanCurrentForm, nextStage);
				currentState.setSequence_no(Integer.valueOf(formLatestState.getSequence_no() - 1));
				currentState.setState_id(formLatestState.getState_id());
				// log.info(("Form State Id is for " + currentState.getState_id()));
				currentState = lifeCycleService.saveFormState(currentState);
				formAction = currentState.getForm_action();
				formActionBean = lifeCycleService.getFormAction((String) formAction);
				NotifyPayer(currentState, beanCurrentForm, request);
				if (formActionBean.getAction_id() == null) {
					return "PaySessionOut";
				}
				formAction = formActionBean.getAction_type();
			}
			request.setAttribute("msg", "Form successfully submitted for review to the previous user!");
			request.setAttribute("link", "window.close()");
			// log.info(("Next Action is " + formAction));
			if (formAction.contentEquals("Pay Online")) {
				return "ForwardTransaction";
			}
			if (formAction.contentEquals("Review")) {
				return "successPopup";
			}
			return "PaySessionOut";
		} catch (Exception e) {
			e.printStackTrace();
			return "SessionTerminated";
		}
	}

	private ArrayList<SampleFormView> processFormViewForLP(Map<Integer, String> formDataMap, HttpSession ses,
			Integer formId) throws Exception {
		ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
		Double amount = 0.0;
		log.info("processing form");
		ArrayList<Integer> keySet = new ArrayList<Integer>(formDataMap.keySet());
		SampleFormBean formBean = new SampleFormBean();

		if (null != formId) {
			log.info("Now samplle form id is ::::::::::: " + formId);
			formBean = sampleFormService.getFormData(formId);
		}

		int i = 0;
		log.info("key set is :: " + keySet.toString());
		while (i < keySet.size()) {
			String[] formFieldValue = formDataMap.get(keySet.get(i)).split("=");

			String fieldKey = keySet.get(i).toString();
			String fieldValue = formFieldValue[0].toString();
			log.debug("fieldKey in loop is ::: " + fieldKey);
			log.debug("formFieldValue[0].toString() in loop is ::: " + fieldValue + "," + "formFieldValue[1].toString()"
					+ formFieldValue[1].toString());
			
			if (formFieldValue.length != 2) {
				log.info("Form Field Value corrupt or Unreadable");
			} else {
				SampleFormView formViewData = new SampleFormView();
				String[] valueAndOrder = formFieldValue[1].split("\\$");
				log.debug(("value is " + formFieldValue[1] + "and next array is " + valueAndOrder[0]));

				String reGenerateValue = valueAndOrder[0].toString();
				
				// for File Upload process 15 June 2019 by Praveen
				// End code
				if (fieldValue.equalsIgnoreCase("AMOUNT") || fieldValue.equalsIgnoreCase("Total Amount")
						|| fieldValue == "Total Amount" || fieldValue == "AMOUNT"
						|| fieldValue.equalsIgnoreCase("Total_Payable_Amount")
						|| fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
					/* if(fieldValue=="Total Amount" || fieldValue=="AMOUNT"){ */
					log.debug("It is in for Final Amount is for payment");
					amount = Double.parseDouble(reGenerateValue);
				}
				log.debug("Final Amount is for payment :::: " + amount.toString());
				formViewData.setLabel(formFieldValue[0]);
				formViewData.setValue(reGenerateValue);
				try {
					formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim())));
				} catch (ArrayIndexOutOfBoundsException e) {
					formViewData.setOrder(Integer.valueOf(i));
				}

				formViewList.add(formViewData);
			}
			++i;
		}

		log.debug("Final Amount is for payment :::: " + amount.toString());
		ses.setAttribute("amountField", amount);
		Collections.sort(formViewList);
		return formViewList;
	}

/*------------------------------------------------------*/
	private ArrayList<SampleFormView> processFormForView(Map<Integer, String> formDataMap, HttpSession ses, SampleFormBean localFormBean,int flag)
			throws Exception {
		ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
		Double amount = 0.0;
		log.info("processing form");
		ArrayList<Integer> keySet = new ArrayList<Integer>(formDataMap.keySet());

		if (null != localFormBean) {
			log.info("flag log is ::::::::::: " + flag);
		}
		
		int i = 0;
		log.info("key set is :: " + keySet.toString());
		while (i < keySet.size()) {
			String[] formFieldValue = formDataMap.get(keySet.get(i)).split("=");

			String fieldKey = keySet.get(i).toString();
			String fieldValue = formFieldValue[0].toString();
			log.info("fieldKey in loop is ::: " + fieldKey);
			log.info("formFieldValue[0].toString() in loop is ::: " + fieldValue + "," + "formFieldValue[1].toString()"
					+ formFieldValue[1].toString());
			if (formFieldValue.length != 2) {
				log.info("Form Field Value corrupt or Unreadable");
			} else {
				SampleFormView formViewData = new SampleFormView();
				String[] valueAndOrder = formFieldValue[1].split("\\$");
				log.info(("value is " + formFieldValue[1] + "and next array is " + valueAndOrder[0]));

				String reGenerateValue = valueAndOrder[0].toString();
				if (fieldValue.equalsIgnoreCase("AMOUNT") || fieldValue.equalsIgnoreCase("Total Amount")
						|| fieldValue == "Total Amount" || fieldValue == "AMOUNT"
						|| fieldValue.equalsIgnoreCase("Total_Payable_Amount")
						|| fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
					//log.info("It is in for Final Amount is for payment reGenerateValue :::: "+reGenerateValue);
					amount = Double.parseDouble(reGenerateValue);
				}
				log.info("finally reGenerateValue is :::: "+reGenerateValue);
				log.debug("Final Amount is for payment :::: " + amount.toString());
				formViewData.setLabel(formFieldValue[0]);
				formViewData.setValue(reGenerateValue);
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
		// ses.setAttribute("downloadList", downloadList);
		Collections.sort(formViewList);
		return formViewList;
	}
	
	public String getGeneratedStringValue(String filePath) {
		String reGenerateValue="";
		reGenerateValue=filePath.substring(filePath.lastIndexOf("\\")+1,filePath.length());
		int i=reGenerateValue.lastIndexOf("_");
		int j=reGenerateValue.lastIndexOf(".");
		String fname=reGenerateValue.substring(0, i);
		String ext=reGenerateValue.substring(j+1, reGenerateValue.length());
		reGenerateValue=fname+"."+ext;
		log.info("FFFFFFFFFFFFFFFFFF1 valueName :: "+reGenerateValue);
		return reGenerateValue;
	}
/*-------------------------------------------------------------*/
	
	
	private ArrayList<SampleFormView> processFormView(Map<Integer, String> formDataMap, HttpSession ses, Integer formId)
			throws Exception {
		ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
		Double amount = 0.0;
		log.info("processing form");
		ArrayList<Integer> keySet = new ArrayList<Integer>(formDataMap.keySet());
		SampleFormBean formBean = (SampleFormBean) ses.getAttribute("form");

		if (null != formId) {
			log.info("Now samplle form id is ::::::::::: " + formId);
			formBean=sampleFormService.getFormData(formId);
		}
		
		int i = 0;
		log.info("key set is :: " + keySet.toString());
		while (i < keySet.size()) {
			String[] formFieldValue = formDataMap.get(keySet.get(i)).split("=");

			String fieldKey = keySet.get(i).toString();
			String fieldValue = formFieldValue[0].toString();
			log.info("fieldKey in loop is ::: " + fieldKey);
			log.info("formFieldValue[0].toString() in loop is ::: " + fieldValue + "," + "formFieldValue[1].toString()"
					+ formFieldValue[1].toString());
			if (formFieldValue.length != 2) {
				log.info("Form Field Value corrupt or Unreadable");
			} else {
				SampleFormView formViewData = new SampleFormView();
				String[] valueAndOrder = formFieldValue[1].split("\\$");
				log.info(("value is " + formFieldValue[1] + "and next array is " + valueAndOrder[0]));

				String reGenerateValue = valueAndOrder[0].toString();

				if (fieldValue.equalsIgnoreCase("AMOUNT") || fieldValue.equalsIgnoreCase("Total Amount")
						|| fieldValue == "Total Amount" || fieldValue == "AMOUNT"
						|| fieldValue.equalsIgnoreCase("Total_Payable_Amount")
						|| fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
					log.info("It is in for Final Amount is for payment reGenerateValue :::: "+reGenerateValue);
					amount = Double.parseDouble(reGenerateValue);
				}
				
				log.debug("Final Amount is for payment :::: " + amount.toString());
				formViewData.setLabel(formFieldValue[0]);
				formViewData.setValue(reGenerateValue);
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
		// ses.setAttribute("downloadList", downloadList);
		Collections.sort(formViewList);
		return formViewList;
	}

	@RequestMapping(value = "/viewFormforOp", method = RequestMethod.POST)
	public String viewFormforOp(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws Exception {
		SampleTransBean beanTransData = new SampleTransBean();
		Integer transID = Integer.parseInt(request.getParameter("transId"));
		beanTransData = sampleTransService.getTransactions(transID);
		Map<Integer, String> formDataMap = new HashMap();
		formDataMap = processFormData(beanTransData.getTransForm().getFormData(), ses);
		int flag=2;
		ses.setAttribute("sesCurrentFormMap", formDataMap);
		formViewData = processFormForView(formDataMap, ses, beanTransData.getTransForm(),flag);
		return "OptFormDetails";
	}

	@RequestMapping(value = "/submitFormData", method = { RequestMethod.POST, RequestMethod.GET })
	public String submitFormData(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		boolean staleCheckResult = checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
				request.getParameter("formid"), request.getParameter("forminstanceid"), ses);
		// log.info("submit for data " + staleCheckResult);
		if (!staleCheckResult) {
			log.info("staleCheckResult fails...terminated user session");
			request.setAttribute("staleCheckResult", "fail");
			return "SessionTerminated";
		}
		log.info("staleCheckResult passes...");
		FormActionsBean formActionBean = new FormActionsBean();

		try {
			String formAction;
			SampleFormBean beanCurrentForm = (SampleFormBean) ses.getAttribute("sesCurrentFormData");
			beanCurrentForm = sampleFormService.saveFormData((SampleFormBean) beanCurrentForm);
			log.debug("submit form data " + beanCurrentForm.getFormId());
			ses.setAttribute("sesCurrentFormData", beanCurrentForm);
			FormStateBean formLatestState = lifeCycleService.getLatestState(beanCurrentForm.getFormId());
			if (formLatestState.getState_id() == null) {
				FormLifeCycleBean currentStage = lifeCycleService.getFormCycle((Integer) 0,
						(Integer) beanCurrentForm.getFormTemplateId());
				FormLifeCycleBean nextStage = lifeCycleService.getFormCycle((Integer) 1,
						(Integer) beanCurrentForm.getFormTemplateId());
				FormStateBean currentState = populateStateBean(currentStage, beanCurrentForm, nextStage);
				currentState.setSequence_no(Integer.valueOf(0));
				// log.info(("Form State Id is for new" + currentState.getState_id()));
				currentState = lifeCycleService.saveFormState(currentState);
				formAction = currentState.getForm_action();
				formActionBean = lifeCycleService.getFormAction((String) formAction);
				// log.info("at the time of submit " + formActionBean.getAction_id());
				NotifyPayer(currentState, beanCurrentForm, request);
				if (formActionBean.getAction_id() == null) {
					return "PaySessionOut";
				}
				formAction = formActionBean.getAction_type();
			} else {
				boolean isLast = false;
				formAction = formLatestState.getForm_action();
				formActionBean = lifeCycleService.getFormAction((String) formAction);
				if (formActionBean.getAction_id() == null) {
					return "PaySessionOut";
				}
				formAction = formActionBean.getAction_type();
				if (formLatestState.getForm_status().contentEquals("COMPLETE")) {
					isLast = true;
				}
				archiveState(formLatestState);
				if (!isLast) {
					FormLifeCycleBean nextStage = new FormLifeCycleBean();
					FormLifeCycleBean currentStage = lifeCycleService.getFormCycle(
							(Integer) (formLatestState.getForm_stage() + 1), (Integer) formLatestState.getForm_id());
					if (currentStage.getForm_status().contentEquals("COMPLETE")) {
						nextStage.setActor_id(Integer.valueOf(-1));
					} else {
						nextStage = lifeCycleService.getFormCycle((Integer) (currentStage.getStage_number() + 1),
								(Integer) formLatestState.getForm_id());
					}
					FormStateBean currentState = populateStateBean(currentStage, beanCurrentForm, nextStage);
					currentState.setSequence_no(Integer.valueOf(formLatestState.getSequence_no() + 1));
					currentState.setState_id(formLatestState.getState_id());
					// log.info(("Form State Id is for " + currentState.getState_id()));
					currentState = lifeCycleService.saveFormState(currentState);
					formAction = currentState.getForm_action();
					formActionBean = lifeCycleService.getFormAction((String) formAction);
					NotifyPayer(currentState, beanCurrentForm, request);
					if (formActionBean.getAction_id() == null) {
						return "PaySessionOut";
					}
					formAction = formActionBean.getAction_type();
				}
			}
			request.setAttribute("msg", "Form successfully submitted for review to the next user!");
			request.setAttribute("link", "window.close()");
			// log.info(("Next Action is " + formAction));
			if (formAction.contentEquals("Pay Online")) {
				return "ForwardTransaction";
			}
			if (formAction.contentEquals("Review")) {
				return "successPopup";
			}
			return "PaySessionOut";
		} catch (Exception e) {
			e.printStackTrace();
			return "SessionTerminated";
		}
	}

	private void NotifyPayer(FormStateBean currentState, SampleFormBean beanCurrentForm, HttpServletRequest request)
			throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException,
			BadPaddingException {
		log.info("sending mail to notify payer ");
		if (currentState.getNext_actor_id() == -1) {
			return;
		}
		ActorBean nextActor = actorService.getActors(currentState.getNext_actor_id());
		String nextActorPro = nextActor.getProfile();
		EmailSessionBean mailSender = new EmailSessionBean();

		// log.info(("actor profile is " + nextActorPro));
		if (nextActorPro.contentEquals("PAYER")) {
			log.info("Sending Email to Payer");
			StringBuffer url = request.getRequestURL();
			String uri = request.getRequestURI();
			String ctx = request.getContextPath();
			String urlPath = String.valueOf(url.substring(0, url.length() - uri.length() + ctx.length())) + "/";
			LoginBean creds = new LoginBean();
			creds.setActorBean(nextActor);
			if (!loginDAOService.checkUsername(beanCurrentForm.getEmail())) {
				String pass = String
						.valueOf(RandomPasswordGenerator.generatePswd((int) 8, (int) 15, (int) 1, (int) 1, (int) 1));
				PasswordEncryption.encrypt((String) pass);
				String encryptedPwd = PasswordEncryption.encStr;
				creds.setUserName(beanCurrentForm.getEmail());
				creds.setPassword(encryptedPwd);
				creds.setProfile("Actor");
				loginDAOService.saveCreds(creds);
				String msg = "You have pending forms to complete! " + urlPath;

				// SendSMSs.sendSMS(beanCurrentForm.getContact(), msg);
				// mailSender.sendEMailtoPayer(beanCurrentForm.getEmail(), "You have pending
				// forms to complete!", urlPath, beanCurrentForm.getName(),
				// beanCurrentForm.getEmail(), pass);

				ElasticSendMailer.Send(beanCurrentForm.getEmail(), "You have pending forms to complete!", urlPath,
						beanCurrentForm.getName(), beanCurrentForm.getEmail(), pass);

			} else {
				ElasticSendMailer.Send(beanCurrentForm.getEmail(), "You have pending forms to complete!", urlPath,
						beanCurrentForm.getName(), beanCurrentForm.getEmail(), beanCurrentForm.getContact());

				// mailSender.sendEMailtoPayer(beanCurrentForm.getEmail(), "You have pending
				// forms to complete!", urlPath, beanCurrentForm.getName(),
				// beanCurrentForm.getDob(), beanCurrentForm.getContact(), true);
				/*
				 * String msg = "You have pending forms to complete! " +urlPath;
				 * SendSMSs.sendSMS(beanCurrentForm.getContact(), msg);
				 */

			}
		}
	}

	private FormStateBean populateStateBean(FormLifeCycleBean stage, SampleFormBean formData,
			FormLifeCycleBean nextStage) {
		FormStateBean state = new FormStateBean();
		state.setActor_action(stage.getActor_action());
		state.setActor_id(stage.getActor_id());
		state.setForm_id(stage.getForm_id());
		state.setForm_instance_id(formData.getFormId());
		state.setForm_stage(stage.getStage_number());
		state.setForm_status(stage.getForm_status());
		state.setSubmission_date(new Date());
		state.setUsername(formData.getEmail());
		state.setNext_actor_id(nextStage.getActor_id());
		state.setForm_action(stage.getForm_action());
		return state;
	}

	private void archiveState(FormStateBean formLatestState) {
		FormStateHistoryBean stateToArchive = new FormStateHistoryBean();
		stateToArchive.setActor_action(formLatestState.getActor_action());
		stateToArchive.setActor_id(formLatestState.getActor_id());
		stateToArchive.setForm_id(formLatestState.getForm_id());
		stateToArchive.setForm_instance_id(formLatestState.getForm_instance_id());
		stateToArchive.setForm_stage(formLatestState.getForm_stage());
		stateToArchive.setForm_status(formLatestState.getForm_status());
		stateToArchive.setNext_actor_id(formLatestState.getNext_actor_id());
		stateToArchive.setSequence(formLatestState.getSequence_no());
		stateToArchive.setSubmission_date(formLatestState.getSubmission_date());
		stateToArchive.setUsername(formLatestState.getUsername());
		stateToArchive.setForm_action(formLatestState.getForm_action());
		stateToArchive = lifeCycleService.archiveFormState(stateToArchive);
	}

	private void NotifyPayerOfFormLink(SampleFormBean beanCurrentForm, boolean payerCredRequired,
			HttpServletRequest request, HttpSession ses) throws InvalidKeyException, NoSuchAlgorithmException,
			InvalidKeySpecException, InvalidAlgorithmParameterException, UnsupportedEncodingException,
			IllegalBlockSizeException, BadPaddingException {
		/*
		 * log.info("notify form payer is  NotifyPayerOfFormLink :::::::::::: " +
		 * beanCurrentForm.toString() +
		 * " and getdob on this form payer is :::::::::::::" + beanCurrentForm.getDob()
		 * + " and dob date is  " + beanCurrentForm.getDobDate());
		 */
		log.info("Start NotifyPayerOfFormLink() method");
		StringBuffer url = request.getRequestURL();
		// log.info(("request url is::" + url));
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		// log.info(("ctx::" + ctx));
		String urlPath = String.valueOf(url.substring(0, url.length() - uri.length() + ctx.length())) + "/";
		// log.info(("urlPath :: >>> " + urlPath));

		String urlFormLink = String.valueOf(urlPath) + "getPayerFormsById1?formid=" + beanCurrentForm.getFormId()
				+ "&bid=" + ses.getAttribute("BankId") + "&cid=" + ses.getAttribute("CollegeId") + "&PayeeProfile="
				+ ses.getAttribute("PayeeProfile") + "&flag=1";
		log.debug(("urlFormLink :: >>> " + urlFormLink));

		EmailSessionBean mailSender = new EmailSessionBean();
		// String msg = "You have pending forms to complete! " + urlFormLink;
		// SendSMSs.sendSMS(beanCurrentForm.getContact(), msg);

		String msg = "You have pending forms to complete!" + beanCurrentForm.getFormTransId() + " , and Link is !";
		SendSMSs.sendSmsUsingLinkPaisaTinyUrl(beanCurrentForm.getContact(), msg, urlFormLink,
				beanCurrentForm.getEmail());

		/*
		 * new Thread(() -> { ElasticSendMailer.Send(beanCurrentForm.getEmail(),
		 * "You have pending forms to complete!", urlFormLink,
		 * beanCurrentForm.getName(), beanCurrentForm.getEmail(),
		 * beanCurrentForm.getContact()); log.info("mail sent "); }).start();
		 */
	}

	// (http://localhost:8081/QwikForms/validateFieldFormById?formid=46&bid=3&cid=125&PayeeProfile=MAYURBAREILLY)
	// send to client of QForms
	// Use for Open Link Paisa Transaction Flow 15Feb2019 by Dataformdetails formid
	@RequestMapping(value = "/validateFieldFormById", method = { RequestMethod.POST, RequestMethod.GET })
	public String callValidationForm(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.info("inside callValidationForm() Method ");
		String returnFlag = "";
		String browserStatus = "";
		Integer brVer = null;
		String browserName = "";
		browserStatus = browserDetail(request);
		log.info("Browser status for move to form if it is required status 2 ::::::: " + browserStatus);
		Integer cid = Integer.parseInt(request.getParameter("cid").toString());
		Integer bid = Integer.parseInt(request.getParameter("bid").toString());
		String payerProfile = request.getParameter("PayeeProfile");
		BeanFormDetails beanDataForm = new BeanFormDetails();
		CollegeBean colBean = new CollegeBean();
		String dataForm_FormId = request.getParameter("formid");

		try {
			colBean = collegeService.getClientDetailsBasedOnId(cid);
		} catch (Exception e) {

			e.printStackTrace();
		}

		if (null != ses.getAttribute("formViewData")) {
			ses.removeAttribute("formViewData");
		}
		if (null != ses.getAttribute("sampleFormBean")) {
			ses.removeAttribute("sampleFormBean");
		}
		/*
		 * if (null != ses.getAttribute("form")) { ses.removeAttribute("form"); }
		 */
		if (null != ses.getAttribute("formDetails")) {
			ses.removeAttribute("formDetails");
		}
		if (null != ses.getAttribute("formInstanceId")) {
			ses.removeAttribute("formInstanceId");
		}
		if (null != ses.getAttribute("feeAmt")) {
			ses.removeAttribute("feeAmt");
		}
		if (null != ses.getAttribute("feeDetails")) {
			ses.removeAttribute("feeDetails");
		}
		if (null != ses.getAttribute("paidAmount")) {
			ses.removeAttribute("paidAmount");
		}

		if (null != ses.getAttribute("browserName") || null != ses.getAttribute("brVer")) {
			browserName = (String) ses.getAttribute("browserName");
			brVer = (Integer) ses.getAttribute("brVer");
			log.info("Browser name : " + browserName + " : browser version : " + brVer);
		}

		log.info("Browser status for move to form if it is required status 2 ::::::: " + browserStatus);
		if (browserStatus != null && !browserStatus.isEmpty() && browserStatus.equalsIgnoreCase("No")) {
			if (browserName.equalsIgnoreCase("Firefox")) {
				ses.setAttribute("downloadLink", "https://www.mozilla.org/en-US/firefox/new/");
			} else if (browserName.equalsIgnoreCase("Chrome")) {
				ses.setAttribute("downloadLink",
						"https://www.google.com/chrome/?brand=CHBD&gclid=EAIaIQobChMI04SKg-bF5AIVhIRwCh0X0QB9EAAYASAAEgJdWfD_BwE&gclsrc=aw.ds#campaign-promo");
			} else if (browserName.equalsIgnoreCase("Opera")) {
				ses.setAttribute("downloadLink", "https://www.opera.com/hi");
			} else if (browserName.equalsIgnoreCase("IE")) {
				ses.setAttribute("downloadLink",
						"https://www.microsoft.com/en-in/download/Internet-Explorer-11-for-Windows-7-details.aspx");
			} else if (browserName.equalsIgnoreCase("safari")) {
				ses.setAttribute("downloadLink", "https://safari.en.softonic.com/download?ex=DSK-1697.0");
			}

			ses.setAttribute("msgData", "Oops!! : Your Browser (" + browserName + ") Version (" + brVer
					+ ") seems too old. Kindly update." + "from the given download link in this page.");

			returnFlag = "BrowserMissmatchIssue/browser_mismatch_issue";
		} else {

			if (null != colBean) {
				log.debug("colBean " + colBean.toString());
			}

			beanDataForm = sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
			String fieldForValidate = null;
			fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
			String formStatus = beanDataForm.getStatus();

			if ((fieldForValidate != null && !fieldForValidate.equals("")) && formStatus.equalsIgnoreCase("APPROVED")) {
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
				log.debug(("genAlphaNu is::" + genAlphaNum));
				ses.setAttribute("genAlphaNum", genAlphaNum);
			} else {
				request.setAttribute("errorMsg",
						"dose not matched form fild list for validation or form status is not approved. Please contact to your administrator.");
				returnFlag = "errorPage";
			}
		}
		ses.setAttribute("CollegeBean", colBean);
		ses.setAttribute("bid", bid);
		ses.setAttribute("cid", cid);
		ses.setAttribute("payerProfile", payerProfile);
		ses.setAttribute("beanDataForm", beanDataForm);
		return returnFlag;
	}
	
	
	// Get Client details as per given validate value for Linkbased form process
	@RequestMapping(value = "/getClientDetailsNew", method = { RequestMethod.POST, RequestMethod.GET })
	public String getEndUserDetailsNew(ModelMap model, HttpServletRequest request, HttpSession ses)
			throws ParseException, SQLException {
		log.info("inside getEndUserDetailsNew() Method ");
		ArrayList<String> columnNameList = new ArrayList<String>();
		BeanPayerType payerTypeBean = new BeanPayerType();
		String dynFieldData = request.getParameter("values");
		String captcha = request.getParameter("captchaByJsp");
		String approvalStatus=request.getParameter("approvalStatus");
		String matchCaptcha = (String) ses.getAttribute("captchaValue");
		String uName = "NA", uContact = "NA", uEmail = "NA", dobDate = "NA", unique_Key = "NA";
		BeanFormDetails beanDataForm = (BeanFormDetails) ses.getAttribute("beanDataForm");
		Integer formTempId = beanDataForm.getId();
		String clientCode = beanDataForm.getFormOwnerName();
		String lifeCycle = beanDataForm.getLife_cycle();
		String returFlag = "";
		Double amount = 0.0;
		Double feeDetails = 0.0;
		Integer bid = (Integer) ses.getAttribute("bid");
		Integer cid = (Integer) ses.getAttribute("cid");
		String payeeProfile = (String) ses.getAttribute("payerProfile");
		log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "
				+ payeeProfile);
		HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
		List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
		Map<String, Object> tableValueMap = new HashMap<String, Object>();
		ArrayList<String> nameOfFields = new ArrayList<String>();
		List<String> list = new ArrayList<String>();
		
		try {
			feeDetails = lateFeeCalculator.calculateLateFee(beanDataForm);
			log.info("late fee fine for this form is : " + feeDetails);

			payerTypeBean = daoFieldLookupService.getPayerLookupsById(beanDataForm.getPayer_type());
		} catch (Exception e) {
			e.printStackTrace();
		}

		log.debug("formTempId is ::::::::::::::: " + formTempId + " ::::: ClientCode is ::::::: " + clientCode
				+ " ::::: lifeCycle is ::::::: " + lifeCycle);
		log.debug("Table name for this formTempId is ::::::::::::::: " + "{zz_client_user_data_" + formTempId + "}");
		
		String[] formFields = dynFieldData.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		
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
		for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) {
			String[] b = temp.getValue().split("$");
			int k = b[0].indexOf('$');
			String proofresult = b[0].substring(0, k);
			nameOfFields.add(proofresult);
		}

		if (null != nameOfFields
				&& matchCaptcha.equalsIgnoreCase(request.getParameter("captchaByJsp").toString().trim())) {
			
			// Start Use for only GGU form approval process 
			if(null!=approvalStatus) {
				
				String fieldNames = String.join(" && ", nameOfFields);
				log.info("fieldNames in form of string Field Value is" + fieldNames+ "approval status ::::: "+approvalStatus);
				
				String status=sampleTransService.getApprovalStatusForGGUClient(fieldNames, formTempId, clientCode,
						payerTypeBean.getPayer_type());
				log.info("status is comming form db is :::::::: "+status);
				if(!approvalStatus.equalsIgnoreCase(status)) {
					log.info("Client is not approved.");
					request.setAttribute("errorMsg",
							"Your Form is not approved. please contact to admin.");
					return "errorPage";
				}
			}
			// End Use for only GGU form approval process
			
			aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId, clientCode,
					payerTypeBean.getPayer_type(), ses);
			Boolean flag1 = false;
			flag1 = (Boolean) ses.getAttribute("listValueofMap");
			log.info("flag1 value in controller ::::: " + flag1);
			ses.removeAttribute("captchaValue");
			if (flag1 == true) {
				// flag1=true;
				tableValueMap = aliasToValue.get(0);
				columnNameList = (ArrayList<String>) ses.getAttribute("clientDisplayFieldsList");
				ArrayList<String> columnNameList1 = (ArrayList<String>) ses.getAttribute("clientDisplayField");
				log.debug("columnNameList :::::: " + columnNameList.toString());
				log.debug("columnNameList1 :::::: " + columnNameList1.toString());
				ArrayList<String> listDataForm = new ArrayList<String>();
				String key = "";
				for (int j = 0; j < columnNameList.size(); j++) {
					String n = columnNameList.get(j);
					String m = columnNameList1.get(j);
					log.debug("columnNameList " + n + " >> columnNameList " + m);
					for (Map.Entry<String, Object> entry : tableValueMap.entrySet()) {
						if (n.equalsIgnoreCase(entry.getKey()) && !entry.getKey().equalsIgnoreCase("Notification")
								&& !entry.getKey().equalsIgnoreCase("Page_Title")) {
							key = m + "=" + entry.getValue() + "$" + j;
							listDataForm.add(key);
						}
						
//						if ((entry.getKey().equalsIgnoreCase("APPLICANT_NAME")
//								|| entry.getKey().equalsIgnoreCase("STUDENT_NAME")
//								|| entry.getKey().equalsIgnoreCase("NAME")
//								|| entry.getKey().equalsIgnoreCase("Student_Name")) && (uName == "NA")) {
//							uName = entry.getValue().toString();
//							log.debug("new uName is :::::: " + uName.toString());
//						}
//						if ((entry.getKey().equalsIgnoreCase("CONTACT_NUMBER")
//								|| entry.getKey().equalsIgnoreCase("Contact_Number")
//								|| entry.getKey().equalsIgnoreCase("Mobile_Number")
//								|| entry.getKey().equalsIgnoreCase("MOBILE_NUMBER")) && (uContact == "NA")) {
//							uContact = entry.getValue().toString();
//							log.debug("new uContact is :::::: " + uContact.toString());
//						}
//						if ((entry.getKey().equalsIgnoreCase("DATE_OF_BIRTH")
//								|| entry.getKey().equalsIgnoreCase("DATE OF BIRTH")
//								|| entry.getKey().equalsIgnoreCase("DOB") || entry.getKey().equalsIgnoreCase("dob"))
//								&& (dobDate == "NA")) {
//							dobDate = entry.getValue().toString();
//							log.info("new DATE_OF_BIRTH is :::::: " + dobDate.toString());
//						}
//						if ((entry.getKey().equalsIgnoreCase("EMAIL") || entry.getKey().equalsIgnoreCase("EMAIL_ID")
//								|| entry.getKey().equalsIgnoreCase("EMLIL_ID")) && (uEmail == "NA")) {
//							uEmail = entry.getValue().toString();
//							log.debug("new uEmail is :::::: " + uEmail.toString());
//						}
						if ((entry.getKey().equalsIgnoreCase("AMOUNT")
								|| entry.getKey().equalsIgnoreCase("TOTAL_AMOUNT")
								|| entry.getKey().equalsIgnoreCase("Total_Payable_Amount")
								|| entry.getKey().equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")
								|| entry.getKey().equalsIgnoreCase("Amount")
								|| entry.getKey().equalsIgnoreCase("Total_Amount")) && (amount == 0.0)) {
							if ((0.0 != feeDetails || null != feeDetails) && amount == 0.0) {
								if(null!=entry.getValue()) {
									amount = Double.parseDouble(entry.getValue().toString()) + feeDetails;
								}else {
									amount = 0.0 + feeDetails;
								}
							} else {
								if(null!=entry.getValue()) {
									amount = Double.parseDouble(entry.getValue().toString());
								}else {
									amount = 0.0 + feeDetails;
								}
							}
						}
						if (entry.getKey().equalsIgnoreCase("unique_Key") && (unique_Key == "NA")) {
							unique_Key = entry.getValue().toString();
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
						+ uEmail + "}, Amount {" + amount + "}, unique_Key {" + unique_Key + "}");

				if (amount == 0.0 && null != ses.getAttribute("feeAmt")) {
					amount = (Double) ses.getAttribute("feeAmt");
				}

				String listData = String.join(",", listDataForm);
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
				ses.setAttribute("feeDetails", feeDetails);
				model.put("uniqueKey", unique_Key);
				returFlag = showFormSummaryNew(beanDataForm, listData, amount, cid.toString(), bid.toString(), payeeProfile, nameOfFields, ses, request);
				
				if (returFlag == "Requestedsummary") {
					return returFlag;
				} else {
					request.setAttribute("errorMsg",
							"dose not matched form fild list for validation or form status is not approved.");
					return "errorPage";
				}

			} else {
				log.info("It is in else block and send errorpage.");
				request.setAttribute("errorMsg",
						"dose not matched validate value. Please insert correct data in fieldcontact to your administrator.");
				return "errorPage";
			}

		} else {
			log.info("It is in else block and send errorpage.");
			request.setAttribute("errorMsg", "Captcha is not matched");
			return "errorPage";
		}

	}

	// Magicbricks Solution for E-Mandet
	// http://localhost:8081/QForms/validateFieldForMB?formid=1&bid=32&cid=2107&PayeeProfile=TestPayer9Feb

	@RequestMapping(value = "/validateFieldForMB")
	public String payerFormNewForMB(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		if (null != ses.getAttribute("bid") || null != ses.getAttribute("cid")
				|| null != ses.getAttribute("payerProfile") || null != ses.getAttribute("beanDataForm")) {
			ses.removeAttribute("bid");
			ses.removeAttribute("cid");
			ses.removeAttribute("payerProfile");
			ses.removeAttribute("beanDataForm");
		}

		Integer cid = Integer.parseInt(request.getParameter("cid").toString());
		Integer bid = Integer.parseInt(request.getParameter("bid").toString());
		String payerProfile = request.getParameter("PayeeProfile");
		String formId = request.getParameter("formid");
		String formStatus = null, returnFlag = null;

		CollegeBean colBean = collegeService.getClientDetailsBasedOnId(cid);
		if (null != colBean) {
			log.debug("colBean " + colBean.toString());
		}
		ses.setAttribute("CollegeBean", colBean);
		BeanFormDetails beanDataForm = sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
		formStatus = beanDataForm.getStatus();

		if (formStatus.equalsIgnoreCase("APPROVED")) {

			returnFlag = "PayerFormNewForMB";
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
	}

	@RequestMapping(value = "/requestForClientDetailsForMB", method = { RequestMethod.POST, RequestMethod.GET })
	public String requestForClientDetailsForMB(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws Exception {
		log.info("inside requestForClientDetailsForMB() Method ");

		String returFlag = "";
		SampleFormBean sBean = new SampleFormBean();
		HashMap<Integer, String> fieldMap = new HashMap<Integer, String>();
		List<Map<String, Object>> aliasToValue = new ArrayList<Map<String, Object>>();
		Map<String, Object> tableValueMap = new HashMap<String, Object>();
		Map<String, Object> valueMap = new HashMap<String, Object>();
		ArrayList<String> nameOfFields = new ArrayList<String>();
		String uName = "NA", uContact = "NA", uEmail = "NA", dobDate = "NA";
		Double amount = 0.0;
		String usrTransId = request.getParameter("values");
		BeanPayerType payerTypeBean = new BeanPayerType();
		BeanFormDetails beanDataForm = (BeanFormDetails) ses.getAttribute("beanDataForm");
		Integer formTempId = beanDataForm.getId();
		String clientCode = beanDataForm.getFormOwnerName();
		String lifeCycle = beanDataForm.getLife_cycle();
		Integer bid = (Integer) ses.getAttribute("bid");
		Integer cid = (Integer) ses.getAttribute("cid");
		String payeeProfile = (String) ses.getAttribute("payerProfile");
		if (null != columnNameList) {
			columnNameList = new ArrayList<String>();
		}
		ArrayList<String> columnNameList1 = new ArrayList<String>();

		log.info("bid is ::::::::::::::: " + bid + " ::::: cid is ::::::: " + cid + " ::::: payeeProfile is ::::::: "
				+ payeeProfile);
		log.debug("varification flag is ::: " + beanDataForm.getMoveToPg());
		ses.setAttribute("veriflag", beanDataForm.getMoveToPg());
		ses.setAttribute("veriflag1", beanDataForm.getHasInstructions());
		ses.setAttribute("cid", cid);
		ses.setAttribute("bid", bid);

		try {
			payerTypeBean = daoFieldLookupService.getPayerLookupsById(beanDataForm.getPayer_type());
		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("Table name for this formTempId is ::::::::::::::: " + "{zz_client_user_data_" + formTempId + "}");

		log.info("usrTransId is for new transaction ::::::::: " + usrTransId);
		String[] formFields = usrTransId.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));

		log.info(("formFieldsList size is ::::::::::::::: " + formFieldsList.size()));
		int i = 0;
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split("~");
			log.debug("afetr spliting formFieldData values are ::::::::::::::::: " + formFieldData[i].toString());

			if (formFieldData.length != 2) {
				log.info(("Form Field at index " + i + " is corrupt or unreadable"));
			} else {
				fieldMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
			}
			++i;
		}
		log.debug("Before iteration values formDataMap >> " + fieldMap.toString());

		String linkPass = "", qcId = "null";

		for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) {
			// log.info("Field Key is" + temp.getKey());
			// log.info("Field Value is" + temp.getValue());

			String[] b = temp.getValue().split("$");
			// log.info("value of b is " + b.toString());
			int k = b[0].indexOf('$');
			// log.info("value of k is " + k);
			String proofresult = b[0].substring(0, k);
			// log.info("String is in proofresult= " + proofresult);
			nameOfFields.add(proofresult);
			int l = proofresult.indexOf("=");
			linkPass = proofresult.substring(l + 2, proofresult.length() - 1);
			// log.info("String is in linkPass= " + linkPass);
		}

		if (linkPass != "" || !linkPass.isEmpty() || !linkPass.equalsIgnoreCase(null)) {
			log.info("linkPass is  :::::: " + linkPass + " :::::: FormTempId is :::: " + formTempId);
			qcId = sampleFormService.getQfId(linkPass, formTempId);
		}

		if (null == qcId || qcId.equalsIgnoreCase(null) || qcId.equalsIgnoreCase("null") || qcId == "null") {
			request.setAttribute("errorMsg", "Validate password is not matched.");
			return "PayerFormNewForMB";

		} else {
			log.info("qcId is  :::::: " + qcId);
			sBean = sampleFormService.getFormDetailsByQfId(qcId);
		}

		uName = sBean.getName();
		uContact = sBean.getContact();
		dobDate = sBean.getDobDate().toString();
		uEmail = sBean.getEmail();
		amount = sBean.getTransAmount();
		log.info("ApplicantName {" + uName + "}, Contact {" + uContact + "}, dobDate {" + dobDate + "}, EMAIL {"
				+ uEmail + "}, Amount {" + amount + "}");

		if (null != nameOfFields) {

			// aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId,
			// ses);
			aliasToValue = sampleFormService.colNameColValue(nameOfFields, formTempId, clientCode,
					payerTypeBean.getPayer_type(), ses);
		}
		valueMap = aliasToValue.get(0);
		// log.info("valueMap :::::: " + valueMap.toString());
		ArrayList<String> colList = (ArrayList<String>) ses.getAttribute("clientDisplayFieldsList");
		ArrayList<String> colListWithId = (ArrayList<String>) ses.getAttribute("clientDisplayField");

		// log.info("colList :::::: " + colList.toString());
		// log.info("colListWithId :::::: " + colListWithId.toString());

		String cName = "", cNameWithId = "";
		for (int j = 0; j < colList.size(); j++) {
			cName = colList.get(j).replaceAll("hphn", "\\-");
			columnNameList.add(cName);
		}
		log.debug("columnNameList after replacing string to special char :::::: " + columnNameList.toString());

		for (int j = 0; j < colListWithId.size(); j++) {
			cNameWithId = colListWithId.get(j).replaceAll("hphn", "\\-");
			columnNameList1.add(cNameWithId);
		}
		log.debug("columnNameList1 after replacing string to special char :::::: " + columnNameList1.toString());

		String key = "";
		for (int j = 0; j < columnNameList.size(); j++) {
			String n = columnNameList.get(j);
			String m = columnNameList1.get(j);
			// log.info("columnNameList " + n + " >> columnNameList " + m);
			for (Map.Entry<String, Object> entry : valueMap.entrySet()) {
				key = entry.getKey().replaceAll("hphn", "\\-");
				// log.info("key1 value :::: " + key);
				if (n.equalsIgnoreCase(key)) {
					// log.info("tableValueMap :::::: " + tableValueMap.toString());
					tableValueMap.put(key, entry.getValue());
				}
			}
		}

		// log.info("tableValueMap :::::: " + tableValueMap.toString());

		ses.setAttribute("beanFormData", sBean);
		ses.setAttribute("columnNameList", columnNameList);
		ses.setAttribute("columnNameList1", columnNameList1);
		ses.setAttribute("validateFieldNames", nameOfFields);
		ses.setAttribute("payerBeanMap", tableValueMap);
		ses.setAttribute("CollegeCode", clientCode);
		ses.setAttribute("lifeCycle", lifeCycle);

		ses.setAttribute("PayeeProfile", payeeProfile);
		ses.setAttribute("formTempId", formTempId);
		returFlag = showFormSummaryForMB(cid.toString(), bid.toString(), payeeProfile, nameOfFields, ses, request);
		if (returFlag == "temptoDelete") {
			return returFlag;
		} else if (returFlag == "RequestedPayerFormRevival") {
			return returFlag;
		} else {
			request.setAttribute("errorMsg",
					"dose not matched form fild list for validation or form status is not approved. Please contact to your administrator.");
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
		// log.info("formDataValue is :::: " + formDataValue);
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

		if (dobDate == "NA") {
			dobDate = "01-02-2000";
		}

		if (dobDate != null) {
			udobDate = new SimpleDateFormat("dd-MM-yyyy").parse(dobDate);

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
		String code = "NA";
		String formNumber = getGenerateFormNumber(formClientId, formTemplateId);
		String payerId = beanFormDetails.getPayer_type().toString();

		/*
		 * log.info("all values are :::: " + formApplicantId + ", " + formData + ", " +
		 * formTemplateId + ", " + formFeeId + ", " + formClientId + ", " + formFeeName
		 * + ", " + formEndDate + ", " + formStartDate + ", " + formNumber);
		 */
		try {
			beanFormData = new SampleFormBean(formData, formTemplateId, formDate, formInstId, formApplicantId,
					formFeeId, name, udobDate, email, contact, amt, formFeeName, formStartDate, formEndDate, code,
					payerId, formNumber);
			beanFormData = sampleFormService.saveFormDataForLp((SampleFormBean) beanFormData);
			// log.info("this.beanformdata ::: " + this.beanFormData.getFormId());
			ses.setAttribute("beanFormData", beanFormData);
			if (null != beanFormData) {
				return true;
			} else {
				return false;
			}
		} catch (NullPointerException np) {
			np.printStackTrace();
			return false;
		}

	}

	private String showFormSummaryNew(BeanFormDetails dataFormBean, String formData, Double amount, String cid1,
			String bid1, String payeeProfile, ArrayList<String> nameOfFields, HttpSession ses,
			HttpServletRequest request) {

		log.info("inside showFormSummaryNew() Method and amount is : " + amount);

		String returnFlag = "";
		formDetails = new BeanFormDetails();
		payerFormDataMap = new HashMap<Integer, String>();

		String revisedEntereddob = "";
		String formid = "";
		String cid = "";
		String bid = "";
		String payerProfile = "";

		SampleFormBean formDataBean = new SampleFormBean();

		try {
			ses.setAttribute("authVerified", "data_enterd");
			// clientDisplayFieldsList
			cid = cid1;
			bid = bid1;
			payerProfile = payeeProfile;
			log.info("cid is ::::::::::::::: {" + cid + "}, bid is ::::::::: {" + bid + "}, payerprofile is ::::::::: {"
					+ payerProfile + "}");

			colBean = collegeService.validateCollegeAndBank(Integer.valueOf(cid), Integer.valueOf(bid));
			colBean.setCollegeCode(colBean.getCollegeCode());
			log.info(("colBean.getCollegeCode() is.." + colBean.getCollegeCode()
					+ ", :::::::: colBean.getCollegeId() is :::" + colBean.getCollegeId()));

			log.info("payerProfile is.." + payerProfile);

			ses.setAttribute("PayeeProfile", payerProfile);
			ses.setAttribute("CollegeId", colBean.getCollegeId());
			ses.setAttribute("CollegeBean", colBean);
			ses.setAttribute("BankId", colBean.getBankDetailsOTM().getBankId());

			Double paidAmount = amount;

			if (null == nameOfFields) {
				request.setAttribute("msg", "The details provided are incorrect");
				returnFlag = "PayerFormForLP";
				// log.info("The detais provided are incorrect");
				ses.invalidate();
			} else {
				// log.info("usr provided correct dob , mobile");
				// log.info("The detais provided are correct");
				ses.setAttribute("authVerified", "verified");

				String payerFormData = formData;
				// log.info(("payerFormData is::" + payerFormData));

				int formtemplateid = dataFormBean.getId();
				// log.info(("formtemplateid is" + formtemplateid));
				ses.setAttribute("currentFormId", formtemplateid);

				formDetails = sampleFormService.getFormDetails(formtemplateid);
				SetOptionsMap(formDetails, ses);
				SetOptionsMapforPayer(formDetails, ses);
				log.debug(("form name is ::" + formDetails.getFormName()));
				ArrayList al = new ArrayList(formDetails.getFormStructure());
				Collections.sort(al);
				formDetails.setStructureList(al);
				log.debug(("structureList size is " + al.size()));
				int i = 0;
				while (i < formDetails.getStructureList().size()) {
					BeanFormStructure formStructure = (BeanFormStructure) formDetails.getStructureList().get(i);
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
				log.info(("genAlphaNu is::" + genAlphaNum));
				ses.setAttribute("genAlphaNum", genAlphaNum);
				payerFormDataMap = processFormData(payerFormData, ses);
				// log.info("Before Iteration payerFormDataMap " + payerFormDataMap.toString() +
				// "");
				Set<Integer> setOfKeys = payerFormDataMap.keySet();
				for (Integer key : setOfKeys) {
					String value = payerFormDataMap.get(key);
					// log.info(("Key: " + key + ", Value: " + value));

					String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
					// log.info(("Revised Value is: " + revisedValue));
					payerFormDataMap.put(key, revisedValue);
				}
				// log.info("After Iteration payerFormDataMap value is ::::: " +
				// payerFormDataMap.toString() + "");

				ses.setAttribute("feeAmt", formDetails.getFormFee().getFeeBaseAmount());
				ses.setAttribute("currentFee", formDetails.getFormFee());
				ses.setAttribute("formDetails", formDetails);
				ses.setAttribute("payerFormDataMap", payerFormDataMap);
				/* ses.setAttribute("form", form); */
				ses.setAttribute("paidAmount", paidAmount);

				log.info("after the call to getHistoricalFormsListForPayer");
				returnFlag = "Requestedsummary";
				request.setAttribute("feeFieldCount", GetFeeFields(formDetails));
			}
		} catch (NullPointerException e) {
			e.printStackTrace();

		}
		return returnFlag;
	}

	public String showFormSummaryForMB(String cid1, String bid1, String payeeProfile, ArrayList<String> nameOfFields,
			HttpSession ses, HttpServletRequest request) {

		log.info("inside getPayerForms1() Method ");
		colBean = new CollegeBean();
		String returnFlag = "";
		String revisedEntereddob = "";
		String formid = "";
		String cid = "";
		String bid = "";
		String payerProfile = "";

		SampleFormBean formDataBean = new SampleFormBean();

		try {
			ses.setAttribute("authVerified", "data_enterd");
			// clientDisplayFieldsList
			cid = cid1;
			bid = bid1;
			payerProfile = payeeProfile;
			log.debug("cid is ::::::::::::::: {" + cid + "}, bid is ::::::::: {" + bid
					+ "}, payerprofile is ::::::::: {" + payerProfile + "}");

			ses.setAttribute("bid", Integer.parseInt(bid));
			ses.setAttribute("cid", Integer.parseInt(cid));

			colBean = collegeService.validateCollegeAndBank(Integer.valueOf(cid), Integer.valueOf(bid));
			colBean.setCollegeCode(colBean.getCollegeCode());
			ses.setAttribute("PayeeProfile", payerProfile);
			ses.setAttribute("CollegeId", colBean.getCollegeId());
			ses.setAttribute("CollegeBean", colBean);
			ses.setAttribute("BankId", colBean.getBankDetailsOTM().getBankId());
			beanFormData = (SampleFormBean) ses.getAttribute("beanFormData");

			formid = beanFormData.getFormId().toString();

			log.debug(("formid is.." + formid));
			ses.setAttribute("formInstanceId", formid);
			formDataBean = sampleFormService.getFormData(Integer.valueOf(Integer.parseInt(formid)));
			Double amount = formDataBean.getTransAmount();
			ses.setAttribute("feeAmt", amount);
			// log.info(("amount set to session deriving from original form is::" +
			// ses.getAttribute("feeAmt")));

			if (null != formDataBean.getFormNumber() && null != nameOfFields) {
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
				// log.info("usr provided correct dob , mobile");
				// log.info("The detais provided are correct");
				ses.setAttribute("authVerified", "verified");

				formsList = sampleFormService.getFormList(formid, "formid");
				// log.info(("form id is:" + formid));
				ses.setAttribute("formid", formid);
				// log.info(("Form Data ::" + this.formsList.get(0).getFormData()));
				formDataBean = formsList.get(0);

				String payerFormData = formDataBean.getFormData();
				// log.info(("payerFormData is::" + payerFormData));
				int formtemplateid = formDataBean.getFormTemplateId();
				// log.info(("formtemplateid is" + formtemplateid));
				ses.setAttribute("currentFormId", formtemplateid);

				formDetails = sampleFormService.getFormDetails(formtemplateid);
				SetOptionsMap(formDetails, ses);
				SetOptionsMapforPayer(formDetails, ses);
				log.debug(("form name is ::" + formDetails.getFormName()));
				ArrayList al = new ArrayList(formDetails.getFormStructure());
				Collections.sort(al);
				formDetails.setStructureList(al);
				log.debug(("structureList size is " + al.size()));
				int i = 0;
				while (i < formDetails.getStructureList().size()) {
					BeanFormStructure formStructure = (BeanFormStructure) formDetails.getStructureList().get(i);
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
				payerFormDataMap = processFormData(formsList.get(0).getFormData(), ses);
				// log.debug("Before Iteration payerFormDataMap " + payerFormDataMap.toString()
				// + "");
				Set<Integer> setOfKeys = payerFormDataMap.keySet();
				for (Integer key : setOfKeys) {
					String value = payerFormDataMap.get(key);
					// log.info(("Key: " + key + ", Value: " + value));

					String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
					// log.info(("Revised Value is: " + revisedValue));
					payerFormDataMap.put(key, revisedValue);
				}
				// log.info("After Iteration payerFormDataMap value is ::::: " +
				// payerFormDataMap.toString() + "");

				ses.setAttribute("feeAmt", formDetails.getFormFee().getFeeBaseAmount());
				ses.setAttribute("currentFee", formDetails.getFormFee());
				ses.setAttribute("formDetails", formDetails);
				ses.setAttribute("payerFormDataMap", payerFormDataMap);
				ses.setAttribute("form", formDataBean);

				log.info("after the call to getHistoricalFormsListForPayer");
				if (colBean.getCollegeCode().equalsIgnoreCase("PCI99")) {
					returnFlag = "temptoDelete";
				} else {
					returnFlag = "RequestedPayerFormRevival";
				}
				request.setAttribute("feeFieldCount", GetFeeFields(formDetails));

			}
		} catch (NullPointerException e) {
			e.printStackTrace();

		}
		return returnFlag;
	}

	// Use for check field form by the end user
	// http://localhost:8081/QwikForms/getPayerFormsById1?formid=127&bid=4&cid=2313&PayeeProfile=RDVJ1_Payer&flag=1
	@RequestMapping(value = "/getPayerFormsById1", method = { RequestMethod.POST, RequestMethod.GET })
	public String getPayerForms(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.info("inside getPayerFormsById1() Method ");
		colBean = new CollegeBean();
		formDataBean = new SampleFormBean();
		formsList = new ArrayList<SampleFormBean>();
		// SampleFormBean formDataBean = new SampleFormBean();
		SampleTransBean stb = new SampleTransBean();
		// Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
		// Map<Integer, String> revisedPayerFormDataMap = new HashMap<Integer,
		// String>();
		String returnFlag = "";
		// String reviseddobFromDB = "";
		// String revisedEntereddob = "";
		// String formid = "";
		String cid = "";
		String bid = "";
		// String payerProfile = "";
		String dataForm_FormId = null;
		// String fieldForValidate = null;
		if (null != request.getParameter("formid")) {
			dataForm_FormId = request.getParameter("formid");
			log.info("DataForm FormId is :::::::::: " + dataForm_FormId.toString());
		}

		try {
			// String payerAuthenticationType = "";

			if ((null == request.getParameter("qfId") || "".equals(request.getParameter("qfId")))
					&& (Integer.parseInt(request.getParameter("flag")) == 1)) {

				returnFlag = "PayerFormBasedAuthentication";
				log.info("first visit");
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
			} else {

				BeanFormDetails beanDataForm = sampleFormService
						.getFormTempId(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
				if (null != beanDataForm) {

					cid = request.getParameter("cid");
					bid = request.getParameter("bid");
					log.info("cid is ::::::::::::::: {" + cid + "}, bid is ::::::::: {" + bid + "}");
					log.info("request.getParameter(PayeeProfile) ::::::::::::::: "
							+ request.getParameter("PayeeProfile"));
					colBean = collegeService.validateCollegeAndBank(Integer.valueOf(cid), Integer.valueOf(bid));

					log.info(("formid is.." + dataForm_FormId));
					formDataBean = sampleFormService.getFormData(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
					Double amount = formDataBean.getTransAmount();

					formsList = sampleFormService.getFormList(dataForm_FormId, "formid");
					formDataBean = formsList.get(0);
					String payerFormData = formDataBean.getFormData();
					int formtemplateid = formDataBean.getFormTemplateId();

					request.setAttribute("feeAmt", amount);
					request.setAttribute("formInstanceId", dataForm_FormId);
					request.setAttribute("PayeeProfile", request.getParameter("PayeeProfile"));
					ses.setAttribute("CollegeId", colBean.getCollegeId());
					ses.setAttribute("CollegeBean", colBean);
					ses.setAttribute("BankId", colBean.getBankDetailsOTM().getBankId());
					request.setAttribute("bid", Integer.parseInt(bid));
					request.setAttribute("cid", Integer.parseInt(cid));
					ses.setAttribute("authVerified", "verified");
					ses.setAttribute("formid", dataForm_FormId);
					request.setAttribute("currentFormId", formtemplateid);

					stb = sampleTransService.getTransactions(formDataBean.getFormTransId());
					if (null != stb) {
						if (null != stb.getTransStatus() && !"".equalsIgnoreCase(stb.getTransStatus())
								&& stb.getTransStatus().equalsIgnoreCase(ApplicationStatus.SUCCESS.toString())) {
							log.info("form was submitted earlier, so expired");
							request.setAttribute("errorMsg", "The Form Link has expired since the form was submitted!");

							returnFlag = "errorPage";
						} else {
							log.info("form was not submitted earlier, so it is not expired");
							returnFlag = getSubmittedForm(model, ses, beanDataForm);
							log.info("return uri is : 1 =========> " + returnFlag);

							ses.setAttribute("feeAmt", beanDataForm.getFormFee().getFeeBaseAmount());
							ses.setAttribute("currentFee", beanDataForm.getFormFee());
							model.addAttribute("formDetails", beanDataForm);
							model.addAttribute("form", formDataBean);
							request.setAttribute("feeFieldCount", GetFeeFields(beanDataForm));
						}
					} else {
						returnFlag = getSubmittedForm(model, ses, beanDataForm);
						log.info("return uri is : 2 =========> " + returnFlag);
						ses.setAttribute("feeAmt", beanDataForm.getFormFee().getFeeBaseAmount());
						ses.setAttribute("currentFee", beanDataForm.getFormFee());
						model.addAttribute("formDetails", beanDataForm);
						model.addAttribute("form", formDataBean);
						request.setAttribute("feeFieldCount", GetFeeFields(beanDataForm));
					}

				} else {
					request.setAttribute("errorMsg",
							"Details of this user is not present. Please try again to fill the fresh form.");
					returnFlag = "errorPage";
				}
				return returnFlag;
			}

		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		return returnFlag;
	}

	public String getSubmittedForm(Model model, HttpSession ses, BeanFormDetails beanDataForm) {
		log.info("Start of getSubmittedForm() method");
		/* formDetails = sampleFormService.getFormDetails(formtemplateid); */
		Map<Integer, String> revisedPayerFormDataMap = new HashMap<Integer, String>();
		String returnFlag;
		SetOptionsMap(beanDataForm, ses);
		SetOptionsMapforPayer(beanDataForm, ses);
		log.info(("form name is ::" + beanDataForm.getFormName()));
		ArrayList<BeanFormStructure> al = new ArrayList<BeanFormStructure>(beanDataForm.getFormStructure());
		Collections.sort(al);
		beanDataForm.setStructureList(al);
		log.info(("structureList size is " + al.size()));
		int i = 0;
		while (i < beanDataForm.getStructureList().size()) {
			BeanFormStructure formStructure = (BeanFormStructure) beanDataForm.getStructureList().get(i);
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

		ses.setAttribute("genAlphaNum", genAlphaNum);
		payerFormDataMap = processFormData(formsList.get(0).getFormData(), ses);

		Set<Integer> setOfKeys = payerFormDataMap.keySet();
		for (Integer key : setOfKeys) {
			String value = payerFormDataMap.get(key);
			log.debug(("Key: " + key + ", Value: " + value));
			String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
			log.debug(("Revised Value is: " + revisedValue));
			revisedPayerFormDataMap.put(key, revisedValue);
		}
		log.debug("After Iteration payerFormDataMap value is ::::: " + payerFormDataMap.toString() + "");

		returnFlag = "PayerFormRevival";
		model.addAttribute("payerFormDataMap", revisedPayerFormDataMap);
		log.info("End of getSubmittedForm() method");
		return returnFlag;
	}

	@RequestMapping(value = "/photoSignatureUpload", method = { RequestMethod.GET, RequestMethod.POST })
	public String photoSignatureUpload(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @RequestParam MultipartFile userImage) throws IOException {
		String ext = null;
		String imagePath = null;
		Integer totalFileSize = 0;
		block10: {
			byte[] bytes = userImage.getBytes();
			Path path = Paths.get("" + userImage.getOriginalFilename());

			Files.write(path, bytes);
			imagePath = uploadPath + "/img/";
			userImageFileName = userImage.getOriginalFilename();
			totalFileSize = new File(imagePath).listFiles().length;
			totalFileSize = totalFileSize + 1;
			try {
				ext = FilenameUtils.getExtension((String) userImageFileName);
				if (ext.equalsIgnoreCase("jpg") || ext.equalsIgnoreCase("jpeg") || ext.equalsIgnoreCase("png"))
					break block10;
				request.setAttribute("msg", "Please Select an image file with .jpg, .jpeg or .png extension !");
				request.setAttribute("link", "window.close()");
				return "successPopup2";
			} catch (Exception ex) {
				ex.printStackTrace();
				request.setAttribute("msg", "Something went Wrong :( Please try again or contact the administrator!");
				request.setAttribute("link", "window.close()");
				return "successPopup2";
			}
		}
		userImageFileName = StringUtils.removeEnd(userImageFileName, "." + ext);
		userImageFileName = userImageFileName + "_" + totalFileSize + "." + ext;

		File file = new File(imagePath, userImageFileName);

		String dbpath = imagePath + userImageFileName;

		File dstFile = new File(dbpath);

		Path source = Paths.get(userImage.getOriginalFilename());
		Path destination = Paths.get(dstFile.getPath());
		Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
		byte[] bFile = new byte[(int) file.length()];
		try {
			FileInputStream fileInputStream = new FileInputStream(file);
			fileInputStream.read(bFile);
			fileInputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "Something went Wrong :( Please try again or contact the administrator!");
			request.setAttribute("link", "window.close()");
			return "successPopup2";
		}
		
		SampleFormBean beanFormData = (SampleFormBean) ses.getAttribute("sesCurrentFormData");
		Integer currentFormId = (Integer) ses.getAttribute("currentFormId");

		tempFileTypeValue = request.getParameter("tempFileTypeValue");
		log.debug((" tempFileTypeValue number is::" + tempFileTypeValue));
		if (beanFormData == null) {
			beanFormData = new SampleFormBean();
			int randomInt = 0;
			Random randomGenerator = new Random();
			int idx = 1;
			while (idx <= 10) {
				randomInt = randomGenerator.nextInt(10000000);
				++idx;
			}
			String formNumber = "" + randomInt;
			log.debug((" form number is::" + formNumber));
			beanFormData.setFormTemplateId(currentFormId);
			beanFormData.setFormNumber(formNumber);
		}

		if (tempFileTypeValue.contentEquals("photo")) {
			beanFormData.setPhotograph(bFile);
			beanFormData.setPhoto_ext(ext);
		} else if (tempFileTypeValue.contentEquals("sign")) {
			beanFormData.setSignature(bFile);
			beanFormData.setSignature_ext(ext);
		}

		if (null != beanFormData.getPhoto_ext()) {
			log.debug("getPhotograph(bFile)<< : " + beanFormData.getPhotograph().toString()
					+ ", : getPhotograph_EXT(bFile)<< : " + beanFormData.getPhoto_ext());
		} else if (null != beanFormData.getSignature_ext()) {
			log.debug("getPhotograph(bFile)<< : " + beanFormData.getSignature().toString()
					+ ", : getPhotograph_EXT(bFile)<< : " + beanFormData.getSignature_ext());
		} else {
			log.debug("File is not selected");
		}

		ses.setAttribute("currentPhoto", beanFormData.getPhotograph());
		ses.setAttribute("currentPhotoExt", beanFormData.getPhoto_ext());
		ses.setAttribute("currentSignature", beanFormData.getSignature());
		ses.setAttribute("currentSignatureExt", beanFormData.getSignature_ext());
		ses.setAttribute("sesCurrentFormData", beanFormData);
		request.setAttribute("msg", "Your File Has been Successfully Uploaded !");
		request.setAttribute("link", "window.close()");
		return "successPopup2";
	}

	@RequestMapping(value = "/documentFileUploadGeneral", method = RequestMethod.POST)
	public String documentFileUploadGeneral(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @ModelAttribute("formfile") FormFileBean formfile, @RequestParam MultipartFile userFile)
			throws IOException {
		
		String formName = "", payerName = "";
		String newFormName = "";
		String cid = request.getParameter("cidForNewFile");
		String fid = request.getParameter("currentFormId");
		String payerProfile = request.getParameter("PayeeProfile");
		String tempFileTypeValue = request.getParameter("tempFileTypeValue");
		String formInstanceIdForFile=request.getParameter("formInstanceIdForFile");
		log.info("clientId { " + cid + " }, form id { " + fid + " }, payerProfile { " + payerProfile
				+ " }, Document Id {" + tempFileTypeValue + "}, formInstanceIdForFile {"+formInstanceIdForFile+"}");

		payerProfile = stringNameChangeIfSpecialCherIsExist(payerProfile);

		CollegeBean colBeanForFile = collegeService.getClientDetailsBasedOnId(Integer.parseInt(cid));
		BeanFormDetails formDetail = sampleFormService.getFormDetails(Integer.parseInt(fid));
		
		newFormName = stringNameChangeIfSpecialCherIsExist(formDetail.getFormName());

		formName = newFormName + "_" + formDetail.getId();
		payerName = payerProfile + "_" + formDetail.getPayer_type();
		String clientLogoPath = getImagePath(userFile, colBeanForFile.getCollegeCode(), formName, payerName);
		
		log.info("return value is " + clientLogoPath);

		try {
			SampleFormBean beanFormData = (SampleFormBean) ses.getAttribute("sesCurrentFormData");
			//log.info(("beanFormData is" + beanFormData.getFormId()));
			
			Integer currentFormId = (Integer) ses.getAttribute("currentFormId");
				if (beanFormData == null) {				
					beanFormData = new SampleFormBean();
					int randomInt = 0;
					Random randomGenerator = new Random();
					int idx = 1;
					while (idx <= 10) {
						randomInt = randomGenerator.nextInt(10000000);
						log.debug(("Generated : " + randomInt));
						++idx;
					}
					String formNumber = "" + randomInt;
					log.debug((" form number is::" + formNumber));
					beanFormData.setFormTemplateId(currentFormId);
					beanFormData.setFormNumber(formNumber);
				}
//			}
			
			if (tempFileTypeValue != null) {
				switch (tempFileTypeValue) {
				case "Document1":
					beanFormData.setFile_Path1(clientLogoPath);
					log.info(("beanFormData.getFile_Path1() is" + beanFormData.getFile_Path1()));
					ses.setAttribute("Document1",beanFormData.getFile_Path1());
					break;
				case "Document2":
					beanFormData.setFile_Path2(clientLogoPath);
					log.info(("beanFormData.getFile_Path2() is" + beanFormData.getFile_Path2()));
					ses.setAttribute("Document2",beanFormData.getFile_Path2());
					break;
				case "Document3":
					beanFormData.setFile_Path3(clientLogoPath);
					log.info(("beanFormData.getFile_Path3() is" + beanFormData.getFile_Path3()));
					ses.setAttribute("Document3", beanFormData.getFile_Path3());
					break;
				case "Document4":
					beanFormData.setFile_Path4(clientLogoPath);
					log.info(("beanFormData.getFile_Path4() is" + beanFormData.getFile_Path4()));
					ses.setAttribute("Document4", beanFormData.getFile_Path4());
					break;
				case "Document5":
					beanFormData.setFile_Path5(clientLogoPath);
					log.info(("beanFormData.getFile_Path5() is" + beanFormData.getFile_Path5()));
					ses.setAttribute("Document5", beanFormData.getFile_Path5());
					break;
				case "Document6":
					beanFormData.setFile_Path6(clientLogoPath);
					log.info(("beanFormData.getFile_Path6() is" + beanFormData.getFile_Path6()));
					ses.setAttribute("Document6", beanFormData.getFile_Path6());
					break;
				case "Document7":
					beanFormData.setFile_Path7(clientLogoPath);
					log.info(("beanFormData.getFile_Path7() is" + beanFormData.getFile_Path7()));
					ses.setAttribute("Document7", beanFormData.getFile_Path7());
					break;
				case "Document8":
					beanFormData.setFile_Path8(clientLogoPath);
					log.info(("beanFormData.getFile_Path8() is" + beanFormData.getFile_Path8()));
					ses.setAttribute("Document8", beanFormData.getFile_Path8());
					break;
				case "Document9":
					beanFormData.setFile_Path9(clientLogoPath);
					log.info(("beanFormData.getFile_Path9() is" + beanFormData.getFile_Path9()));
					ses.setAttribute("Document9", beanFormData.getFile_Path9());
					break;
				case "Document10":
					beanFormData.setFile_Path10(clientLogoPath);
					log.info(("beanFormData.getFile_Path10() is" + beanFormData.getFile_Path10()));
					ses.setAttribute("Document10", beanFormData.getFile_Path10());
					break;

				default:
					System.out.println("no match");
				}

			}
			
			/*
			 * formfile.setFile_path(clientLogoPath); //formfile.setFile_extension(ext);
			 * Set<FormFileBean> uploadedfiles = beanFormData.getUploadedFiles(); //
			 * HashSet<FormFileBean> uploadedfiles = beanFormData.getUploadedFiles(); if
			 * (uploadedfiles == null) { uploadedfiles = new HashSet<FormFileBean>(); }
			 * this.formfile = formfile; uploadedfiles.add(this.formfile);
			 * beanFormData.setUploadedFiles(uploadedfiles);
			 */
			// beanFormData = sampleFormService.saveFormData((SampleFormBean) beanFormData);
			ses.setAttribute("sesCurrentFormData", beanFormData);
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Something went Wrong :( Please try again or contact the administrator!");
			request.setAttribute("link", "window.close()");
			return "successPopup2";
		}
		request.setAttribute("msg", "Your File Has been Successfully Uploaded !");
		request.setAttribute("link", "window.close()");
		return "successPopup2";
	}

//	private SampleFormBean getAllUploadedFiles(SampleFormBean loclFormBean, HttpSession ses) {
//		
//		Map<String,String> fileMap=(Map<String, String>) ses.getAttribute("uploadedfiles");
//		
//		Set<String> setOfKeys = fileMap.keySet();
//		for (String key : setOfKeys) {
//			log.info("1 :: "+key + " : " + fileMap.get(key));
//			switch (key) {
//			case "Document1":
//				loclFormBean.setFile_Path1(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document2":
//				loclFormBean.setFile_Path2(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document3":
//				loclFormBean.setFile_Path3(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document4":
//				loclFormBean.setFile_Path4(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document5":
//				loclFormBean.setFile_Path5(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document6":
//				loclFormBean.setFile_Path6(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document7":
//				loclFormBean.setFile_Path7(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document8":
//				loclFormBean.setFile_Path8(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document9":
//				loclFormBean.setFile_Path9(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//			case "Document10":
//				loclFormBean.setFile_Path10(fileMap.get(key));
//				log.info(key + " : " + fileMap.get(key));
////				ses.removeAttribute("uploadedfiles");
//				break;
//
//			default:
//				System.out.println("no match");
//			}
//		}
//			
//		return loclFormBean;
//	}
	
	private String getImagePath(MultipartFile companyLogoPath, String colCode, String formName, String payerName) {

		String logoPath = "";
		String reqLogoPath = "";
		if (companyLogoPath != null && !companyLogoPath.isEmpty()) {
			logoPath = ImageUpload.uploadFileHandler(companyLogoPath, colCode, formName, payerName);
			String[] arr = logoPath.split("webapps");
			reqLogoPath = arr[1];
		}
		return reqLogoPath;
	}

	private String stringNameChangeIfSpecialCherIsExist(String stringVal) {
		String string2 = stringVal;

		string2 = string2.replaceAll("\\s", "_");
		string2 = string2.replaceAll("'", "apos");
		string2 = string2.replaceAll("/", "fslsh");
		string2 = string2.replaceAll("\\\\", "bslsh");
		string2 = string2.replaceAll("\\*", "astrk");
		string2 = string2.replaceAll("\\(", "obkt");
		string2 = string2.replaceAll("\\)", "cbkt");
		string2 = string2.replaceAll("\\-", "hphn");
		// string2 = string2.replaceAll("hphn", "\\-");
		string2 = string2.replaceAll("\\:", "cln");
		string2 = string2.replaceAll("\\.", "dot");

		return string2;
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

		optionsMap2 = optionMap;
		ses.setAttribute("optionsMap2", optionsMap2);
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
		optionsMap = optionMap;
		ses.setAttribute("OptionsMap", optionsMap);
	}

	private List<SampleFormBean> getHistoricalFormsListForPayer(HttpServletRequest request) {
		log.info("inside getHistoricalFormsListForPayer method");
		if (request.getParameter("userid") != null && !request.getParameter("userid").equals("")) {
			log.info("inside getHistoricalFormsListForPayer method: user id case");
			String string = request.getParameter("userid");
		} else if (request.getParameter("formid") != null && !request.getParameter("formid").equals("")) {
			log.info("inside getHistoricalFormsListForPayer method: formid id case");
		} else {
			log.info("inside getHistoricalFormsListForPayer method: no id in request");
			return null;
		}
		return formsList;
	}

	private boolean checkStaleSession(String bid, String cid, String formtempid, String forminstanceid,
			HttpSession ses) {
		boolean checkResult = true;
		Integer sesBid = (Integer) ses.getAttribute("BankId");
		Integer sesCid = (Integer) ses.getAttribute("CollegeId");
		Integer formTemplateIdFromSession = (Integer) ses.getAttribute("currentFormId");
		String formInstanceIdFromSession = ses.getAttribute("formInstanceId") == null ? ""
				: (String) ses.getAttribute("formInstanceId");

		if (sesBid != null && !String.valueOf(sesBid).equalsIgnoreCase(bid)) {
			checkResult = false;
			log.info(
					"ummmm, the session is not valid, courtesy the user having started a new session...bids do not match");
		}
		if (sesCid != null && !String.valueOf(sesCid).equalsIgnoreCase(cid)) {
			checkResult = false;
			log.info(
					"ummmm, the session is not valid, courtesy the user having started a new session...cids do not match");
		}
		if (formtempid != null && !String.valueOf(formTemplateIdFromSession).equalsIgnoreCase(formtempid)) {
			checkResult = false;
			log.info(
					"ummmm, the session is not valid, courtesy the user having continued with the form template in the expired session...form templates do not match");
		}
		if (!(forminstanceid == null || forminstanceid.equals("") || forminstanceid.equalsIgnoreCase("null")
				|| "".equalsIgnoreCase(formInstanceIdFromSession)
				|| formInstanceIdFromSession.equalsIgnoreCase(forminstanceid))) {
			checkResult = false;
			log.info(
					"ummmm, the session is not valid, courtesy the user having continued with the form instance in the expired session...form instance ids do not match");
		}
		if (checkResult) {
			log.info("all is well, the session is active...");
		}
		return checkResult;
	}

	public Map<Integer, String> getFormDataInSequence(SampleFormBean formdata, HttpSession ses) {
		Map<Integer, String> finalmap = new HashMap<Integer, String>();
		Map formdataMapRaw = new HashMap();
		String formDataRaw = formdata.getFormData();
		Integer formTemplateId = formdata.getFormTemplateId();
		try {
			BeanFormDetails formdetails = this.sampleFormService.getFormDetails(formTemplateId.intValue());
			ArrayList formsStructure = new ArrayList(formdetails.getFormStructure());
			Collections.sort(formsStructure);
			formdataMapRaw = this.processFormData(formDataRaw, ses);
			int i = 0;
			while (i < formsStructure.size()) {
				Integer fieldId = ((BeanFormStructure) formsStructure.get(i)).getFormField().getLookup_id();
				finalmap.put(fieldId, (String) formdataMapRaw.get(fieldId));
				++i;
			}
			return finalmap;
		} catch (Exception e) {
			e.printStackTrace();
			return finalmap;
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
			log.debug(("optionsfieldcount is" + count));
			return count;
		} catch (Exception e) {
			return count;
		}
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

	public String autoGenerateLinkPassword(String name, String contact) {
		String linkPass = "", mbName = "", mbContact = "";

		if ("" == name || null == name) {
			name = "NPCIKUMAR";
		}
		if ("" == contact || null == contact) {
			contact = "8967453423";
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
		log.debug("genAlphaNum for linkPass is :::::::: " + genAlphaNum);

		mbName = name.substring(0, 4);
		mbContact = contact.substring(5, 9);
		linkPass = getAlphaNumericString(8) + genAlphaNum;
		return linkPass;
	}

	
	
	public ArrayList<SampleFormView> getFormViewData() {
		return this.formViewData;
	}

	public void setFormViewData(ArrayList<SampleFormView> formViewData) {
		this.formViewData = formViewData;
	}

	public SampleFormBean getForm() {
		return this.formDataBean;
	}

	public void setForm(SampleFormBean form) {
		this.formDataBean = form;
	}

	public String getFormName() {
		return this.formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public BeanFeeLookup getFeeLookupDetails() {
		return this.feeLookupDetails;
	}

	public void setFeeLookupDetails(BeanFeeLookup feeLookupDetails) {
		this.feeLookupDetails = feeLookupDetails;
	}

	public BeanFormDetails getFormDetails() {
		return this.formDetails;
	}

	public void setFormDetails(BeanFormDetails formDetails) {
		this.formDetails = formDetails;
	}

	public Map<Integer, String> getPayerFormDataMap() {
		return this.payerFormDataMap;
	}

	public void setPayerFormDataMap(Map<Integer, String> payerFormDataMap) {
		this.payerFormDataMap = payerFormDataMap;
	}

	public CollegeBean getColBean() {
		return this.colBean;
	}

	public void setColBean(CollegeBean colBean) {
		this.colBean = colBean;
	}

	public File getFileUpload() {
		return this.fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getTempFileTypeValue() {
		return this.tempFileTypeValue;
	}

	public void setTempFileTypeValue(String tempFileTypeValue) {
		this.tempFileTypeValue = tempFileTypeValue;
	}

	public File getUserImage() {
		return this.userImage;
	}

	public void setUserImage(File userImage) {
		this.userImage = userImage;
	}

	public String getUserImageContentType() {
		return this.userImageContentType;
	}

	public void setUserImageContentType(String userImageContentType) {
		this.userImageContentType = userImageContentType;
	}

	public String getUserImageFileName() {
		return this.userImageFileName;
	}

	public void setUserImageFileName(String userImageFileName) {
		this.userImageFileName = userImageFileName;
	}

	public FormFileBean getFormfile() {
		return this.formfile;
	}

	public void setFormfile(FormFileBean formfile) {
		this.formfile = formfile;
	}

	public Map<Integer, List<String>> getOptionsMap() {
		return this.optionsMap;
	}

	public void setOptionsMap(Map<Integer, List<String>> optionsMap) {
		this.optionsMap = optionsMap;
	}

	public Map<Integer, List<String>> getOptionsMap2() {
		return this.optionsMap2;
	}

	public void setOptionsMap2(Map<Integer, List<String>> optionsMap2) {
		this.optionsMap2 = optionsMap2;
	}

	public String showTerminatedSession() {
		return "success";
	}

	public SampleFormService getSampleFormService() {
		return sampleFormService;
	}

	public void setSampleFormService(SampleFormService sampleFormService) {
		this.sampleFormService = sampleFormService;
	}

	public SampleTransService getSampleTransService() {
		return sampleTransService;
	}

	public void setSampleTransService(SampleTransService sampleTransService) {
		this.sampleTransService = sampleTransService;
	}

	public LifeCycleService getLifeCycleService() {
		return lifeCycleService;
	}

	public void setLifeCycleService(LifeCycleService lifeCycleService) {
		this.lifeCycleService = lifeCycleService;
	}

	public DaoFieldLookupService getDaoFieldLookupService() {
		return daoFieldLookupService;
	}

	public void setDaoFieldLookupService(DaoFieldLookupService daoFieldLookupService) {
		this.daoFieldLookupService = daoFieldLookupService;
	}

	public ActorService getActorService() {
		return actorService;
	}

	public void setActorService(ActorService actorService) {
		this.actorService = actorService;
	}

	public DaoFeeService getDaoFeeService() {
		return daoFeeService;
	}

	public void setDaoFeeService(DaoFeeService daoFeeService) {
		this.daoFeeService = daoFeeService;
	}

	public LoginDAOService getLoginDAOService() {
		return loginDAOService;
	}

	public void setLoginDAOService(LoginDAOService loginDAOService) {
		this.loginDAOService = loginDAOService;
	}

	public CollegeService getCollegeService() {
		return collegeService;
	}

	public void setCollegeService(CollegeService collegeService) {
		this.collegeService = collegeService;
	}

	public SessionFactory getFactory() {
		return factory;
	}

	public void setFactory(SessionFactory factory) {
		this.factory = factory;
	}

	public List<String> getTxtfield() {
		return txtfield;
	}

	public void setTxtfield(List<String> txtfield) {
		this.txtfield = txtfield;
	}

	public List<SampleFormBean> getFormsList() {
		return formsList;
	}

	public void setFormsList(List<SampleFormBean> formsList) {
		this.formsList = formsList;
	}

	public List<BeanFormStructure> getStructureList() {
		return structureList;
	}

	public void setStructureList(List<BeanFormStructure> structureList) {
		this.structureList = structureList;
	}

	public ArrayList<String> getColumnNameList() {
		return columnNameList;
	}

	public void setColumnNameList(ArrayList<String> columnNameList) {
		this.columnNameList = columnNameList;
	}

	public SampleFormBean getBeanFormData() {
		return beanFormData;
	}

	public void setBeanFormData(SampleFormBean beanFormData) {
		this.beanFormData = beanFormData;
	}

	public SampleTransBean getBeanTransData() {
		return this.beanTransData;
	}

	public void setBeanTransData(SampleTransBean beanTransData) {
		this.beanTransData = beanTransData;
	}
}
