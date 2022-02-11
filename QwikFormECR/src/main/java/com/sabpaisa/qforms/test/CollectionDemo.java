package com.sabpaisa.qforms.test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

public class CollectionDemo {
	
	public static void main(String[] args) throws Exception {	
		String str="80~Misc_Fee=32110$14,81~Gender=F$7,82~Year_of_Study=2ND YEAR$9,83~Date_of_Birth=20-05-2000$5,"
				+ "84~Fathers_Name=SHIVASHANKAR SHARMA K$3,85~USN_Number=1CF18AT103$1,86~Total_Payable_Amount=232110$15,87~Category=GM$6,"
				+ "88~Quota=MGMT$10,89~Notification=Online Form For Payment$0,90~Tuition_Fee=200000$13,91~Academic_Batch=2018-19$4,"
				+ "92~Course=B.ARCH$8,93~Mobile_No=9108456059$11,94~Email_ID=shwethasharma2000@gmail.com$12,95~Student_Name=SHWETHA SHARMA$2";
		System.out.println(str);
		String[] formFields = str.split(",");
		
		int i=0;
		String str2="";
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		System.out.println(formFieldsList.toString());
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split("$");
			//String[] b = temp.getValue().split("$");
			int k = formFieldData[0].indexOf('$');
			String proofresult = formFieldData[0].substring(0, k);
			int m = proofresult.indexOf("~");
			String val = proofresult.substring(m + 1, k);
			//String col = proofresult.substring(0, m);
			str2=str2+val+",";
			++i;
		}
		System.out.println(str2.toString());
	}
}

/*String str="Field_Officer, Entity_Type, Name_of_the_OwnerhphnAgenthphnBuilder, Contact_No, Email_ID, Initial_Payment_Mode, Product_and_Rate, Subscription_Mode, Debit_Frequency, Name_of_Account_Holder, Bank_Name, Account_Type, Account_Number, Cheque_No, IFSC_Code, Starting_From, Date_Of_Birth";
		System.out.println(str);
		String str3="";
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(str));
		
		System.out.println(formFieldsList.toString());
		
		for(int i=0;i<formFieldsList.size();i++) {
			str3=str3+formFieldsList.get(i).replaceAll("hphn", "\\-")+", ";
			//formFieldsList.add(formFieldsList.get(i).replaceAll("\\-", "hphn"));
		}
		formFieldsList=new ArrayList<String>(Arrays.asList(str3));
		System.out.println(formFieldsList.toString());*/


/*
 * String str="30~Field_Officer, 31~Entity_Type, 32~Name_of_the_OwnerhphnAgenthphnBuilder, 33~Contact_No, 34~Email_ID, 35~Initial_Payment_Mode, 37~Product_and_Rate, 38~Subscription_Mode, 39~Debit_Frequency, 40~Name_of_Account_Holder, 43~Bank_Name, 41~Account_Type, 42~Account_Number, 36~Cheque_No, 44~IFSC_Code, 45~Starting_From, 6~Date_Of_Birth";
		System.out.println(str);
		String str3="";
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(str));
		
		System.out.println(formFieldsList.toString());
		
		for(int i=0;i<formFieldsList.size();i++) {
			str3=str3+formFieldsList.get(i).replaceAll("hphn", "\\-")+", ";
			//formFieldsList.add(formFieldsList.get(i).replaceAll("\\-", "hphn"));
		}
		formFieldsList=new ArrayList<String>(Arrays.asList(str3));
		System.out.println(formFieldsList.toString());*/











/*String str1="2356=UNIVERSITY EXAM FEE=3400, 2357=EMAIL_ID=arvind.gangwar@srslive.in, 2358=INTERNAL_EXAM_FEE=500";
String str3="";
String[] str = str1.split(",");
HashMap<String, String> fieldMap = new HashMap<String, String>();
ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(str));
ArrayList<String> formFieldsList1 = new ArrayList<String>();
System.out.println("the size is "+formFieldsList.size()+" :::::::::: "+formFieldsList.toString());
int i = 0;
while (i < formFieldsList.size()) {
	
	String[] formFieldData = formFieldsList.get(i).split("=");
	str3=str3+formFieldsList.get(i).replaceFirst("=", "~")+", ";
	System.out.println("DDDDDDDDDDDv "+str3);
	System.out.println("formFieldData[0] :::: " + formFieldData[0] + " :::::: formFieldData[1] :: '"
			+ formFieldData[1]+"'");
	if (formFieldData.length != 2) {
		System.out.println(("Form Field at index " + i + " is corrupt or unreadable"));
	} else {
		String string2=formFieldData[0];
		
		string2 = string2.replaceAll("\\s", "_");
		
		string2 = StringUtils.removeEnd(string2, "_");
		string2=StringUtils.removeStart(string2, "_");
		
		int ind=formFieldData[1].indexOf("*");
		if(ind!=0) {
			formFieldData[1]=formFieldData[1].substring(ind+1, formFieldData[1].length());
		}
		fieldMap.put(string2, "'"+formFieldData[1]+"'");
		formFieldsList1.add(string2+"='"+formFieldData[1]+"'");
	}
	++i;
}
System.out.println(" ddddddddd "+formFieldsList1.toString());

System.out.println(" mmmmmmmmmm "+fieldMap.toString());
*/

/*@RequestMapping(value = "/processForm", method = RequestMethod.GET)
public String prepareForm(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

	log.info("bid {" + request.getParameter("bid") + "}, cid {" + request.getParameter("cid") + "}, formId {"
			+ request.getParameter("formid") + "}, " + "forminstanceid {" + request.getParameter("forminstanceid")
			+ "}, isFormBeingRevived {" + request.getParameter("isFormBeingRevived") + "}, formrevivalinstanceid {"
			+ request.getParameter("formrevivalinstanceid"));
	if(null!= ses.getAttribute("formViewData")) {
		ses.removeAttribute("formViewData");
	}
	formViewData = new ArrayList();
	
	boolean staleCheckResult = this.checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
			request.getParameter("formid"), request.getParameter("forminstanceid"), ses);

	if(null!=form) {
		form = new SampleFormBean();
	}
	if (staleCheckResult) {
		block34: {
			block33: {
				log.info("staleCheckResult passes...");
				String isFormBeingRevived = request.getParameter("isFormBeingRevived") == null ? "N"
						: request.getParameter("isFormBeingRevived");
				String forminstanceid = request.getParameter("forminstanceid");
				String formInstanceIdFromRevivalRequest = request.getParameter("formrevivalinstanceid") == null ? ""
						: request.getParameter("formrevivalinstanceid");
				log.info(("formInstanceIdFromRevivalRequest is::" + formInstanceIdFromRevivalRequest));
				ses.setAttribute("lpFlag", 1);
				CollegeBean colBean=new CollegeBean();
				colBean=(CollegeBean) ses.getAttribute("CollegeBean");
				log.info("College Id is :::: "+colBean.getCollegeId());
				ses.setAttribute("CollegeBean",colBean);
				String payerID = "";
				Date formSubmitDate = new Date();
				Date dobDate = new Date();
				String formNumber=null;
				try {
					SampleFormBean beanFormData;
					BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
					String formData = request.getParameter("values");
					// log.info("form data before Specific Chars removal, which found from view
					// is:>" + formData);
					formData = formData.replaceAll("'", " ");
					formData = formData.replaceAll("/", "_");
					formData = formData.replaceAll("\\\\", "_");
					formData = formData.replaceAll("\\(", "-");
					formData = formData.replaceAll("\\)", "-");
					// log.info(("form data after Specific Chars removal is:>" + formData));
					Integer formTemplateId = (Integer) ses.getAttribute("currentFormId");
					this.formDetails = this.daoFieldLookupService.getFormDetails(formTemplateId);
					log.info("varification flag is ::: " + formDetails.getMoveToPg());
					ses.setAttribute("veriflag", formDetails.getMoveToPg());
					ses.setAttribute("veriflag1", formDetails.getHasInstructions());
					Integer formInstId = Integer.parseInt(ses.getAttribute("CollegeId").toString());
					Integer formFeeId = fee != null ? fee.getId() : null;
					Integer formApplicantId = 0;
					String code = request.getParameter("rccode");
					String name = request.getParameter("rcname");
					String email = request.getParameter("rcemail");
					String contact = request.getParameter("rccontact");
					String dob = request.getParameter("rcdob");
					if (request.getParameter("rcPayerID") != null) {
						payerID = request.getParameter("rcPayerID");
						ses.setAttribute("Roll Number", payerID);
					}
					log.info((":----:" + dob));
					Double amount = (Double) ses.getAttribute("feeAmt");
					log.info(("amount is::" + amount));
					String formFeeName = String.valueOf(formFeeId);
					// log.info(("formFeeName after copying value from formFeeId is::" +
					// formFeeName));
					String startDate = request.getParameter("rcStartDate");
					String endDate = request.getParameter("rcEndDate");
					if (amount == null && amount == 0.0) {
						amount = Double.parseDouble(ses.getAttribute("amt").toString());
					}
					log.info("Trans Amount is :::: " + amount.toString());
					SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
					try {
						if (dob != null && !"".equals(dob)) {
							log.info(("dob from request::" + dob));
							dobDate = formatter.parse(dob);
							log.info(("dobDate after formatting is::" + dobDate));
						} else {
							log.info("dob from request is null");
						}
					} catch (ParseException e) {
						e.printStackTrace();
					}
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
										|| col.equals("Total_Payable_Amount") || col.equals("Amount") 
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

							formViewData = this.processFormView(formDataMap, ses);

							// End 13 Mar 2019
							formNumber = this.getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
									formTemplateId);

							beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
									formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
									startDate, endDate, code, payerID, formNumber);
							log.info("first server hit, saving forminstanceid to session ");
						} else {
							log.info("case of revival flow first server hit");

							beanFormData = sampleFormService.getFormData(
									Integer.valueOf(Integer.parseInt(formInstanceIdFromRevivalRequest)));
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
								formNumber = this.getGenerateFormNumber(
										(Integer) ses.getAttribute("CollegeId"), formTemplateId);
								sampleFormService.deleteFormData((SampleFormBean) beanFormData);
								beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate,
										formInstId, formApplicantId, formFeeId, name, dobDate, email, contact,
										amount, formFeeName, startDate, endDate, code, payerID, formNumber);
							}
						}
					} else {
						log.info("case of subsequent hits regular or revival flow");
						this.form.setFormData(formData);
						beanFormData = this.form;
						log.info("beanFormData.getFormData(); :::::::::::::::::: " + beanFormData.getFormData());

						Map<Integer, String> formDataMap1 = new HashMap();
						// log.info(("Initial form is 1:-------------:" + formData.toString()));
						formDataMap1 = this.processFormData(formData, ses);
						log.info(("form data after processForm is 2:-------------:" + formDataMap1.toString()));

						ses.setAttribute("sesCurrentFormMap", formDataMap1);
						formViewData = this.processFormView(formDataMap1, ses);
						log.info(("formViewData after processFormView is 2:-------------:"
								+ formViewData.toString()));

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
						if (!dob.contentEquals(formatted_date)) {
							payerVitalContactInfoRevised = true;
							beanFormData.setDob(dob);
							if (!dobDate.equals("")) {
								beanFormData.setDobDate(dobDate);
							}
						}
						beanFormData.setCode(code);
						beanFormData.setName(name);
						beanFormData.setTransAmount(amount);
						if (payerVitalContactInfoRevised) {
							formNumber = this.getGenerateFormNumber((Integer) ses.getAttribute("CollegeId"),
									formTemplateId);
							sampleFormService.deleteFormData((SampleFormBean) beanFormData);
							beanFormData = new SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId,
									formApplicantId, formFeeId, name, dobDate, email, contact, amount, formFeeName,
									startDate, endDate, code, payerID, formNumber);
						}
						// log.info(("this.formviewdata after isempty checking :-------------:" +
						// this.formViewData));
					}
					log.info("beanFormData >>>>>>>>>>>>>>>>>>>>>>>>>> {" + beanFormData.getFormData().toString()
							+ "}");

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
						ses.removeAttribute("currentPhotoExt");
						ses.removeAttribute("currentPhoto");
						ses.removeAttribute("currentSignatureExt");
						ses.removeAttribute("currentSignature");
					} else {
						log.info("photo and signature is not uploaded.");
					}

					beanFormData = sampleFormService.saveFormData((SampleFormBean) beanFormData);
					ses.setAttribute("formViewData", formViewData);
					ses.setAttribute("sesCurrentFormData", beanFormData);
					ses.setAttribute("formInstanceId", String.valueOf(beanFormData.getFormId()));
					ses.setAttribute("formnumber",formNumber);
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
					log.info(("revival indicator is.::" + isFormBeingRevived));
					if (!"Y".equals(isFormBeingRevived))
						break block33;
					log.info("returning revivalsuccess");
					return "formSummaryRevival";
				} catch (NullPointerException e) {
					e.printStackTrace();
					return "PaySessionOut";
				}
			}
			if (request.getParameter("actorFlow") == null || !"Y".equals(request.getParameter("actorFlow")))
				break block34;
			log.info("returning actorsuccess as this is the case of internal form submission");
			return "formSummaryInternal";
		}
		log.info("returning regular success");
		//ses.setAttribute("formViewData", formViewData);
		ses.setAttribute("form", form);
		if (this.formDetails.getMoveToPg().contentEquals("yes")
				&& this.formDetails.getHasInstructions().contentEquals("yes")) {
			return "FormSummaryNewWithoutPG";
		}
		return "formSummaryNew";
	}
	log.info("staleCheckResult fails...terminated user session");
	request.setAttribute("staleCheckResult", "fail");
	return "SessionTerminated";
}*/


/*
 
 @RequestMapping(value="/renderPreview",method = RequestMethod.GET)
	public String renderPreview(Model model,HttpServletRequest request, HttpServletResponse response,HttpSession ses) {

		 	boolean hasPhoto = false;
	        boolean hasSignature = false;
	        HashMap renderMap = new HashMap();
	        HashMap valuesMap = new HashMap();
	        HashMap optionMap = new HashMap();
	        HashMap<Integer, String> pageTitlesMap = new HashMap<Integer, String>();
	        List mandatoryFields = new ArrayList();
	        List validateFieldNameList=new ArrayList();
	        String[] tempField = request.getParameter("definedFieldValues").split("~");
	        Integer l = 0;
	        pageTitlesMap = new HashMap();
	        String saveFlag = request.getParameter("lastCall");
	        String orderChangereq = request.getParameter("orderchange");
	        if (!orderChangereq.trim().contentEquals("-1")) {
	            ArrayList orderedLookups = new ArrayList();
	            orderedLookups = (ArrayList)ses.getAttribute("renderLookups");
	            String[] comboArr = orderChangereq.split("~");
	            String index = comboArr[0];
	            Integer indexint = Integer.parseInt(index.trim());
	            String direction = comboArr[1];
	            if (direction.trim().contentEquals("U")) {
	                Collections.swap(orderedLookups, (int)indexint, indexint - 1);
	            } else {
	                Collections.swap(orderedLookups, (int)indexint, indexint + 1);
	            }
	            this.renderLookups = orderedLookups;
	            ses.setAttribute("renderLookups", this.renderLookups);
	            renderMap = (HashMap)ses.getAttribute("sesRenderMap");
	            valuesMap = (HashMap)ses.getAttribute("sesValuesMap");
	            ArrayList renderKeySet = new ArrayList(renderMap.keySet());
	            renderKeySet.isEmpty();
	            this.optionsMap = (Map)ses.getAttribute("sesOptionsMap");
	            log.info("End of renderPreview() method 0, >> "+optionsMap.toString());
	            return "renderPage";
	        }
	        
	        ArrayList<Integer> fieldIds = (ArrayList)ses.getAttribute("sesFieldsList");
	       
	        if(null!=fieldIds) {
	        	log.info("fieldIds are ::::::::: "+fieldIds.toString());
	        }
	        
	        optionMap = (HashMap)ses.getAttribute("sesOptionsMap");
	        pageTitlesMap = (HashMap<Integer, String>)ses.getAttribute("sesPageTitlesMap");
	        
	        excelFieldList=(ArrayList<Integer>) ses.getAttribute("fieldLookupList");
	        if(null!=excelFieldList && null!=fieldIds) {
	        	log.info("excelFieldList is "+excelFieldList.toString());
	        	fieldIds = (ArrayList<Integer>) Stream.concat(fieldIds.stream(), excelFieldList.stream()).collect(Collectors.toList());
	        	log.info("fieldIds with excelfieldlist are ::::::::: "+fieldIds.toString());
	        }
	        if (pageTitlesMap == null) {
	            pageTitlesMap = new HashMap<Integer, String>();
	        }
	        String selectedFields = request.getParameter("fieldarray");
	        String mandFields = request.getParameter("mandatoryList");
	        String validateFieldName = request.getParameter("validateFields");
	        log.info("selectedFields ::: {"+selectedFields+"},  mandFields :: {"+mandFields+"}, validateFieldName :: {"+validateFieldName+"}");
	        
	        if (!validateFieldName.trim().contentEquals("")) {
	        	validateFieldNameList = Arrays.asList(validateFieldName.split(","));
	            log.info("validateFieldNameList Fields field value in array is "+validateFieldNameList.toString());
	        }
	        
	        if (!mandFields.trim().contentEquals("")) {
	            mandatoryFields = Arrays.asList(mandFields.split(","));
	        }
	        
	        List<String> fieldList=null;
	        if(null!=selectedFields && !selectedFields.isEmpty() && ""!=selectedFields) {
		        fieldList = Arrays.asList(selectedFields.split(","));
		        log.info((Object)("selected Fields are " + fieldList.toString()));
	        }
	        
	        if(null!=fieldList && ""!=fieldList.toString()) {
		        for(String x :fieldList ) {
		        	Integer y=Integer.parseInt(x);
					if(null==fieldIds) {
						fieldIds.add(y);
					}
					else if(!fieldIds.contains(y)) {
						fieldIds.add(y);
					}
				}
	        }
	        log.info("fieldIds are ::::::::: "+fieldIds.toString());
	        
	        Iterator<Integer> fieldIdIterator = fieldIds.iterator();
	        while (fieldIdIterator.hasNext()) {
	            Integer selectedId;
	            boolean add = true;
	            try {
	                selectedId = fieldIdIterator.next();
	            }
	            catch (NumberFormatException e) {
	                log.info((Object)"breaking from add to List while loop");
	                break;
	            }
	            for (Integer currentId : fieldIds) {
	                if (!currentId.equals(selectedId)) continue;
	                add = false;
	            }
	            if (!add) continue;
	            fieldIds.add(selectedId);
	        }
	        log.info("fieldIds are ::::::::: "+fieldIds.toString());
	        
	        Iterator currentIt = fieldIds.iterator();
	        if(null!=excelFieldList) {
		        while (currentIt.hasNext()) {
		            boolean remove = true;
		            Integer currId = (Integer)currentIt.next();
		            Iterator<Integer> selectedIt = fieldIds.iterator();
		            while (selectedIt.hasNext()) {
		                try {
		                    Integer selId = selectedIt.next();
		                    if (!selId.equals(currId)) continue;
		                    remove = false;
		                }
		                catch (NumberFormatException e) {
		                    remove = true;
		                }
		            }
		            if (!remove) continue;
		            currentIt.remove();
		        }
	        }else {
	        	while (currentIt.hasNext()) {
	                boolean remove = true;
	                Integer currId = (Integer)currentIt.next();
	                Iterator<String> selectedIt = fieldList.iterator();
	                while (selectedIt.hasNext()) {
	                    try {
	                        Integer selId = Integer.parseInt(selectedIt.next());
	                        if (!selId.equals(currId)) continue;
	                        remove = false;
	                    }
	                    catch (NumberFormatException e) {
	                        remove = true;
	                    }
	                }
	                if (!remove) continue;
	                currentIt.remove();
	            }
	        }
	        Integer baseAmount = Integer.parseInt(request.getParameter("feeAmount"));
	        log.info((Object)("SelectedFields are " + fieldIds.toString() + " Amount is " + baseAmount));
	        ArrayList<BeanFieldLookup> currentFieldLookups = new ArrayList<BeanFieldLookup>();
	        ArrayList<BeanFieldLookup> currentFieldLookupsOrdered = new ArrayList<BeanFieldLookup>();
	        if(excelFieldList==null && fieldIds!=null) {
	        	
		        log.info((Object)("SelectedFields are " + fieldIds.toString() + " Amount is " + baseAmount));
		        
		        if (!fieldIds.isEmpty()) {
		        	log.info("SelectedFields are in IF block when fieldid is not empty:::::::::: " + fieldIds.toString());
		            currentFieldLookups = this.daoFieldLookupService.getFieldLookups(fieldIds);
		            log.info("currentFieldLookups is in daoimpl ::::::::: "+currentFieldLookups.toString());
		            Integer i = 0;
		            while (i < fieldIds.size()) {
		                Integer tempid = (Integer)fieldIds.get(i);
		                Integer j = 0;
		                while (j < currentFieldLookups.size()) {
		                    log.info((Object)("lookup id in array " + ((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id() + " lookup id from jsp " + tempid));
		                    if (((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
		                    	log.info("Temp type in code -->>> "+currentFieldLookups.get(j).getLookup_subtype()+ "  "+currentFieldLookups.get(j).getLookup_subtype());
		                        currentFieldLookupsOrdered.add((BeanFieldLookup)currentFieldLookups.get(j));
		                    }
		                    j = j + 1;
		                }
		                i = i + 1;
		            }
		            log.info("currentFieldLookupsOrdered   is :::::::::::::::::::: "+currentFieldLookupsOrdered.toString());
		            currentFieldLookups = currentFieldLookupsOrdered;
		        }
	        }else if(excelFieldList!=null && fieldIds!=null) {
    	 		
	        log.info((Object)("SelectedFields are " + fieldIds.toString() + " Amount is " + baseAmount));
	        
	        if (!fieldIds.isEmpty()) {
	        	log.info("SelectedFields are in IF block when fieldid is not empty:::::::::: " + fieldIds.toString());
	            currentFieldLookups = this.daoFieldLookupService.getFieldLookups(fieldIds);
	            log.info("currentFieldLookups is in daoimpl ::::::::: "+currentFieldLookups.toString());
	            Integer i = 0;
	            while (i < fieldIds.size()) {
	                Integer tempid = (Integer)fieldIds.get(i);
	                Integer j = 0;
	                while (j < currentFieldLookups.size()) {
	                    log.info((Object)("lookup id in array " + ((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id() + " lookup id from jsp " + tempid));
	                    if (((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
	                    	log.info("Temp type in code -->>> "+currentFieldLookups.get(j).getLookup_subtype()+ "  "+currentFieldLookups.get(j).getLookup_subtype());
	                        currentFieldLookupsOrdered.add((BeanFieldLookup)currentFieldLookups.get(j));
	                    }
	                    j = j + 1;
	                }
	                i = i + 1;
	            }
	            log.info("currentFieldLookupsOrdered   is :::::::::::::::::::: "+currentFieldLookupsOrdered.toString());
	            currentFieldLookups = currentFieldLookupsOrdered;
	        }
    	 
    }else if(excelFieldList!=null && this.fieldIds==null) {
    	fieldIds = new ArrayList<Integer>(excelFieldList);
   	 	
        log.info((Object)("SelectedFields are " + fieldIds.toString() + " Amount is " + baseAmount));
        if (!fieldIds.isEmpty()) {
        	log.info("SelectedFields are in IF block when fieldid is not empty:::::::::: " + fieldIds.toString());
            currentFieldLookups = this.daoFieldLookupService.getFieldLookups(fieldIds);
            log.info("currentFieldLookups is in daoimpl ::::::::: "+currentFieldLookups.toString());
            Integer i = 0;
            while (i < fieldIds.size()) {
                Integer tempid = (Integer)fieldIds.get(i);
                Integer j = 0;
                while (j < currentFieldLookups.size()) {
                    log.info((Object)("lookup id in array " + ((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id() + " lookup id from jsp " + tempid));
                    if (((BeanFieldLookup)currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
                    	log.info("Temp type in code -->>> "+currentFieldLookups.get(j).getLookup_subtype()+ "  "+currentFieldLookups.get(j).getLookup_subtype());
                        currentFieldLookupsOrdered.add((BeanFieldLookup)currentFieldLookups.get(j));
                    }
                    j = j + 1;
                }
                i = i + 1;
            }
            log.info("currentFieldLookupsOrdered   is :::::::::::::::::::: "+currentFieldLookupsOrdered.toString());
            currentFieldLookups = currentFieldLookupsOrdered;
        }
    }
	        log.info("fieldIds1 for new selection 23Feb is ::::: "+fieldIds.toString());
	        log.info("save flag is  is "+saveFlag);
	        if (saveFlag != null && saveFlag.trim().contentEquals("Y")) {
	            currentFieldLookups = (ArrayList)ses.getAttribute("sesRenderList");
	        }
	        log.info("objecct is "+(Object)currentFieldLookups);
	        HashMap optMap = (HashMap)ses.getAttribute("sesOptionsMap");
	        if (!currentFieldLookups.isEmpty()) {
	            ArrayList optionKeys = new ArrayList(optMap.keySet());
	            Iterator it = currentFieldLookups.iterator();
	            boolean k = false;
	            while (it.hasNext()) {
	                int i;
	                Integer key;
	                BeanFieldLookup temp = (BeanFieldLookup)it.next();
	                String temptype = temp.getLookup_type();
	                Integer tempid = temp.getLookup_id();
	                String subType = temp.getLookup_subtype();
	                log.info("temp type iterator ---->>> "+temptype+ " "+subType);
	                //for testing
	                if(temptype.contains("readonly")) {
	                	log.info("it contains read only "+optionKeys.size());
	                	if (optionKeys.isEmpty()) {
	                         request.setAttribute("text", (Object)temp.getLookup_name());
	                         request.setAttribute("readonly", "readonly");
	                         return "readonly";
	                     }
	                }
	                
	                
	                if (temptype.contentEquals("Select Box")) {
	                    if (optionKeys.isEmpty()) {
	                        request.setAttribute("optionName", (Object)temp.getLookup_name());
	                        request.setAttribute("optionId", (Object)temp.getLookup_id());
	                        return "optionPage";
	                    }
	                    boolean optionpage = true;
	                    i = 0;
	                    while (i < optionKeys.size()) {
	                        key = (Integer)optionKeys.get(i);
	                        if (key.equals(tempid)) {
	                            optionpage = false;
	                        }
	                        ++i;
	                    }
	                    if (!optionpage) continue;
	                    request.setAttribute("optionName", (Object)temp.getLookup_name());
	                    request.setAttribute("optionId", (Object)temp.getLookup_id());
	                    return "optionPage";
	                }
	                if (temptype.contentEquals("Multiplier")) {
	                    if (optionKeys.isEmpty()) {
	                        request.setAttribute("multiplierName", (Object)temp.getLookup_name());
	                        request.setAttribute("multiplierId", (Object)temp.getLookup_id());
	                        return "multiplierPage";
	                    }
	                    boolean multiplierpage = true;
	                    i = 0;
	                    while (i < optionKeys.size()) {
	                        key = (Integer)optionKeys.get(i);
	                        if (key.equals(tempid)) {
	                            multiplierpage = false;
	                        }
	                        ++i;
	                    }
	                    if (!multiplierpage) continue;
	                    request.setAttribute("multiplierName", (Object)temp.getLookup_name());
	                    request.setAttribute("multiplierId", (Object)temp.getLookup_id());
	                    return "multiplierPage";
	                }
	                if (temptype.contentEquals("Radio Button Group")) {
	                    if (optionKeys.isEmpty()) {
	                        request.setAttribute("optionName", (Object)temp.getLookup_name());
	                        request.setAttribute("optionId", (Object)temp.getLookup_id());
	                        return "radioGroupPage";
	                    }
	                    boolean radiopage = true;
	                    i = 0;
	                    while (i < optionKeys.size()) {
	                        key = (Integer)optionKeys.get(i);
	                        if (key.equals(tempid)) {
	                            radiopage = false;
	                        }
	                        ++i;
	                    }
	                    if (!radiopage) continue;
	                    request.setAttribute("optionName", (Object)temp.getLookup_name());
	                    request.setAttribute("optionId", (Object)temp.getLookup_id());
	                    return "radioGroupPage";
	                }
	                if (!temptype.contentEquals("PageBreak")) continue;
	                log.info((Object)"inside PageBreak Map building");
	                log.info((Object)("temp id is..::" + tempid));
	                log.info((Object)("pageTitleValue is..::" + tempField[l]));
	                pageTitlesMap.put(tempid, tempField[l]);
	                ses.setAttribute("sesPageTitlesMap", pageTitlesMap);
	                l = l + 1;
	            }
	        }
	        if (!currentFieldLookups.isEmpty()) {
	            int i = 0;
	            while (i < currentFieldLookups.size()) {
	                Integer tempid = ((BeanFieldLookup)currentFieldLookups.get(i)).getLookup_id();
	                ((BeanFieldLookup)currentFieldLookups.get(i)).setIsMandatory(Integer.valueOf(0));
	                int j = 0;
	                while (j < mandatoryFields.size()) {
	                    Integer mandId = Integer.parseInt(((String)mandatoryFields.get(j)).trim());
	                    if (mandId.equals(tempid)) {
	                        ((BeanFieldLookup)currentFieldLookups.get(i)).setIsMandatory(Integer.valueOf(1));
	                    }
	                    ++j;
	                }
	                ++i;
	            }
	        }
	        renderLookups = currentFieldLookups;
	        ses.setAttribute("sesRenderList", renderLookups);
	        ses.setAttribute("renderLookups", this.renderLookups);
	        ses.setAttribute("validateFieldNameList", validateFieldNameList);
	        ses.setAttribute("setFieldIdsNo", fieldIds);
	        renderMap = (HashMap)ses.getAttribute("sesRenderMap");
	        valuesMap = (HashMap)ses.getAttribute("sesValuesMap");
	        ArrayList renderKeySet = new ArrayList(renderMap.keySet());
	        renderKeySet.isEmpty();
	        optionsMap = (Map)ses.getAttribute("sesOptionsMap");
	        ses.setAttribute("optionsMap", optionsMap);
	        ses.setAttribute("sesPageTitlesMap", pageTitlesMap);
	        return "renderPage";
	}
  */
 