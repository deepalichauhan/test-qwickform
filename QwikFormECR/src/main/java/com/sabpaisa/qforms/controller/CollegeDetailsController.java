package com.sabpaisa.qforms.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.ServicesBean;
import com.sabpaisa.qforms.beans.SpConfigBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.beans.WhiteLableTempBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.test.ImageUpload;
import com.sabpaisa.qforms.util.ApplicationStatus;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.RandomPasswordGenerator;
import com.sabpaisa.qforms.util.SendMail;

@CrossOrigin
@Controller
@RequestMapping
public class CollegeDetailsController {

	@Autowired
	private CollegeService collegeService;

	private CollegeBean collegeBean = new CollegeBean();
	private BankDetailsBean bankDetailsBean = new BankDetailsBean();
	private ClientMappingCodeOfSabPaisa clientMappingDetails = new ClientMappingCodeOfSabPaisa();
	ClientMappingCodeOfSabPaisa clientMappingBean = new ClientMappingCodeOfSabPaisa();
	private List<ServicesBean> servicesList = new ArrayList<ServicesBean>();
	private ServicesBean servicesBean = new ServicesBean();
	private SuperAdminBean superAdminBean = new SuperAdminBean();
	private LoginBean loginBeanCob = new LoginBean();
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String qFormsIP = properties.getProperty("qFormsIP");
	String uploadPath = properties.getProperty("qFormsImgFloderPath");
	String quickCollectImgFloderPath = properties.getProperty("quickCollectImgFloderPath");
	String cobUrl = properties.getProperty("cobUrl");
	private String colId;
	private String clientBankId;
	private String userImageFileName;
	private String userImageContentType;
	private File userImage;
	List<CollegeBean> filteredCollegeList;
	List<CollegeBean> collegelst = new ArrayList<CollegeBean>();
	List<WhiteLableTempBean> whitelableList = new ArrayList<WhiteLableTempBean>();
	private List<ClientMappingCodeOfSabPaisa> clientMappingCodeOfSabPaisa = new ArrayList<ClientMappingCodeOfSabPaisa>();

	private List<BankDetailsBean> bankDetailsList = new ArrayList<BankDetailsBean>();
	private ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa = new ClientMappingCodeOfSabPaisa();
	private List<StateBean> stateList = new ArrayList<StateBean>();
	private List<SuperAdminBean> companyList = new ArrayList<SuperAdminBean>();
	private static Logger log = LogManager.getLogger(CollegeDetailsController.class.getName());
	private String bankId;

	@RequestMapping(value = "/clientDashBoadDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String getClientDashBoadDetails(HttpServletRequest request) {
		HttpSession ses = request.getSession();
		SuperAdminBean superAdmin = (SuperAdminBean) ses.getAttribute("sABean");
		CollegeBean collegeBean = new CollegeBean();
		String returnVal = "";
		if (null != ses.getAttribute("sABean")) {
			log.debug("superadminbean is :: " + superAdmin.toString());
			log.debug("id value:" + request.getParameter("id"));
			try {
				collegeBean = collegeService.viewInstDetail(Integer.valueOf(Integer.parseInt(request.getParameter("id"))));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
			ses.setAttribute("CollegeBean", collegeBean);
			ses.setAttribute("loginUserBean", collegeBean.getLoginBean());
			log.debug("loginUserBean:" + collegeBean.getLoginBean().getUserName());
			returnVal = "clientDetails";
		} else {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}

	@RequestMapping(value = "/addSabPaisaClientMapping", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addSabPaisaClientMapping(HttpServletRequest request) {

		log.debug("work in addSabPaisaClientMapping() for configuration");

		ModelAndView mav = new ModelAndView("addSabPaisaClientMapping");

		return mav;
	}

	@RequestMapping(value = "/SaveSabPaisaClientMappingDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveSabPaisaClientMappingDetails(Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession ses,
			@ModelAttribute("clientMapping") ClientMappingCodeOfSabPaisa clientMappingbean) {

		Boolean result = Boolean.valueOf(false);

		collegeBean = collegeService.getClientDetailsBasedOnId(Integer.parseInt(clientMappingbean.getCid()));
		clientMappingBean = clientMappingbean;

		result = collegeService.saveSabPaisaClientMappingDetailsDao(collegeBean, clientMappingBean);

		if (result.booleanValue()) {
			request.setAttribute("msg", "client Mapping Details saved successfull..");
		} else {
			request.setAttribute("msg", "sorry..");
		}
		log.debug("college name:" + clientMappingBean.getCMCode() + " : " + clientMappingBean.getCMProfile() + " : "
				+ clientMappingBean.getCid());

		return "Success";
	}
	
//	@RequestMapping(value = "/addNewFormTarget", method = { RequestMethod.GET, RequestMethod.POST })
//	public ModelAndView addNewFormTarget(HttpServletRequest request) {
//
//		log.info("work in addNewFormTarget() in collegedetailscontroller");
//		HttpSession ses = request.getSession();
//		CollegeBean colBean = new CollegeBean();
//
//		if (null != request.getParameter("college_Id")) {
//			log.info("updated collegeid is ::: ==========> " + request.getParameter("college_Id"));
//		}
//		colBean = (CollegeBean) ses.getAttribute("CollegeBean");
//		ModelAndView mav = null;
//
//		if (null != colBean) {
//			log.info("colBean :::: " + colBean.getCollegeId());
//			mav = new ModelAndView("addNewFormTarget");
//		} else {
//			mav = new ModelAndView("SessionTerminated");
//		}
//
//		return mav;
//
//	}

	@RequestMapping(value = "/ViewClientDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewClientDetailsAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws InvalidKeyException, NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException, IOException {

		log.debug("client Id:" + request.getParameter("id"));
		collegeBean=new CollegeBean();
		try {
			collegeBean = collegeService.viewInstDetail(Integer.valueOf(Integer.parseInt(request.getParameter("id"))));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		String clientUrl = qFormsIP + "StartUrl?bid=" + collegeBean.getBankDetailsOTM().getBankId() + "&cid="
				+ collegeBean.getCollegeId();
		request.setAttribute("clientUrl", clientUrl);

		String pwdQC = PasswordEncryption.decryptQC(collegeBean.getLoginBean().getPassword());
		request.setAttribute("pwdQC", pwdQC);
		ses.setAttribute("CollegeBean", collegeBean);

		return "editClientDetails";
	}

	@RequestMapping(value = "/sabPaisaClientDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String getSabPaisaClientDetails(Model model, HttpServletRequest request, HttpSession ses) {

		clientMappingCodeOfSabPaisa=new ArrayList<ClientMappingCodeOfSabPaisa>();
		
		try {
			clientMappingCodeOfSabPaisa = collegeService.getSabPaisaClientDetailsDAO(request.getParameter("id"));
		} catch (Exception e) {
			log.error("client mapping code for sabpaisa is not found");
			e.printStackTrace();
		}
		
		ses.setAttribute("clientMappingCodeOfSabPaisa", clientMappingCodeOfSabPaisa);

		return "viewSabPaisaClientMappingDetails";
	}

	@RequestMapping(value = "/UpdateClientBean", method = { RequestMethod.GET, RequestMethod.POST })
	public String UpdateClientImage(Model model, HttpServletRequest request) {
		log.debug("id val2:" + colId);
		collegeBean.setCollegeId(Integer.parseInt(colId));
		URL u = getClass().getProtectionDomain().getCodeSource().getLocation();

		String pathOfImage = u.toString().split("WEB-INF")[0] + "img";
		pathOfImage = pathOfImage.substring(6);
		log.debug("path of current Domain url:" + pathOfImage);
		String filePath = pathOfImage;
		String ext = null;
		Integer totalFileSize = null;
		try {
			ext = FilenameUtils.getExtension(this.userImageFileName);
			totalFileSize = new File(filePath).listFiles().length;
			totalFileSize = totalFileSize + 1;

			userImageFileName = StringUtils.removeEnd(userImageFileName, "." + ext);
			userImageFileName = userImageFileName + "_" + collegeBean.getCollegeCode() + "_" + totalFileSize + "."
					+ ext;

			log.debug("userImageFileName:" + userImageFileName);

			System.out.println("Server path:" + filePath);
			log.debug("location of :" + filePath);
			File file = new File(filePath, this.userImageFileName);

			FileUtils.copyFile(this.userImage, file);
			byte[] bFile = new byte[(int) file.length()];

			try {
				FileInputStream fileInputStream = new FileInputStream(file);
				fileInputStream.read(bFile);
				fileInputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			collegeBean.setCollegeImage(bFile);
			collegeBean.setCollegeLogo("img/" + userImageFileName);
			log.debug("college image is:" + bFile);
			collegeService.updateClientlogoDetails(collegeBean);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		request.setAttribute("msg", "logo updated successfully...");
		return "Success";
	}

	@RequestMapping(value = "/addBankDetailsUI", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addBankDetailsUI(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("addBankDetailsUI");

		return mav;
	}

	@RequestMapping(value = "/SaveBankDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveBankDetailsAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @RequestParam MultipartFile userImage,
			@ModelAttribute("bankDetailsBean") BankDetailsBean bankDetails) throws IOException {

		log.info("bankname : " + bankDetails.getBankname() + ": bankID :" + bankDetails.getBankId()
				+ " :contactPerson : " + bankDetails.getContactPerson() + " :emailId : " + bankDetails.getEmailId()
				+ " :bankLogo: " + bankDetails.getBankLogo() + " :address : " + bankDetails.getAddress()
				+ " :contactNumber : " + bankDetails.getContactNumber() + " :Company Bean Id : "
				+ bankDetails.getCompanyBean().getId());

		log.debug("path of current Domain url before spliting :" + uploadPath);

		String ext = null;
		Integer totalFileSize = Integer.valueOf(0);

		try {
			CompanyBean compBean = collegeService.getCompany(bankDetails.getCompanyBean().getId());

			byte[] bytes = userImage.getBytes();
			Path path = Paths.get("" + userImage.getOriginalFilename());
			log.debug("fileUploadFileName path :::::::::::: " + path.toString());
			String imagePath = null;
			Files.write(path, bytes);
			imagePath = uploadPath + "/img/";
			userImageFileName = userImage.getOriginalFilename();

			log.debug("fileUploadFileName :::::::::::: " + userImageFileName.toString());

			ext = FilenameUtils.getExtension(userImageFileName);

			totalFileSize = new File(imagePath).listFiles().length;
			totalFileSize = totalFileSize + 1;

			userImageFileName = StringUtils.removeEnd(userImageFileName, "." + ext);
			userImageFileName = userImageFileName + "_" + bankDetails.getBankname() + "_" + totalFileSize + "." + ext;

			log.debug("userImageFileName:" + userImageFileName);

			log.debug("location of :" + imagePath);

			File file = new File(imagePath, userImageFileName);
			log.debug("file Name:" + file + " : userImageContentType:" + userImageContentType);
			String dbpath = imagePath + userImageFileName;
			log.debug("dbpath is ::::::::::: " + dbpath);

			File dstFile = new File(dbpath);
			log.debug("dstFile is ::::::::::: " + dstFile);

			Path source = Paths.get(userImage.getOriginalFilename());
			Path destination = Paths.get(dstFile.getPath());
			log.debug("source for file : " + source + ", : destination for file : " + destination);
			Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);

			byte[] bFile = new byte[(int) file.length()];

			try {
				FileInputStream fileInputStream = new FileInputStream(file);
				fileInputStream.read(bFile);
				fileInputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("errorMsg",
						"Bank Added Successfully but image missing ,please set the image path");
			}

			bankDetails.setBankLogo("img/" + userImageFileName);
			bankDetails.setBankImage(bFile);
			bankDetails.setCompanyBean(compBean);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		String valid = collegeService.saveBankDetailsDao(bankDetails);
		bankDetailsBean = bankDetails;
		if (valid.equals("true")) {
			request.setAttribute("msg", "Bank Added Successfully");
			request.setAttribute("redirectLink", "Success");
			return "Success";
		}

		return "errorPage";
	}
	
	@RequestMapping(value = "/addServiceUI", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addServiceUI(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("addServiceUI");

		return mav;
	}

	@RequestMapping(value = "/EditBankLogoDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String EditBankImage(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@ModelAttribute("bankDetailsBean") BankDetailsBean bankDetails) {

		String valid = "true";
		try {
			bankDetailsBean = bankDetails;
			valid = collegeService.EditBankDetails(bankDetailsBean);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (valid.equals("true")) {
			request.setAttribute("msg", "Bank Details  updated successfully...");
			return "Success";
		}
		return "errorPage";
	}

	@RequestMapping(value = "/EditBankDetailsById", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBankDetailsInfo(ModelMap model, HttpServletRequest request) {
		HttpSession ses = request.getSession();
		BankDetailsBean bankDetailsBean = new BankDetailsBean();
		try {
			bankDetailsBean = collegeService.getBankDetailsBasedOnId(request.getParameter("id"));
			model.put("bankDetailsBean", bankDetailsBean);
			return "editBank";
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "editBank";
	}

	@RequestMapping(value = "/loadCollegesDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCollegesDetail(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.info("Start of loadCollegesDetail() method, ");
		clientBankId = request.getParameter("bid");
		if (clientBankId.equals("ALL"))
			clientBankId = "0";
		ses.setAttribute("BID", clientBankId);
		log.debug("clientBankId is::" + clientBankId);
		
		try {
			collegelst = collegeService.getCollegeListOfBank(Integer.parseInt(clientBankId));
			stateList = collegeService.getStateList();
			servicesList = collegeService.getServicesList();
			companyList = collegeService.getcompantList();
		} catch (NumberFormatException e) {
			
			e.printStackTrace();
		}
		
		log.debug("collegelst " + collegelst.size());
		request.setAttribute("collegeList", collegelst);
		log.info("End Of loadCollegesDetail() method, List of stateList Size is:::::::::" + stateList.size());

		return "/Banks/whiteLevelBank";
	}

	@RequestMapping(value = "/loadCollegesDetailForSabPaisa", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCollegesDetailForSabPaisa(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		try {
			collegelst = collegeService.getCollegeListOfBankForSabPaisa();
			stateList = collegeService.getStateList();
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		request.setAttribute("collegeList", collegelst);
		log.info("List Size is:::::::::" + stateList.size());

		return "indexSabPaisa";
	}

	@RequestMapping(value = "/addBankAction", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBankAction() {
		return "addBankDetailsUI";
	}

	@RequestMapping(value = "/getCollegeListBasedOnStateId", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCollegeListAjax(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		Integer bid = Integer.valueOf(Integer.parseInt(ses.getAttribute("BID").toString()));
		Integer stateId = Integer.valueOf(Integer.parseInt(request.getParameter("stateId")));
		Integer serviceId = Integer.valueOf(Integer.parseInt(request.getParameter("serviceId")));
		log.debug("State Id Is:::" + stateId);
		try {
			collegelst = collegeService.getCollegeDetailsBasedOnStateId(stateId, bid, serviceId);
			whitelableList = collegeService.getWhiteLableClientlist(stateId, bid, serviceId);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		log.debug("White Lable Size :::" + whitelableList.size());
		log.debug("College List Size:::" + collegelst.size());
		return "CollegeListAjax";
	}

	@RequestMapping(value = "/getCollegeListBasedOnStateIdForSabPaisa", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getCollegeListAjaxForSabPaisa(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		Integer stateId = Integer.valueOf(Integer.parseInt(request.getParameter("stateId")));
		log.debug("State Id Is:::" + stateId);
		collegelst = collegeService.getCollegeDetailsBasedOnStateIdForSabPaisa(stateId);
		log.debug("College List Size:::" + collegelst.size());
		return "SabPaisaCollegeListAjax";
	}

	@RequestMapping(value = "/GetCollegeListOfBank", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCollegeListOfBank(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		try {
			filteredCollegeList = new ArrayList<CollegeBean>();

			Integer cid = Integer.valueOf(Integer.parseInt((String) ses.getAttribute("cid")));
			log.debug("college Id :" + cid);
			collegelst = collegeService.getCollegeListOfBank(Integer.parseInt((String) ses.getAttribute("bid")));
			log.debug("size of the CollegeList:" + collegelst.size());
			for (CollegeBean collegeBean : collegelst) {
				if (collegeBean.getCollegeId() == cid) {
					filteredCollegeList.add(collegeBean);
				}
			}
			log.debug(filteredCollegeList.size() + "size of the colllege list");
			return "chooseCollege";
		} catch (Exception ex) {
		}
		return "chooseCollege";
	}

	@RequestMapping(value = "/searchCollegeBasedOnCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchCollegeBasedOnCodeAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		CollegeBean filteredCollegeBean = new CollegeBean();
		try {
			filteredCollegeList = new ArrayList<CollegeBean>();

			Integer cid = Integer.valueOf(Integer.parseInt((String) ses.getAttribute("cid")));
			log.debug("college Id :" + cid);
			log.debug("college code :" + request.getParameter("clgCode"));
			filteredCollegeList = collegeService.getCollegeDetailsBasedOnCode(request.getParameter("clgCode"));
			filteredCollegeBean = (CollegeBean) filteredCollegeList.iterator().next();
			ses.setAttribute("filteredCollegeBean", filteredCollegeBean);

			log.debug(filteredCollegeList.size() + ": size of the colllege list");
			return "chooseCollege";
		} catch (Exception ex) {
		}
		return "chooseCollege";

	}

	@RequestMapping(value = "/getCollegeDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCollegeDetailsAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		try {
			collegeBean = collegeService.viewInstDetail(Integer.valueOf(Integer.parseInt(request.getParameter("cid"))));
		} catch (Exception ex) {
			return "demoForm4";
		}

		return "demoForm4";
	}

	@RequestMapping(value = "/saClientFlow", method = { RequestMethod.GET, RequestMethod.POST })
	public String getClientDetailsAction(ModelMap model, HttpServletRequest request) {
		log.debug("Start of getClientDetailsAction() method in CollegeDetailsController");
		HttpSession ses = request.getSession();
		String returnVal = "";
		List<CollegeBean> collegelst = new ArrayList<CollegeBean>();
		SuperAdminBean superAdminBean = ((SuperAdminBean) ses.getAttribute("sABean"));

		if (null == superAdminBean || superAdminBean.equals(null) || superAdminBean.equals("")
				|| superAdminBean.equals("null")) {
			returnVal = "SessionTerminated";
		} else {
			collegelst = collegeService.getAllClientDetails(superAdminBean);
			log.debug("returnback to controller and collegeList size is: >>>>>>>>>>>>>>>>>>>>> " + collegelst.size());
			model.put("collegelst", collegelst);
			returnVal = "sa-ClientFlow";
		}
		return returnVal;
	}

	@RequestMapping(value = "/GetBankDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBankDetailsAction(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		String returnVal = "";
		List<BankDetailsBean> bankDetailsList = new ArrayList<BankDetailsBean>();
		SuperAdminBean superAdminBean = ((SuperAdminBean) ses.getAttribute("sABean"));
		if (null == superAdminBean || superAdminBean.equals(null) || superAdminBean.equals("")
				|| superAdminBean.equals("null")) {
			returnVal = "SessionTerminated";
		} else {
			bankDetailsList = collegeService.getAllBankDetails(superAdminBean);
			model.put("bankDetailsList", bankDetailsList);
			returnVal = "sa-BankFlow";
		}
		return returnVal;
	}

	// @CrossOrigin
	@RequestMapping(value = "/saveClientDetailsByCOB", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveClientDetailsByCOB(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @RequestParam MultipartFile userImage,
			@ModelAttribute("collegeBean") CollegeBean collegeBeanParam,
			@ModelAttribute("loginbean") LoginBean loginBeanByCOB) throws InvalidKeyException, NoSuchAlgorithmException,
			InvalidKeySpecException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException,
			IOException, URISyntaxException {

		log.debug("path of current Domain url before spliting :" + uploadPath);
		BankDetailsBean bankDetailsBean = new BankDetailsBean();
		ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa = new ClientMappingCodeOfSabPaisa();
		String value = "";
		Integer cobClientId = collegeBeanParam.getCollegeId();
		log.debug("cobClientId is ::: " + cobClientId.toString());

		String clientBankId = request.getParameter("clientBankId");
		log.debug("clientBankId is ::: " + clientBankId.toString());

		CollegeBean collegeBean = new CollegeBean();
		String ext = null;
		Integer totalFileSize = 0;
		try {
			bankDetailsBean = collegeService.getBankDetailsBasedOnId(clientBankId);

		} catch (NullPointerException ex) {
			ex.printStackTrace();
			request.setAttribute("errorMsg", "Please ");
			return "errorPage";
		}
		log.debug("bankDetailsBean name is ::::: " + bankDetailsBean.getBankname().toString());

		collegeBean = collegeBeanParam;
		log.debug("collegeBean name is ::::: " + collegeBean.toString());

		String username = new String();
		String password = new String();
		try {

			if (null != loginBeanByCOB.getUserName() || null != loginBeanByCOB.getPassword()) {
				log.debug("UserName is :: " + loginBeanByCOB.getUserName() + ", Password is :: "
						+ loginBeanByCOB.getPassword());
				username = loginBeanByCOB.getUserName();
				password = loginBeanByCOB.getPassword();

			} else {
				password = RandomPasswordGenerator.generatePswd(6, 8, 1, 2, 0);
				username = "Ins".concat(collegeBean.getCollegeName()).replaceAll("\\s+", "").substring(0, 4)
						.concat(collegeService.getRowCount().toString());
			}

		} catch (java.lang.NullPointerException e) {

		}
		PasswordEncryption.encrypt(password);
		String encryptedPwd = PasswordEncryption.encStr;
		log.debug("username for new client :::: " + username + " , password :::::::: " + encryptedPwd.toString());
		LoginBean loginDetails = new LoginBean();
		loginDetails.setPassword(encryptedPwd);
		loginDetails.setUserName(username);
		loginDetails.setProfile("Institute");
		loginDetails.setCollgBean(collegeBean);

		try {
			byte[] bytes = userImage.getBytes();
			Path path = Paths.get("" + userImage.getOriginalFilename());
			log.debug("fileUploadFileName path :::::::::::: " + path.toString());
			String imagePath = null;
			Files.write(path, bytes);
			imagePath = uploadPath + "/userimages/";
			userImageFileName = userImage.getOriginalFilename();

			log.debug("fileUploadFileName :::::::::::: " + userImageFileName.toString());

			ext = FilenameUtils.getExtension(userImageFileName);

			totalFileSize = new File(imagePath).listFiles().length;
			totalFileSize = totalFileSize + 1;

			userImageFileName = StringUtils.removeEnd(userImageFileName, "." + ext);
			userImageFileName = userImageFileName + "_" + totalFileSize + "." + ext;

			log.debug("userImageFileName:" + userImageFileName);

			System.out.println("Server path:" + imagePath);
			log.debug("location of :" + imagePath);

			File file = new File(imagePath, userImageFileName);
			log.debug("file Name:" + file + " : userImageContentType:" + userImageContentType);
			String dbpath = imagePath + userImageFileName;
			log.debug("dbpath is ::::::::::: " + dbpath);

			File dstFile = new File(dbpath);
			log.debug("dstFile is ::::::::::: " + dstFile);

			Path source = Paths.get(userImage.getOriginalFilename());
			Path destination = Paths.get(dstFile.getPath());
			log.debug("source for file : " + source + ", : destination for file : " + destination);
			Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);

			byte[] bFile = new byte[(int) file.length()];

			try {
				FileInputStream fileInputStream = new FileInputStream(file);
				fileInputStream.read(bFile);
				fileInputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("errorMsg",
						"Bank Added Successfully but image missing ,please set the image path");
			}

			collegeBean.setCollegeImage(bFile);
			collegeBean.setCollegeLogo("userimages/" + userImageFileName);
			System.out.println("college image is:" + bFile);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		log.debug("State Id is" + collegeBean.getStateBean().getStateId());
		log.debug("Service Id is" + collegeBean.getServiceBean().getServiceId());
		log.debug("ComId  is" + collegeBean.getCompanyBean().getId());
		StateBean stateBean = collegeService.getStateBean(collegeBean.getStateBean().getStateId());
		ServicesBean servicesBean = collegeService.getServicesBean(collegeBean.getServiceBean().getServiceId());
		CompanyBean compBean = collegeService.getCompany(collegeBean.getCompanyBean().getId());
		log.debug("Service Id is  33333");
		collegeBean.setLoginBean(loginDetails);
		collegeBean.setBankDetailsOTM(bankDetailsBean);
		collegeBean.setStateBean(stateBean);
		collegeBean.setServiceBean(servicesBean);
		collegeBean.setCompanyBean(compBean);

		log.debug("loginBean {" + loginDetails.getUserName().toString() + "}, bankdetailsotm {"
				+ collegeBean.getBankDetailsOTM().getBankname().toString() + "}, statebean {"
				+ collegeBean.getStateBean().getStateName().toString() + "}, servicebean {"
				+ collegeBean.getServiceBean().getServiceName().toString() + "}");

		collegeBean = collegeService.saveClientDetails(collegeBean);

		log.info("collegeBean :::::::::::::::: " + collegeBean.getCollegeId().toString());

		if (collegeBean == null) {
			return "error";
		}
		ses.setAttribute("colBeans", collegeBean);

		mappingCodeOfSabPaisa.setBid(collegeBean.getBankDetailsOTM().getBankId().toString());
		mappingCodeOfSabPaisa.setCid(collegeBean.getCollegeId().toString());
		mappingCodeOfSabPaisa.setCMCode(collegeBean.getCollegeCode());
		mappingCodeOfSabPaisa.setCollegeBeanMappingToSabPaisaClient(collegeBean);

		try {
			value = collegeService.saveMappingCodeOfSabPaisaDetails(mappingCodeOfSabPaisa);
			log.info("returned value of clientMappingCodeOfSabpaisa stored data is ======> " + value);
		} catch (Exception e1) {
			e1.printStackTrace();
			log.error(
					"client mapping is not configured returned value of clientMappingCodeOfSabpaisa stored data is ======> "
							+ value);
		}

		String emailContent = "Welcome to the QForms portal of " + collegeBean.getCollegeName();
		SendMail email = new SendMail();
		email.sendRegMail("Welcome To QForms !", collegeBean.getEmailId(), username, password, emailContent, "");

		request.setAttribute("msg", "Client Added Successfully");
		if (collegeBean.getCollegeId() != null) {

			log.debug("in if " + collegeBean.getCollegeId() + " cobClientId :::: " + cobClientId.toString());
			log.debug("clientID >> " + collegeBean.getCollegeId() + ", appID >> " + 1 + ", ifconfigStatus >> sucess");

			try {
				String cobReturnUrl = cobUrl + "UpdateConfigStatus?clientId=" + collegeBean.getCollegeId()
						+ "&&appId=1&&configStatus=sucess";
				log.debug("Going to update ClientOnBoard, cobReturnUrl " + cobReturnUrl);

				URL url = new URL(cobReturnUrl);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");

				int responseCode = conn.getResponseCode();
				log.debug("Response Code from COB Application >> " + responseCode);
				if (conn.getResponseCode() != 200) {
					log.debug("Response Code from COB Application is other then 200, so throwing Http error code");
					throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
				}
				BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

				String output, str = null;
				log.debug("Output from Server .... \n");
				while ((output = br.readLine()) != null) {
					str = output;
				}
				log.debug("//" + str);
				conn.disconnect();
			} catch (MalformedURLException e) {

				e.printStackTrace();

			} catch (IOException e) {

				e.printStackTrace();
			}

			request.setAttribute("clientId", String.valueOf(cobClientId));
			request.setAttribute("appId", "1");
			request.setAttribute("configStatus", "sucess");
			request.setAttribute("redirectLink", "Success.jsp");
		}
		return "SuccessCOB";
	}

	private SpConfigBean requestForConfiurationDetailWithSp(String spUrl, SpConfigBean spBean) {
		log.info("Open requestForConfiurationDetailWithSp() method for sp Request  " + spBean.getClientCode());

		SpConfigBean spConfig = new SpConfigBean();

		RestTemplate restTemplate = new RestTemplate();

		log.info("response challan bean is " + spBean.toString());
		// Data attached to the request.
		HttpEntity<SpConfigBean> requestBody = new HttpEntity<>(spBean);

		// Send request with POST method.
		log.info("sending request to spUrl : " + spUrl);

		ResponseEntity<SpConfigBean> result = restTemplate.postForEntity(spUrl, requestBody, SpConfigBean.class);

		log.info("Status code:" + result.getStatusCode());

		if (result.getStatusCode() == HttpStatus.OK || result.getStatusCodeValue() == 200) {
			log.info("status is ");
			// log.info("value is "+mapper.convertValue(result,ResponseCobBean.class));
			SpConfigBean e = result.getBody();
			log.info(" ok status " + e.getClientCode());
			log.info("End requestForConfiurationDetailWithSp() method for sp Request  " + spBean.getClientCode());
			return e;
		}
		log.info("End requestForConfiurationDetailWithSp() method for sp Request  " + spBean.getClientCode());
		return spConfig;
	}

	@RequestMapping(value = "/fetchClientConfigurationDetailsBySp", method = RequestMethod.POST)
	public ResponseEntity<String> fetchClientConfigurationDetailsBySp(@RequestBody SpConfigBean spConfig) {

		log.info("Open requestForConfiurationDetailWithSp() method for sp Request ");
		String returnStatus = "";
		try {
			if (null != spConfig.getClientCode()) {
				returnStatus = collegeService.updateClientConfigDetailWithSp(spConfig);
			}
			if (returnStatus == ApplicationStatus.Created.toString()) {
				return new ResponseEntity<>(HttpStatus.OK);
			} else if (returnStatus == ApplicationStatus.AlreadyCreated.toString()) {
				return new ResponseEntity<>(HttpStatus.ALREADY_REPORTED);
			} else if (returnStatus == ApplicationStatus.NotCreated.toString()) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			} else {
				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
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
	
	

	public String sabPaisaClientDetailsAction(HttpServletRequest request, HttpSession ses)
			throws InvalidKeyException, NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException, IOException {

		log.debug("client Id:" + request.getParameter("id"));
		collegeBean = collegeService.viewInstDetail(Integer.valueOf(Integer.parseInt(request.getParameter("id"))));
		String clientUrl = qFormsIP + "StartUrl?bid=" + collegeBean.getBankDetailsOTM().getBankId() + "&cid="
				+ collegeBean.getCollegeId();
		request.setAttribute("clientUrl", clientUrl);

		String pwdQC = PasswordEncryption.decryptQC(collegeBean.getLoginBean().getPassword());
		request.setAttribute("pwdQC", pwdQC);

		return "Success";
	}

	@RequestMapping(value = "/userImage", method = { RequestMethod.POST, RequestMethod.GET })
	public String uploadLogoAction(HttpServletRequest request) {

		try {
			ServletContext sc = request.getSession().getServletContext();
			String filePath = sc.getRealPath("/").concat("img");

			System.out.println("Server path:" + filePath);
			log.debug("location of by Praveen uploadLogoAction() methos :" + filePath);

			collegeBean.setCollegeId(Integer.valueOf(16));

			collegeService.saveAndUpdateClientlogoDetails(collegeBean);
		} catch (Exception e) {
			e.printStackTrace();

			return "uploadlogo";
		}
		return "SuccessUserImage";
	}

	@RequestMapping(value = "/editSabPaisaMappingDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public String editSabPaisaMappingDetails(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		clientMappingDetails = collegeService.viewSabPaisaClientDetailsDAO(request.getParameter("id"));
		log.info("details:" + clientMappingDetails.getCMCId() + " : " + clientMappingDetails.getBid() + " : "
				+ clientMappingDetails.getCid() + " : " + clientMappingDetails.getCMCode() + " : "
				+ clientMappingDetails.getClientUrl());
		ses.setAttribute("clientMappingDetails", clientMappingDetails);
		return "viewSabPaisaClientDetails";
	}

	@RequestMapping(value = "/UpdateSabPaisaClientDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public String updateSabPaisaClientDetails(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.debug(clientMappingBean.getCMCId() + ":id :" + request.getParameter("cMCId"));

		log.debug("details:" + request.getParameter("cMCId") + " : " + request.getParameter("cMProfile") + " : "
				+ request.getParameter("clientUrl"));
		clientMappingBean = collegeService.updateSabPaisaClientDetailsDAO(request.getParameter("cMCId"),
				request.getParameter("cMProfile"), request.getParameter("cMCode"), request.getParameter("clientUrl"));
		log.info("clientMappingBean is having " + clientMappingBean);
		if (clientMappingBean == null) {
			request.setAttribute("msg", "Client not  Updated Successfully");
			return "errorPage";
		}

		request.setAttribute("msg", "Client  Updated Successfully");
		return "Success";
	}

	@RequestMapping(value = "/addServices", method = { RequestMethod.POST, RequestMethod.GET })
	public String addService(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		log.debug("Service Name == " + request.getParameter("servicesName"));
		servicesBean.setServiceName(request.getParameter("servicesName"));
		try {
			log.debug("Services bean is " + servicesBean.getServiceName());
			collegeService.saveServicesBean(servicesBean);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "addServiceUI";
	}

	@RequestMapping(value = "/UpdateBankLogoDetails", method = { RequestMethod.POST, RequestMethod.GET })
	public String updateBankImage(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		/* log.debug("id val2:" + colId); */

		URL u = getClass().getProtectionDomain().getCodeSource().getLocation();

		String pathOfImage = u.toString().split("WEB-INF")[1] + "img";
		pathOfImage = pathOfImage.substring(6);
		log.debug("path of current Domain url:" + pathOfImage);
		String filePath = pathOfImage;
		String ext = null;
		Integer totalFileSize = null;
		try {

			collegeService.updateBanklogoDetails(bankDetailsBean);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		request.setAttribute("msg", "logo updated successfully...");
		return "Success";
	}

	@RequestMapping(value = "/updateBankImage", method = { RequestMethod.POST, RequestMethod.GET })
	public String getBankList(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		superAdminBean = ((SuperAdminBean) ses.getAttribute("sABean"));
		bankDetailsList = collegeService.getBankDetails(superAdminBean);

		return "editBankLogo";
	}

	@RequestMapping(value = "/GetBankDetailsForDropdown", method = { RequestMethod.POST, RequestMethod.GET })
	public String getBankDetailsForDropdownList(Model model, HttpServletRequest request, HttpSession ses) {
		superAdminBean = ((SuperAdminBean) ses.getAttribute("sABean"));
		log.debug("value of superadminbean is ::::::::: " + superAdminBean.toString());

		bankDetailsList = collegeService.getBankDetails(superAdminBean);
		stateList = collegeService.getStateList();
		servicesList = collegeService.getServicesList();
		companyList = collegeService.getcompantList();
		ses.setAttribute("bankDetailsList", bankDetailsList);
		ses.setAttribute("stateList", stateList);
		ses.setAttribute("servicesList", servicesList);
		ses.setAttribute("companyList", companyList);

		return "addClientToFormLinkUI";
	}
	
	@RequestMapping(value = "/uploadData", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView upload(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		log.debug("work in addNewFormTarget() for configuration");

		ModelAndView mav = new ModelAndView("upload");
		ses = request.getSession();

		return mav;

	}

	@RequestMapping(value = "/LandingPageForm", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView landingPageForm(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		log.debug("work in addNewFormTarget() for configuration");

		ModelAndView mav = new ModelAndView("LandingPageForm");

		return mav;

	}
	
	
	@RequestMapping(value = "/saPayersReport", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView saPayersReport(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		log.debug("work in saPayersReport() for configuration in collegedetailscontroller");

		ModelAndView mav = new ModelAndView("SAPayersReport");
		ses = request.getSession();

		return mav;

	}
	public CollegeService getCollegeService() {
		return collegeService;
	}

	public void setCollegeService(CollegeService collegeService) {
		this.collegeService = collegeService;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	public BankDetailsBean getBankDetailsBean() {
		return bankDetailsBean;
	}

	public void setBankDetailsBean(BankDetailsBean bankDetailsBean) {
		this.bankDetailsBean = bankDetailsBean;
	}

	public String getColId() {
		return colId;
	}

	public void setColId(String colId) {
		this.colId = colId;
	}

	public String getClientBankId() {
		return clientBankId;
	}

	public void setClientBankId(String clientBankId) {
		this.clientBankId = clientBankId;
	}

	public String getUserImageContentType() {
		return userImageContentType;
	}

	public void setUserImageContentType(String userImageContentType) {
		this.userImageContentType = userImageContentType;
	}

	public String getUserImageFileName() {
		return userImageFileName;
	}

	public void setUserImageFileName(String userImageFileName) {
		this.userImageFileName = userImageFileName;
	}

	public File getUserImage() {
		return userImage;
	}

	public void setUserImage(File userImage) {
		this.userImage = userImage;
	}

	public List<CollegeBean> getFilteredCollegeList() {
		return filteredCollegeList;
	}

	public void setFilteredCollegeList(List<CollegeBean> filteredCollegeList) {
		this.filteredCollegeList = filteredCollegeList;
	}

	public List<CollegeBean> getCollegelst() {
		return collegelst;
	}

	public void setCollegelst(List<CollegeBean> collegelst) {
		this.collegelst = collegelst;
	}

	public List<WhiteLableTempBean> getWhitelableList() {
		return whitelableList;
	}

	public void setWhitelableList(List<WhiteLableTempBean> whitelableList) {
		this.whitelableList = whitelableList;
	}

	public List<ClientMappingCodeOfSabPaisa> getClientMappingCodeOfSabPaisa() {
		return clientMappingCodeOfSabPaisa;
	}

	public void setClientMappingCodeOfSabPaisa(List<ClientMappingCodeOfSabPaisa> clientMappingCodeOfSabPaisa) {
		this.clientMappingCodeOfSabPaisa = clientMappingCodeOfSabPaisa;
	}

	public String getqFormsIP() {
		return qFormsIP;
	}

	public void setqFormsIP(String qFormsIP) {
		this.qFormsIP = qFormsIP;
	}

	public String getQuickCollectImgFloderPath() {
		return quickCollectImgFloderPath;
	}

	public void setQuickCollectImgFloderPath(String quickCollectImgFloderPath) {
		this.quickCollectImgFloderPath = quickCollectImgFloderPath;
	}

	public ServicesBean getServicesBean() {
		return servicesBean;
	}

	public void setServicesBean(ServicesBean servicesBean) {
		this.servicesBean = servicesBean;
	}

	public List<BankDetailsBean> getBankDetailsList() {
		return bankDetailsList;
	}

	public void setBankDetailsList(List<BankDetailsBean> bankDetailsList) {
		this.bankDetailsList = bankDetailsList;
	}

	public ClientMappingCodeOfSabPaisa getClientMappingBean() {
		return clientMappingBean;
	}

	public void setClientMappingBean(ClientMappingCodeOfSabPaisa clientMappingBean) {
		this.clientMappingBean = clientMappingBean;
	}

	public ClientMappingCodeOfSabPaisa getMappingCodeOfSabPaisa() {
		return mappingCodeOfSabPaisa;
	}

	public void setMappingCodeOfSabPaisa(ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa) {
		this.mappingCodeOfSabPaisa = mappingCodeOfSabPaisa;
	}

	public List<StateBean> getStateList() {
		return stateList;
	}

	public void setStateList(List<StateBean> stateList) {
		this.stateList = stateList;
	}

	public List<ServicesBean> getServicesList() {
		return servicesList;
	}

	public void setServicesList(List<ServicesBean> servicesList) {
		this.servicesList = servicesList;
	}

	public List<SuperAdminBean> getCompanyList() {
		return companyList;
	}

	public void setCompanyList(List<SuperAdminBean> companyList) {
		this.companyList = companyList;
	}

	public ClientMappingCodeOfSabPaisa getClientMappingDetails() {
		return clientMappingDetails;
	}

	public void setClientMappingDetails(ClientMappingCodeOfSabPaisa clientMappingDetails) {
		this.clientMappingDetails = clientMappingDetails;
	}

	public SuperAdminBean getSuperAdminBean() {
		return superAdminBean;
	}

	public void setSuperAdminBean(SuperAdminBean superAdminBean) {
		this.superAdminBean = superAdminBean;
	}

	public LoginBean getLoginBeanCob() {
		return loginBeanCob;
	}

	public void setLoginBeanCob(LoginBean loginBeanCob) {
		this.loginBeanCob = loginBeanCob;
	}

	public AppPropertiesConfig getAppProperties() {
		return appProperties;
	}

	public void setAppProperties(AppPropertiesConfig appProperties) {
		this.appProperties = appProperties;
	}

	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	public String getCobUrl() {
		return cobUrl;
	}

	public void setCobUrl(String cobUrl) {
		this.cobUrl = cobUrl;
	}

	public String getBankId() {
		return bankId;
	}

	public void setBankId(String bankId) {
		this.bankId = bankId;
	}

}
