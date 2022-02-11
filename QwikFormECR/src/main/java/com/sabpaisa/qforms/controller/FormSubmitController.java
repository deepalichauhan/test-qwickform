package com.sabpaisa.qforms.controller;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.PayeerTargetMappingToClient;
import com.sabpaisa.qforms.beans.SpConfigBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.requestprocessing.Encryptor;
//import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
@RequestMapping
public class FormSubmitController extends HttpServlet {

	@Autowired
	private CollegeService clientService;

	@Autowired
	private SampleTransService sampleTransService;
	
	@Autowired
	private SampleFormService sampleFormService;

	private static Logger log = LogManager.getLogger(FormSubmitController.class.getName());

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String sabpaisaUrlIP = properties.getProperty("sabpaisaUrl");
	String urlForSpConfiguration = properties.getProperty("urlForSpConfiguration");
	String qcUserName = properties.getProperty("qcUserName");
	String qcPassword = properties.getProperty("qcPassword");

	String qcAuthKey = properties.getProperty("qcAuthKey");
	String qcAuthIV = properties.getProperty("qcAuthIV");
	String prodCode = properties.getProperty("prodCode");

	PayeerTargetMappingToClient payeerTargetMappingToClient = new PayeerTargetMappingToClient();
	ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa = new ClientMappingCodeOfSabPaisa();

	public PayeerTargetMappingToClient getPayeerTargetMappingToClient() {
		return payeerTargetMappingToClient;
	}

	public ClientMappingCodeOfSabPaisa getClientMappingCodeOfSabPaisa() {
		return clientMappingCodeOfSabPaisa;
	}

	public void setClientMappingCodeOfSabPaisa(ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa) {
		this.clientMappingCodeOfSabPaisa = clientMappingCodeOfSabPaisa;
	}

	public void setPayeerTargetMappingToClient(PayeerTargetMappingToClient payeerTargetMappingToClient) {
		this.payeerTargetMappingToClient = payeerTargetMappingToClient;
	}

	@RequestMapping(value = "/TestClient", method = { RequestMethod.GET, RequestMethod.POST })
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// HttpServletResponse response = null; //Initialize your
		// ServeletResponse Object Here
		ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa = new ClientMappingCodeOfSabPaisa();
		CollegeBean colBean = new CollegeBean();
		BeanFormDetails beanFormDetails= new BeanFormDetails();
		SpConfigBean spConBean = new SpConfigBean();
		String spURL = null;
		boolean auth = false;

		String spDomain = sabpaisaUrlIP; // URL provided by SabPaisa(Mandatory)
		String username = ""; // Username provided by Sabpaisa
								// (Mandatory)
		String password = ""; // Password provided by Sabpaisa
								// (Mandatory)
		String txnId = request.getParameter("txnid"); // Transaction ID
														// (Mandatory)
		String clientCode = ""; // Client Code Provided by Sabpaisa
								// (Mandatory)
		String authKey = ""; // Authentication Key Provided By
								// Sabpaisa (Mandatory only if
								// authentication is enabled)
		String authIV = ""; // Authentication IV Provided By
							// Sabpaisa (Mandatory only if
							// authentication is enabled)
		String txnAmt = request.getParameter("amt"); // Transaction Amount
		// (Mandatory)

		log.info("amt:" + txnAmt);
		/*
		 * String URLsuccess = request.getParameter("success"); String URLfailure =
		 * request.getParameter("failure");
		 */
		String URLsuccess = "";
		String URLfailure = "";

		String ip = request.getServerName();
		log.debug("requested ip is or server name : " + ip);
		log.info("requeste url from currentRequest >>  " + request.getRequestURL().toString());
		ip = org.apache.commons.lang.StringUtils.substring(ip, 0, 2);
		log.info("requested ip is after substring is ==  " + ip);
		if (ip.equals("lo") || ip.equals("qw") || ip.equals("19") || ip.equals("sp") || ip.equals("po")) {
			URLsuccess = request.getRequestURL().toString().substring(0,
					request.getRequestURL().toString().length() - 10) + "ClientResponse";
			URLfailure = request.getRequestURL().toString().substring(0,
					request.getRequestURL().toString().length() - 10) + "ClientResponse";// Return URL upon

		} else {
			URLsuccess = request.getRequestURL().toString().substring(0,
					request.getRequestURL().toString().length() - 10) + "ClientResponse";
			URLfailure = request.getRequestURL().toString().substring(0,
					request.getRequestURL().toString().length() - 10) + "ClientResponse";// Return URL upon

		}

		// failed
		// Transaction
		// (Optional)
		String payeeFirstName = request.getParameter("fn"); // Payee's First
															// Name (Optional)
		String payeeLastName = ""; // Payee's Last Name (Optional)
		String payeeContact = request.getParameter("con"); // Payee's Contact
															// Number (Optional)
		String payeeEmail = request.getParameter("email"); // Payee's Email
															// Address
															// (Optional)
		String payeeAddress = request.getParameter("add"); // Payee's Address
															// (Optional)

		String startDate1 = request.getParameter("formStartDate");
		String endDate1 = request.getParameter("formEndDate");

		String startDate = null, endDate = null;
		if (startDate1 != "" && endDate1 != "") {
			log.info("the start date:" + startDate1 + " : " + "the end date:" + endDate1);
			/*
			 * String[] strArray=startDate1.split("/");
			 * log.info(" print the value:"+strArray);
			 */
			Date date1 = null, date2 = null;
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

			try {
				date1 = formatter.parse(startDate1);
				date2 = formatter.parse(endDate1);
			} catch (Exception e) {
				e.printStackTrace();
			}

			startDate = new SimpleDateFormat("dd-MM-yyyy").format(date1);
			endDate = new SimpleDateFormat("dd-MM-yyyy").format(date2);
		}
		String payeeProfile = request.getParameter("payeeProfile");
		String bid = request.getParameter("bid");
		String cid = request.getParameter("cid");
		String feeName = request.getParameter("feeName");
		
		if (payeeProfile == null) {
			payeeProfile = (String) request.getSession().getAttribute("payeeProfile");
			log.info("payeeProfile:" + payeeProfile);
		}

		if (bid == null) {
			bid = (String) request.getSession().getAttribute("bid");
			log.info("bid:" + bid);
		}
		if (cid == null) {
			cid = (String) request.getSession().getAttribute("cid");
			log.info("cid:" + cid);
		}
		if (feeName == null) {
			feeName = (String) request.getSession().getAttribute("feeName");
			log.info("feeName:" + feeName);
		}

		log.info("feeName:" + feeName);
		log.info("payeeProfile:" + payeeProfile);
		log.info("bid:" + bid);
		log.info("cid:" + cid);
		
		Integer authflag = 1;
		if (authflag == 1) {
			auth = true;
		} else {
			auth = false;
		}

		try {
			colBean = clientService.getClientDetailsBasedOnId(Integer.parseInt(cid));
			log.debug("Client details for the payment : " + colBean.toString());

			if ((null == colBean.getAuthKey() || colBean.getAuthKey().isEmpty())
					&& (null == colBean.getAuthIV() || colBean.getAuthIV().isEmpty())
					&& (null == colBean.getUserName() || colBean.getUserName().isEmpty())
					&& (null == colBean.getUserPassword() || colBean.getUserPassword().isEmpty())) {

				spConBean.setClientCode(colBean.getCollegeCode());
				// spConBean.setClientCode("ABN");
				spConBean = requestForConfiurationDetailWithSp(urlForSpConfiguration, spConBean);

				if (null != spConBean.getSpAuthIV() && null != spConBean.getSpAuthKey()
						&& null != spConBean.getSpUserName() && null != spConBean.getSpUserPassword()) {
					log.info("use for updating sp setails for this client : " + spConBean.getClientCode());
					colBean.setAuthIV(spConBean.getSpAuthIV());
					colBean.setAuthKey(spConBean.getSpAuthKey());
					colBean.setUserName(spConBean.getSpUserName());
					colBean.setUserPassword(spConBean.getSpUserPassword());

					colBean = clientService.saveAndUpdateClientDetailsAs(colBean);

					username = colBean.getUserName();
					password = colBean.getUserPassword();
					authKey = colBean.getAuthKey();
					authIV = colBean.getAuthIV();
					log.info("----authKey---------- 1 " + authKey + "----authIV---------- 1 "
							+ authIV);
					log.info("----UserName---------- 1 " + username + "----UserPassword---------- 1 "
							+ password);
				} else {
					log.info("sabpaisa configuration is not done with qwikforms.");
					log.info("so i will use my old configuration by ApplicationProperies file");
					username = qcUserName;
					password = qcPassword;
					authKey = qcAuthKey;
					authIV = qcAuthIV;
				}

			} else {
				// spConBean.setClientCode(colBean.getCollegeCode());
				log.info("sabpaisa configuration is done Properly with qwikforms. all data is fetched by DB");
				log.info("----authKey---------- 0 " + authKey + "----authIV---------- 0 "
						+ authIV);
				log.info("----UserName---------- 0 " + username + "----UserPassword---------- 0 "
						+ password);

				username = colBean.getUserName();
				password = colBean.getUserPassword();
				authKey = colBean.getAuthKey();
				authIV = colBean.getAuthIV();

			}

			clientMappingCodeOfSabPaisa = clientService.getClientMappingCode(bid, cid, payeeProfile);
			log.debug("clientMappingCodeOfSabPaisa: " + clientMappingCodeOfSabPaisa.toString() + ": cmcode : "
					+ clientMappingCodeOfSabPaisa.getCMCode());

			clientCode = clientMappingCodeOfSabPaisa.getCMCode();
			log.info("Client code is:" + clientCode);
			if (clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().geteGFDays() == null) {
				clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().seteGFDays(3);
			}
		} catch (Exception e1) {

			e1.printStackTrace();
		}
		log.info(clientCode + ":---------: client code");
		
		if ("" == username || null == username || username.isEmpty()) {
			username = qcUserName;
		}
		if ("" == password || null == password || password.isEmpty()) {
			password = qcPassword;
		}
		if ("" == authKey || null == authKey || authKey.isEmpty()) {
			authKey = qcAuthKey;
		}
		if ("" == authIV || null == authIV || authIV.isEmpty()) {
			authIV = qcAuthIV;
		}
		log.debug("----authKey---------- 2 " + authKey + "----authIV---------- 2 "
				+ authIV);
		log.debug("----UserName---------- 2 " + username + "----UserPassword---------- 2 "
				+ password);
		
		if (startDate1 == "" && endDate1 == "") {
			log.debug("----startDate:" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()) + " : "
					+ new SimpleDateFormat("dd-MM-yyyy").format(DateUtils.addDays(new Date(), 3))
					+ " :endDate----------");
			
			clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().geteGFDays();
			startDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
			endDate = new SimpleDateFormat("dd-MM-yyyy").format(DateUtils.addDays(new Date(),
					clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().geteGFDays()));
			
		} else if (startDate1 == null && endDate1 == null) {

			log.debug("----startDate:" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()) + " : "
					+ new SimpleDateFormat("dd-MM-yyyy").format(DateUtils.addDays(new Date(), 3))
					+ " :endDate----------");
			
			clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().geteGFDays();
			startDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
			endDate = new SimpleDateFormat("dd-MM-yyyy").format(DateUtils.addDays(new Date(),
					clientMappingCodeOfSabPaisa.getCollegeBeanMappingToSabPaisaClient().geteGFDays()));
		}

		log.info("----startDate:" + startDate + " : " + endDate + " :endDate----------");

		Integer progId = (Integer) request.getSession().getAttribute("currentFormId");
		
		beanFormDetails=sampleFormService.getFormDetails(progId);
		
		String programId = String.valueOf(progId);
		String currentFormName="NA";
		if(beanFormDetails.getId()!=null && (beanFormDetails.getId().equals(progId) || beanFormDetails.getId()==progId)) {
			programId = String.valueOf(beanFormDetails.getId());
			currentFormName=beanFormDetails.getFormName();
			log.info("programId is checked by DB:" + programId);
			log.info("formName is checked by DB:" + currentFormName);
		}
		log.info("programId being sent to SabPaisa is:" + programId);
		
		List<Map<String, Object>> clientSpecificDJBDataMap = null;

		String cbsAccountNumber = "";
		String biddingFirmName = "";
		String djbExtraParam = "";
		String nameOfBank = "";
		String typeOfFee = "";
		String ifscCode = "";
		String itemNo = "";
		String nitNo = "";

		if ((!clientCode.equalsIgnoreCase("DJLTF")) && clientCode.substring(0, 2).equalsIgnoreCase("DJ")) {
			try {
				clientSpecificDJBDataMap = fetchClientTableData(programId, txnId);
				for (Map<String, Object> cmap : clientSpecificDJBDataMap) {
					
					for (Map.Entry<String, Object> entry : cmap.entrySet()) {
						log.info("Key = " + entry.getKey() + ", Value = " + entry.getValue());

						if (entry.getKey().equalsIgnoreCase("Type_of_Fee")) {
							typeOfFee = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("Bidding_Firm_Name")) {
							biddingFirmName = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("NIT_No")) {
							nitNo = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("Item_No")) {
							itemNo = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("Name_of_Bank")) {
							nameOfBank = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("IFSC_Code")) {
							ifscCode = entry.getValue().toString();
						} else if (entry.getKey().equalsIgnoreCase("CBS_Account_No")) {
							cbsAccountNumber = entry.getValue().toString();
						}
					}
				}
				djbExtraParam = typeOfFee + "-" + nitNo + "-" + itemNo + "-" + ifscCode + "-" + cbsAccountNumber + "-"
						+ nameOfBank + "-" + biddingFirmName;
				log.info("final param for DJB ::: >>>>>> " + djbExtraParam);
			} catch (Exception e) {
				log.info("Exception occoured by fetching data for QC Id =====> " + txnId);
				e.printStackTrace();
			}

			spURL = "?clientName=" + clientCode + "&programId=" + programId + "&usern=" + username + "&pass=" + password
					+ "&amt=" + txnAmt + "&txnId=" + txnId + "&firstName=" + payeeFirstName + "&lstName="
					+ payeeLastName + "&contactNo=" + payeeContact + "&Email=" + payeeEmail + "&Add=" + payeeAddress
					+ "&ru=" + URLsuccess + "&failureURL=" + URLfailure + "&profile=" + payeeProfile + "&cid=" + cid
					+ "&bid=" + bid + "&startDate=" + startDate + "&endDate=" + endDate + "&param2=" + feeName
					+ "&grNumber=" + djbExtraParam + "&param1=" + typeOfFee + "&param3=" + nitNo + "&param4="
					+ biddingFirmName + "&studentUin=" + nameOfBank + "&paymentCycleDescription=" + nitNo
					+ "&applicationId=" + biddingFirmName + "&udf9=" + programId + "&udf10=" + currentFormName;
		} else {
			spURL = "?clientName=" + clientCode + "&programId=" + programId + "&usern=" + username + "&pass=" + password
					+ "&amt=" + txnAmt + "&txnId=" + txnId + "&firstName=" + payeeFirstName + "&lstName="
					+ payeeLastName + "&contactNo=" + payeeContact + "&Email=" + payeeEmail + "&Add=" + payeeAddress
					+ "&ru=" + URLsuccess + "&failureURL=" + URLfailure + "&profile=" + payeeProfile + "&cid=" + cid
					+ "&bid=" + bid + "&startDate=" + startDate + "&endDate=" + endDate + "&param2=" + feeName + "&udf9=" + programId + "&udf10=" + currentFormName;
		}

		if (auth) {
			try {
				log.info("transactionDetails:" + spURL);
				log.info("----authKey---------- " + authKey.toString() + "----authIV----------  " + authIV.toString());
				spURL = Encryptor.encrypt(authKey, authIV, spURL);
			} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException
					| InvalidAlgorithmParameterException | NoSuchAlgorithmException | NoSuchPaddingException e) {

				e.printStackTrace();
			}
			
			log.info("spURL before replacing spasings :::: " + spURL.toString());
			spURL = spURL.replaceAll("\\+", "%2B");
			spURL = "?query=" + spURL + "&clientName=" + clientCode + "&prodCode=" + prodCode;
		}
		String clientUrlFromDB = null;
		clientUrlFromDB = clientMappingCodeOfSabPaisa.getClientUrl();
		log.info("clientMappingCodeOfSabPaisa.getClientUrl(); ::::::: " + clientMappingCodeOfSabPaisa.getClientUrl());

		if (clientUrlFromDB == null || clientUrlFromDB.isEmpty()) {
			clientUrlFromDB = spDomain;
		}
		
		spURL = clientUrlFromDB + spURL;
		spURL = spURL.replace(" ", "%20");
		log.info(spURL);
		response.sendRedirect(spURL);
	}

	public List<Map<String, Object>> fetchClientTableData(String formId, String txnQfId) {
		log.info("Start of fetchClientTableData() method txnQfId {" + txnQfId + "}");
		List<Map<String, Object>> clientSpecificDataMap = null;
		try {
			clientSpecificDataMap = sampleTransService.getClientSpecificDataFromClientTable(formId, txnQfId);
			if (null != clientSpecificDataMap) {
				log.info("clientSpecificDataMap size return is ========> " + clientSpecificDataMap.size());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("End of fetchClientTableData() method txnQfId {" + txnQfId + "}");
		return clientSpecificDataMap;
	}

	@RequestMapping(value = "/ClientResponse")
	public ModelAndView clientResponse(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("ClientResponse");
		mav.addObject("ClientResponse", "ClientResponse");

		return mav;
	}

	private SpConfigBean requestForConfiurationDetailWithSp(String spUrl, SpConfigBean spBean) {
		log.info("Open requestForConfiurationDetailWithSp() method for sp Request  " + spBean.getClientCode());

		SpConfigBean spConfig = new SpConfigBean();
		try {
			RestTemplate restTemplate = new RestTemplate();

			log.info("response challan bean is " + spBean.toString());
			// Data attached to the request.
			HttpEntity<SpConfigBean> requestBody = new HttpEntity<SpConfigBean>(spBean);

			// Send request with POST method.
			spUrl = spUrl + spBean.getClientCode();
			log.info("sending request to spUrl : " + spUrl);

			try {
				ResponseEntity<SpConfigBean> result = restTemplate.getForEntity(spUrl, SpConfigBean.class);

				log.info("Status code:" + result.getStatusCode());

				if (result.getStatusCode() == HttpStatus.OK || result.getStatusCodeValue() == 200) {
					log.info("status is ");
					// log.info("value is "+mapper.convertValue(result,ResponseCobBean.class));
					SpConfigBean spcon = result.getBody();
					log.info(" ok status " + spcon.getClientCode());
					log.info("End requestForConfiurationDetailWithSp() method for sp Request  "
							+ spcon.getClientCode());
					return spcon;
				} else if (result.getStatusCode() == HttpStatus.NOT_IMPLEMENTED || result.getStatusCodeValue() == 501) {
					log.info("client not found in sp");
				}
			} catch (Exception e) {

				e.printStackTrace();
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		log.info("End requestForConfiurationDetailWithSp() method for sp Request  " + spBean.getClientCode());
		return spConfig;
	}
}

