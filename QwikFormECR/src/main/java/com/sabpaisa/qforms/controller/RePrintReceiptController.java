package com.sabpaisa.qforms.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;

@CrossOrigin
@Controller
@RequestMapping
public class RePrintReceiptController {

	@Autowired
	CollegeService collegeService;

	@Autowired
	SampleTransService sampleTransService;

	@Autowired
	SampleFormService sampleFormService;

	static Logger log = LogManager.getLogger(SampleFormAction.class.getName());
	private SampleTransBean beanTransData;
	private CollegeBean collegeBean = new CollegeBean();
	private SampleFormBean form = new SampleFormBean();
	ArrayList<SampleFormView> formViewData = new ArrayList();

	@RequestMapping(value = "/getReprintReciept", method = { RequestMethod.POST, RequestMethod.GET })
	public String reprintReciept(HttpSession ses, HttpServletRequest request, Model model) {

		/*
		 * if(null!=ses.getAttribute("form") || null!=ses.getAttribute("formViewData")
		 * || null!=ses.getAttribute("sesCurrentFormMap") ||
		 * null!=ses.getAttribute("transStatus")) {
		 * 
		 * ses.removeAttribute("form"); ses.removeAttribute("formViewData");
		 * ses.removeAttribute("sesCurrentFormMap"); ses.removeAttribute("transStatus");
		 * 
		 * }
		 */

		// request.setAttribute("msg", "Transaction Id not Found");
		return "reprint-reciept";
	}

	@RequestMapping(value = "/getTxnReceipt", method = { RequestMethod.POST, RequestMethod.GET })
	public String reGenerateReciept(HttpSession ses, HttpServletRequest request, Model model) throws Exception {
		beanTransData=new SampleTransBean();
		form=new SampleFormBean();
		formViewData=new ArrayList<SampleFormView>();
		
		String txnId = request.getParameter("txnId");
		String result = null;
		log.info("TxnId =" + txnId);
		/*
		 * form=new SampleFormBean(); formViewData=new ArrayList<SampleFormView>();
		 */
		try {
			beanTransData = sampleTransService.getTransactionsBySabPaisaTxnId(txnId);
			if (beanTransData == null) {
				request.setAttribute("msg", txnId + " Transaction Id not Found");
				result = "reprint-reciept";
			} else {
				collegeBean = collegeService.viewInstDetail(Integer.valueOf(beanTransData.getCid()));

				log.info("collegeId ::::::: " + collegeBean.getCollegeCode());

				form = sampleFormService.getFormData(beanTransData.getTransForm().getFormId());

				log.debug("form id is " + form.getFormNumber());
				ses.setAttribute("formnumber", form.getFormNumber());
				ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
				ses.setAttribute("CollegeId", collegeBean.getCollegeId());
				ses.setAttribute("CollegeBean", collegeBean);

				Map<Integer, String> formDataMap = new HashMap();
				formDataMap = processFormData(form.getFormData(), ses);
				log.debug("formDataMap value is :::::::::: " + formDataMap.toString());

				formViewData = processFormView(formDataMap, form);
				ses.setAttribute("form", form);
				ses.setAttribute("formViewData", formViewData);
				ses.setAttribute("sesCurrentFormMap", formDataMap);
				ses.setAttribute("transStatus", beanTransData.getTransStatus());

				result = "formSummaryForRePrint";
			}
		} catch (IndexOutOfBoundsException e) {
			request.setAttribute("msg", txnId + " Transaction Id not Found");
			result = "reprint-reciept";
		}

		return result;
	}

	public HashMap<Integer, String> processFormData(String formDataRaw, HttpSession ses) {
		log.debug("Start of processFormData(), formDataRaw >> " + formDataRaw);
		//CollegeBean cBean = (CollegeBean) ses.getAttribute("CollegeBean");
		HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
		String[] formFields = formDataRaw.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		//log.debug((Object) ("formFieldsList is " + formFieldsList.toString()));
		int i = 0;
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split("~");
			if (formFieldData.length != 2) {
				log.info((Object) ("Form Field at index " + i + " is corrupt or unreadable"));
			} else {
				
				formDataMap.put(Integer.parseInt(formFieldData[0].trim()), formFieldData[1]);
			}
			++i;
		}
		//log.debug("formDataMap is :::::::::: " + formDataMap.toString());
		log.info("End of processFormData().");
		return formDataMap;
	}

	private ArrayList<SampleFormView> processFormView(Map<Integer, String> formDataMap, SampleFormBean form)
			throws Exception {
		log.info("Start of processFormView().");
		ArrayList<SampleFormView> formViewList = new ArrayList();
		log.info("Form id for file upload is :: " + form.getFormId());
		Integer fId = form.getFormId();
		ArrayList<Integer> keySet = new ArrayList(formDataMap.keySet());
		for (int i = 0; i < keySet.size(); i++) {
			String[] formFieldValue = ((String) formDataMap.get(keySet.get(i))).split("=");
			String fieldKey = keySet.get(i).toString();
			if (formFieldValue.length == 2) {

				SampleFormView formViewData = new SampleFormView();
				String[] valueAndOrder = formFieldValue[1].split("\\$");

				String reGenerateValue = valueAndOrder[0].toString();

				if ((reGenerateValue.equalsIgnoreCase("File Upload") || reGenerateValue == "File Upload")
						&& null != fId) {
					reGenerateValue = sampleFormService.getFileUploadLink(fieldKey, fId);
					// log.info("reGenerateValue for file upload is ::::: "+reGenerateValue);
					if (null == reGenerateValue) {
						reGenerateValue = sampleFormService.getFileUploadLink1(fieldKey, fId);
						//log.info("reGenerateValue for file upload is ::::: " + reGenerateValue);
					}
				}

				formViewData.setLabel(formFieldValue[0]);
				formViewData.setValue(reGenerateValue);
				try {
					formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim())));
				} catch (ArrayIndexOutOfBoundsException e) {
					formViewData.setOrder(Integer.valueOf(i));
				}

				formViewList.add(formViewData);
			}
		}
		Collections.sort(formViewList);
		//log.debug("formViewList is :::: " + formViewList.toString());
		log.info("End of processFormView().");
		return formViewList;
	}

	public SampleTransBean getBeanTransData() {
		return beanTransData;
	}

	public void setBeanTransData(SampleTransBean beanTransData) {
		this.beanTransData = beanTransData;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	public SampleFormBean getForm() {
		return form;
	}

	public void setForm(SampleFormBean form) {
		this.form = form;
	}

	public ArrayList<SampleFormView> getFormViewData() {
		return formViewData;
	}

	public void setFormViewData(ArrayList<SampleFormView> formViewData) {
		this.formViewData = formViewData;
	}
}
