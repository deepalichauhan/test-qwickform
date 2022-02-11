package com.sabpaisa.qforms.controller;

import java.util.ArrayList;
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
public class ProvisionalAdmitCardController {

	@Autowired
	CollegeService collegeService;
	@Autowired
	SampleTransService sampleTransService;
	@Autowired
	SampleFormService sampleFormService;
	
	private static Logger log = LogManager.getLogger(ProvisionalAdmitCardController.class.getName());
	
	private SampleTransBean beanTransData;
	private CollegeBean collegeBean = new CollegeBean();
	
	private SampleFormBean form = new SampleFormBean();
	
	ArrayList<SampleFormView> formViewData = new ArrayList<SampleFormView>();
	
	@RequestMapping(value="/getAdmitCard",method = RequestMethod.GET)
	public String getAdmitCard(Model model, HttpServletRequest request, HttpSession ses) {
		
		String txnId = request.getParameter("txnId");
		log.info("TxnId =" + txnId);
	    try
	    {
	      beanTransData = sampleTransService.getTransactionsBySabPaisaTxnId(txnId);
	      if (beanTransData == null) {
	        request.setAttribute("msg", txnId + " Transaction Id not Found");
	        return "FetchAdmitCard";
	      }
	      collegeBean = collegeService.viewInstDetail(Integer.valueOf(beanTransData.getCid()));
	      ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
	      ses.setAttribute("CollegeId", collegeBean.getCollegeId());
	      ses.setAttribute("CollegeBean", collegeBean);
	      form = sampleFormService.getFormData(beanTransData.getTransForm().getFormId());
	      
	      SampleFormAction action = new SampleFormAction();
	      Map<Integer, String> formDataMap = new HashMap();
	      formDataMap = action.processFormData(form.getFormData(),ses);
	      formViewData = processFormView(formDataMap);
	    } catch (IndexOutOfBoundsException e) {
	      request.setAttribute("msg", txnId + " Transaction Id not Found");
	      return "FetchAdmitCard";
	    }
	    
	    HashMap<Integer, String> formDataMap;
	    return "ProvisionalAdmitCard";
	}
	
	private ArrayList<SampleFormView> processFormView(Map<Integer, String> formDataMap) {
		ArrayList<SampleFormView> formViewList = new ArrayList();

	    ArrayList<Integer> keySet = new ArrayList(formDataMap.keySet());
	    for (int i = 0; i < keySet.size(); i++) {
	      String[] formFieldValue = ((String)formDataMap.get(keySet.get(i))).split("=");
	      if (formFieldValue.length == 2)
	      {

	        SampleFormView formViewData = new SampleFormView();
	        String[] valueAndOrder = formFieldValue[1].split("\\$");
	        
	        formViewData.setLabel(formFieldValue[0]);
	        formViewData.setValue(valueAndOrder[0]);
	        try
	        {
	          formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim())));
	        }
	        catch (ArrayIndexOutOfBoundsException e) {
	          formViewData.setOrder(Integer.valueOf(i));
	        }
	        
	        formViewList.add(formViewData);
	      }
	    }
	    Collections.sort(formViewList);
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
