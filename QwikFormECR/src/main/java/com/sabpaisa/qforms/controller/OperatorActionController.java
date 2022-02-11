package com.sabpaisa.qforms.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.services.OperatorDaoService;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.RandomPasswordGenerator;
import com.sabpaisa.qforms.util.SendMail;

@CrossOrigin
@Controller
@RequestMapping
public class OperatorActionController {

	private static final long serialVersionUID = 1L;

	@Autowired
	private OperatorDaoService operatorDaoService;
	
	private static Logger log = LogManager.getLogger(OperatorActionController.class.getName());
	private String opInstId;
	private LoginBean loginUser = new LoginBean();
	private CollegeBean collegeBean = new CollegeBean();
	private OperatorBean operatorBean = new OperatorBean();
	
	/* AffBean affBean = new AffBean(); */
	private List<OperatorBean> listOprtBean = new ArrayList<OperatorBean>();
	
	@RequestMapping(value="/operatorDash",method = {RequestMethod.GET})
	public ModelAndView operatorDash(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
		
		log.info("work in OperatorDash() for configuration");
		
		ModelAndView mav = new ModelAndView("OperatorDash");
		ses=request.getSession();
		
		return mav;

	}

	@RequestMapping(value="/operator_report",method = {RequestMethod.GET})
	public ModelAndView operatorReport(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
		
		log.info("work in operatorReport() for configuration");
		
		ModelAndView mav = new ModelAndView("operator_report_consolidated");
		ses=request.getSession();
		
		return mav;

	}
	
	@RequestMapping(value="/adminReportConsolidated",method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView adminReportConsolidated(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
		
		log.info("work in adminReportConsolidated() for configuration");
		
		ModelAndView mav = new ModelAndView("admin_report_consolidated");
		ses=request.getSession();
		
		return mav;

	}
	
	@RequestMapping(value = "operatorForm", method = RequestMethod.GET)
	public String registerCollegeOperatorAction(HttpServletRequest request, HttpSession ses, HttpServletResponse response, Model model) throws InvalidKeyException, NoSuchAlgorithmException,
			InvalidKeySpecException, InvalidAlgorithmParameterException, UnsupportedEncodingException,
			IllegalBlockSizeException, BadPaddingException {
		// AffDAO affDAO = new AffDAO();

		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		collegeBean = loginUser.getCollgBean();

		String username = new String();
		// generate credentials for admin login
		try {
			username = "Op".concat(operatorBean.getOperatorName().concat(operatorBean.getOperatorLstName())
					.replaceAll("\\s+", "").substring(0, 4).concat(operatorDaoService.getRowCount().toString()));

		} catch (java.lang.NullPointerException e) {
			username = "Op".concat(operatorBean.getOperatorName().concat(operatorBean.getOperatorLstName())
					.replaceAll("\\s+", "").substring(0, 4).concat("1"));

		}

		String password = RandomPasswordGenerator.generatePswd(6, 8, 1, 2, 0);
		// log.info("Password Generated is " + password);

		PasswordEncryption.encrypt(password);

		String encryptedPwd = PasswordEncryption.encStr;

		LoginBean creds = new LoginBean();

		creds.setPassword(encryptedPwd);
		creds.setUserName(username);

		creds.setProfile("Operator");

		creds.setOperatorBean(operatorBean);

		operatorBean.setLoginBean(creds);
		operatorBean.setCollegeBean_fk(collegeBean);

		/* Integer instId = Integer.parseInt(opInstId); */

		/* affBean = affDAO.viewInstDetail(instId); */

		/*
		 * log.info("Institutre Name is ::" + affBean.getInstName());
		 * 
		 * operatorBean.setCollegeName(affBean.getInstName());
		 */

		/*
		 * affBean.getOptrBeanSet().add(operatorBean);
		 * operatorBean.setAffBean(affBean);
		 * 
		 * affDAO.saveOrUpdate(affBean, null);
		 */

		/*
		 * if (creds.getProfile().equals("CollegeOperator")) {
		 * 
		 * // for bidirectional relationship ,set child record to // Parent //
		 * record operatorBean.setLoginBean(creds);
		 * 
		 * }
		 */

		String value = operatorDaoService.registerCollegeOperatorDao(operatorBean);
		
		if(value.equals("true"))
		{
			// -----Code for sending email//--------------------

			String emailContent = "Welcome to the QwiCollect portal of " + operatorBean.getCollegeBean_fk().getCollegeName();
			SendMail email = new SendMail();
			email.sendRegMail("Welcome To QForms !", operatorBean.getOperatorEmail(), username, password,
					emailContent, operatorBean.getOperatorName() + " " + operatorBean.getOperatorLstName());

			request.setAttribute("msg", "Operator Added Successfully");
			request.setAttribute("redirectLink", "Success.jsp");

			/* request.setAttribute("msg", "Operator Added Successfully"); */

			return "Success";
		}
		else
		{
			return "errorPage";
		}
		
	}

	public String addOperator(HttpServletRequest request) {

		operatorDaoService.registerCollegeOperatorDao(operatorBean);

		request.setAttribute("msg", "Successfully Regstered ...");
		return "SUCCESS";
	}

	// Getting All Records of College Operators
	@RequestMapping(value = "/getAllOperatorList", method = RequestMethod.POST)
	public String getListOfCollegeOperators(Model model, HttpSession ses) {
		try {

			CollegeBean bean = (CollegeBean) ses.getAttribute("CollegeBean");
			log.debug("college bean is : >>>>>>>>>>>>>>>>>>>>>>>"+bean.toString()+":::: cid ::::::: "+bean.getCollegeId().toString());
			
			Integer cid = bean.getCollegeId();
			// listAffBean = affDAO.getCollegesList();

			listOprtBean = operatorDaoService.getAllRecordsOfCollegeOperator(cid);
			ses.setAttribute("listOprtBean", listOprtBean);

			log.debug(listOprtBean.size() + ":size of the list");
		} catch (NullPointerException e) {
			e.printStackTrace();
			return "SessionTerminated";

		}

		return "admin-Operators";
	}

	@RequestMapping(value = { "/EditOperatorDetails" }, method = RequestMethod.GET)
	public String editOperatorDetailsAction(Model model, HttpServletRequest request,HttpSession ses) {

		operatorBean = operatorDaoService.getOperatorDetails(Integer.parseInt(request.getParameter("id")));
		ses.setAttribute("operatorBean", operatorBean);
		return "EditOperator";
	}
	
	@RequestMapping(value = { "/viewOperatorDetails" }, method = RequestMethod.GET)
	public String viewOperatorDetailsAction(Model model, HttpServletRequest request,HttpSession ses) {

		operatorBean = operatorDaoService.getOperatorDetails(Integer.parseInt(request.getParameter("id")));
		ses.setAttribute("operatorBean", operatorBean);
		return "operatorDetails";
	}

	@RequestMapping(value = { "/UpdateOperator" }, method = RequestMethod.GET)
	public String updateOperator(Model model,HttpServletRequest request) {
		operatorDaoService.updatePersonalRecordOfCollegeOperatorDetail(operatorBean);
		request.setAttribute("msg", "Operator updated successfully");

		return "Success";
	}

	@RequestMapping(value = { "/deleteOperatorDetails" }, method = RequestMethod.GET)
	public String deleteOperatorDetailsAction(Model model, HttpServletRequest request) {

		operatorDaoService.deleteOperatorDetails(Integer.parseInt(request.getParameter("id")));
		request.setAttribute("msg", "Successfully deleted ...");
		return "Success";
	}

	/*
	 * public String getOperatorLogin() { HttpSession httpSession =
	 * request.getSession(); loginBean = (LoginBean)
	 * httpSession.getAttribute("loginUserBean");
	 * 
	 * return SUCCESS; }
	 * 
	 * 
	 * 
	 * public String getOpInstId() { return opInstId; }
	 * 
	 * public void setOpInstId(String opInstId) { this.opInstId = opInstId; }
	 * 
	 * public AffBean getAffBean() { return affBean; }
	 * 
	 * public void setAffBean(AffBean affBean) { this.affBean = affBean; }
	 * 
	 * public List<AffBean> getListAffBean() { return listAffBean; }
	 * 
	 * public void setListAffBean(List<AffBean> listAffBean) { this.listAffBean
	 * = listAffBean; }
	 * 
	 * public LoginBean getLoginBean() { return loginBean; }
	 * 
	 * public void setLoginBean(LoginBean loginBean) { this.loginBean =
	 * loginBean; }
	 */
	
	
	public List<OperatorBean> getListOprtBean() {
		return listOprtBean;
	}

	public void setListOprtBean(List<OperatorBean> listOprtBean) {
		this.listOprtBean = listOprtBean;
	}

	public LoginBean getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(LoginBean loginUser) {
		this.loginUser = loginUser;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
