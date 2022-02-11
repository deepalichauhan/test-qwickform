package com.sabpaisa.qforms.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.ServicesBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LifeCycleService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.LookupRoleService;
import com.sabpaisa.qforms.services.MainLoginService;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.SendMail;

@CrossOrigin
@Controller
@RequestMapping
public class MainLoginController {

	@Autowired
	private LookupRoleService lookupRoleService;

	@Autowired
	SessionFactory factory;

	@Autowired
	LifeCycleService lifeCycleService;

	@Autowired
	private CollegeService collegeService;

	@Autowired
	private MainLoginService loginService;

	@Autowired
	LoginDAOService loginDAOService;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	private static Logger log = LogManager.getLogger(MainLoginController.class.getName());

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String cobUrl = properties.getProperty("cobUrl");
	DBConnection connection = new DBConnection();

	@RequestMapping(value = { "/saLogin" }, method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	//@CrossOrigin
	public ModelAndView superAdminLoginByCob(ModelMap model, HttpServletRequest request) {

		log.info("Start of superAdminLoginByCob() method in mainLoginController");
		HttpSession ses = request.getSession();
		List<BankDetailsBean> bankDetailsList = new ArrayList<BankDetailsBean>();
		List<StateBean> stateList = new ArrayList<StateBean>();
		List<ServicesBean> servicesList = new ArrayList<ServicesBean>();
		List<SuperAdminBean> companyList = new ArrayList<SuperAdminBean>();

		ModelAndView mav = null;
		SuperAdminBean sAdminBean = null;
		String userId = request.getParameter("userName");
		String password = request.getParameter("pass");

		String clientId = request.getParameter("clientId");
		String regTymName = request.getParameter("cobUserName");
		String idForCob = request.getParameter("idForCob");

		String cobpassword = request.getParameter("password");
		String requestType = request.getParameter("requestType");
		String url = "";
		log.info("outside if:::" + clientId + "requestType>>" + requestType + " : cobpassword : " + cobpassword
				+ " regTymName>>> " + regTymName);
		log.info("id for cob " + idForCob);

		try {
			PasswordEncryption.encrypt(String.valueOf(password));
			password = PasswordEncryption.encStr;
		} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException
				| InvalidAlgorithmParameterException | UnsupportedEncodingException | IllegalBlockSizeException
				| BadPaddingException e1) {
			e1.printStackTrace();
		}

		//log.info("user Name" + regTymName + " Password " + password);
		if (requestType == null) {
			try {
				sAdminBean = loginService.getLoginforCob(userId, password);
				if (sAdminBean == null) {
					mav = new ModelAndView("SAPortal");
					request.setAttribute("msg", "Invalid Username or Password");
					return mav;
				}
				mav = new ModelAndView("saPortalhome");
				log.info("User Name of Super Admin is == " + sAdminBean.getUserName());
				ses.setAttribute("sABean", sAdminBean);
				ses.setAttribute("sesCID", sAdminBean.getCompanyBean().getId());
				return mav;
			} catch (Exception e) {
				log.info("Ravi Jr's code exception" + e);
			}
			mav = new ModelAndView("SAPortal");
			return mav;
		} else {
			//log.info("else::: " + requestType + " clientId " + clientId);
			if (clientId == null) {
				log.info("in inner if");
				try {
					PasswordEncryption.encrypt(String.valueOf(cobpassword));
					cobpassword = PasswordEncryption.encStr;
				} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException
						| InvalidAlgorithmParameterException | UnsupportedEncodingException | IllegalBlockSizeException
						| BadPaddingException e1) {
					e1.printStackTrace();
				}
				sAdminBean = loginDAOService.getLogin(regTymName, cobpassword);

				if (sAdminBean == null) {
					mav = new ModelAndView("SAPortal");
					request.setAttribute("msg", "Invalid Username or Password");
					return mav;
				}
				mav = new ModelAndView("saPortalhome");
				//log.info("User Name of Super Admin is == " + sAdminBean.getUserName());
				ses.setAttribute("sABean", sAdminBean);
				ses.setAttribute("sesCID", sAdminBean.getCompanyBean().getId());
				return mav;
			} else {
				try {
					PasswordEncryption.encrypt(String.valueOf(cobpassword));
					cobpassword = PasswordEncryption.encStr;
					sAdminBean = loginDAOService.getLogin(regTymName, cobpassword);
					if (sAdminBean == null) {
						mav = new ModelAndView("SAPortal");
						request.setAttribute("msg", "Invalid Username or Password");
						return mav;
					}

					log.info("url:http://qforms.sabpaisa.in/clientOnBoarding/GetClientByID?clientId=" + clientId);
					log.info("Neww cob url is :::: " + cobUrl + "GetClientByID?clientId=" + clientId);
					url = cobUrl + "GetClientByID?clientId=" + clientId;

					log.info("User Name of Super Admin is == " + sAdminBean.getUserName());
					ses.setAttribute("sABean", sAdminBean);
					ses.setAttribute("sesCID", sAdminBean.getCompanyBean().getId());
					request.setAttribute("clientId", clientId);
					request.setAttribute("idForCob", idForCob);

					bankDetailsList = collegeService.getBankDetails(sAdminBean);
					stateList = collegeService.getStateList();
					servicesList = collegeService.getServicesList();
					companyList = collegeService.getcompantList();

					log.info("bankdetail { " + bankDetailsList.size() + " } statelist { " + stateList.size()
							+ " } serviceList { " + servicesList.size() + " } companylist { " + companyList.size()
							+ " }");
					ses.setAttribute("bankDetailsList", bankDetailsList);
					ses.setAttribute("stateList", stateList);
					model.put("servicesList", servicesList);
					ses.setAttribute("companyList", companyList);
					mav = new ModelAndView("addClientToQFormsUI");

					return mav;
				} catch (Exception e) {
					log.info("code for exception" + e);
				}
			}
			return mav;
		}
	}

	@RequestMapping(value = { "/loginProcess" }, method = RequestMethod.GET)
	public ModelAndView showLoginProcess(HttpServletRequest request, @ModelAttribute("login") SuperAdminBean mlogin) {
		HttpSession ses = request.getSession();
		ModelAndView mav = null;
		mlogin = (SuperAdminBean) ses.getAttribute("sABean");

		if (null != mlogin) {
			log.info("mlogin is >>>>>>>>>>>>>>>" + ses.getAttribute("sABean").toString());
			mav = new ModelAndView("saPortalhome");
			mav.addObject("userName", mlogin.getUserName());
			return mav;
		} else {
			mav = new ModelAndView("SessionTerminated");
			return mav;
		}

	}

	@RequestMapping(value = { "/addSuperAdminDetails" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String addSuperAdminDetailsInfo(HttpServletRequest request, ModelMap model, HttpSession ses) {

		return "SuperAdmin";
	}

	@RequestMapping(value = { "/EditSuperAdminDetailsById" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String getSuperAdminDetailsInfo(HttpServletRequest request, ModelMap model, HttpSession ses) {
		SuperAdminBean superAdmin = new SuperAdminBean();
		try {
			log.info("Super Admin ID is =" + request.getParameter("id"));
			superAdmin = loginDAOService.getSuperAdminDetailsBasedOnId(request.getParameter("id"));

			String pwdQC = PasswordEncryption.decryptQC(String.valueOf(superAdmin.getPass()));
			model.put("superAdmin", superAdmin);

			return "editSuperAdmin";
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "editSuperAdmin";
	}

	/*@RequestMapping(value = { "/GetSuperAdminDetails/{id}" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String getSuperAdminDetails(@PathVariable String id, ModelMap model, HttpServletRequest request) {
		log.info("start of getSuperAdminDetails() method in MainLoginController");
		HttpSession ses = request.getSession();
		List<SuperAdminBean> saList = new ArrayList<SuperAdminBean>();
		//String comId = request.getParameter("comid");
		String returnVal = "";
		if (null != id) {
			log.info("compid is : >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + id.toString());
			saList = loginDAOService.getAllSuperAdminDetails(id);
			log.info("size of list:" + saList.size());
			// saList = getSuperAllAdmin(comId, ses);
			model.put("saList", saList);
			returnVal = "sa-SuperAdmin";
		} else {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}*/
	
	
	@RequestMapping(value = { "/GetSuperAdminDetails" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String getSuperAdminDetails(ModelMap model, HttpServletRequest request) {
		log.info("start of getSuperAdminDetails() method in MainLoginController");
		HttpSession ses = request.getSession();
		List<SuperAdminBean> saList = new ArrayList<SuperAdminBean>();
		String comId = request.getParameter("comid");
		String returnVal = "";
		if (null != comId) {
			log.info("compid is : >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + comId.toString());
			saList = loginDAOService.getAllSuperAdminDetails(comId);
			log.info("size of list:" + saList.size());
			// saList = getSuperAllAdmin(comId, ses);
			model.put("saList", saList);
			returnVal = "sa-SuperAdmin";
		} else {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}

	public String getSuperAllAdmin(String comId) {

		log.info("Start of getSuperAllAdmin() method and " + "Companey ID is : >>>>>>>>>>>>>>>>>>>>>>>>>>> "
				+ comId.toString());
		List<SuperAdminBean> saList = new ArrayList();
		saList = loginDAOService.getAllSuperAdminDetails(comId);
		//log.info("saList is in controller part : >>>>>>>>>>>>>>>>>>>>" + saList.toString());
		for (SuperAdminBean bean : saList) {
			log.info(":username:" + bean.getUserName());
		}
		log.info("size of list:" + saList.size());
		return "success";
	}

	public List<SuperAdminBean> getSuperAllAdmin(String comId, HttpSession ses) {

		log.info("Start of getSuperAllAdmin() method and " + "Companey ID is : >>>>>>>>>>>>>>>>>>>>>>>>>>>"
				+ comId.toString());
		List<SuperAdminBean> saList = new ArrayList();
		saList = loginDAOService.getAllSuperAdminDetails(comId);
		//log.info("saList is in controller part : >>>>>>>>>>>>>>>>>>>>" + saList.toString());
		for (SuperAdminBean bean : saList) {
			log.info(":username:" + bean.getUserName());
		}
		log.info("size of list:" + saList.size());
		return saList;
	}

	@RequestMapping(value = { "/reg" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String saveSuperAdminDetails(@ModelAttribute SuperAdminBean superAdmin) {
		log.info("Inside SA Registration ");
		// SuperAdminBean superAdmin = new SuperAdminBean();
		String pass = null;

		try {
			superAdmin = loginDAOService.saveUser(superAdmin);
			pass = PasswordEncryption.decryptQC(String.valueOf(superAdmin.getPass()));
		} catch (Exception e) {

			e.printStackTrace();
		}

		String emailContent = "Welcome to the QwikForms SuperAdmin Password Update " + superAdmin.getContact();
		SendMail email = new SendMail();

		email.sendRegMail("Welcome To QForms !", superAdmin.getEmail(), superAdmin.getUserName(), pass, emailContent,
				"");

		return "Success";
	}

	@RequestMapping(value = { "/EditSuperAdminDetails" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String EditSuperAdmin(HttpServletRequest request, ModelMap model,
			@ModelAttribute SuperAdminBean superAdmin) {
		try {
			String enterPass = superAdmin.getPass();
			/*
			 * boolean pass1 =
			 * enterPass.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*(_|[^\\w])).+$");
			 * 
			 * log.info("Password is = " + pass1);
			 */
			if (null != enterPass) {
				log.info("Pass");
				loginDAOService.EditSupeAdminDetails(superAdmin);
				String emailContent = "Welcome to the QwiCollect SuperAdmin Password Update " + superAdmin.getContact();
				SendMail email = new SendMail();

				email.sendRegMail("Welcome To QForms !", superAdmin.getEmail(), superAdmin.getUserName(), enterPass,
						emailContent, "");
				request.setAttribute("msg", "Admin Details  updated successfully...");
			} else {
				log.info("Fail");
				request.setAttribute("msg", "Some Field Havin wrong Entry :(");
				return "editSuperAdmin";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "Success";
	}

	private void sendUrlTOCob(String formId, Integer collegeId, Integer bankId, String idForCob) {

		log.info("called send url to cob , form link");
		log.info("form id " + formId + " cid " + collegeId + " bid " + bankId + " idforcob " + idForCob);

		String urlLink = "idForQf=" + idForCob + "&&qfCidId=" + collegeId + "&&qfBidId=" + bankId;
		log.info("url link is " + urlLink);
		String cobUrl = properties.getProperty("cobUrl");
		try {
			String cobSendUrL = properties.getProperty("cobUrl");
			log.info("cob send url is " + cobSendUrL);
			URL url = new URL(cobSendUrL + "/updateQcLinkForEvent?" + urlLink);

			log.info("final url for cob is " + url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			log.info("conn is " + conn.getResponseCode());

			int responseCode = conn.getResponseCode();
			log.info("Response Code : " + responseCode);
			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
			}
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

			String output, str = null;
			log.info("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				str = output;
			}
			log.info("//" + str);
			conn.disconnect();
		} catch (MalformedURLException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		}
	}

}
