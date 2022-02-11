package com.sabpaisa.qforms.controller;

public class tempclasses {

	/*
	 * @RequestMapping(value = "/processTransRevival", method = {
	 * RequestMethod.POST, RequestMethod.GET }) public String
	 * processTransRevival(Model model, HttpServletRequest request,
	 * HttpServletResponse response, HttpSession ses) { log.
	 * info("prepare Transaction Submitting Transactions in SampleTransActionController............"
	 * );
	 * 
	 * SampleFormBean beanCurrentForm = new SampleFormBean(); HashMap<Integer,
	 * String> fieldMap = new HashMap<Integer, String>(); Double formBeanAmount;
	 * beanCurrentForm = (SampleFormBean) ses.getAttribute("beanFormData"); if (null
	 * != beanCurrentForm) { log.info("data is in sampleformbean is : " +
	 * beanCurrentForm.getFormData().toString()); } try { log.
	 * info("processTransRevival Transaction Submitting Transactions in SampleTransActionController."
	 * );
	 * 
	 * Date transDate = new Date(); Integer cid =
	 * Integer.parseInt(request.getParameter("cid").toString());
	 * log.info("college id in process trans is :::::::::::: " + cid.toString());
	 * String formid = request.getParameter("formid").toString();
	 * log.info("formid id in process trans is :::::::::::: " + formid.toString());
	 * String bid =
	 * collegeService.viewCollegeDetail(cid.intValue()).getBankDetailsOTM().
	 * getBankId().toString(); log.info("Bank id in process trans is :::::::::::: "
	 * + bid);
	 * 
	 * CollegeBean college = collegeService.viewInstDetail((Integer) cid);
	 * log.info((Object) ("college :----------:" + (Object) college) + " cid " +
	 * cid);
	 * 
	 * BeanFormDetails beanDataForm =
	 * sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(formid)));
	 * String fieldForValidate = null; fieldForValidate =
	 * beanDataForm.getValidateFieldOfExcel().toString(); String lifeCycle =
	 * beanDataForm.getLife_cycle();
	 * 
	 * log.info("formTemplateId for DataFormDetails table :::: " + fieldForValidate
	 * + " :::: lifecycle is :::: " + lifeCycle);
	 * 
	 * String dynFieldData = request.getParameter("values");
	 * log.info("dynFieldData values from requested summary page : " +
	 * dynFieldData); String dynFieldData1 = request.getParameter("values1");
	 * log.info("dynFieldData1  values1 from requested summary page : " +
	 * dynFieldData1);
	 * 
	 * ArrayList<String> columnNameList = (ArrayList<String>)
	 * ses.getAttribute("columnNameList"); if (null != columnNameList) {
	 * log.info("columnNameList " + columnNameList); }
	 * 
	 * ArrayList<String> lookUpIdAndcolumnNameList = (ArrayList<String>)
	 * ses.getAttribute("columnNameList1"); if (null != lookUpIdAndcolumnNameList) {
	 * log.info("lookUpIdAndcolumnNameList " +
	 * lookUpIdAndcolumnNameList.toString()); }
	 * 
	 * Integer sesBid = (Integer) ses.getAttribute("BankId"); log.info("bid " +
	 * sesBid); Integer sesCid = (Integer) ses.getAttribute("CollegeId");
	 * log.info("cid " + sesCid); if (null == ses.getAttribute("BankId") && null ==
	 * ses.getAttribute("CollegeId")) { sesBid = Integer.parseInt(bid); sesCid =
	 * cid; } log.info("bid " + sesBid + "cid " + sesCid);
	 * 
	 * ArrayList<String> fieldNames = new ArrayList<String>(); if (null !=
	 * dynFieldData) { String[] formFields = dynFieldData.split(",");
	 * ArrayList<String> formFieldsList = new
	 * ArrayList<String>(Arrays.asList(formFields));
	 * 
	 * int i = 0; while (i < formFieldsList.size()) { String[] formFieldData =
	 * formFieldsList.get(i).split("~");
	 * 
	 * if (formFieldData.length != 2) { log.info(("Form Field at index " + i +
	 * " is corrupt or unreadable")); } else {
	 * fieldMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]); }
	 * ++i; } for (Map.Entry<Integer, String> temp : fieldMap.entrySet()) { String[]
	 * b = temp.getValue().split("$"); int k = b[0].indexOf('$'); String proofresult
	 * = b[0].substring(0, k); int j = proofresult.indexOf("="); String col =
	 * proofresult.substring(0, j); col = col.replaceAll("\\-", "hphn"); String val
	 * = proofresult.substring(j + 1, proofresult.length()); fieldNames.add(col +
	 * "=" + val); } nameOfFields = fieldNames;
	 * log.info("Out of For Loop formFieldsList Field Value is" + nameOfFields); }
	 * 
	 * Double amountFormTransBean = null; String payerId; String transId; transId =
	 * this.GenerateTransactionId(); log.info((Object) ("transId:" + transId));
	 * 
	 * Integer idForm = Integer.parseInt(formid);
	 * log.info("formid of DataForm file in table :::::: " + idForm);
	 * ses.setAttribute("formId", idForm.toString());
	 * 
	 * String formIdb = (String) ses.getAttribute("formInstanceId");
	 * log.info("formidBDB of DataForm file in table :::::: " + formIdb); Integer
	 * formId1 = null;
	 * 
	 * if (null != formIdb) { formId1 = Integer.parseInt(formIdb); }
	 * 
	 * String[] formFields1 = dynFieldData1.split(","); //
	 * log.info(("formFields is ::::::::::::::: " + formFields1.toString()));
	 * ArrayList<String> formFieldsList1 = new
	 * ArrayList<String>(Arrays.asList(formFields1)); //
	 * log.info(("formFieldsList1 is ::::::::::::::: " + //
	 * formFieldsList1.toString()));
	 * 
	 * ArrayList<String> listDataForm = new ArrayList<String>(); String key = "";
	 * for (int j = 0; j < formFieldsList1.size(); j++) { String n =
	 * columnNameList.get(j); String m = lookUpIdAndcolumnNameList.get(j); //
	 * log.info("columnNameList " + n + " >> columnNameList " + m); int x =
	 * m.indexOf("~"); String o = m.substring(x + 1); // log.info("columnNameList "
	 * + n + " >> columnNameList " + m + " >>> Compared // column name is >>>> " +
	 * o);
	 * 
	 * String val = formFieldsList1.get(j).toString(); if (n.equals(o) &&
	 * !n.equals("Notification") && !n.equals("Page_Title")) { key = m + "=" + val +
	 * "$" + j; listDataForm.add(key); } } // log.info("listDataForm is :: >> " +
	 * listDataForm.toString()); String listData = String.join(",", listDataForm);
	 * // log.info("listData as String result is :: " + listData.toString()); int
	 * res = 0;
	 * 
	 * res = sampleFormService.updateFormData(listData, transId, formId1, cid);
	 * 
	 * Double transactionAmount = amountFormTransBean; SampleTransBean
	 * beanCurrentTrans = new SampleTransBean();
	 * beanCurrentTrans.setTransDate(transDate);
	 * beanCurrentTrans.setTransStatus(ApplicationStatus.pending.toString());
	 * beanCurrentTrans.setCollegeBean(college);
	 * beanCurrentTrans.setContact(beanCurrentForm.getContact());
	 * beanCurrentTrans.setName(beanCurrentForm.getName());
	 * beanCurrentTrans.setEmail(beanCurrentForm.getEmail());
	 * beanCurrentTrans.setDob(beanCurrentForm.getDobDate());
	 * beanCurrentTrans.setCid(cid.toString()); beanCurrentTrans.setBid(bid);
	 * beanCurrentTrans.setFormId(beanCurrentForm.getFormTemplateId());
	 * beanCurrentForm.setFormClientId(cid.toString()); log.info((Object)
	 * ("cid:----------:" + beanCurrentForm.getFormClientId())); payerId = (String)
	 * ses.getAttribute("PayerID"); log.info((Object) ("payerId:----:" + payerId));
	 * if (payerId == null) {
	 * beanCurrentTrans.setPayerID("NIT J students (Semester fee)"); } else {
	 * beanCurrentTrans.setPayerID(ses.getAttribute("PayerID").toString());
	 * ses.removeAttribute("PayerID"); } log.info((Object)
	 * (String.valueOf(beanCurrentTrans.getPayerID()) + ":--------:PayerId"));
	 * 
	 * beanCurrentTrans.setTransId(transId);
	 * 
	 * formBeanAmount = beanCurrentForm.getTransAmount(); log.info((Object)
	 * ("amt in transaction class:" + formBeanAmount)); if (amountFormTransBean ==
	 * null) { beanCurrentTrans.setTransAmount(formBeanAmount);
	 * beanCurrentTrans.setTransOgAmount(formBeanAmount);
	 * beanCurrentTrans.setActAmount(formBeanAmount); } else {
	 * beanCurrentTrans.setTransAmount(amountFormTransBean);
	 * beanCurrentTrans.setTransOgAmount(amountFormTransBean);
	 * beanCurrentTrans.setActAmount(amountFormTransBean); }
	 * 
	 * beanCurrentForm.setFormTransId(transId);
	 * 
	 * beanCurrentTrans.setTransForm(beanCurrentForm); feeLookup = null; feeLookup =
	 * daoFeeService.getFeeDetails("feeid", (Object)
	 * beanCurrentTrans.getTransForm().getFormFeeId()) .getFeeLookup(); if
	 * (feeLookup == null) { beanCurrentTrans.setFeeName("NITJ Payment form"); }
	 * else { beanCurrentTrans.setFeeName(feeLookup.getFeeName()); log.info((Object)
	 * ("fee Name is " + feeLookup.getFeeName())); }
	 * beanCurrentTrans.setTransPaymode(beanCurrentTrans.getTransPaymode());
	 * 
	 * beanCurrentTrans = sampleTransService.saveTransaction(beanCurrentTrans);
	 * ses.setAttribute("sesCurrentTransData", (Object) beanCurrentTrans);
	 * beanTransData = new SampleTransBean(); beanTransData = beanCurrentTrans;
	 * ses.setAttribute("beanTransData", beanTransData);
	 * 
	 * transAmounts = null; log.info("this.transamounts ::: " + transAmounts);
	 * log.info("res for amount is ::: " + res);
	 * 
	 * if (transAmounts == null && res == 2) { transAmounts = formBeanAmount;
	 * 
	 * new Thread(() -> { log.info("Adding to reporting Database in async thread.. "
	 * + transId + " " + transAmounts);
	 * 
	 * sampleTransService.updateApplicantTransDataToReportingDB(ses, nameOfFields,
	 * transId, transAmounts, beanDataForm);
	 * 
	 * }).start(); }
	 * 
	 * ses.setAttribute("transId", transId); ses.setAttribute("transAmounts",
	 * transAmounts.toString()); ses.setAttribute("cid", cid.toString());
	 * ses.setAttribute("bid", bid); ses.setAttribute("feeName",
	 * feeLookup.getFeeName());
	 * 
	 * return "ForwardTransaction"; } catch (NullPointerException ex) {
	 * ex.printStackTrace(); return "sessionFailurePage"; } }
	 */
}
