package com.sabpaisa.qforms.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
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

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.communication.EmailSessionBean;
import com.sabpaisa.qforms.services.ActorService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.OperatorDaoService;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.SendSMS;

@CrossOrigin
@Controller
@RequestMapping
public class LoginActionController {

	@Autowired
	private ActorService actorService;

	@Autowired
	SessionFactory factory;

	@Autowired
	CollegeService collegeService;

	@Autowired
	LoginDAOService loginDAOService;

	@Autowired
	DaoFieldLookupService daoFieldLookupService;

	@Autowired
	OperatorDaoService operatorDaoService;

	private static Logger log = LogManager.getLogger(LoginActionController.class.getName());
	private boolean isfromBank;
	List<BeanPayerType> beanPayerTypeLst = new ArrayList<BeanPayerType>();
	List<ActorBean> actorList = new ArrayList<ActorBean>();
	Integer cid, bid;
	LoginBean loginBean = new LoginBean();
	private String firstName /* ,newPwd */;
	private CollegeBean collegeBean = new CollegeBean();
	private BankDetailsBean bankBean = new BankDetailsBean();
	private String profile;
	private String emailId;
	
	@RequestMapping(value = { "/cLogin" }, method = { RequestMethod.GET})
	public ModelAndView showLogin(HttpServletRequest request/*, 
			@ModelAttribute("showLog") LookupRoleDaoImpl lRoleDaoImpl*/) {

		ModelAndView mav = null;

		mav = new ModelAndView("LoginAdmin");

		return mav;
	}

	@RequestMapping(value = { "/clientLogin" }, method = { RequestMethod.POST })
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public ModelAndView clientLogin(Model model, HttpServletRequest request, HttpServletResponse response,
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
				log.info("valid User name and Password");
				httpSession.setAttribute("loginSuccess", true);
				Cookie usercookie = new Cookie("userName", loginBean.getUserName());
				usercookie.setMaxAge(60 * 1);
				response.addCookie(usercookie);
				httpSession.setAttribute("cart_init", 0);
				Object loginUserId = loginDAOService.getIdOFLoginUser(profile, loginBean);
				log.debug("loginUserId is in LoginActionController ::::::::::: " + loginUserId.toString()
						+ " :: and profile is :::::: " + profile.toString());
				if (profile.contentEquals("Institute")) {
					collegeBean = collegeService.viewCollegeDetail(Integer.parseInt(loginUserId.toString()));
					mav = new ModelAndView("adminDash");
					log.info("Valid College");
					httpSession.setAttribute("sesProfile", "Institute");
					httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
					httpSession.setAttribute("CollegeBean", collegeBean);
					httpSession.setAttribute("loginUserBean", collegeBean.getLoginBean());
					log.info("BEFORE GETTING BEAN ");
					return mav;
				} else if (profile.contentEquals("Operator")) {
					OperatorBean operatorBean = operatorDaoService.viewOperatorDetail(Integer.parseInt(loginUserId.toString()));
					log.info("Valid Operator");
					mav = new ModelAndView("OperatorDash");
					httpSession.setAttribute("sesProfile", "Operator");
					httpSession.setAttribute("dashLink", "OperatorDash.jsp");
					log.info("BEFORE GETTING BEAN ");
					httpSession.setAttribute("OperatorId", operatorBean.getOperatorId());
					httpSession.setAttribute("OperatorBean", operatorBean);
					httpSession.setAttribute("loginUserBean", operatorBean.getLoginBean());
					httpSession.setAttribute("CollegeBean", operatorBean.getCollegeBean_fk());
					httpSession.setAttribute("CollegeId", operatorBean.getCollegeBean_fk().getCollegeId());
					return mav;
				} else if (profile.contentEquals("Actor")) {
					ActorBean actorBean = actorService.getActors(Integer.parseInt(loginUserId.toString()));
					log.info("Valid Actor");
					mav = new ModelAndView("LoginActor");
					httpSession.removeAttribute("currentFormId");
					httpSession.removeAttribute("formInstanceId");
					httpSession.removeAttribute("formid");
					httpSession.removeAttribute("BankId");
					httpSession.removeAttribute("CollegeId");

					httpSession.setAttribute("sesProfile", "Actor");
					httpSession.setAttribute("dashLink", "actor_pending_list.jsp");
					httpSession.setAttribute("payeeProfile", actorBean.getActor_id() + "$actor");
					httpSession.setAttribute("PayeeProfile", actorBean.getActor_id() + "$actor");
					log.info("BEFORE GETTING BEAN ");
					httpSession.setAttribute("Actor_id", actorBean.getActor_id());
					httpSession.setAttribute("ActorBean", actorBean);
					CollegeBean cbean = collegeService.viewInstDetail(actorBean.getClient_id());
					httpSession.setAttribute("CollegeBean", cbean);
					BankDetailsBean bankBean = cbean.getBankDetailsOTM();
					log.debug("bid fetched is::" + bankBean.getBankId());

					httpSession.setAttribute("BankId", bankBean.getBankId());
					httpSession.setAttribute("CollegeId", actorBean.getClient_id());
					httpSession.setAttribute("PayerUsername", loginBean.getUserName());

					return mav;
				}
			}
		} catch (java.lang.NullPointerException e) {
			request.setAttribute("msg", "Session Time Out");

			return mav;
		}
		return mav;
	}

	@RequestMapping(value = { "/validateCollegeAndBank" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String validateCollegeAndBank(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession,
			@ModelAttribute("loginBean") LoginBean loginbean, Model model) throws InvalidKeyException,
			NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException,
			IOException, NoSuchAlgorithmException, InvalidKeySpecException {
		
		log.info("inside validateCollegeAndBank() method");
		
		bid = Integer.parseInt(request.getParameter("bid"));
		cid = Integer.parseInt(request.getParameter("cid"));

		boolean isfromBank = Boolean.parseBoolean(request.getParameter("isfromBank"));
		if (isfromBank) {
			log.info("inside isFromBank login is " + isfromBank);
			try {
				if(null!=httpSession.getAttribute("uploadedfiles")){
					log.info("in if block for removing previous sessions");
					httpSession.removeAttribute("uploadedfiles");
				}
				collegeBean = collegeService.validateCollegeAndBank(cid, bid);
				log.debug("return back to LoginController and valule of collegeBean is ::::::::::: "
						+ collegeBean.toString());
				

				beanPayerTypeLst = daoFieldLookupService.getPayerDetails(collegeBean, bid);
				log.debug("return back to LoginController and valule of beanPayerTypeLst is ::::::::::: "
						+ beanPayerTypeLst.toString());

				bankBean = collegeService.getBankDetailsBasedOnId(bid.toString());
				log.debug("return back to LoginController and getting actors for client id ::::::::::: "
						+ collegeBean.getCollegeId());

				actorList = actorService.getActors("payers", collegeBean.getCollegeId());
				log.debug("got actors size {" + actorList.size() + "}");

				httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
				httpSession.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
				httpSession.setAttribute("CollegeBean", collegeBean);
				httpSession.setAttribute("bankBean", bankBean);
				httpSession.setAttribute("beanPayerTypeLst", beanPayerTypeLst);
				httpSession.setAttribute("actorList", actorList);
				return "PayerFlow";

			} catch (NoSuchElementException e) {
				log.info("no such Element Exception");
				request.setAttribute("msg", "URL not supported");
				return "InvalidUserPage";
			} catch (Exception e) {
				log.info("Unknown College Validation Error");
				request.setAttribute("msg", "URL not supported");
				return "InvalidUserPage";
			}

		} else {

			
			loginBean = loginbean;

			log.debug("user Name is ::" + loginBean.getUserName());
			log.debug("Password is ::" + loginBean.getPassword());
			String encryptedPwd = null;

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
					request.setAttribute("msg", "Invalid Username or Password");
					return "InvalidUserPage";
				}
			} catch (java.lang.IndexOutOfBoundsException e) {
				request.setAttribute("msg", "Invalid Username or Password");
				return "InvalidUserPage";
			}

			try {

				if (null != profile) {

					log.info("valid User name and Password");
					httpSession.setAttribute("loginSuccess", true);

					Cookie usercookie = new Cookie("userName", loginBean.getUserName());
					usercookie.setMaxAge(60 * 1);
					response.addCookie(usercookie);
					httpSession.setAttribute("cart_init", 0);

					Object loginUserId = loginDAOService.getIdOFLoginUser(profile, loginBean);

					if (profile.contentEquals("Institute")) {

						collegeBean = collegeService.viewCollegeDetail(Integer.parseInt(loginUserId.toString()));

						log.info("Valid College");
						httpSession.setAttribute("sesProfile", "Institute");
						
						httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
						httpSession.setAttribute("CollegeBean", collegeBean);
						httpSession.setAttribute("loginUserBean", collegeBean.getLoginBean());

						log.info("BEFORE GETTING BEAN ");

						return "adminDash";
					} else if (profile.contentEquals("Operator")) {

						OperatorBean operatorBean = operatorDaoService
								.viewOperatorDetail(Integer.parseInt(loginUserId.toString()));
						log.info("Valid Operator");
						httpSession.setAttribute("sesProfile", "Operator");
						httpSession.setAttribute("dashLink", "OperatorDash.jsp");
						log.info("BEFORE GETTING BEAN ");
						httpSession.setAttribute("OperatorId", operatorBean.getOperatorId());
						httpSession.setAttribute("OperatorBean", operatorBean);
						httpSession.setAttribute("loginUserBean", operatorBean.getLoginBean());
						httpSession.setAttribute("CollegeBean", operatorBean.getCollegeBean_fk());
						httpSession.setAttribute("CollegeId", operatorBean.getCollegeBean_fk().getCollegeId());
						return "OperatorDash";
					} else if (profile.contentEquals("Actor")) {

						ActorBean actorBean = actorService.getActors(Integer.parseInt(loginUserId.toString()));
						log.info("Valid Actor");
						httpSession.removeAttribute("currentFormId");
						httpSession.removeAttribute("formInstanceId");
						httpSession.removeAttribute("formid");
						httpSession.removeAttribute("BankId");
						httpSession.removeAttribute("CollegeId");

						httpSession.setAttribute("sesProfile", "Actor");
						httpSession.setAttribute("dashLink", "actor_pending_list.jsp");
						httpSession.setAttribute("payeeProfile", actorBean.getActor_id() + "$actor");
						httpSession.setAttribute("PayeeProfile", actorBean.getActor_id() + "$actor");
						log.info("BEFORE GETTING BEAN ");
						httpSession.setAttribute("Actor_id", actorBean.getActor_id());
						httpSession.setAttribute("ActorBean", actorBean);
						CollegeBean cbean = collegeService.viewInstDetail(actorBean.getClient_id());
						httpSession.setAttribute("CollegeBean", cbean);
						BankDetailsBean bankBean = cbean.getBankDetailsOTM();
						log.debug("bid fetched is::" + bankBean.getBankId());

						httpSession.setAttribute("BankId", bankBean.getBankId());
						httpSession.setAttribute("CollegeId", actorBean.getClient_id());
						httpSession.setAttribute("PayerUsername", loginBean.getUserName());

						return "LoginActor";
					}
				}
			} catch (java.lang.NullPointerException e) {

				request.setAttribute("msg", "Session Time Out");

				return "InvalidUserPage";
			}
			return "InvalidUserPage";
		}
	}

	@RequestMapping(value = { "/LoginUser" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String userLogin(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession,
			@ModelAttribute("loginBean") LoginBean loginbean, Model model) throws InvalidKeyException,
			NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException,
			IOException, NoSuchAlgorithmException, InvalidKeySpecException {
		
		String userName = request.getParameter("userName");
		String cobpassword = request.getParameter("password");
		String requestType = request.getParameter("requestType");

		String serviceId = request.getParameter("serviceId");
		
		/*log.info("got bid:::" + bid + " ...  user location toDate>>" + toDate);*/
		log.info("got Cid:::" + cid + " " + isfromBank);
		log.debug("user namee and service id formDate" + "formDate" + "ll" + userName + " requesttype " + requestType
				+ " ser " + serviceId);

		if (isfromBank) {
			try {
				collegeBean = collegeService.validateCollegeAndBank(cid, bid);
				log.debug("collegebean data is " + collegeBean.toString());
				log.debug("show basic form " + collegeBean.getCompanyBean().getId());
				httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
				httpSession.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
				httpSession.setAttribute("CollegeBean", collegeBean);
				log.debug("bean type payer list is " + collegeBean.toString() + " " + bid);
				beanPayerTypeLst = daoFieldLookupService.getPayerDetails(collegeBean, bid);
				bankBean = collegeService.getBankDetailsBasedOnId(bid.toString());
				log.debug("getting actors for client id " + collegeBean.getCollegeId() + " size "
						+ beanPayerTypeLst.size() + " " + bankBean.getBankname());

				log.debug("got " + actorList.size() + " actors");
				return "PayerFlow";

			} catch (NoSuchElementException e) {
				log.info("no such Element Exception");
				request.setAttribute("msg", "URL not supported");
				return "InvalidUserPage";
			} catch (Exception e) {
				log.info("Unknown College Validation Error");
				request.setAttribute("msg", "URL not supported");
				return "InvalidUserPage";
			}

		} else {

			
			if (requestType == null) {
				log.debug("user Name is ::" + loginBean.getUserName());
				log.debug("Password is ::" + loginBean.getPassword());
				String encryptedPwd = null;

				// to Encrypt Password
				PasswordEncryption.encrypt(String.valueOf(loginBean.getPassword()));
				encryptedPwd = PasswordEncryption.encStr;
				loginBean.setPassword(encryptedPwd);
				log.debug("testing :" + encryptedPwd);
			} else {
				log.debug("cob user Name is ::" + userName);
				log.debug("cobpassword is ::" + cobpassword);
				String encryptedPwd = null;

				// to Encrypt Password
				PasswordEncryption.encrypt(String.valueOf(cobpassword));
				encryptedPwd = PasswordEncryption.encStr;
				loginBean.setPassword(encryptedPwd);
				loginBean.setUserName(userName);
				log.debug("testing :" + encryptedPwd);
			}

			String profile = null;
			try {
				profile = loginDAOService.getDetailsOfLoginUser(loginBean);
				log.debug("Profile is " + profile);
				if (profile == null) {
					httpSession.setAttribute("loginSuccess", false);
					httpSession.removeAttribute("loginUserBean");
					request.setAttribute("msg", "Invalid Username or Password");
					return "InvalidUserPage";
				}
			} catch (java.lang.IndexOutOfBoundsException e) {
				request.setAttribute("msg", "Invalid Username or Password");
				return "InvalidUserPage";
			}

			try {

				if (null != profile) {

					log.info("valid User name and Password");
					httpSession.setAttribute("loginSuccess", true);

					Cookie usercookie = new Cookie("userName", loginBean.getUserName());
					usercookie.setMaxAge(60 * 1);
					response.addCookie(usercookie);
					httpSession.setAttribute("cart_init", 0);

					log.debug("profile and login bean is " + profile + "  " + loginBean);
					Object loginUserId = loginDAOService.getIdOFLoginUser(profile, loginBean);
					log.debug("request type for identitfying " + requestType);
					if (profile.contentEquals("Institute")) {
						log.debug("request type in case of college " + requestType);
						if (requestType != "COB") {
							log.info("for college when request type is not cob ");
							collegeBean = collegeService.viewCollegeDetail(Integer.parseInt(loginUserId.toString()));

							log.info("Valid College");
							httpSession.setAttribute("sesProfile", "Institute");
							httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
							httpSession.setAttribute("CollegeBean", collegeBean);
							httpSession.setAttribute("loginUserBean", collegeBean.getLoginBean());

							log.debug("college name and code " + collegeBean.getCollegeName() + " code "
									+ collegeBean.getCollegeCode());
							if (collegeBean.getCollegeName().contentEquals("MDU")
									|| collegeBean.getCollegeCode().contentEquals("MDA11")) {
								log.info("Inside MDA");

								return "collegeMDA";
							}
						}

						else {
							log.debug("calling when request type is cob with serviceId is " + serviceId);
							collegeBean = collegeService.viewCollegeDetail(serviceId);

							log.debug("Valid College " + collegeBean.getCollegeId());
							httpSession.setAttribute("sesProfile", "Institute");
							httpSession.setAttribute("CollegeId", collegeBean.getCollegeId());
							httpSession.setAttribute("CollegeBean", collegeBean);
							httpSession.setAttribute("loginUserBean", collegeBean.getLoginBean());
						}

						return "adminDash";
					} else if (profile.contentEquals("Operator")) {

						OperatorBean operatorBean = operatorDaoService
								.viewOperatorDetail(Integer.parseInt(loginUserId.toString()));
						log.info("Valid Operator");
						httpSession.setAttribute("sesProfile", "Operator");
						httpSession.setAttribute("dashLink", "OperatorDash.jsp");
						log.info("BEFORE GETTING BEAN ");
						httpSession.setAttribute("OperatorId", operatorBean.getOperatorId());
						httpSession.setAttribute("OperatorBean", operatorBean);
						httpSession.setAttribute("loginUserBean", operatorBean.getLoginBean());
						httpSession.setAttribute("CollegeBean", operatorBean.getCollegeBean_fk());
						httpSession.setAttribute("CollegeId", operatorBean.getCollegeBean_fk().getCollegeId());
						return "OperatorDash";
					} else if (profile.contentEquals("Actor")) {

						ActorBean actorBean = actorService.getActors(Integer.parseInt(loginUserId.toString()));
						log.info("Valid Actor");
						httpSession.removeAttribute("currentFormId");
						httpSession.removeAttribute("formInstanceId");
						httpSession.removeAttribute("formid");
						httpSession.removeAttribute("BankId");
						httpSession.removeAttribute("CollegeId");

						httpSession.setAttribute("sesProfile", "Actor");
						httpSession.setAttribute("dashLink", "actor_pending_list.jsp");
						httpSession.setAttribute("payeeProfile", actorBean.getActor_id() + "$actor");
						httpSession.setAttribute("PayeeProfile", actorBean.getActor_id() + "$actor");
						log.info("BEFORE GETTING BEAN ");
						httpSession.setAttribute("Actor_id", actorBean.getActor_id());
						httpSession.setAttribute("ActorBean", actorBean);
						CollegeBean cbean = collegeService.viewInstDetail(actorBean.getClient_id());
						httpSession.setAttribute("CollegeBean", cbean);
						BankDetailsBean bankBean = cbean.getBankDetailsOTM();
						log.debug("bid fetched is::" + bankBean.getBankId());

						httpSession.setAttribute("BankId", bankBean.getBankId());
						httpSession.setAttribute("CollegeId", actorBean.getClient_id());
						httpSession.setAttribute("PayerUsername", loginBean.getUserName());

						return "LoginActor";
					}
				}
			} catch (java.lang.NullPointerException e) {

				request.setAttribute("msg", "Session Time Out");

				return "InvalidUserPage";
			}
			return "InvalidUserPage";
		}
	}

	@RequestMapping(value = "/verifyEmailOTP", method = RequestMethod.POST)
	public String verifyEmailOTPAction(HttpServletRequest request, Model model) {

		String emailID = request.getParameter("emailId");
		log.info(request.getParameter("emailId"));

		String password = Math.random() + "";
		password = password.substring(3, 8);
		log.info(password + "hello is Random number");
		String username = "Your OTP of QuickCollect";

		// -----Code for sending email//--------------------
		EmailSessionBean email = new EmailSessionBean();
		email.sendOTPToEmail(emailID, "Welcome To FeeDesk!", username, password);

		request.setAttribute("oTPCode", password);

		return "Login-OTP";
	}

	@RequestMapping(value = "/verifymobileNoOTP", method = RequestMethod.POST)
	public String verifymobileNoOTPAction(HttpServletRequest request, Model model) {

		String mobileNum = request.getParameter("mobileNo");

		String password = Math.random() + "";
		password = password.substring(3, 8);
		log.info(password + "hello is Random number");

		SendSMS sms = new SendSMS();
		sms.sendOTPToSMS(mobileNum, password);

		request.setAttribute("oTPCode", password);

		return "Login-OTP";
	}

	@RequestMapping(value = "/formOperatorAction", method = RequestMethod.POST)
	public String formOperatorAction(Model model) {

		return "formOperator";
	}

	/*@RequestMapping(value = "/adminReportConsolidated", method = RequestMethod.POST)
	public String adminReportConsolidated(Model model) {
		return "admin_report_consolidated";
	}*/

	@RequestMapping(value = "/adminDash", method = RequestMethod.GET)
	public String adminDash(Model model) {
		return "adminDash";
	}

	@RequestMapping(value = "/verifyOTP", method = RequestMethod.POST)
	public String verifyOTPAction(HttpServletRequest request, Model model) {

		Integer otpString = Integer.parseInt(request.getParameter("code"));
		Integer otpCode = Integer.parseInt(request.getParameter("userOTP"));

		if (otpString != otpCode) {
			return "Login-OTP";
		}

		return "index";
	}

	@RequestMapping(value = { "/logOutUser" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String logoutUser(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession,
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
		request.setAttribute("redirectLink", "Login.jsp");

		return "LoginAdmin";
	}

	@RequestMapping(value = { "/collegePage" }, method = RequestMethod.POST)
	public String viewCollegeForm(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession,
			Model model) {
		request.getParameter("id");

		if (Integer.parseInt(request.getParameter("id")) == 2) {
			log.info(request.getParameter("id") + " page no:");
			return "formDetails";
		} else {

			log.info(request.getParameter("id") + " page no:");
			return "formDetails";
		}

	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	public boolean isIsfromBank() {
		return isfromBank;
	}

	public void setIsfromBank(boolean isfromBank) {
		this.isfromBank = isfromBank;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public List<ActorBean> getActorList() {
		return actorList;
	}

	public void setActorList(List<ActorBean> actorList) {
		this.actorList = actorList;
	}

	public BankDetailsBean getBankBean() {
		return bankBean;
	}

	public void setBankBean(BankDetailsBean bankBean) {
		this.bankBean = bankBean;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

}
