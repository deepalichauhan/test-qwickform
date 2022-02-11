package com.sabpaisa.qforms.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.NoidaFormBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.dao.SampleTransDao;
import com.sabpaisa.qforms.services.ApplicantService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.NoidaFormBeanService;
import com.sabpaisa.qforms.services.SampleTransService;

@CrossOrigin
@Controller
@RequestMapping
public class ApplicantActionController implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//public static SessionFactory factoryReportsDB = ConnectionClass.getSessionFactoryfactoryReportsDB();
	
	@Autowired
	private NoidaFormBeanService noidaFormBeanService;
	
	@Autowired
	private DaoFieldLookupService daoFieldLookupService;
	
	@Autowired
	private SampleTransService sampleTransService;
	
	@Autowired
	private CollegeService collegeService;
	
	@Autowired
	private ApplicantService applicantService;
	
	Set<String> headerSet =new LinkedHashSet<String>();
	static Logger log = Logger.getLogger(ApplicantActionController.class.getName());
	ArrayList<ArrayList<String>> aplDetails;
	
	private CollegeBean collegeBean = new CollegeBean();
	private BeanPayerType beanPayerType = new BeanPayerType();
	private List<BeanPayerType> beanPayerTypeLst = new ArrayList<BeanPayerType>();
	private SampleTransDao sTransDao;

	public List<BeanPayerType> getBeanPayerTypeLst() {
		return beanPayerTypeLst;
	}

	public void setBeanPayerTypeLst(List<BeanPayerType> beanPayerTypeLst) {
		this.beanPayerTypeLst = beanPayerTypeLst;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	private ArrayList<NoidaFormBean> noidaFormBeansList = new ArrayList<NoidaFormBean>();
	private LoginBean loginUser = new LoginBean();
	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();

	// method to find of the meta data of applicant and return in the form of
	// set
	public Set<String> getHeader(String values) {
		
		//log.debug("Values Are::::" + values);
				// applicant value is seperated by (,) value is being spited
				String[] aplicantKeyValueArray = values.split(",");
				// creating linkedHash set for stroing the key only with coming order
				Set<String> keySet = new LinkedHashSet<String>();
				String key = null;
				for (int i = 0; i < aplicantKeyValueArray.length; i++) {
					// after spited string got the key value Pair

					//log.debug("header values:" + aplicantKeyValueArray[i]);
					String keyValuePair = aplicantKeyValueArray[i];

					// again spited key value pair string and get the key and add into
					// set
					try {
						key = keyValuePair.substring(0, keyValuePair.lastIndexOf("="));
						key = key.substring(key.lastIndexOf("` ") + 1, key.length());

					} catch (java.lang.StringIndexOutOfBoundsException ex) {
						ex.printStackTrace();
					}
					// key = key.replaceAll("[^A-Za-z\\s$]", "");
					//log.debug("The Header value of the reports:" + key);
					if (key.contentEquals("Notification-1") || key.contentEquals("Receipt Data")
							|| key.contentEquals("Notification-1.") || key.contentEquals("Notification-2.")
							|| key.contentEquals("Notification-2")) {

					} else {
						keySet.add(key);
						/* log.debug("final values:" + key); */
					}

				}

				return keySet;
	}

	public ArrayList<ArrayList<String>> getValueOfApplicant(List<String> allApplicantDetails) {
		ArrayList<ArrayList<String>> allApplicantData = new ArrayList<ArrayList<String>>();
		Iterator<String> aplItr = allApplicantDetails.iterator();
		while (aplItr.hasNext()) {
			ArrayList<String> singleApplicantDetail = new ArrayList<String>();
			String oneAplicantDetails = aplItr.next();
			String keyValuePairArray[] = oneAplicantDetails.split(",");
			for (int i = 0; i < keyValuePairArray.length; i++) {
				String onePairOfKeyValue = keyValuePairArray[i];
				String value = onePairOfKeyValue.substring(onePairOfKeyValue.lastIndexOf("=") + 1);
				singleApplicantDetail.add(value);
				/*
				 * if (value.length() > 100) {
				 * 
				 * } else { singleApplicantDetail.add(value); }
				 */

			}
			//log.debug("singleApplicantDetail:" + singleApplicantDetail);
			allApplicantData.add(singleApplicantDetail);
		}
		return allApplicantData;
		
	}

	@RequestMapping(value="/ApplicantReports",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicant(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");
		/*
		 * List<String> tempApplicantDetails =
		 * applicantDAO.getAllAplicantDetails();
		 * headerSet=getHeader(tempApplicantDetails.get(0));
		 * aplDetails=getValueOfApplicant(tempApplicantDetails);
		 */
		try {
			loginUser = (LoginBean) ses.getAttribute("loginUserBean");
			noidaFormBeansList = noidaFormBeanService.getDetailsOfDataSumaryAnd(loginUser.getCollgBean().getCollegeId());
			log.debug("noidaFormBeansList testing:" + noidaFormBeansList);

			String result = forDownLoad != null && forDownLoad.contentEquals("True") ? "ForDown" : "success";
			return result;
		} catch (Exception ex) {
			return "Applicant-Reports";
		}
	}

	@RequestMapping(value="/ApplicantReportsAllClients",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicantAllClients(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		
		String forDownLoad = request.getParameter("ForDownLoad");
		String checkval = null;
		int sequenceCount = 0;
		String feeType = request.getParameter("feeType");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		request.setAttribute("feeType", feeType);
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		String result = "";
		String sortingOfSequenceVal = null;
		Integer sortingOfSequenceCountVal = 0;
		
		try {
			
			BeanFormDetails form = daoFieldLookupService.getFormDetails(Integer.parseInt(feeType));
			buildHeaders(form);
			
			forms = new ArrayList<BeanFormDetails>(daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));
			List<String> successTransDetailsIds = new ArrayList<String>();
		
			List<SampleTransBean> successTransDetails = sampleTransService.getSuccessTransactionDetailsBasedOnDates(loginUser.getCollgBean().getCollegeId(), form.getFormFee().getFeeLookup().getFeeName(),fromDate,toDate);
			
		log.debug("size of transaction is:"+successTransDetails.size());
		if(successTransDetails.size()<1){
			return "Applicant-ReportsForAllClients";
		}
		
		SampleTransBean stransBean = null;
		for (SampleTransBean sampleTransBean : successTransDetails) {
			successTransDetailsIds.add(sampleTransBean.getTransId());
		}
		List<SampleFormBean> tempApplicantDetailsAll = applicantService.getSuccessTransAplicantDetailsOfParticularClient(feeType, "transIds", successTransDetailsIds);
		List<String> tempApplicantDetails = new ArrayList<String>();
		String formDataTrans = null;
		for (SampleFormBean sform : tempApplicantDetailsAll) {
			/* tempApplicantDetails.add(sform.getFormData()); */
			stransBean = sTransDao.getTransactions(sform.getFormTransId());
			// sorting the values based on sequence
			Map<String, Integer> map = new HashMap<String, Integer>();
			String sortedDataForm = null;
			sortingOfSequenceVal = sform.getFormData()+","+"-1`Receipt No=-1*"+sform.getFormTransId()+"$-99";
//			log.debug("receipt noO Is:"+sform.getFormData()+","+"-1`Receipt No=-1*"+sform.getFormTransId()+"$-99");
			String[] collectionOfFormFields = sortingOfSequenceVal.split(",");
			
			if(Integer.parseInt(feeType)==106){
				//log.debug("Form IdP:"+feeType);
				collectionOfFormFields=	addSpecialCharToGivenDataForm(collectionOfFormFields);
				
			}
		
			StringBuilder builder = new StringBuilder();
			String key = null;
			int count=1;
			for (String fieldWithSpecialChar : collectionOfFormFields) {
				try{
				sortingOfSequenceCountVal = Integer.parseInt(fieldWithSpecialChar.substring(fieldWithSpecialChar
						.lastIndexOf("$") + 1));
				map.put(fieldWithSpecialChar, sortingOfSequenceCountVal);
				}catch(NumberFormatException nex){
					nex.printStackTrace();
					map.put(fieldWithSpecialChar, count);
					count++;
				}
				
			}
			// sortingOfSequenceCountVal=Integer.parseInt(sortingOfSequenceVal.substring(sortingOfSequenceVal.lastIndexOf("$")+1));
			map = sortByValue(map);
			for (Map.Entry<String, Integer> entry : map.entrySet()) {
				// System.out.println(entry.getKey()+" ==== "+entry.getValue());
				sortedDataForm = entry.getKey();
				//log.debug(":::::::::::::Form Data:::::::" + sortedDataForm + ":key:" + entry.getKey() + ":::::::"
					//	+ entry.getValue());
				// log.debug(":::::::::::::Form Data:::::::"+sortedDataForm+":key:"+entry.getKey()+":::::::"+entry.getValue());
				try {
					key = sortedDataForm.substring(0, sortedDataForm.lastIndexOf("="));
					key = key.substring(key.lastIndexOf("`") + 1, key.length());
				} catch (java.lang.StringIndexOutOfBoundsException ex) {
					ex.printStackTrace();
				}
				if (key.contentEquals("Notification-1") || key.contentEquals("Receipt Data")
						|| key.contentEquals("Notification-1.") || key.contentEquals("Notification-2.")
						|| key.contentEquals("Notification-2") || key.contentEquals("Remarks")) {
				} else {
					builder.append("," + sortedDataForm);
				}
			}
			String sortedFormFields = builder.toString();
			sortedFormFields = sortedFormFields.substring(1);
		
			
			// log.debug("String values:" + formDataTrans);
			//Aditya K Code Changed on 09/08/2016
			
			
			
			//Dev:Dinesh:adding Code for CHSE Format
		
			
			 tempApplicantDetails.add(sortedFormFields);
			
			
		Set<String> headerval=new LinkedHashSet<String>();
		headerval.add("Category Name");
		headerval.add("Payment Mode");
		headerval.add("SabPaisaTxnId");
		headerval.add("Transaction Date");
		headerval.add("Amount");
		headerval.add("Status");
		/*headerval.add("Receipt Number");*/
		
		
		//Aditya K code Changed on 09/08/2016
		
		
		
		if(Integer.parseInt(feeType)==106){
			headerSet.add("Category");
			headerSet.add("Roll Number");
			headerSet.add("firstName");
			headerSet.add("lstName");
			headerSet.add("Father's Name");
			headerSet.add("Semester");
			headerSet.add("Department");
			headerSet.add("Payment Category");
			headerSet.add("Total Amount");
			headerSet.add("Name");
			headerSet.add("Date of Birth");
			headerSet.add("Mobile Number");
		
			
			
			headerSet.add("Email");
			headerSet.add("Receipt No");
		}else{
			headerSet=buildHeaders(form);
		}
		
		for (String string : headerSet) {
			//log.debug("value of header:"+string);
			headerval.add(string);
		
		}
		/*headerval.add("ReceiptNo");*/
		headerSet=headerval;
		ArrayList<ArrayList<String>> aplDataVal=new ArrayList<ArrayList<String>>();
		Map<Integer,Integer>headerMap =new LinkedHashMap<Integer, Integer>(); 
		if(Integer.parseInt(feeType)==106){
			headerMap.put(1,0);
			headerMap.put(2,1);
			headerMap.put(222,2);
			headerMap.put(223,3);
			headerMap.put(4,4);
			headerMap.put(6,5);
			headerMap.put(55,6);
			headerMap.put(77,7);
			headerMap.put(18,8);
			headerMap.put(14,9);
			headerMap.put(15,10);
			headerMap.put(16,11);
			headerMap.put(224,12);
			headerMap.put(-1,-99);
		}else{
			headerMap=buildHeaderMap(form);
		}
		
		
		
		
		aplDetails=buildFormContent(headerSet, headerMap, tempApplicantDetails);
//		log.debug("Lst values:"+aplDetails);
		for (ArrayList<String> stringAlst : aplDetails) {
			SampleTransBean transBean=new SampleTransBean();
			ArrayList<String> dataValStr=new ArrayList<String>();
			transBean=sampleTransService.getTransactionDetailsBasedOnTransactionId(stringAlst.get(stringAlst.size()-1));
			dataValStr.add(form.getFormName());
			dataValStr.add(transBean.getTransPaymode());
			dataValStr.add(transBean.getSpTransId());
			dataValStr.add(transBean.getTransDate().toString());
			dataValStr.add(transBean.getTransAmount().toString());
			dataValStr.add(transBean.getTransStatus());
			/*dataValStr.add(transBean.getTransId());*/
			
	
			
			for (String string : stringAlst) {
				//log.debug("value of formData:"+string);
				dataValStr.add(string);
				
			}
			aplDataVal.add(dataValStr);
		}
		
		aplDetails=aplDataVal;
		
	
		ArrayList<Integer> sizeOfHeaders = new ArrayList<Integer>();
		for (int k = 0; k <= headerSet.size(); k++) {
			sizeOfHeaders.add(k);
		}
		
	
		}
		result = forDownLoad != null && forDownLoad.contentEquals("True") ? "ForDown" : "success";
	} catch (Exception ex) {
		ex.printStackTrace();
		return "Applicant-ReportsForAllClients";
	}
	return result;
			
		
	}

	private String indexOf(char c) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@RequestMapping(value="/ApplicantReportsAllClientsBAPR",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicantAllClientsBAPR(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");

		String feeType = request.getParameter("feeType");
		request.setAttribute("feeType", feeType);
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		String result = "";
		try {
			/*DaoFieldLookup daoFieldLookupService = new DaoFieldLookup();*/
			/*
			 * List<String> tempApplicantDetails =
			 * applicantService.getAllAplicantDetails();
			 */

			forms = new ArrayList<BeanFormDetails>(daoFieldLookupService.getApprovedFormDetails(loginUser));
			List<String> tempApplicantDetails = applicantService.getAllAplicantDetailsOfParticularClient(loginUser
					.getOperatorBean().getCollegeBean_fk().getCollegeId(), feeType);
			log.debug("size of list is" + tempApplicantDetails.size());
			headerSet = getHeader(tempApplicantDetails.get(0));
			aplDetails = getValueOfApplicant(tempApplicantDetails);
			result = forDownLoad != null && forDownLoad.contentEquals("True") ? "Applicant-ReportsForExcelForAllClients" : "Applicant-Operator-Reports";
		} catch (Exception ex) {
			ex.printStackTrace();
			return "Applicant-Operator-Reports";
		}
		/*
		 * if(loginUser.getProfile().contentEquals("Operator")){ return
		 * "operator"; }else{
		 */

		return result;
		/* } */
		/* return result; */
	}

	@RequestMapping(value="/ApplicantReportsAllClientsForExcelDownloads",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicantAllClientsForExcelDownloads(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");

		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		String result = "";
		try {
			/*
			 * List<String> tempApplicantDetails =
			 * applicantService.getAllAplicantDetails();
			 */
			List<String> tempApplicantDetails = applicantService
					.getAllAplicantDetailsOfParticularClientForExcelDownlods(loginUser.getCollgBean().getCollegeId());
			log.debug("size of list is" + tempApplicantDetails.size());
			headerSet = getHeader(tempApplicantDetails.get(0));
			aplDetails = getValueOfApplicant(tempApplicantDetails);
			result = forDownLoad != null && forDownLoad.contentEquals("True") ? "ForDown" : "Applicant-ReportsForExcelForAllClients";
		} catch (Exception ex) {
			return "Applicant-ReportsForExcelForAllClients";
		}

		return result;
	}

	@RequestMapping(value="/ApplicantReportsAllClientsforOp",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicantAllClientsforOp(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");
		String feeType = request.getParameter("feeType");
		ses.setAttribute("feeType", feeType);
		log.debug("Feet Type is ::" + feeType);
		
		String result = "";
		try {
			/*
			 * List<String> tempApplicantDetails =
			 * applicantService.getAllAplicantDetails();
			 */
			List<String> tempApplicantDetails = applicantService.getAllAplicantDetailsOfParticularClientForExcelDownlods(1);
			log.debug("size of list is" + tempApplicantDetails.size());
			headerSet = getHeader(tempApplicantDetails.get(0));
			aplDetails = getValueOfApplicant(tempApplicantDetails);
			result = forDownLoad != null && forDownLoad.contentEquals("True") ? "Applicant-ReportsForExcelForAllClients" : "Applicant-Operator-Reports";
		} catch (Exception ex) {
			return "Applicant-Operator-Reports";
		}

		return result;
	}

	@RequestMapping(value="/ApplicantReportsAllClientsOp",method = {RequestMethod.GET,RequestMethod.POST})
	public String viewAllApplicantAllClientsOP(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		String forDownLoad = request.getParameter("ForDownLoad");
		String feeType = request.getParameter("feeType");
		ses.setAttribute("feeType", feeType);
		
		String result = "";
		try {
			/*
			 * List<String> tempApplicantDetails =
			 * applicantService.getAllAplicantDetails();
			 */
			List<String> tempApplicantDetails = applicantService.getAllAplicantDetailsOfParticularClient(1, feeType);
			log.debug("size of list is" + tempApplicantDetails.size());
			headerSet = getHeader(tempApplicantDetails.get(0));
			aplDetails = getValueOfApplicant(tempApplicantDetails);
			result = forDownLoad != null && forDownLoad.contentEquals("True") ? "Applicant-ReportsForExcelForAllClients" : "Applicant-Operator-Reports";
		} catch (Exception ex) {
			return "Applicant-Operator-Reports";
		}

		return result;
	}

	/* chooseApplicantAction */
	@RequestMapping(value="/chooseApplicantAction",method = {RequestMethod.GET,RequestMethod.POST})
	public String chooseApplicantAction(HttpSession ses) {

		String bidString = ses.getAttribute("bid").toString();
		String cidString = ses.getAttribute("cid").toString();

		collegeBean = collegeService.getInstDetailUsingCidAndBid(bidString, cidString);
		beanPayerTypeLst = collegeService.getBeanPayerListDetails(collegeBean);
		ses.setAttribute("beanPayerTypeLst", beanPayerTypeLst);
		log.debug("PayerBean list:" + beanPayerTypeLst.size());

		return "chooseStudentOrCollegeOption";
	}

	public String NormalizeFormData(String formData,BeanFormDetails formDetails,Set<String>headers)
	{
		log.debug("Data String of Form is "+formData);
		log.debug("Headers are "+headers.toString());
		return null;
	}
	
	public Set<String> buildHeaders(BeanFormDetails formDetails)
	{
		Set<String> headerSet=new LinkedHashSet<String>();
		List<BeanFormStructure> structure=new ArrayList(formDetails.getFormStructure());
		Collections.sort(structure,Comparator.comparingInt(BeanFormStructure::getFieldOrder));
		for (int i = 0; i < structure.size(); i++) {
			if(structure.get(i).getFormField().getLookup_name().contentEquals("Notification-1") || structure.get(i).getFormField().getLookup_name().contentEquals("Notification-2") || structure.get(i).getFormField().getLookup_name().contentEquals("Remarks") || structure.get(i).getFormField().getLookup_name().contentEquals("Page Title")){
				
			}else{
			headerSet.add(structure.get(i).getFormField().getLookup_name());
			}
		}
		
		headerSet.add("Receipt No");
		return headerSet;
	}
	public Map<Integer,Integer> buildHeaderMap(BeanFormDetails formDetails)
	{
		Map<Integer,Integer>headerMap=new LinkedHashMap<Integer, Integer>();
		List<BeanFormStructure> structure=new ArrayList(formDetails.getFormStructure());
		Collections.sort(structure,Comparator.comparingInt(BeanFormStructure::getFieldOrder));
		for (int i = 0; i < structure.size(); i++) {
			headerMap.put(structure.get(i).getId(),structure.get(i).getFieldOrder());
		}
		
		headerMap.put(-1, -99);
		return headerMap;
		
	}
	
	public ArrayList<ArrayList<String>> buildFormContent(Set<String>headerSet,Map<Integer,Integer>headerMap,List<String>formData)
	{
		Map<Integer,String>contentMap=new LinkedHashMap<Integer, String>();
		String checkval = null;
		int sequenceCount = 0;
//		log.debug("map val:"+headerMap);
		ArrayList<ArrayList<String>> allApplicantData = new ArrayList<ArrayList<String>>();
		Map<Integer,String>contentMapEx=new LinkedHashMap<Integer, String>();
		Iterator<String> aplItr = formData.iterator();
		while (aplItr.hasNext()) {
			ArrayList<String> singleApplicantDetail = new ArrayList<String>();
			String oneAplicantDetails = aplItr.next();
			//log.debug("Applicant Detail in raw form "+oneAplicantDetails);
			String keyValuePairArray[] = oneAplicantDetails.split(",");
			for (int i = 0; i < keyValuePairArray.length; i++) {
				String onePairOfKeyValue = keyValuePairArray[i];
				String value = onePairOfKeyValue.substring(onePairOfKeyValue.lastIndexOf("=") + 1);
				if(value.contains("$"))
				{
					//log.debug("removing $");
					checkval = value.substring(value.length() - 1);
					sequenceCount = Integer.parseInt(checkval);
					value = value.substring(0, value.indexOf('$'));
				}
				if(value.contains("*"))
				{
					//log.debug("removing *");
					value = value.substring(value.lastIndexOf('*') + 1);
					//log.debug("value retrieved is::"+value);
				}
				//log.debug("header info is "+onePairOfKeyValue.split("=")[0].split("`")[0]);
				Integer header_id=Integer.parseInt(onePairOfKeyValue.split("=")[0].split("`")[0].trim());
				//log.debug("next header id is::"+headerMap.get(header_id)+" : "+value);;
				contentMap.put(headerMap.get(header_id), value);
				
				

			}
			
			
			for (int i = 0; i < contentMap.keySet().size(); i++) {
				
				if(i==contentMap.keySet().size()-1){
					//log.debug("putting in value "+contentMap.get(-99));					
					singleApplicantDetail.add(contentMap.get(-99));	
				}
				else{
		//	log.debug("putting in value "+contentMap.get(i)+" : "+i+" : "+contentMap.get(13));
				singleApplicantDetail.add(contentMap.get(i));
				}
			}
			
			
			
			//log.debug("singleApplicantDetail:" + singleApplicantDetail);
			allApplicantData.add(singleApplicantDetail);
		}
		log.debug("allApplic data size" +allApplicantData.size());
	//	log.debug("allApplicantData data:" +allApplicantData);
		
		
		return allApplicantData;

	}
	
	// setters and getters
	public Set<String> getHeaderSet() {
		return headerSet;
	}

	public void setHeaderSet(Set<String> headerSet) {
		this.headerSet = headerSet;
	}

	public ArrayList<ArrayList<String>> getAplDetails() {
		return aplDetails;
	}

	public void setAplDetails(ArrayList<ArrayList<String>> aplDetails) {
		this.aplDetails = aplDetails;
	}

	public ArrayList<NoidaFormBean> getNoidaFormBeansList() {
		return noidaFormBeansList;
	}

	public void setNoidaFormBeansList(ArrayList<NoidaFormBean> noidaFormBeansList) {
		this.noidaFormBeansList = noidaFormBeansList;
	}

	public LoginBean getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(LoginBean loginUser) {
		this.loginUser = loginUser;
	}

	public List<BeanFormDetails> getForms() {
		return forms;
	}

	public void setForms(List<BeanFormDetails> forms) {
		this.forms = forms;
	}

	public BeanPayerType getBeanPayerType() {
		return beanPayerType;
	}

	public void setBeanPayerType(BeanPayerType beanPayerType) {
		this.beanPayerType = beanPayerType;
	}

	public static <K, V extends Comparable<? super V>> Map<K, V> sortByValue(Map<K, V> map) {
		Map<K, V> result = new LinkedHashMap<>();
		Stream<Map.Entry<K, V>> st = map.entrySet().stream();

		st.sorted(Map.Entry.comparingByValue()).forEachOrdered(e -> result.put(e.getKey(), e.getValue()));

		return result;
	}

	public String[] addSpecialCharToGivenDataForm(String[] collectionOfFormFields){
		String[] collectionOfFinallFormFields=null;

		StringBuilder addingSpecialSymbolsIntoFields = new StringBuilder();
		int seqCount=1;
		log.debug(collectionOfFormFields.length+":lenth of  collectionOfFormFields");
		/*if(seqCount!=collectionOfFormFields.length){*/
		for (String formFieldswithMissingSpecialSymbols : collectionOfFormFields) {
			String[] formFieldsSaperatingWithComma=formFieldswithMissingSpecialSymbols.split(",");
			log.debug("Id val of Field:"+formFieldsSaperatingWithComma[0].substring(0,formFieldsSaperatingWithComma[0].indexOf("`")));
			
			
			for (String strFeilds : formFieldsSaperatingWithComma) {
				String[] formFieldsSaperatingWithequalTo=strFeilds.split("=");
				
				addingSpecialSymbolsIntoFields.append(","+formFieldsSaperatingWithequalTo[0]+"="+formFieldsSaperatingWithequalTo[0].substring(0,formFieldsSaperatingWithequalTo[0].indexOf("`"))+"*"+formFieldsSaperatingWithequalTo[1]+"$"+seqCount);
				seqCount++;
				log.debug("strFeilds:"+strFeilds);
			}
			log.debug("Data is:"+addingSpecialSymbolsIntoFields);
		}
		log.debug(" the total string with special symbols is:"+addingSpecialSymbolsIntoFields.substring(1));
	
		collectionOfFinallFormFields=addingSpecialSymbolsIntoFields.substring(1).split(",");
		/*}*/
		
		return collectionOfFinallFormFields;
	}
	

}
