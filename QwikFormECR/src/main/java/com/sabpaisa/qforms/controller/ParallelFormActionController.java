package com.sabpaisa.qforms.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.util.LateFeeCalculator;

@CrossOrigin
@Controller
@RequestMapping
public class ParallelFormActionController {
	
	@Autowired
	private CollegeService collegeService;
	@Autowired
	private DaoFieldLookupService daoFieldLookupService;
	@Autowired
	private SampleFormService sampleFormService;
	
    private static Logger log = LogManager.getLogger(ParallelFormActionController.class.getName());
    private LateFeeCalculator lateFeeCalculator = new LateFeeCalculator();
    private CollegeBean collegeBean = new CollegeBean();
    private BeanFormDetails form = new BeanFormDetails();   
    private BeanPayerType beanPayerType = new BeanPayerType();
    private SampleFormBean sampleFormBean = new SampleFormBean();
    
    private Map<Integer, String> payerFormDataMap = new HashMap();
    private Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
    private Map<Integer, List<String>> optionsMap2 = new HashMap<Integer, List<String>>();

    @RequestMapping(value= {"/getFormPayerInstant"}, method=RequestMethod.POST)
    public String getFormReadyPay(HttpServletRequest request, HttpSession ses, Model model) {
        boolean staleCheckResult = true;
        if (staleCheckResult) {
            block22 : {
                BeanFormDetails formdetails;
                boolean landingpage;
                Integer lpFlag;
                Integer sesCid;
                String formInstanceId;
                block21 : {
                    sesCid = 0;
                    collegeBean = null;
                    String formId = "";
                    String formNumber = "";
                    formInstanceId = request.getParameter("formInstanceId");
                    lpFlag = null;
                    try {
                        lpFlag = 1;
                    }
                    catch (Exception e) {
                        lpFlag = 1;
                    }
                    try {
                        formId = request.getParameter("formId");
                        if (formId == null) {
                            formId = form.getId().toString();
                        }
                    }
                    catch (Exception e) {
                        // empty catch block
                    }
                    log.debug(("form id from request is::" + formId));
                    landingpage = false;
                    formdetails = new BeanFormDetails();
                    formdetails = daoFieldLookupService.getFormDetails(Integer.parseInt(formId));
                    if (formdetails.getId() != null) break block21;
                    log.info("FORM NOT FOUND");
                    return "error";
                }
                try {
                    try {
                        Integer sesBid = Integer.valueOf(request.getParameter("BankId"));
                        log.debug(("SesBid Is" + sesBid));
                        sesCid = Integer.valueOf(request.getParameter("CollegeId"));
                        log.debug(("ses Cid Is" + sesCid));
                        collegeBean = collegeService.viewInstDetail((Integer)sesCid);
                        log.debug(("form template id is:" + formdetails.getId()));
                        collegeBean = daoFieldLookupService.getClientDetailsBasedOnClientCode(formdetails.getFormOwnerName());
                        beanPayerType = daoFieldLookupService.getPayerLookupsBasedOnPayerId(formdetails.getPayer_type());
                        log.debug(("form instance id from session is::" + formInstanceId));
                        if (!StringUtils.isBlank((String)formInstanceId) && !"null".equals(formInstanceId)) {
                            log.info("came inside the if block");
                            /*SampleFormDao formDAO = new SampleFormDao();*/
                            SampleFormAction formAction = new SampleFormAction();
                            sampleFormBean = sampleFormService.getFormData(Integer.valueOf(Integer.parseInt(formInstanceId)));
                            SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
                            String formatted_date = formatter1.format(sampleFormBean.getDobDate());
                            log.debug(("formatted_date from DB is::" + formatted_date));
                            sampleFormBean.setDob(formatted_date);
                            payerFormDataMap = formAction.processFormData(sampleFormBean.getFormData(),ses);
                            Set<Integer> setOfKeys = payerFormDataMap.keySet();
                            for (Integer key : setOfKeys) {
                                String value = payerFormDataMap.get(key);
                                log.debug(("Key: " + key + ", Value: " + value));
                                String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
                                log.debug(("Revised Value is: " + revisedValue));
                                payerFormDataMap.put(key, revisedValue);
                            }
                        }
                        log.debug(("testing Val:" + collegeBean.getCollegeId() + " : " + collegeBean.getBankDetailsOTM().getBankId() + " : " + collegeBean + " : " + beanPayerType.getPayer_type()));
                        ses.setAttribute("CollegeId", collegeBean.getCollegeId());
                        ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
                        ses.setAttribute("CollegeBean", collegeBean);
                        ses.setAttribute("PayeeProfile", beanPayerType.getPayer_type());
                    }
                    catch (NullPointerException ex) {
                        ex.printStackTrace();
                    }
                    log.debug(("Landing Page is " + formdetails.getLandingpage_srcPath()));
                    if (formdetails.getLandingpage_srcPath() != null) {
                        log.info("has landing page");
                        landingpage = true;
                        ses.setAttribute("landingURL", formdetails.getLandingpage_srcPath());
                    }
                    BeanFeeDetails fee = formdetails.getFormFee();
                    Double baseamt = fee.getFeeBaseAmount();
                    
                    fee = lateFeeCalculator.calculateLateFeeAsBeanFeeDetails(formdetails);
                    
                    SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
                    FormBuilderController actionsFormBuilder = new FormBuilderController();
                    actionsFormBuilder.SetOptionsMap(formdetails, ses);
                    SetOptionsMapforPayer(formdetails);
                    formdetails = actionsFormBuilder.orderStructure(formdetails);
                    formdetails.setFormFee(fee);
                    form = formdetails;
                    ses.setAttribute("currentFee", fee);
                    ses.setAttribute("feeAmt", form.getFormFee().getFeeBaseAmount());
                    ses.setAttribute("currentLateFee", form.getFormFee().getLatefeeset());
                    ses.setAttribute("currentFormId", form.getId());
                    log.debug(("Form list :" + form.getStructureList().size()));
                    char[] symbolsString1 = new char[]{};
                    StringBuilder tmp = new StringBuilder();
                    char ch = 'a';
                    while (ch <= 'g') {
                        tmp.append(ch);
                        char ch1 = 'a';
                        while (ch1 <= 'd') {
                            tmp.append(ch1);
                            symbolsString1 = tmp.toString().toCharArray();
                            ch1 = (char)(ch1 + '\u0001');
                        }
                        ch = (char)(ch + '\u0001');
                    }
                    double captNumber = 5.0 + Math.random() * 5.0;
                    String genCapt = String.valueOf(captNumber).substring(2, 4);
                    String ranGenString = symbolsString1.toString().substring(3, 7);
                    String genAlphaNum = String.valueOf(ranGenString) + genCapt;
                    log.debug(("genAlphaNu is::" + genAlphaNum));
                    ses.setAttribute("genAlphaNum", genAlphaNum);
                    if (!landingpage || lpFlag != 1) break block22;
                    return "LandingPage";
                }
                catch (NumberFormatException e) {
                    e.printStackTrace();
                    log.info("Form ID not parseable");
                    return "error";
                }
            }
            ses.setAttribute("lpFlag", 1);
            return "success";
        }
        log.info("staleCheckResult fails...terminated user session");
        request.setAttribute("staleCheckResult", "fail");
        return "sessionterminated";
    }

    public void SetOptionsMapforPayer(BeanFormDetails form) {
        HashMap<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
        BeanFieldLookup field = new BeanFieldLookup();
        if (form.getId() == null) {
            return;
        }
        ArrayList<BeanFormStructure> structures = new ArrayList<BeanFormStructure>(form.getFormStructure());
        int i = 0;
        while (i < structures.size()) {
            field = structures.get(i).getFormField();
            if (field.getLookup_type().contentEquals("Select Box") || field.getLookup_type().contentEquals("Multiplier") || field.getLookup_type().contentEquals("Radio Button Group")) {
                ArrayList<String> options = new ArrayList<String>();
                String optionsStr = structures.get(i).getFieldValues();
                String[] optionsArr = optionsStr.split(",");
                int j = 0;
                while (j < optionsArr.length) {
                    options.add(optionsArr[j].split("=")[0]);
                    ++j;
                }
                optionMap.put(structures.get(i).getId(), options);
            }
            ++i;
        }
        optionsMap2 = optionMap;
    }

    public CollegeBean getCollegeBean() {
        return this.collegeBean;
    }

    public void setCollegeBean(CollegeBean collegeBean) {
        this.collegeBean = collegeBean;
    }

    public BeanFormDetails getForm() {
        return this.form;
    }

    public void setForm(BeanFormDetails form) {
        this.form = form;
    }

    public BeanPayerType getBeanPayerType() {
        return this.beanPayerType;
    }

    public void setBeanPayerType(BeanPayerType beanPayerType) {
        this.beanPayerType = beanPayerType;
    }

    public SampleFormBean getSampleFormBean() {
        return this.sampleFormBean;
    }

    public void setSampleFormBean(SampleFormBean sampleFormBean) {
        this.sampleFormBean = sampleFormBean;
    }

    public Map<Integer, String> getPayerFormDataMap() {
        return this.payerFormDataMap;
    }

    public void setPayerFormDataMap(Map<Integer, String> payerFormDataMap) {
        this.payerFormDataMap = payerFormDataMap;
    }

    public Map<Integer, List<String>> getOptionsMap() {
        return this.optionsMap;
    }

    public void setOptionsMap(Map<Integer, List<String>> optionsMap) {
        this.optionsMap = optionsMap;
    }

    public Map<Integer, List<String>> getOptionsMap2() {
        return this.optionsMap2;
    }

    public void setOptionsMap2(Map<Integer, List<String>> optionsMap2) {
        this.optionsMap2 = optionsMap2;
    }
}
