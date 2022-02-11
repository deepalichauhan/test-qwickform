package com.sabpaisa.qforms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormFileBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.beans.SubInstitute;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFeeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LifeCycleService;
import com.sabpaisa.qforms.services.OffLineFormService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.util.LateFeeCalculator;

@CrossOrigin
@Controller
@RequestMapping
public class FormBuilderController implements Serializable {

	private static final long serialVersionUID = 1L;

	@Autowired
	private CollegeService collegeService;
	
	@Autowired
	private DaoFeeService daoFeeService;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;
	
	@Autowired
	private SampleFormService sampleFormService;
	
	@Autowired
	private LifeCycleService lifeCycleService;
	
	@Autowired
	private OffLineFormService offLineFormService;

	private LateFeeCalculator lateFeeCalculator = new LateFeeCalculator();
	
	private static Logger log = LogManager.getLogger(FormBuilderController.class.getName());
	private InputStream fileInputStream;
	private String fileName;
	private ArrayList<BeanFieldLookup> fields = new ArrayList<BeanFieldLookup>();
	private ArrayList<BeanFeeLookup> fees = new ArrayList<BeanFeeLookup>();
	private ArrayList<String> selectedFields = new ArrayList<String>();
	private ArrayList<String> selectedFees = new ArrayList<String>();
	private BeanPayerType beanPayerType = new BeanPayerType();
	private CollegeBean collegeBean = new CollegeBean();
	private ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa = new ClientMappingCodeOfSabPaisa();
	private SampleFormBean sampleFormBean = new SampleFormBean();
	private ArrayList<BeanPayerType> payers = new ArrayList<BeanPayerType>();
	private ArrayList<BeanFieldLookup> renderLookups = new ArrayList<BeanFieldLookup>();
	private Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
	private Map<Integer, List<String>> optionsMap2 = new HashMap<Integer, List<String>>();
	private List<BeanFormDetails> instructionList = new ArrayList<BeanFormDetails>();
	private BeanFormDetails form = new BeanFormDetails();
	private SubInstitute subInstitutebean = new SubInstitute();
	private File landingPage;
	private File userImage;
	private Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
	private FormFileBean formfile;
	private String userImageContentType;
	private String userImageFileName;
	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	private BeanFeeDetails fee = new BeanFeeDetails();
	private BeanLateFee latefee = new BeanLateFee();
	private BeanFieldLookup field = new BeanFieldLookup();
	private List<CollegeBean> colleges = new ArrayList<CollegeBean>();
	private List<SubInstitute> subcolleges = new ArrayList<SubInstitute>();
	private ArrayList<Integer> excelFieldList = new ArrayList<Integer>();
	private ArrayList<Integer> fieldIds = new ArrayList<Integer>();
	private LoginBean loginUser = new LoginBean();

	//private DBConnection connection = new DBConnection();
	private AppPropertiesConfig appProperties = new AppPropertiesConfig();
	private Properties properties = appProperties.getPropValues();
	private String formLinkImgFloderPath = properties.getProperty("qFormsLandingPageFloderPath");
	//private String dbName = properties.getProperty("dbName");
	
	
	private String reqFormId;

	@RequestMapping(value = "/initBuilder", method = RequestMethod.GET)
	public String initBuilder(ModelMap model, HttpServletRequest request) {
		HttpSession ses = request.getSession();
		log.debug("Start of initBuilder() ");
		LoginBean loginUser = new LoginBean();
		String returnVal = "";
		if (null != ses) {
			log.info("removing old session of renderPreview");
			ses.removeAttribute("validateFieldNameList");
			ses.removeAttribute("previousFormId");
			ses.removeAttribute("fieldLookupList");
			ses.removeAttribute("renderLookups");
			fieldIds.clear();
		}
		ses.setAttribute("FormFileBean", null);

		ArrayList<BeanFieldLookup> fieldLookupList = new ArrayList<BeanFieldLookup>();
		ArrayList<BeanFeeLookup> feeLookupList = new ArrayList<BeanFeeLookup>();
		ArrayList fieldIds = new ArrayList();
		ArrayList<BeanPayerType> payertypes = new ArrayList<BeanPayerType>();
		HashMap renderMap = new HashMap();
		HashMap valuesMap = new HashMap();
		HashMap optionsMap = new HashMap();
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		if (null == loginUser) {
			returnVal = "SessionTerminated";
		} else {
			log.debug(("login Bean name is " + loginUser.getUserName()));
			fieldLookupList = daoFieldLookupService.getFieldLookups();
			// log.debug("size of fieldLookuplist " + fieldLookupList.size());
			feeLookupList = daoFeeService.getFeeLookups("", null);
			payertypes = daoFieldLookupService.getPayerLookups(loginUser);

			ses.setAttribute("sesRenderMap", renderMap);
			ses.setAttribute("sesValuesMap", valuesMap);
			ses.setAttribute("sesFieldsList", fieldIds);
			ses.setAttribute("sesOptionsMap", optionsMap);
			ses.setAttribute("sesPhotoFieldFlag", 0);
			ses.setAttribute("sesSignatureFlag", 0);
			model.put("fees", feeLookupList);
			model.put("fields", fieldLookupList);
			model.put("payers", payertypes);
			model.addAttribute("fee", fee);
			model.addAttribute("latefee", latefee);
			returnVal = "index2";
		}
		return returnVal;
	}

	private void alert() {
		// TODO Auto-generated method stub

	}

	@RequestMapping(value = "/saveOptions", method = RequestMethod.GET)
	public String saveOptions(HttpServletRequest request) {
		log.debug("Open Save option method in formbuilder controller");
		HttpSession ses = request.getSession();
		HashMap optionMap = new HashMap();
		String optionArray = request.getParameter("optionArray");
		// log.debug("value of optionArray in formbuilder controller::::::::::: " +
		// optionArray.toString());
		Integer fieldId = Integer.parseInt(request.getParameter("fieldId").trim());
		log.debug("value of fieldId in formbuilder controller::::::::::: " + fieldId.toString());
		optionMap = (HashMap) ses.getAttribute("sesOptionsMap");
		// log.debug("value of optionMap in formbuilder controller::::::::::: " +
		// optionMap.toString());
		List<String> optionList = Arrays.asList(optionArray.split(","));
		optionMap.put(fieldId, optionList);
		// log.debug("value of optionMap after creating optionList in formbuilder
		// controller::::::::::: "+ optionMap.toString());
		ses.setAttribute("sesOptionsMap", optionMap);
		return "renderPage";
	}

	@RequestMapping(value="/formCustomField",method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView formCustomField(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
		
		ModelAndView mav = new ModelAndView("formCustomField");
		
		return mav;
	}
	
	@RequestMapping(value = "/renderPreview", method = RequestMethod.GET)
	public String renderPreview(ModelMap model, HttpServletRequest request, HttpSession ses) {

		ArrayList<BeanFieldLookup> renderLookups = new ArrayList<BeanFieldLookup>();
		Map<Integer, List<String>> optionsMap = new HashMap<Integer, List<String>>();
		ArrayList<Integer> excelFieldList = new ArrayList<Integer>();
		boolean hasPhoto = false;
		boolean hasSignature = false;
		HashMap renderMap = new HashMap();
		HashMap valuesMap = new HashMap();
		HashMap optionMap = new HashMap();
		HashMap<Integer, String> pageTitlesMap = new HashMap<Integer, String>();
		List mandatoryFields = new ArrayList();
		List mandNameFields = new ArrayList();
		List validateFieldNameList = new ArrayList();
		Integer l = 0;

		String saveFlag = request.getParameter("lastCall");
		String orderChangereq = request.getParameter("orderchange");
		String[] tempField = request.getParameter("definedFieldValues").split("~");

		// use for order change of the form fields
		if (!orderChangereq.trim().contentEquals("-1")) {
			renderLookups = (ArrayList) ses.getAttribute("renderLookups");
			String[] comboArr = orderChangereq.split("~");
			String index = comboArr[0];
			Integer indexint = Integer.parseInt(index.trim());
			String direction = comboArr[1];
			if (direction.trim().contentEquals("U")) {
				Collections.swap(renderLookups, (int) indexint, indexint - 1);
			} else {
				Collections.swap(renderLookups, (int) indexint, indexint + 1);
			}

			ses.setAttribute("renderLookups", renderLookups);
			model.put("sesRenderList", renderLookups);
			renderMap = (HashMap) ses.getAttribute("sesRenderMap");
			valuesMap = (HashMap) ses.getAttribute("sesValuesMap");
			ArrayList renderKeySet = new ArrayList(renderMap.keySet());
			renderKeySet.isEmpty();
			optionsMap = (Map) ses.getAttribute("sesOptionsMap");
			// log.debug("End of renderPreview() method 0, >> " + optionsMap.toString());
			return "renderPage";
		}
		// End order change request

		ArrayList<Integer> fieldIdsLocal = (ArrayList) ses.getAttribute("sesFieldsList");
		if (null != fieldIdsLocal) {
			log.info("fieldIds are ::::::::: " + fieldIdsLocal.toString());
		}

		optionMap = (HashMap) ses.getAttribute("sesOptionsMap");
		pageTitlesMap = (HashMap<Integer, String>) ses.getAttribute("sesPageTitlesMap");
		excelFieldList = (ArrayList<Integer>) ses.getAttribute("fieldLookupList");

		if (null != excelFieldList && null != fieldIdsLocal) {
			log.debug("excelFieldList is " + excelFieldList.toString());
			fieldIdsLocal = (ArrayList<Integer>) Stream.concat(fieldIdsLocal.stream(), excelFieldList.stream())
					.collect(Collectors.toList());
			log.info("fieldIds with excelfieldlist are ::::::::: " + fieldIdsLocal.toString());
		}

		if (pageTitlesMap == null) {
			pageTitlesMap = new HashMap<Integer, String>();
		}

		String selectedFields = request.getParameter("fieldarray");
		String mandFields = request.getParameter("mandatoryList");
		String validateFieldName = request.getParameter("validateFields");
		String mandNameMNumber = request.getParameter("mandNameMNumber");
		log.debug("selectedFields ::: {" + selectedFields + "},  mandFields :: {" + mandFields
				+ "}, validateFieldName :: {" + validateFieldName + "}");

		if (!validateFieldName.trim().contentEquals("")) {
			validateFieldNameList = Arrays.asList(validateFieldName.split(","));
			log.debug("validateFieldNameList Fields field value in array is " + validateFieldNameList.toString());
		}

		if (!mandFields.trim().contentEquals("")) {
			mandatoryFields = Arrays.asList(mandFields.split(","));
		}
		log.info("Mandatory Field List is : ================> "+mandatoryFields.toString());
		// mandNameFields
		if (!mandNameMNumber.trim().contentEquals("")) {
			mandNameFields = Arrays.asList(mandNameMNumber.split(","));
		}
		log.info("Mandatory name mobile email amount Field List is : ================> "+mandNameFields.toString());
		
		List<String> fieldList = null;
		if (null != selectedFields && !selectedFields.isEmpty() && "" != selectedFields) {
			fieldList = Arrays.asList(selectedFields.split(","));
			log.debug(("selected Fields are " + fieldList.toString()));
		}

		if (null != fieldList && "" != fieldList.toString()) {
			for (String x : fieldList) {
				Integer y = Integer.parseInt(x);
				if (null == fieldIdsLocal) {
					fieldIdsLocal.add(y);
				} else if (!fieldIdsLocal.contains(y)) {
					fieldIdsLocal.add(y);
				}
			}
		}
		log.debug("fieldIds are ::::::::: " + fieldIdsLocal.toString());

		Iterator<Integer> fieldIdIterator = fieldIdsLocal.iterator();
		while (fieldIdIterator.hasNext()) {
			Integer selectedId;
			boolean add = true;
			try {
				selectedId = fieldIdIterator.next();
			} catch (NumberFormatException e) {
				log.debug("breaking from add to List while loop");
				break;
			}
			for (Integer currentId : fieldIdsLocal) {
				if (!currentId.equals(selectedId))
					continue;
				add = false;
			}
			if (!add)
				continue;
			fieldIdsLocal.add(selectedId);
		}
		log.debug("fieldIds are ::::::::: " + fieldIdsLocal.toString());

		Iterator currentIt = fieldIdsLocal.iterator();
		if (null != excelFieldList) {
			while (currentIt.hasNext()) {
				boolean remove = true;
				Integer currId = (Integer) currentIt.next();
				Iterator<Integer> selectedIt = fieldIdsLocal.iterator();
				while (selectedIt.hasNext()) {
					try {
						Integer selId = selectedIt.next();
						if (!selId.equals(currId))
							continue;
						remove = false;
					} catch (NumberFormatException e) {
						remove = true;
					}
				}
				if (!remove)
					continue;
				currentIt.remove();
			}
		} else {
			while (currentIt.hasNext()) {
				boolean remove = true;
				Integer currId = (Integer) currentIt.next();
				Iterator<String> selectedIt = fieldList.iterator();
				while (selectedIt.hasNext()) {
					try {
						Integer selId = Integer.parseInt(selectedIt.next());
						if (!selId.equals(currId))
							continue;
						remove = false;
					} catch (NumberFormatException e) {
						remove = true;
					}
				}
				if (!remove)
					continue;
				currentIt.remove();
			}
		}
		Integer baseAmount = Integer.parseInt(request.getParameter("feeAmount"));
		log.debug(("SelectedFields are " + fieldIdsLocal.toString() + " Amount is " + baseAmount));
		ArrayList<BeanFieldLookup> currentFieldLookups = new ArrayList<BeanFieldLookup>();
		ArrayList<BeanFieldLookup> currentFieldLookupsOrdered = new ArrayList<BeanFieldLookup>();
		if (excelFieldList == null && fieldIdsLocal != null) {
			log.debug(("SelectedFields are " + fieldIdsLocal.toString() + " Amount is " + baseAmount));
			if (!fieldIdsLocal.isEmpty()) {
				log.debug("SelectedFields are in IF block when fieldid is not empty:::::::::: "
						+ fieldIdsLocal.toString());
				currentFieldLookups = daoFieldLookupService.getFieldLookups(fieldIdsLocal);
				log.debug("currentFieldLookups is in daoimpl ::::::::: " + currentFieldLookups.toString());
				Integer i = 0;
				while (i < fieldIdsLocal.size()) {
					Integer tempid = (Integer) fieldIdsLocal.get(i);
					Integer j = 0;
					while (j < currentFieldLookups.size()) {
						log.debug(("lookup id in array " + ((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id()
								+ " lookup id from jsp " + tempid));
						if (((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
							log.debug("Temp type in code -->>> " + currentFieldLookups.get(j).getLookup_subtype() + "  "
									+ currentFieldLookups.get(j).getLookup_subtype());
							currentFieldLookupsOrdered.add((BeanFieldLookup) currentFieldLookups.get(j));
						}
						j = j + 1;
					}
					i = i + 1;
				}
				log.debug("currentFieldLookupsOrdered   is :::::::::::::::::::: "
						+ currentFieldLookupsOrdered.toString());
				currentFieldLookups = currentFieldLookupsOrdered;
			}
		} else if (excelFieldList != null && fieldIdsLocal != null) {
			log.debug(("SelectedFields are " + fieldIdsLocal.toString() + " Amount is " + baseAmount));
			if (!fieldIdsLocal.isEmpty()) {
				log.debug("SelectedFields are in IF block when fieldid is not empty:::::::::: "
						+ fieldIdsLocal.toString());
				currentFieldLookups = daoFieldLookupService.getFieldLookups(fieldIdsLocal);
				log.debug("currentFieldLookups is in daoimpl ::::::::: " + currentFieldLookups.toString());
				Integer i = 0;
				while (i < fieldIdsLocal.size()) {
					Integer tempid = (Integer) fieldIdsLocal.get(i);
					Integer j = 0;
					while (j < currentFieldLookups.size()) {
						log.debug(("lookup id in array " + ((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id()
								+ " lookup id from jsp " + tempid));
						if (((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
							log.debug("Temp type in code -->>> " + currentFieldLookups.get(j).getLookup_subtype() + "  "
									+ currentFieldLookups.get(j).getLookup_subtype());
							currentFieldLookupsOrdered.add((BeanFieldLookup) currentFieldLookups.get(j));
						}
						j = j + 1;
					}
					i = i + 1;
				}
				log.debug("currentFieldLookupsOrdered   is :::::::::::::::::::: "
						+ currentFieldLookupsOrdered.toString());
				currentFieldLookups = currentFieldLookupsOrdered;
			}
		} else if (excelFieldList != null && fieldIds == null) {
			fieldIdsLocal = new ArrayList<Integer>(excelFieldList);
			log.debug(("SelectedFields are " + fieldIdsLocal.toString() + " Amount is " + baseAmount));
			if (!fieldIdsLocal.isEmpty()) {
				log.debug("SelectedFields are in IF block when fieldid is not empty:::::::::: "
						+ fieldIdsLocal.toString());
				currentFieldLookups = daoFieldLookupService.getFieldLookups(fieldIdsLocal);
				log.debug("currentFieldLookups is in daoimpl ::::::::: " + currentFieldLookups.toString());
				Integer i = 0;
				while (i < fieldIdsLocal.size()) {
					Integer tempid = (Integer) fieldIdsLocal.get(i);
					Integer j = 0;
					while (j < currentFieldLookups.size()) {
						log.debug(("lookup id in array " + ((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id()
								+ " lookup id from jsp " + tempid));
						if (((BeanFieldLookup) currentFieldLookups.get(j)).getLookup_id().equals(tempid)) {
							log.debug("Temp type in code -->>> " + currentFieldLookups.get(j).getLookup_subtype() + "  "
									+ currentFieldLookups.get(j).getLookup_subtype());
							currentFieldLookupsOrdered.add((BeanFieldLookup) currentFieldLookups.get(j));
						}
						j = j + 1;
					}
					i = i + 1;
				}
				log.info("currentFieldLookupsOrdered   is :::::::::::::::::::: "
						+ currentFieldLookupsOrdered.toString());
				currentFieldLookups = currentFieldLookupsOrdered;
			}
		}
		log.info("fieldIds1 for new selection 23Feb is ::::: " + fieldIdsLocal.toString());
		log.info("save flag is  is " + saveFlag);

		if (saveFlag != null && saveFlag.trim().equalsIgnoreCase("Y")) {
			log.info("ses.getAttribute sesRenderList :::::::::: " + ses.getAttribute("renderLookups").toString());
			currentFieldLookups = (ArrayList) ses.getAttribute("renderLookups");
		}
		log.info("objecct is " + currentFieldLookups);

		HashMap optMap = (HashMap) ses.getAttribute("sesOptionsMap");
		if (!currentFieldLookups.isEmpty()) {
			ArrayList optionKeys = new ArrayList(optMap.keySet());
			Iterator it = currentFieldLookups.iterator();
			boolean k = false;
			while (it.hasNext()) {
				int i;
				Integer key;
				BeanFieldLookup temp = (BeanFieldLookup) it.next();
				String temptype = temp.getLookup_type();
				Integer tempid = temp.getLookup_id();
				String subType = temp.getLookup_subtype();
				log.debug("temp type iterator ---->>> " + temptype + " " + subType);
				// for testing
				if (temptype.contains("readonly")) {
					log.debug("it contains read only " + optionKeys.size());
					if (optionKeys.isEmpty()) {
						request.setAttribute("text", temp.getLookup_name());
						request.setAttribute("readonly", "readonly");
						return "readonly";
					}
				}
				if (temptype.contentEquals("Select Box")) {
					if (optionKeys.isEmpty()) {
						request.setAttribute("optionName", temp.getLookup_name());
						request.setAttribute("optionId", temp.getLookup_id());
						return "optionPage";
					}
					boolean optionpage = true;
					i = 0;
					while (i < optionKeys.size()) {
						key = (Integer) optionKeys.get(i);
						if (key.equals(tempid)) {
							optionpage = false;
						}
						++i;
					}
					if (!optionpage)
						continue;
					request.setAttribute("optionName", temp.getLookup_name());
					request.setAttribute("optionId", temp.getLookup_id());
					return "optionPage";
				}
				if (temptype.contentEquals("Multiplier")) {
					if (optionKeys.isEmpty()) {
						request.setAttribute("multiplierName", temp.getLookup_name());
						request.setAttribute("multiplierId", temp.getLookup_id());
						return "multiplierPage";
					}
					boolean multiplierpage = true;
					i = 0;
					while (i < optionKeys.size()) {
						key = (Integer) optionKeys.get(i);
						if (key.equals(tempid)) {
							multiplierpage = false;
						}
						++i;
					}
					if (!multiplierpage)
						continue;
					request.setAttribute("multiplierName", temp.getLookup_name());
					request.setAttribute("multiplierId", temp.getLookup_id());
					return "multiplierPage";
				}
				if (temptype.contentEquals("Radio Button Group")) {
					if (optionKeys.isEmpty()) {
						request.setAttribute("optionName", temp.getLookup_name());
						request.setAttribute("optionId", temp.getLookup_id());
						return "radioGroupPage";
					}
					boolean radiopage = true;
					i = 0;
					while (i < optionKeys.size()) {
						key = (Integer) optionKeys.get(i);
						if (key.equals(tempid)) {
							radiopage = false;
						}
						++i;
					}
					if (!radiopage)
						continue;
					request.setAttribute("optionName", temp.getLookup_name());
					request.setAttribute("optionId", temp.getLookup_id());
					return "radioGroupPage";
				}
				if (!temptype.contentEquals("PageBreak"))
					continue;
				log.debug("inside PageBreak Map building");
				log.debug(("temp id is..::" + tempid));
				log.debug(("pageTitleValue is..::" + tempField[l]));
				pageTitlesMap.put(tempid, tempField[l]);
				ses.setAttribute("sesPageTitlesMap", pageTitlesMap);
				l = l + 1;
			}
		}
		if (!currentFieldLookups.isEmpty()) {
			int i = 0;
			// use for iterate current field list
			while (i < currentFieldLookups.size()) {
				Integer tempid = ((BeanFieldLookup) currentFieldLookups.get(i)).getLookup_id();
				((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandatory(Integer.valueOf(0));
				int j = 0,k=0;
				// use for iterate mandatory fields
				while (j < mandatoryFields.size()) {
					Integer mandId = Integer.parseInt(((String) mandatoryFields.get(j)).trim());
					if (mandId.equals(tempid)) {
						((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandatory(Integer.valueOf(1));
					}
					++j;
				}
				// use for iterate Payer Name, Mobile, Email, Amount fields for PG
				while (k < mandNameFields.size()) {
					String str = ((String) mandNameFields.get(k)).trim();
					
					Integer fId = Integer.parseInt(str.substring(str.length() - 1, str.length()));
					Integer mandId = Integer.parseInt(str.substring(0, str.length() - 1));
					
					if (mandId.equals(tempid) && fId == 1) {
						log.info("is for name");
						((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandFieldForSp(Integer.valueOf(1));
					} else if (mandId.equals(tempid) && fId == 2) {
						log.info("is for mobile number");
						((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandFieldForSp(Integer.valueOf(2));
					} else if (mandId.equals(tempid) && fId == 3) {
						log.info("is for email");
						((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandFieldForSp(Integer.valueOf(3));
					} else if (mandId.equals(tempid) && fId == 4) {
						log.info("is for paid amount");
						((BeanFieldLookup) currentFieldLookups.get(i)).setIsMandFieldForSp(Integer.valueOf(4));
					}
					++k;
				}

				++i;
			}
		}
		
		renderLookups = currentFieldLookups;
		// ses.setAttribute("sesRenderList", renderLookups);
		model.put("sesRenderList", renderLookups);
		ses.setAttribute("renderLookups", renderLookups);
		ses.setAttribute("validateFieldNameList", validateFieldNameList);
		renderMap = (HashMap) ses.getAttribute("sesRenderMap");
		valuesMap = (HashMap) ses.getAttribute("sesValuesMap");
		ArrayList renderKeySet = new ArrayList(renderMap.keySet());
		renderKeySet.isEmpty();
		optionsMap = (Map) ses.getAttribute("sesOptionsMap");
		// ses.setAttribute("optionsMap", optionsMap);
		model.put("optionsMap", optionsMap);

		ses.setAttribute("sesPageTitlesMap", pageTitlesMap);
		return "renderPage";
	}

	@RequestMapping(value = "/saveForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveForm(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@ModelAttribute("saveFormData") BeanFormDetails saveFormData,
			@ModelAttribute("lateFeeData") BeanLateFee lateFeeData, @ModelAttribute("feeData") BeanFeeDetails feeData)
			throws Exception {

		log.info("saving the form in formbuidercontroller by saveForm() method");
		Set<BeanLateFee> latefeeSet = new HashSet<BeanLateFee>();
		Map<Integer, String> pageTitlesMap = new HashMap<Integer, String>();
		ArrayList<BeanFieldLookup> currentFieldLookups = new ArrayList<BeanFieldLookup>();
		ArrayList<String> selectedFees = new ArrayList<String>();
		String returnValue = "";
		List validateFieldNames = new ArrayList();
		String fieldNameToValidate = null;
		validateFieldNames = (List) ses.getAttribute("validateFieldNameList");
		fieldNameToValidate = String.join(",", validateFieldNames);
		currentFieldLookups = (ArrayList<BeanFieldLookup>) ses.getAttribute("renderLookups");
		Map<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
		try {
			optionMap = (Map<Integer, List<String>>) ses.getAttribute("sesOptionsMap");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("cannot retrieve field options");
		}

		try {
			pageTitlesMap = (Map<Integer, String>) ses.getAttribute("sesPageTitlesMap");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("cannot retrieve pageTitlesMap");
		}

		log.info("saving form " + saveFormData.getFormName());
		if (null == saveFormData.getHasInstructions()) {
			saveFormData.setHasInstructions("no");
		}
		if (null == saveFormData.getMoveToPg()) {
			saveFormData.setMoveToPg("no");
		}
		log.info("saveFormData.getHasInstructions() " + saveFormData.getHasInstructions());
		log.info("saveFormData.getMoveToPg() " + saveFormData.getMoveToPg());

		BeanFieldLookup tempfield = new BeanFieldLookup();
		List<BeanFormStructure> structures = new ArrayList<BeanFormStructure>();
		for (int i = 0; i < currentFieldLookups.size(); i++) {
			tempfield = currentFieldLookups.get(i);
			log.debug("adding " + tempfield.getLookup_name() + " to structure");
			BeanFormStructure structure = new BeanFormStructure();
			structure.setFormField(tempfield);
			structure.setFieldOrder(i);
			structure.setIsMandatory(tempfield.getIsMandatory());
			
			//use checksum for finding the payer name, mobile number, email-Id, amount. 
			if (null != tempfield.getIsMandFieldForSp()) {
				log.info("field is maped for Name, Mobile, Email, and Amount.");
				if (tempfield.getIsMandFieldForSp() == 1) {
					structure.setIsMandName(tempfield.getIsMandFieldForSp());
				} else if (tempfield.getIsMandFieldForSp() == 2) {
					structure.setIsMandMobileNumber(tempfield.getIsMandFieldForSp());
				} else if (tempfield.getIsMandFieldForSp() == 3) {
					structure.setIsMandEmail(tempfield.getIsMandFieldForSp());
				} else if (tempfield.getIsMandFieldForSp() == 4) {
					structure.setIsMandAmount(tempfield.getIsMandFieldForSp());
				}
			} else {
				log.info("No field is maped for Name, Mobile, Email, and Amount.");
			}

			if (tempfield.getLookup_type().contentEquals("Select Box")
					|| tempfield.getLookup_type().contentEquals("Multiplier")
					|| tempfield.getLookup_type().contentEquals("Radio Button Group")) {
				List<String> options = new ArrayList<String>(optionMap.get(tempfield.getLookup_id()));
				if (options.size() > 0) {
					structure.setFieldValues(ListToString(options));
				}
			}
			if (tempfield.getLookup_type().contentEquals("PageBreak")) {
				structure.setFieldValues(pageTitlesMap.get(tempfield.getLookup_id()));
			}
			structures.add(structure);
			// log.debug("Form structures is "+structures.toString());
		}
		saveFormData.setStatus("NEW");

		if (saveFormData.getLife_cycle().contentEquals("yes")) {
			saveFormData.setStatus("PENDING CONFIG");
			saveFormData.getLandingpage_srcPath();
		}
		saveFormData.setFormDate(new Date());

		log.info("form start date {" + saveFormData.getFormStartDate() + "}, form end date {"
				+ saveFormData.getFormEndDate() + "}, form late end date {" + saveFormData.getFormLateEndDate() + "}");

		LoginBean loginBean = (LoginBean) ses.getAttribute("loginUserBean");
		// log.info("LoginBeanId :: " + loginBean.getLoginId());
		saveFormData.setFormOwnerId(loginBean.getLoginId());
		saveFormData.setFormOwnerName(loginBean.getCollgBean().getCollegeCode());
		saveFormData.setStatus_by(loginBean.getLoginId());

		selectedFees = saveFormData.getSelectedFees();
		if (selectedFees.size() == 0) {
			return "error";
		}
		Integer feeid = Integer.parseInt(selectedFees.get(0));

		BeanFeeLookup feelookup = daoFeeService.getFeeLookups("feeid", feeid).get(0);
		feeData.setFeeLookup(feelookup);
		lateFeeData.getLatefeeAmount();
		lateFeeData.getLatefeeType();
		lateFeeData.setLatefeeStartdate(saveFormData.getFormEndDate());
		lateFeeData.setLatefeeEnddate(saveFormData.getFormLateEndDate());
		log.info("getLatefeeAmount() {" + lateFeeData.getLatefeeAmount() + "}, getLatefeeType() {"
				+ lateFeeData.getLatefeeType() + "}");
		log.info("getLatefeeStartdate() {" + lateFeeData.getLatefeeStartdate() + "}, getLatefeeEnddate() {"
				+ lateFeeData.getLatefeeEnddate() + "}");

		latefeeSet.add(lateFeeData);
		feeData.setLatefeeset(latefeeSet);

		saveFormData.setFormFee(feeData);
		Set<BeanFormStructure> structureSet = new HashSet<BeanFormStructure>(structures);
		saveFormData.setFormStructure(structureSet);
		FormFileBean formfilebean = (FormFileBean) ses.getAttribute("FormFileBean");
		if (formfilebean != null) {
			saveFormData.setFile_ext(formfilebean.getFile_extension());
			saveFormData.setFileLabel(formfilebean.getFile_description());
			saveFormData.setHasInstructions("Y");
			saveFormData.setFile_actu_name((ses.getAttribute("act_file_name")).toString());
			saveFormData.setInstructions(formfilebean.getFile_data());
			ses.setAttribute("FormFileBean", null);
		}

		saveFormData.setValidateFieldOfExcel(fieldNameToValidate);
		log.info("saving formDetailsBean ");
		saveFormData = daoFieldLookupService.saveForm(saveFormData);
		form = saveFormData;
		log.debug("New FormId is :::::: " + saveFormData.getId());
		returnValue = createNewTableWithApprove(request, response, ses, saveFormData.getId());
		ses.setAttribute("form", saveFormData);
		ses.setAttribute("previousFormId", saveFormData.getId().toString());
		if (returnValue == "success") {
			request.setAttribute("msg",
					"Form Successfully Created. Your FormId " + saveFormData.getId() + " and FormName is "
							+ saveFormData.getFormName()
							+ ". Form Must be Approved by an Admin before being activated.");
			request.setAttribute("link", "initBuilder");
		} else {
			request.setAttribute("msg",
					"Form is not Created. somethig is wrong in approving the form Your FormId and FormName is "
							+ saveFormData.getFormName()
							+ ". Form Must be not Approved by an Admin before being activated.");
		}
		log.debug("End of saveForm() method");
		return "successPage";
	}

	public String createNewTableWithApprove(HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			Integer formIds) throws Exception {
		log.info("Open createNewTableWithApprove() Method.");
		log.info("form id is = " + formIds.toString());
		ArrayList<String> columnListOfFirstRow = new ArrayList<String>();
		columnListOfFirstRow = (ArrayList<String>) ses.getAttribute("columnListOfFirstRow");
		String formOwnerName;
		BeanFormDetails form = new BeanFormDetails();
		BeanPayerType payerTypeBean = new BeanPayerType();
		Boolean createDBflag = Boolean.valueOf(false);
		Boolean createDBflagForFileUploafd = Boolean.valueOf(false);
		Boolean tableCreationError = Boolean.valueOf(false);
		String uploadFlag = "";
		String formName = "";
		String tempTableName = "";
		String tempTableNameForFileUpload = "";

		try {
			form = daoFieldLookupService.getFormDetails(formIds);
			formOwnerName = form.getFormOwnerName();
			if (null != form.getPayer_type()) {
				payerTypeBean = daoFieldLookupService.getPayerLookupsById(form.getPayer_type());
			}
			String payerType = "";
			if (null != payerTypeBean.getPayer_type()) {
				payerType = payerTypeBean.getPayer_type();
				payerType = payerType.replaceAll("\\s", "_");
				payerType = payerType.replaceAll("'", "apos");
				payerType = payerType.replaceAll("/", "fslsh");
				payerType = payerType.replaceAll("\\\\", "bslsh");
				payerType = payerType.replaceAll("\\*", "astrk");
				payerType = payerType.replaceAll("\\(", "obkt");
				payerType = payerType.replaceAll("\\)", "cbkt");
				payerType = payerType.replaceAll("\\-", "hphn");
				payerType = payerType.replaceAll("\\:", "cln");
				payerType = payerType.replaceAll("\\.", "dot");
			}

			if (form.getLife_cycle().contentEquals("yes")) {
				FormLifeCycleBean firstCycle = lifeCycleService.getFormCycle(Integer.valueOf(0), form.getId());
				form.setTarget_actor(firstCycle.getActor_id());
			}

			if (columnListOfFirstRow != null && !form.getValidateFieldOfExcel().isEmpty()
					&& !form.getValidateFieldOfExcel().equals(null) && form.getValidateFieldOfExcel() != "") {

				tempTableNameForFileUpload = "zz_" + formOwnerName + "_" + payerType + "_" + form.getId();

				tempTableName = "zz_client_user_data_" + form.getId();

			} else {
				tempTableName = "zz_client_user_data_" + form.getId();
			}

			if (!tempTableNameForFileUpload.isEmpty() && null != tempTableNameForFileUpload) {

				createDBflagForFileUploafd = lifeCycleService.checkTableExit(tempTableNameForFileUpload);
			}

			createDBflag = lifeCycleService.checkTableExit(tempTableName);

			if (createDBflag.booleanValue() || createDBflagForFileUploafd.booleanValue()) {
				FormBuilderController actionsFormBuilder = new FormBuilderController();
				actionsFormBuilder.SetOptionsMap(form, ses);
				form = actionsFormBuilder.orderStructure(form);
				List<BeanFormStructure> structureList = form.getStructureList();
				Iterator<BeanFormStructure> iterator = structureList.iterator();
				String dynSQL = "";
				int i = 0;
				while (iterator.hasNext()) {
					BeanFormStructure beanFormStructure = (BeanFormStructure) iterator.next();
					String string2 = beanFormStructure.getFormField().getLookup_name();
					string2 = string2.replaceAll("\\s", "_");
					string2 = string2.replaceAll("'", "apos");
					string2 = string2.replaceAll("/", "fslsh");
					string2 = string2.replaceAll("\\\\", "bslsh");
					string2 = string2.replaceAll("\\*", "astrk");
					string2 = string2.replaceAll("\\(", "obkt");
					string2 = string2.replaceAll("\\)", "cbkt");
					string2 = string2.replaceAll("\\-", "hphn");
					string2 = string2.replaceAll("\\:", "cln");
					string2 = string2.replaceAll("\\.", "dot");
					string2 = StringUtils.removeEnd(string2, "_");
					// log.debug("generate column names ::" + string2);
					if (string2.equals("Page_Title")) {
						string2 = "Page_Title_" + i;
						i++;
					}
					if (string2.equals("PagewspcTitle")) {
						string2 = "PagewspcTitle" + i;
						i++;
					}
					dynSQL = dynSQL + "," + string2 + " varchar(255)";
				}
				dynSQL = StringUtils.removeStart(dynSQL, ",");
				// log.debug("generated all column names ::" + dynSQL);
				if ((columnListOfFirstRow != null && !form.getValidateFieldOfExcel().isEmpty()
						&& !form.getValidateFieldOfExcel().equals(null) && form.getValidateFieldOfExcel() != "")
						&& (null != tempTableNameForFileUpload && !tempTableNameForFileUpload.equals("")
								&& !tempTableNameForFileUpload.isEmpty())) {
					tableCreationError = daoFieldLookupService.creatDynamicTableForOfflineForm(dynSQL,
							tempTableNameForFileUpload);
					log.error("tableCreationError ::::: " + tableCreationError.toString());
				}
				tableCreationError = daoFieldLookupService.creatDynamicTable(dynSQL, tempTableName);
				log.error("tableCreationError ::::: " + tableCreationError.toString());
			}
			formName = form.getFormName();
			// log.debug("formName is for creating new table is ::::::: "+formName);
			if (tableCreationError.booleanValue()) {
				request.setAttribute("errorMsg",
						"There were some issues with the fields defintions in the form, so the form could not be approved, please review the fields or contact your administrator!!");
				log.error(
						"There were some issues with the fields defintions in the form, so the form could not be approved, please review the fields or contact your administrator!!");
				return "error";
			}

			if (columnListOfFirstRow != null && !form.getValidateFieldOfExcel().isEmpty()
					&& !form.getValidateFieldOfExcel().equals(null) && form.getValidateFieldOfExcel() != "") {
				// log.debug("columnListOfFirstRow id is = " + columnListOfFirstRow.toString());
				log.info("columnListOfFirstRow size is = " + columnListOfFirstRow.size());
				uploadFlag = offLineFormService.generateTempTable(columnListOfFirstRow, tempTableNameForFileUpload, ses,
						formName,formOwnerName);
				ses.removeAttribute("columnListOfFirstRow");
			}
			form = daoFieldLookupService.saveForm(form);
			//List<CollegeBean> collegeBeans = new ArrayList<CollegeBean>();
			//collegeBeans = collegeService.getCollegeDetailsBasedOnCode(form.getFormOwnerName());

			if (uploadFlag == "tableCreationError") {
				request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
				return "OffLineFormUpload";
			}
			if (uploadFlag == "paymentCycleError") {
				request.setAttribute("msg", "Payment Cycle not Configured.");
				return "OffLineFormUpload";
			}
			if (uploadFlag == "excelError") {
				request.setAttribute("msg", "One or more cell headers missing values.");
				return "OffLineFormUpload";
			}
			if (uploadFlag == "fail") {
				request.setAttribute("msg", "All fields must and should be Text type.");
				return "OffLineFormUpload";
			}
			if (uploadFlag == "dbError") {
				request.setAttribute("msg", "Data is not correct in file, please try again.");
				// log.debug("End of addBulkRecord() method , File Upload Status is >> dbError
				// failure");
				return "OffLineFormUpload";
			} else if (uploadFlag == "") {
				request.setAttribute("msg", "Record Uploaded Successfully");
				// log.debug("End of addBulkRecord() method , File Upload Status is >> setup");
				return "success";
			} else {
				request.setAttribute("msg", "Record Uploaded Successfully");
				// log.debug("ReturnMSG " + ses.getAttribute("fieldValidationFlag") + "\\\\" +
				// uploadFlag);
				if (ses.getAttribute("fieldValidationFlag").equals("Y") && uploadFlag.equals("success")) {
					// log.debug("End of addBulkRecord() method , File Upload Status is >> setup");
					return "success";
				}
				log.debug("End of addBulkRecord() method , File Upload Status is >> SUCCESS");
				return "OffLineFormUpload";
			}
		} catch (NumberFormatException e) {
			log.debug("Could not parse form id from request");
		} finally {

		}
		return "error";
	}

	@RequestMapping(value = "/previewForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String previewForm(ModelMap model, HttpServletRequest request) {
		BeanFormDetails formdetails;
		HttpSession ses = request.getSession();
		block5: {
			try {
				Integer formid = Integer.parseInt(request.getParameter("reqFormId"));
				formdetails = new BeanFormDetails();
				formdetails = daoFieldLookupService.getFormDetails(formid);
				if (formdetails.getId() != null)
					break block5;
				log.debug("FORM NOT FOUND");
				return "sessionFailurePage";
			} catch (NumberFormatException e) {
				e.printStackTrace();
				log.debug("Form ID not parseable");
				return "sessionFailurePage";
			}
		}
		SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		try {
			formdetails.setToDateStr(df.format(formdetails.getFormEndDate()));
			formdetails.setFromDateStr(df.format(formdetails.getFormStartDate()));
		} catch (Exception e) {
			log.debug("EVergreen Form");
		}
		SetOptionsMap(formdetails, ses);
		formdetails = orderStructure(formdetails);
		model.put("previewOfForm", formdetails);
		return "formPreview";
	}

	@RequestMapping(value = "/getFormsBasedOnClient", method = RequestMethod.GET)
	public String getFormsBasedOnClient(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		log.debug(("testing user name:" + loginUser.getUserName()));
		forms = new ArrayList<BeanFormDetails>(daoFieldLookupService.getAllApprovedFormDetailsBasedOnClient(loginUser));
		log.debug(("testing the size:" + forms.size()));
		if (loginUser.getProfile().contentEquals("Operator")) {
			return "Applicant-Operator-Reports";
		}
		return "Applicant-ReportsForAllClients";
	}

	@RequestMapping(value = "/getReportForSpotCash", method = RequestMethod.GET)
	public String getReportForSpotCash(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		log.debug(("testing user name:" + loginUser.getUserName()));
		forms = new ArrayList<BeanFormDetails>(daoFieldLookupService.getAllPendingDetailstForSpotCash(loginUser));
		log.debug(("testing the size:" + forms.size()));
		if (loginUser.getProfile().contentEquals("Operator")) {
			return "Applicant-Operator-Reports";
		}
		return "Applicant-MIS-ReportsForAllClients";
	}

	@RequestMapping(value = "/verifyCode", method = RequestMethod.GET)
	public String verifyCode(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		boolean staleCheckResult = checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
				request.getParameter("formid"), request.getParameter("forminstanceid"), ses);
		if (staleCheckResult || (Integer) ses.getAttribute("BankId") == null) {
			log.debug("staleCheckResult passes...");
			SubInstitute coll = new SubInstitute();
			List collList = new ArrayList();
			String code = request.getParameter("code");
			log.debug(("payer is::" + request.getParameter("PayeeProfile")));
			if (request.getParameter("PayeeProfile") != null) {
				ses.setAttribute("PayeeProfile", request.getParameter("PayeeProfile"));
			}
			String cid = null;
			try {
				cid = ses.getAttribute("CollegeId").toString();
			} catch (NullPointerException e) {
				e.printStackTrace();
				return "error";
			}
			if (code != null && !code.trim().contentEquals("")) {
				collList = collegeService.getSubInstituteList((String) code, (String) cid);
				if (collList.size() == 0) {
					log.debug("institute code does not match");
					ses.setAttribute("reqVerFlag", "0");
					ses.setAttribute("msg", " Please Enter Valid College Code");
					request.setAttribute("msg", "Entered Code does not exist in the System");
				} else if (collList.size() > 1) {
					log.debug("institute code matches and multiple results");
					coll = (SubInstitute) collList.get(0);
					ses.setAttribute("reqVerFlag", "2");
					ses.setAttribute("CollegeList", collList);
				} else {
					log.debug("institute code matches and unique result");
					coll = (SubInstitute) collList.get(0);
					ses.setAttribute("SelectedInstitute",
							(String.valueOf(coll.getInstituteName()) + ":" + coll.getInstituteType()));
					ses.setAttribute("reqVerFlag", "1");
					ses.setAttribute("PayerID", code);
				}
			}
			return "PayerFormListNew";
		}
		log.debug("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	@RequestMapping(value = "/storeCode", method = RequestMethod.GET)
	public String storeCode(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		boolean staleCheckResult = checkStaleSession(request.getParameter("bid"), request.getParameter("cid"),
				request.getParameter("formid"), request.getParameter("forminstanceid"), ses);
		if (staleCheckResult || (Integer) ses.getAttribute("BankId") == null) {
			log.debug("inside storeCode and institute code being saved ");
			String code = request.getParameter("sel_code");
			ses.setAttribute("reqVerFlag", "1");
			ses.setAttribute("PayerID", code);
			SubInstitute subIns = new SubInstitute();
			subIns = collegeService.getSubInstituteDetailsOfCollegeBasedOnID((Integer) Integer.parseInt(code.trim()));
			ses.setAttribute("SelectedInstitute",
					(String.valueOf(subIns.getInstituteName()) + ":" + subIns.getInstituteType()));
			ses.setAttribute("InstituteCode", subIns.getInstituteCode());
			log.info("subIns.getInstituteCode()" + subIns.getInstituteCode());
			return "PayerFormListNew";
		}
		log.debug("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	@RequestMapping(value = "/getFormPayerInstant", method = RequestMethod.GET)
	public String getFormReadyPay(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		boolean staleCheckResult = true;
		if (staleCheckResult) {
			block22: {
				BeanFormDetails formdetails;
				boolean landingpage;
				Integer lpFlag;
				Integer sesCid;
				String formInstanceId;
				block21: {
					sesCid = 0;
					this.collegeBean = null;
					String formId = "";
					String formNumber = "";
					formInstanceId = request.getParameter("formInstanceId");
					lpFlag = null;
					try {
						lpFlag = 1;
					} catch (Exception e) {
						lpFlag = 1;
					}
					try {
						formId = request.getParameter("formId");
						if (formId == null) {
							formId = this.form.getId().toString();
						}
					} catch (Exception e) {
						// empty catch block
					}
					log.debug(("form id from request is::" + formId));
					landingpage = false;
					formdetails = new BeanFormDetails();
					formdetails = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
					if (formdetails.getId() != null)
						break block21;
					log.debug("FORM NOT FOUND");
					return "error";
				}
				try {
					try {
						Integer sesBid = Integer.valueOf(request.getParameter("BankId"));
						log.info(("SesBid Is" + sesBid));
						sesCid = Integer.valueOf(request.getParameter("CollegeId"));
						log.info(("ses Cid Is" + sesCid));
						collegeBean = collegeService.viewInstDetail((Integer) sesCid);
						log.info(("form template id is:" + formdetails.getId()));
						collegeBean = daoFieldLookupService
								.getClientDetailsBasedOnClientCode(formdetails.getFormOwnerName());
						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(formdetails.getPayer_type());
						log.info(("form instance id from session is::" + formInstanceId));
						if (!StringUtils.isBlank((String) formInstanceId) && !"null".equals(formInstanceId)) {
							log.debug("came inside the if block");

							SampleFormAction formAction = new SampleFormAction();
							sampleFormBean = sampleFormService
									.getFormData(Integer.valueOf(Integer.parseInt(formInstanceId)));
							SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
							String formatted_date = formatter1.format(sampleFormBean.getDobDate());
							log.debug(("formatted_date from DB is::" + formatted_date));
							sampleFormBean.setDob(formatted_date);
							payerFormDataMap = formAction.processFormData(sampleFormBean.getFormData(), ses);
							Set<Integer> setOfKeys = payerFormDataMap.keySet();
							for (Integer key : setOfKeys) {
								String value = payerFormDataMap.get(key);
								log.debug(("Key: " + key + ", Value: " + value));
								String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
								log.debug(("Revised Value is: " + revisedValue));
								payerFormDataMap.put(key, revisedValue);
							}
						}
						log.debug(("testing Val:" + collegeBean.getCollegeId() + " : "
								+ collegeBean.getBankDetailsOTM().getBankId() + " : " + collegeBean + " : "
								+ beanPayerType.getPayer_type()));
						ses.setAttribute("CollegeId", collegeBean.getCollegeId());
						ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
						ses.setAttribute("CollegeBean", collegeBean);
						ses.setAttribute("PayeeProfile", beanPayerType.getPayer_type());
					} catch (NullPointerException ex) {
						ex.printStackTrace();
					}
					log.debug(("Landing Page is " + formdetails.getLandingpage_srcPath()));
					if (formdetails.getLandingpage_srcPath() != null) {
						log.debug("has landing page");
						landingpage = true;
						ses.setAttribute("landingURL", formdetails.getLandingpage_srcPath());
					}
					BeanFeeDetails fee = formdetails.getFormFee();
					Double baseamt = fee.getFeeBaseAmount();

					fee = lateFeeCalculator.calculateLateFeeAsBeanFeeDetails(formdetails);

					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
					SetOptionsMap(formdetails, ses);
					SetOptionsMapforPayer(formdetails, ses);
					formdetails = this.orderStructure(formdetails);
					formdetails.setFormFee(fee);
					form = formdetails;
					ses.setAttribute("currentFee", fee);
					ses.setAttribute("feeAmt", form.getFormFee().getFeeBaseAmount());
					ses.setAttribute("currentLateFee", form.getFormFee().getLatefeeset());
					ses.setAttribute("currentFormId", form.getId());
					log.debug(("Form list :" + form.getStructureList().size()));
					char[] symbolsString1 = new char[] {};
					StringBuilder tmp = new StringBuilder();
					char ch = 'a';
					while (ch <= 'g') {
						tmp.append(ch);
						char ch1 = 'a';
						while (ch1 <= 'd') {
							tmp.append(ch1);
							symbolsString1 = tmp.toString().toCharArray();
							ch1 = (char) (ch1 + '\u0001');
						}
						ch = (char) (ch + '\u0001');
					}
					double captNumber = 5.0 + Math.random() * 5.0;
					String genCapt = String.valueOf(captNumber).substring(2, 4);
					String ranGenString = symbolsString1.toString().substring(3, 7);
					String genAlphaNum = String.valueOf(ranGenString) + genCapt;
					log.debug(("genAlphaNu is::" + genAlphaNum));
					ses.setAttribute("genAlphaNum", genAlphaNum);
					if (!landingpage || lpFlag != 1)
						break block22;
					return "LandingPageHolder";
				} catch (NumberFormatException e) {
					e.printStackTrace();
					log.debug("Form ID not parseable");
					return "error";
				}
			}
			ses.setAttribute("lpFlag", 1);
			return "PayerFormNewBatch";
		}
		log.debug("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	// <<Praveen getFormforPayer Development>> Open form with basic info and with
	// all fields of the form for the user
	@RequestMapping(value = { "/getFormforPayer" }, method = RequestMethod.GET)
	public String getFormToPay(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {
		log.debug("Start getFormToPay() method in FormBuilderController ");
		boolean staleCheckResult = true;
		CollegeBean collegeBean = new CollegeBean();
		BeanPayerType beanPayerType = new BeanPayerType();
		SampleFormBean sampleFormBean = new SampleFormBean();
		Map<Integer, String> payerFormDataMap = new HashMap<Integer, String>();
		BeanFormDetails formdetails = new BeanFormDetails();
		Set<BeanFormStructure> bfsTest=new HashSet<BeanFormStructure>();
		List<Integer> lstForTestMand=new ArrayList<Integer>();
		if (null != ses.getAttribute("formdetails")) {
			ses.removeAttribute("formdetails");
		}

		if (staleCheckResult) {
			block22: {
				//BeanFormDetails formdetails;
				boolean landingpage;
				Integer lpFlag;
				Integer sesCid;
				Integer sesBid = null;
				String formInstanceId;
				block21: {
					sesCid = 0;
					collegeBean = null;
					String formId = "";
					String formNumber = "";
					formInstanceId = "";
					lpFlag = null;
					try {
						lpFlag = Integer.parseInt(ses.getAttribute("lpFlag").toString());
						log.info("lpFlag is :::::::: " + lpFlag.toString());
					} catch (Exception e) {
						lpFlag = 1;
					}
					try {
						if (null != request.getParameter("form.id")) {
							formId = request.getParameter("form.id");
						} else {
							formId = request.getParameter("formId");
						}

						if (formId == null) {
							formId = formdetails.getId().toString();
						}
					} catch (Exception e) {
						// empty catch block
					}
					log.info(("form id from request is::" + formId));
					log.info(("lpFlag from request is::" + lpFlag));

					landingpage = false;
					formdetails = new BeanFormDetails();
					formdetails = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
					log.info("formdetails.getFormOwnerId() :::::::::: " + formdetails.getFormOwnerId().toString());

					if (formdetails.getId() != null) {
						break block21;
					}else {
						log.debug("FORM NOT FOUND");
						String errorMsg="Form Not Found Error";
						request.setAttribute("errorMsg", errorMsg);
						return "errorPage";
					}
				}
				try {
					try {

						if (null != ses.getAttribute("CollegeBean")) {
							collegeBean = (CollegeBean) ses.getAttribute("CollegeBean");
						} else {
							collegeBean = collegeService.viewInstDetail(formdetails.getFormOwnerId());
						}
						
						if (null != ses.getAttribute("BankId")) {
							sesBid = (Integer) ses.getAttribute("BankId");
						} else {
							sesBid = collegeBean.getBankDetailsOTM().getBankId();
						}
						log.info(("SesBid Is " + sesBid));

						if (null != ses.getAttribute("CollegeId")) {
							sesCid = (Integer) ses.getAttribute("CollegeId");
						} else {
							sesCid = collegeBean.getCollegeId();
						}
						log.info(("ses Cid Is " + sesCid));

						log.info(("form template id is:" + formdetails.getId()));

						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(formdetails.getPayer_type());
						
						formInstanceId = ses.getAttribute("formInstanceId") != null
								? (String) ses.getAttribute("formInstanceId")
								: "";
						
						log.info("form instance id from session is::" + formInstanceId.toString());
						if (!StringUtils.isBlank(formInstanceId) && !"null".equals(formInstanceId)) {
							log.info("came inside the if block");
							SampleFormAction formAction = new SampleFormAction();
							
							sampleFormBean = sampleFormService
									.getFormData(Integer.valueOf(Integer.parseInt(formInstanceId)));
							
							SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
							String formatted_date = formatter1.format(sampleFormBean.getDobDate());
							sampleFormBean.setDob(formatted_date);
							
							payerFormDataMap = formAction.processFormData(sampleFormBean.getFormData(), ses);
							
							Set<Integer> setOfKeys = payerFormDataMap.keySet();
							for (Integer key : setOfKeys) {
								String value = payerFormDataMap.get(key);
								//log.debug(("Key: " + key + ", Value: " + value));
								String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
								//log.debug(("Revised Value is: " + revisedValue));
								payerFormDataMap.put(key, revisedValue);
							}
						}
						log.info("this.collegeBean.getCollegeId() " + collegeBean.getCollegeId()
								+ " this.collegeBean.getBankDetailsOTM().getBankId() "
								+ collegeBean.getBankDetailsOTM().getBankId() + " beanPayerType.getPayer_type() "
								+ beanPayerType.getPayer_type());
						ses.setAttribute("CollegeId", collegeBean.getCollegeId());
						ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
						ses.setAttribute("CollegeBean", collegeBean);
						ses.setAttribute("PayeeProfile", beanPayerType.getPayer_type());
						ses.setAttribute("sampleFormBean", sampleFormBean);
					} catch (NullPointerException formDAO) {

					}
					log.debug(("Landing Page is " + formdetails.getLandingpage_srcPath()));
					if (formdetails.getLandingpage_srcPath() != null) {
						log.debug("has landing page");
						landingpage = true;
						ses.setAttribute("landingURL", formdetails.getLandingpage_srcPath());
					}
					BeanFeeDetails fee = formdetails.getFormFee();
					Double baseamt = fee.getFeeBaseAmount();

					fee = lateFeeCalculator.calculateLateFeeAsBeanFeeDetails(formdetails);

					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
					SetOptionsMap(formdetails, ses);
					SetOptionsMapforPayer(formdetails, ses);
					formdetails = orderStructure(formdetails);
					formdetails.setFormFee(fee);
					//formdetails = formdetails;
					log.debug("has instructions in form id ::: " + formdetails.getHasInstructions());
					
					ses.setAttribute("hasInstruction", formdetails.getHasInstructions());
					ses.setAttribute("formdetails", formdetails);
					ses.setAttribute("currentFee", fee);
					ses.setAttribute("feeAmt", formdetails.getFormFee().getFeeBaseAmount());
					ses.setAttribute("currentLateFee", formdetails.getFormFee().getLatefeeset());
					ses.setAttribute("currentFormId", formdetails.getId());
					log.debug(("Form list :" + formdetails.getStructureList().size()));
					
					char[] symbolsString1 = new char[] {};
					StringBuilder tmp = new StringBuilder();
					char ch = 'a';
					while (ch <= 'g') {
						tmp.append(ch);
						char ch1 = 'a';
						while (ch1 <= 'd') {
							tmp.append(ch1);
							symbolsString1 = tmp.toString().toCharArray();
							ch1 = (char) (ch1 + '\u0001');
						}
						ch = (char) (ch + '\u0001');
					}
					double captNumber = 5.0 + Math.random() * 5.0;
					String genCapt = String.valueOf(captNumber).substring(2, 4);
					String ranGenString = symbolsString1.toString().substring(3, 7);
					String genAlphaNum = String.valueOf(ranGenString) + genCapt;
					log.debug(("genAlphaNu is::" + genAlphaNum));
					ses.setAttribute("genAlphaNum", genAlphaNum);
					
					bfsTest=formdetails.getFormStructure();
					
					Iterator<BeanFormStructure> itrStr=bfsTest.iterator();
					while(itrStr.hasNext()) {
						BeanFormStructure bfs=itrStr.next();
						if(null!=bfs.getIsMandName() && bfs.getIsMandName()==1) {
							lstForTestMand.add(bfs.getId());
							log.debug("list for SP Mandatory value : "+lstForTestMand.toString());
						}else if(null!=bfs.getIsMandMobileNumber() && bfs.getIsMandMobileNumber()==2) {
							lstForTestMand.add(bfs.getId());
							log.debug("list for SP Mandatory value : "+lstForTestMand.toString());
						}else if(null!=bfs.getIsMandEmail() && bfs.getIsMandEmail()==3) {
							lstForTestMand.add(bfs.getId());
							log.debug("list for SP Mandatory value : "+lstForTestMand.toString());
						}else if(null!=bfs.getIsMandAmount() && bfs.getIsMandAmount()==4) {
							lstForTestMand.add(bfs.getId());
							log.debug("list for SP Mandatory value : "+lstForTestMand.toString());
						}else {
							log.info("It is not use for name, mobile number, email, and amount.");
						}
					}
					
					if (formdetails.getMoveToPg().contentEquals("yes")) {
						log.info("returning withoutsp temptoDelete");
						return "PayerFormNewWithOutBI";
					} else {
						log.debug("returning PayerFormNew");
					}
					
					if (!landingpage || lpFlag != 1)
						break block22;
					return "LandingPageHolder";
				} catch (NumberFormatException e) {
					e.printStackTrace();
					log.info("Form ID not parseable");
					String errorMsg="Error Msg is generated";
					request.setAttribute("errorMsg", errorMsg);
					return "errorPage";
				}
			}
			ses.setAttribute("lpFlag", 1);
			String returnString=null;
			if(null==lstForTestMand || lstForTestMand.isEmpty()) {
				log.info("It is in if block");
				returnString= "PayerFormNew";
			}else if(null!=formdetails.getValidateFieldOfExcel() || !formdetails.getValidateFieldOfExcel().isEmpty()) {
				log.info("It is in else block");
				returnString= "PayerFormNewWithOutBI";
				
			}else {
				log.info("It is in else block");
				returnString= "PayerFormNewWithOutBI";
				
			}
			return returnString;
		}
		log.info("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	@RequestMapping(value = { "/getFormforPayerByLink" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String getFormforPayerByLink(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {
		log.debug("Start getFormToPayByLink() method in FormBuilderController ");
		boolean staleCheckResult = true;
		if (staleCheckResult) {
			block22: {
				BeanFormDetails formdetails;
				boolean landingpage;
				Integer lpFlag;
				Integer sesCid;
				String formInstanceId;
				String payer_type;
				block21: {
					sesCid = 0;
					collegeBean = null;
					String formId = "";
					String formNumber = "";
					formInstanceId = "";
					try {
						formId = request.getParameter("formid");
						if (formId == null) {
							formId = this.form.getId().toString();
						}
					} catch (Exception e) {
						// empty catch block
					}
					log.debug(("form id from request is::" + formId));
					// log.debug(("lpFlag from request is::" + lpFlag));
					landingpage = false;
					formdetails = new BeanFormDetails();
					formdetails = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
					if (formdetails.getId() != null)
						break block21;
					log.debug("FORM NOT FOUND");
					return "error";
				}
				try {
					try {
						Integer sesBid = Integer.parseInt(request.getParameter("bid"));
						log.debug(("SesBid Is" + sesBid));
						sesCid = Integer.parseInt(request.getParameter("cid"));
						log.debug(("ses Cid Is" + sesCid));
						payer_type = request.getParameter("PayeeProfile");
						log.debug("now current formId : {" + formdetails.getId() + "}, bid : {" + sesBid + "}, cid : {"
								+ sesCid + "}, payerProfile : {" + payer_type);
						collegeBean = collegeService.viewCollegeDetail(sesCid);
						log.debug(("collegeBean is::::::: " + collegeBean.toString()
								+ ", and college id is ::::::::::::  " + collegeBean.getCollegeId().toString()));
						log.debug(("form template id is:" + formdetails.getId()));
						beanPayerType = daoFieldLookupService
								.getPayerLookupsBasedOnPayerId(formdetails.getPayer_type());
						log.debug("return back to formbuildercontroller and beanpayertype is ::::::::::: "
								+ beanPayerType.toString());
						log.debug("ses.getAttribute(\"formInstanceId\") :::::::::::::::::: "
								+ ses.getAttribute("formInstanceId"));
						formInstanceId = ses.getAttribute("formInstanceId") != null
								? (String) ses.getAttribute("formInstanceId")
								: "";
						log.debug("form instance id from session is::" + formInstanceId.isEmpty());
						if (!StringUtils.isBlank((String) formInstanceId) && !"null".equals(formInstanceId)) {
							log.debug("came inside the if block");
							SampleFormAction formAction = new SampleFormAction();
							sampleFormBean = sampleFormService
									.getFormData(Integer.valueOf(Integer.parseInt(formInstanceId)));
							SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");
							String formatted_date = formatter1.format(sampleFormBean.getDobDate());
							log.debug(("formatted_date from DB is::" + formatted_date));
							sampleFormBean.setDob(formatted_date);
							payerFormDataMap = formAction.processFormData(sampleFormBean.getFormData(), ses);
							Set<Integer> setOfKeys = payerFormDataMap.keySet();
							for (Integer key : setOfKeys) {
								String value = payerFormDataMap.get(key);
								log.debug(("Key: " + key + ", Value: " + value));
								String revisedValue = value.substring(value.lastIndexOf("=") + 1, value.indexOf("$"));
								log.debug(("Revised Value is: " + revisedValue));
								payerFormDataMap.put(key, revisedValue);
							}
						}
						ses.setAttribute("CollegeId", collegeBean.getCollegeId());
						ses.setAttribute("BankId", collegeBean.getBankDetailsOTM().getBankId());
						ses.setAttribute("CollegeBean", collegeBean);
						ses.setAttribute("PayeeProfile", beanPayerType.getPayer_type());
						ses.setAttribute("sampleFormBean", sampleFormBean);
					} catch (NullPointerException formDAO) {
						// empty catch block
					}
					log.debug(("Landing Page is " + formdetails.getLandingpage_srcPath()));
					if (formdetails.getLandingpage_srcPath() != null) {
						log.debug("has landing page");
						landingpage = true;
						ses.setAttribute("landingURL", formdetails.getLandingpage_srcPath());
					}
					BeanFeeDetails fee = formdetails.getFormFee();
					Double baseamt = fee.getFeeBaseAmount();

					fee = lateFeeCalculator.calculateLateFeeAsBeanFeeDetails(formdetails);

					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
					SetOptionsMap(formdetails, ses);
					SetOptionsMapforPayer(formdetails, ses);
					formdetails = orderStructure(formdetails);
					formdetails.setFormFee(fee);
					form = formdetails;
					ses.setAttribute("form", form);
					ses.setAttribute("currentFee", fee);
					ses.setAttribute("feeAmt", form.getFormFee().getFeeBaseAmount());
					ses.setAttribute("currentLateFee", form.getFormFee().getLatefeeset());
					ses.setAttribute("currentFormId", form.getId());
					log.debug(("Form list :" + form.getStructureList().size()));
					char[] symbolsString1 = new char[] {};
					StringBuilder tmp = new StringBuilder();
					char ch = 'a';
					while (ch <= 'g') {
						tmp.append(ch);
						char ch1 = 'a';
						while (ch1 <= 'd') {
							tmp.append(ch1);
							symbolsString1 = tmp.toString().toCharArray();
							ch1 = (char) (ch1 + '\u0001');
						}
						ch = (char) (ch + '\u0001');
					}
					double captNumber = 5.0 + Math.random() * 5.0;
					String genCapt = String.valueOf(captNumber).substring(2, 4);
					String ranGenString = symbolsString1.toString().substring(3, 7);
					String genAlphaNum = String.valueOf(ranGenString) + genCapt;
					log.debug(("genAlphaNu is::" + genAlphaNum));
					// log.debug(("move to pg " + formdetails.getMoveToPg())+ " form id
					// "+formdetails.getId());
					ses.setAttribute("genAlphaNum", genAlphaNum);
					// log.debug("move to pg "+formdetails.getMoveToPg());
				} catch (NumberFormatException e) {
					e.printStackTrace();
					log.debug("Form ID not parseable");
					return "error";
				}
			}
			ses.setAttribute("lpFlag", 1);
			return "PayerFormNewByLink";
		}
		log.debug("staleCheckResult fails...terminated user session");
		request.setAttribute("staleCheckResult", "fail");
		return "SessionTerminated";
	}

	@RequestMapping(value = "/getFee", method = RequestMethod.GET)
	public String GetFee(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		String selectedOptions = request.getParameter("optionArray");
		log.info("value of selectedOptions is in getFee() ::::::::::::::::: " + selectedOptions.toString());
		Double fee = CalculateFee(selectedOptions, ses);
		log.info("value of fee is in getFee is :::::::::::::::::::::::: " + fee.toString());
		request.setAttribute("fee", fee);
		ses.setAttribute("feeAmt", fee);
		return "FeeAjax";
	}

	private Double CalculateFee(String options, HttpSession ses) {
		log.debug("Open CalculateFee() Method in FormBuilderControlletr");
		Double amt = 0.0;
		BeanFeeDetails fee = (BeanFeeDetails) ses.getAttribute("currentFee");
		log.debug("Bean fee details is in this method:: fee ::::::::::: " + fee.toString());
		amt = fee.getFeeBaseAmount();
		log.info("Bean fee details is in this method:: amt ::::::::::: " + amt.toString());
		HashMap optionMap = (HashMap) ses.getAttribute("optionsMap");
		// log.debug("OptionMap values are in this method::::::::::::: "+
		// optionMap.toString());
		log.debug("options values are in this method::::::::::::: " + options);
		String[] optionsArr = options.split(",");
		log.debug("optionsArr values are in this method::::::::::::: " + optionsArr);
		ArrayList<String> optionsList = new ArrayList<String>(Arrays.asList(optionsArr));
		log.debug("optionsList is in this method::::::::::::: " + optionsList + " and size of it is :::::::::: "
				+ optionsList.size());
		try {
			int i = 0;
			while (i < optionsList.size()) {
				String[] optionData = optionsList.get(i).split("\\*");
				log.debug("optionData in the while loop ::::::::::::::::: " + optionData.length);
				for (int x = 0; x < optionData.length; x++) {
					log.debug("optionData Value is in for loop :::::::::::: " + optionData[x]);
				}
				Integer fieldId = Integer.parseInt(optionData[0].trim());
				log.debug("fieldId is in the while loop ::::::::::::::::: " + fieldId);
				String optionValue = optionData[1].trim();
				log.debug("optionValue in the while loop ::::::::::::::::: " + optionValue);
				List optionvalues = (List) optionMap.get(fieldId);
				log.debug("optionvaluesList in the while loop ::::::::::::::::: " + optionvalues);
				int j = 0;
				while (j < optionvalues.size()) {
					Integer cost;
					String valueData = ((String) optionvalues.get(j)).trim();
					String[] valueArr = valueData.split("=");
					String value = valueArr[0].trim();
					if (value.contentEquals("multi-1")) {
						cost = Integer.parseInt(valueArr[1].trim());
						Integer multiplier = Integer.parseInt(optionValue.trim());
						amt = amt + (double) (cost * multiplier);
					} else if (value.contentEquals(optionValue)) {
						cost = Integer.parseInt(valueArr[1].trim());
						amt = amt + cost.doubleValue();
					}
					++j;
				}
				++i;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return amt;
	}

	@RequestMapping(value = "/saveFieldLookup", method = RequestMethod.POST)
	public String addCustomField(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@ModelAttribute("saveField") BeanFieldLookup beanFieldLookup) {
		try {
			log.debug("set field is--->>> " + beanFieldLookup.getLookup_name() + "  "
					+ beanFieldLookup.getLookup_subtype() + "  " + beanFieldLookup.getLookup_type());
			if (beanFieldLookup.getLookup_type().equals("readonly")) {
				beanFieldLookup.setLookup_type("Input");
				beanFieldLookup.setNotification_content("readonly");
			}
			log.debug("set field is after--->>> " + beanFieldLookup.getLookup_name() + "  "
					+ beanFieldLookup.getLookup_subtype() + "  " + beanFieldLookup.getLookup_type() + "  "
					+ beanFieldLookup.getNotification_content());
			beanFieldLookup.setIsVisible(Integer.valueOf(1));
			field = daoFieldLookupService.saveField(beanFieldLookup);
			request.setAttribute("msg", "Field Saved Successfully the form builder will now reload...");
			request.setAttribute("link", "window.location='formCustomField'");
			return "successPopupforFormBuilder";
		} catch (ConstraintViolationException e) {
			request.setAttribute("msg", "Duplicate Field Name");
			request.setAttribute("link", "window.location='formCustomField'");
			return "successPopupforFormBuilder";
		}
	}

	public void SetOptionsMap(BeanFormDetails form, HttpSession ses) {

		log.debug("it is in SetOptionsMap() method");
		HashMap<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
		BeanFieldLookup field = new BeanFieldLookup();
		if (form.getId() == null) {
			return;
		}
		ArrayList structures = new ArrayList(form.getFormStructure());
		int i = 0;
		while (i < structures.size()) {
			field = ((BeanFormStructure) structures.get(i)).getFormField();
			if (field.getLookup_type().contentEquals("Select Box") || field.getLookup_type().contentEquals("Multiplier")
					|| field.getLookup_type().contentEquals("Radio Button Group")) {
				ArrayList<String> options = new ArrayList<String>();
				String optionsStr = ((BeanFormStructure) structures.get(i)).getFieldValues();
				String[] optionsArr = optionsStr.split(",");
				int j = 0;
				while (j < optionsArr.length) {
					options.add(optionsArr[j]);
					++j;
				}
				optionMap.put(((BeanFormStructure) structures.get(i)).getId(), options);
			}
			++i;
		}
		optionsMap = optionMap;
		log.debug("optionsMap value is in SetOptionsMap is ::::>>>>>>>>>::::: " + optionsMap.toString());
		ses.setAttribute("optionsMap", optionsMap);
	}

	private void SetOptionsMapforPayer(BeanFormDetails form, HttpSession ses) {
		log.debug("it is in SetOptionsMapforPayer() method");
		HashMap<Integer, List<String>> optionMap = new HashMap<Integer, List<String>>();
		BeanFieldLookup field = new BeanFieldLookup();
		if (form.getId() == null) {
			return;
		}
		ArrayList structures = new ArrayList(form.getFormStructure());
		int i = 0;
		while (i < structures.size()) {
			field = ((BeanFormStructure) structures.get(i)).getFormField();
			if (field.getLookup_type().contentEquals("Select Box") || field.getLookup_type().contentEquals("Multiplier")
					|| field.getLookup_type().contentEquals("Radio Button Group")) {
				ArrayList<String> options = new ArrayList<String>();
				String optionsStr = ((BeanFormStructure) structures.get(i)).getFieldValues();
				String[] optionsArr = optionsStr.split(",");
				int j = 0;
				while (j < optionsArr.length) {
					options.add(optionsArr[j].split("=")[0]);
					++j;
				}
				log.debug("In iteration value of i is :::::" + i + " and value of option is ::::::: "
						+ options.toString());
				optionMap.put(((BeanFormStructure) structures.get(i)).getId(), options);
				log.debug("In iteration value of i is :::::" + i + " and value of optionMap is ::::::: "
						+ optionMap.toString());
			}
			++i;
		}
		optionsMap2 = optionMap;
		log.debug("optionsMap2 value is in SetOptionsMapforPayer is ::::>>>>>>>>>::::: " + optionsMap2.toString());
		ses.setAttribute("optionsMap2", optionsMap2);
	}

	public BeanFormDetails orderStructure(BeanFormDetails form) {
		log.debug("Open orderStructure Method in FormBuilderController");
		List<BeanFormStructure> structure = new ArrayList<BeanFormStructure>(form.getFormStructure());
		Collections.sort(structure);
		form.setStructureList(structure);
		Set<BeanFormStructure> newSet = new HashSet<BeanFormStructure>(structure);
		form.setFormStructure(newSet);
		log.debug("Value of Form in oredrStructure Method :::::::::>>>>>>>>>>>>>>>>::::::::: " + form.toString());
		return form;
	}

	private ArrayList<SampleFormView> processFormView(HashMap<Integer, String> formDataMap) {
		ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
		ArrayList<Integer> keySet = new ArrayList<Integer>(formDataMap.keySet());
		int i = 0;
		while (i < keySet.size()) {
			String[] formFieldValue = formDataMap.get(keySet.get(i)).split("=");
			if (formFieldValue.length != 2) {
				log.debug("Form Field Value corrupt or Unreadable");
			} else {
				SampleFormView formViewData = new SampleFormView();
				formViewData.setLabel(formFieldValue[0]);
				formViewData.setValue(formFieldValue[1]);
				formViewList.add(formViewData);
			}
			++i;
		}
		return formViewList;
	}

	private String ListToString(List<String> optlist) {

		String optString = null;
		StringBuilder sb = new StringBuilder();
		int i = 0;
		while (i < optlist.size()) {
			sb.append(optlist.get(i));
			if (i < optlist.size() - 1) {
				sb.append(",");
			}
			++i;
		}
		optString = sb.toString();
		return optString;
	}

	@RequestMapping(value = "/addNewFormTarget", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addNewFormTarget(HttpServletRequest request) {

		log.info("work in addNewFormTarget() in collegedetailscontroller");
		HttpSession ses = request.getSession();
		CollegeBean colBean = new CollegeBean();

		if (null != request.getParameter("college_Id")) {
			log.info("updated collegeid is ::: ==========> " + request.getParameter("college_Id"));
		}
		colBean = (CollegeBean) ses.getAttribute("CollegeBean");
		ModelAndView mav = null;

		if (null != colBean) {
			log.info("colBean :::: " + colBean.getCollegeId());
			mav = new ModelAndView("addNewFormTarget");
		} else {
			mav = new ModelAndView("SessionTerminated");
		}

		return mav;

	}
	
	@RequestMapping(value = "/saveTargetPayerAction", method = RequestMethod.POST)
	public String saveTargetPayerAction(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @ModelAttribute("beanPayerType") BeanPayerType beanPayer) {

		log.info(String.valueOf(beanPayer.getPayer_type()) + ":payee Type Name");
		payers=new ArrayList<BeanPayerType>();
		ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa=new ClientMappingCodeOfSabPaisa();
		loginUser = (LoginBean) ses.getAttribute("loginUserBean");
		log.info("collegeId is ::::: " + loginUser.getCollgBean().getCollegeId() + " : and BankId is :::::::::: "+ loginUser.getCollgBean().getBankDetailsOTM().getBankId());
		
		payers = sampleFormService.getAllPayersTargetData(loginUser.getCollgBean().getCollegeId(), loginUser.getCollgBean().getBankDetailsOTM().getBankId());
		
		log.info("Payers size is : >>>>>>>>>> "+payers.size());
		
		beanPayer.setBid(loginUser.getCollgBean().getBankDetailsOTM().getBankId().toString());
		beanPayer.setCid(loginUser.getCollgBean().getCollegeId().toString());
		beanPayer.setClientName(loginUser.getCollgBean().getCollegeName());
		beanPayer.setPayer_type(beanPayer.getPayer_type());
		
		log.info("value of all :::::: " + beanPayer.getBid() + " : " + beanPayer.getCid() + " : "
				+ beanPayer.getClientName() + " : " + beanPayer.getPayer_type());
		
		beanPayer = sampleFormService.saveTargetPayerDao(beanPayer);
		log.info("Beanpayertype is before of if block :::::::::::: " + beanPayer.getPayer_type());
		
		if (payers.size() > 0) {
			clientMappingCodeOfSabPaisa.setBid(loginUser.getCollgBean().getBankDetailsOTM().getBankId().toString());
			clientMappingCodeOfSabPaisa.setCid(loginUser.getCollgBean().getCollegeId().toString());
			clientMappingCodeOfSabPaisa.setCMCode(loginUser.getCollgBean().getCollegeCode());
			clientMappingCodeOfSabPaisa.setCollegeBeanMappingToSabPaisaClient(loginUser.getCollgBean());
			clientMappingCodeOfSabPaisa.setCMProfile(beanPayer.getPayer_type());
			collegeService.saveMappingCodeOfSabPaisaDetails(clientMappingCodeOfSabPaisa);
		} else {
			collegeService.updateClientMappingCodeOfSabPaisa(beanPayer, loginUser);
		}
		
		request.setAttribute("msg", "Successfully added...");
		return "Success";
	}

	@RequestMapping(value = "/uploadLP", method = RequestMethod.GET)
	public String LPUploadAction(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws URISyntaxException, IOException {
		Integer form_id = Integer.parseInt(this.reqFormId.trim());
		String filePath = formLinkImgFloderPath;
		String ext = null;
		Integer totalFileSize = null;
		ext = FilenameUtils.getExtension((String) userImageFileName);
		totalFileSize = new File(filePath).listFiles().length;
		totalFileSize = totalFileSize + 1;
		userImageFileName = StringUtils.removeEnd((String) userImageFileName, (String) ("." + ext));
		userImageFileName = String.valueOf(userImageFileName) + "_" + "form" + form_id + "_" + totalFileSize + "."
				+ ext;
		log.debug(("userImageFileName:" + userImageFileName));
		System.out.println("Server path:" + filePath);
		log.debug(("location of :" + filePath));
		File file = new File(filePath, userImageFileName);
		log.debug(("file Name:" + file + " : userImageContentType:" + userImageContentType));
		FileUtils.copyFile((File) userImage, (File) file);
		byte[] bFile = new byte[(int) file.length()];
		try {
			FileInputStream fileInputStream = new FileInputStream(file);
			fileInputStream.read(bFile);
			fileInputStream.close();
			log.debug(("filePath:" + filePath));
			BeanFormDetails formdetails = daoFieldLookupService.getFormDetails(form_id);
			log.debug("The File was successfully moved to the new folder");
			formdetails.setLandingpage_srcPath("\\LandingPages\\" + userImageFileName.replace(" ", "_"));
			daoFieldLookupService.saveForm(formdetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", "The Landing Page has been successfully uploaded!");
		request.setAttribute("link", "window.close()");
		return "successPopup";
	}

	@RequestMapping(value = "/GetFormURL", method = RequestMethod.GET)
	public String getURL(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
			throws URISyntaxException {
		String formId = request.getParameter("reqFormId");
		StringBuffer url = request.getRequestURL();
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String urlPath = String.valueOf(url.substring(0, url.length() - uri.length() + ctx.length()))
				+ "/getFormforPayer?form.id=" + formId;
		request.setAttribute("msg", ("The Url for Microsite is: " + urlPath));
		request.setAttribute("link", "window.close()");
		return "successPopup";
	}

	private boolean checkStaleSession(String bid, String cid, String formtempid, String forminstanceid,
			HttpSession ses) {
		boolean checkResult = true;
		Integer sesBid = (Integer) ses.getAttribute("BankId");
		Integer sesCid = (Integer) ses.getAttribute("CollegeId");
		Integer formTemplateIdFromSession = (Integer) ses.getAttribute("currentFormId");
		String formInstanceIdFromSession = ses.getAttribute("formInstanceId") == null ? ""
				: (String) ses.getAttribute("formInstanceId");
		log.debug(("String.valueOf(sesBid) is evaluated to" + String.valueOf(sesBid)));
		log.debug(("String.valueOf(sesCid) is evaluated to" + String.valueOf(sesCid)));
		log.debug(("cid from client request is::" + cid));
		log.debug(("bid from client request is::" + bid));
		log.debug(("form template id from client request is::" + formtempid));
		if (sesBid != null) {
			if (!String.valueOf(sesBid).equals(bid)) {
				checkResult = false;
				log.debug(
						"ummmm, the session is not valid, courtesy the user having started a new session...bids do not match");
			}
		} else if (sesCid != null) {
			if (!String.valueOf(sesCid).equals(cid)) {
				checkResult = false;
				log.debug(
						"ummmm, the session is not valid, courtesy the user having started a new session...cids do not match");
			}
		} else if (formtempid != null) {
			if (!String.valueOf(formTemplateIdFromSession).equals(formtempid)) {
				checkResult = false;
				log.debug(
						"ummmm, the session is not valid, courtesy the user having continued with the form template in the expired session...form templates do not match");
			}
		} else if (forminstanceid != null) {
			if (!formInstanceIdFromSession.equals(forminstanceid)) {
				checkResult = false;
				log.debug(
						"ummmm, the session is not valid, courtesy the user having continued with the form instance in the expired session...form templates do not match");
			}
		} else {
			log.debug("all is well, the session is active...");
		}
		return checkResult;
	}

	@RequestMapping(value = "/InstructionDownloadForm", method = RequestMethod.GET)
	public String DownloadFileToForm(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) throws IOException {

		String ext = null;
		Object hasInstruction = null;
		Object instructions = null;
		String fileLabel = null;
		Integer totalFileSize = 0;
		String act_file_name = null;
		Integer formid = Integer.parseInt(request.getParameter("reqFormId"));
		log.debug(("formid:" + formid));
		BeanFormDetails formdetails = new BeanFormDetails();
		formdetails = daoFieldLookupService.getFormDetails(formid);
		ext = formdetails.getFile_ext();
		act_file_name = formdetails.getFile_actu_name();
		log.debug(("ext of:" + ext));
		fileLabel = formdetails.getFileLabel();
		log.debug(("fileLabel of:" + fileLabel));
		log.debug(("ext of:" + ext));
		String inst = act_file_name;
		File fileTodownload = new File(/* filePath */" ");
		fileInputStream = new FileInputStream(fileTodownload);
		fileName = String.valueOf(fileLabel) + "." + ext;
		return "Success";
	}

	@RequestMapping(value = "/formInstructionUpload", method = RequestMethod.POST)
	public String AttachFileToForm(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @ModelAttribute("formDetail") BeanFormDetails formBean,
			@ModelAttribute("userImageFile") FormFileBean fFileBean) throws IOException {
		byte[] bFile;
		String ext = null;
		Integer totalFileSize = 0;
		try {
			ext = FilenameUtils.getExtension((String) userImageFileName);
			userImageFileName = StringUtils.removeEnd((String) userImageFileName, (String) ("." + ext));
			log.debug(("userImageFileName:" + userImageFileName));
			File file = new File(/* filePath, this.userImageFileName */ "");
			log.debug(("file Name:" + file + " : userImageContentType:" + userImageContentType));
			FileUtils.copyFile((File) userImage, (File) file);
			bFile = new byte[(int) file.length()];
			try {
				FileInputStream fileInputStream = new FileInputStream(file);
				fileInputStream.read(bFile);
				fileInputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "Something went Wrong :( Please try again or contact the administrator!");
				request.setAttribute("link", "window.close()");
				return "successPopup2";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Something went Wrong :( Please try again or contact the administrator!");
			request.setAttribute("link", "window.close()");
			return "successPopup2";
		}
		ses.setAttribute("act_file_name", userImageFileName);
		formBean.setHasInstructions("img/" + userImageFileName);
		formBean.setImage(this.userImageFileName);
		formBean.setInstructions(bFile);
		fFileBean.setFile_data(bFile);
		fFileBean.setFile_extension(ext);
		form = formBean;
		formfile = fFileBean;
		ses.setAttribute("FormFileBean", formfile);
		request.setAttribute("msg", "Your File Has been Successfully Uploaded !");
		request.setAttribute("link", "window.close()");
		return "successPopup2";
	}

	@RequestMapping(value = "/formUpdationProcess", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView formUpdationProcess(HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		log.info("work in formUpdationProcess() for configuration");

		// ModelAndView mav = new ModelAndView("admin_report_consolidated");
		ModelAndView mav = new ModelAndView("client_form_update_request");
		ses = request.getSession();

		return mav;

	}

	// <<Praveen formDataAsCollegeCode Development>> use for upload new data of the
	// previous form and update late fee configuration as
	// per required by client
	@RequestMapping(value = "/formDataAsCollegeCode", method = { RequestMethod.POST, RequestMethod.GET })
	public String formDataAsCollegeCode(ModelMap model, HttpServletRequest request, HttpSession ses)
			throws SQLException {
		log.info("Finding collegeCode for updating the offline form process");

		CollegeBean colBean = new CollegeBean();
		colBean = (CollegeBean) ses.getAttribute("CollegeBean");
		String idval = (String) request.getParameter("idVal");
		Map<Integer, String> formMap = new HashMap<Integer, String>();
		String ccode = null;
		if (null != colBean && null != idval) {
			log.debug("colBean ::::: " + colBean.toString() + " :::: idval is :::::::::: " + idval);
			ccode = colBean.getCollegeCode();
			formMap = daoFieldLookupService.getFormDataAsCollegeCode(ccode);
			log.debug("formData is " + formMap.toString());
			ses.setAttribute("formMapData", formMap);
			if (idval.equalsIgnoreCase("uploaded")) {
				return "offLineFormUpdateAndNewInsert";
			} else if (idval.equalsIgnoreCase("lateFeeChange")) {
				return "feeChangeConfigurForms";
			} else {
				return "SessionTerminated";
			}
		} else {
			return "SessionTerminated";
		}
	}

	// <<Praveen findOldConfigurdLateFee Development>> use for fetch old configured
	// late fee for the form as per filled by client
	@RequestMapping(value = "/findOldConfigurdLateFee", method = { RequestMethod.POST, RequestMethod.GET })
	public String findOldConfigurdLateFee(ModelMap modelMap, HttpServletRequest request, HttpSession ses)
			throws SQLException {
		log.info("Finding Old Configurd Late Fee by findOldConfigurdLateFee() method.");

		if (null != ses.getAttribute("formIdForLateFee")) {
			ses.removeAttribute("formIdForLateFee");
		}

		String formId = (String) request.getParameter("formId");

		BeanFormDetails formDetailsForLateFee = new BeanFormDetails();
		Set<BeanLateFee> lateFee = new LinkedHashSet<BeanLateFee>();
		String returnVal = "";
		try {
			returnVal = formDataAsCollegeCode(modelMap, request, ses);
			log.info("Name of UI as returned =======> " + returnVal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if ("feeChangeConfigurForms" == returnVal && (!formId.isEmpty() || null != formId)) {

			formDetailsForLateFee = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
			log.info("Latefee StartDate {" + formDetailsForLateFee.getFormFee().getId() + "}");
			log.info("get late fee as lisiting formtae : ------------> "
					+ formDetailsForLateFee.getFormFee().getListOfLateFee());
			lateFee = formDetailsForLateFee.getFormFee().getLatefeeset();
			log.info("Latefee data for updation is =======> " + lateFee.toString());

			// ses.setAttribute("formDetailsForLateFee", lateFee);
			modelMap.addAttribute("formDetailsForLateFee", lateFee);
			modelMap.addAttribute("formIdForLateFee", formId);
			return "feeChangeConfigurForms";
		} else {
			return "SessionTerminated";
		}
	}

	// <<Praveen saveNewConfiguredLateFee Development>> use for update late fee
	// with new dates and amount for the form as per filled by client
	@RequestMapping(value = "/saveNewConfiguredLateFee", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveNewConfiguredLateFee(Model modelMap, HttpServletRequest request, HttpSession ses)
			throws SQLException, ParseException {
		log.info("update New Configured Late Fee by updateNewConfiguredLateFee() method.");
		BeanFormDetails formDetailsForLateFee = new BeanFormDetails();
		BeanFeeDetails feeDetailsForNewAdd = new BeanFeeDetails();
		BeanLateFee lateFee = new BeanLateFee();

		String feeType = "";
		feeType = (String) request.getParameter("feeType");
		String formId = (String) request.getParameter("formIdForLateFee");
		String fromdate = (String) request.getParameter("fromdate");
		String todate = (String) request.getParameter("todate");
		String feeAmount = (String) request.getParameter("feeAmount");

		Date formStartDate = null;
		Date toEndDate = null;
		log.info("(formId :" + formId + ": fromdate :" + fromdate + ": todate :" + todate + ": feeAmount :" + feeAmount
				+ ": feeType :" + feeType + ":)");

		if (null != fromdate || null != todate) {
			formStartDate = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
			toEndDate = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
		}

		if (!formId.isEmpty() || null != formId) {

			try {
				formDetailsForLateFee = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}

			// update formEndDate and formLateEndDate in Data Form Details
			formDetailsForLateFee.setFormLateEndDate(toEndDate);

			// update lateFeeStartDate, lateFeeEndDate, lateFeeAmount, lateFeeType in
			// DataLateFee
			feeDetailsForNewAdd = formDetailsForLateFee.getFormFee();
			// lateFee.setFeeDetails(feeDetailsForNewAdd);
			lateFee.setLatefeeAmount(Double.parseDouble(feeAmount));
			lateFee.setLatefeeStartdate(formStartDate);
			lateFee.setLatefeeEnddate(toEndDate);

			if (null != feeType || "" != feeType || !feeType.equals("")) {
				lateFee.setLatefeeType(feeType);
			}

			try {
				feeDetailsForNewAdd.getLatefeeset().add(lateFee);
				formDetailsForLateFee.setFormFee(feeDetailsForNewAdd);
				formDetailsForLateFee = daoFieldLookupService.saveForm(formDetailsForLateFee);// daoFieldLookupService.saveLateFee(lateFee);
			} catch (Exception e) {
				e.printStackTrace();
			}

			log.info("Latefee data for updation is =======> "
					+ formDetailsForLateFee.getFormFee().getLatefeeset().toString());

			request.setAttribute("msg", "Late Fee is Saved successfully!");
			request.setAttribute("link", "window.close()");
			return "successPopup";
		} else {
			return "SessionTerminated";
		}
	}

	// editLateFeeById
	// <<Praveen editLateFeeById Development>> use for show late fee details of
	// current id
	@RequestMapping(value = "/editLateFeeById", method = { RequestMethod.GET })
	public String getlateFeeDetailsInfo(ModelMap model, HttpServletRequest request) {
		log.info("Open getBankDetailsInfo() method for fetching configured late fee by id");
		BeanLateFee lateFeeBean = new BeanLateFee();
		Integer formId = Integer.parseInt(request.getParameter("formId"));
		log.info("New FormId is for edit : " + formId);
		// SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
		try {
			lateFeeBean = daoFieldLookupService.getLateFeeOnId(Integer.parseInt(request.getParameter("id")));
			model.put("lateFeeBean", lateFeeBean);
			model.put("formIdForThisLateFee", formId);
			return "editLateFee";
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Late Fee is not show properly! Please try again");
			// request.setAttribute("link", "window.close()");
			return "successPopup";
		}
	}

	// <<Praveen updateNewConfiguredLateFee Development>> use for update late fee
	// with new dates and amount for the form as per filled by client
	@RequestMapping(value = "/updateNewConfiguredLateFee", method = { RequestMethod.POST, RequestMethod.GET })
	public String updateNewConfiguredLateFee(Model modelMap, HttpServletRequest request, HttpSession ses)
			throws SQLException, ParseException {

		log.info("update New Configured Late Fee by updateNewConfiguredLateFee() method.");
		BeanFormDetails formDetailsForLateFee = new BeanFormDetails();
		BeanFeeDetails feeDetailsForNewAdd = new BeanFeeDetails();
		BeanLateFee lateFeeBean = new BeanLateFee();
		Set<BeanLateFee> setLateFee = new HashSet<BeanLateFee>();

		String feeType = "";
		feeType = (String) request.getParameter("latefeeType");
		String formId = (String) request.getParameter("formIdLateFee");

		String fromdate = (String) request.getParameter("fromDateStr");
		String todate = (String) request.getParameter("toDateStr");

		String feeAmount = (String) request.getParameter("latefeeAmount");
		Integer lateFeeId = Integer.parseInt(request.getParameter("id"));

		Date formStartDate = null;
		Date toEndDate = null;
		log.info("(latefeeId is :" + lateFeeId + ": formId :" + formId + ": fromdate :" + fromdate + ": todate :"
				+ todate + ": feeAmount :" + feeAmount + ": feeType :" + feeType + ":)");

		if (null != fromdate || null != todate) {
			formStartDate = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
			toEndDate = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
		}
		try {
			if (!formId.isEmpty() || null != formId) {

				formDetailsForLateFee = daoFieldLookupService.getFormDetails(Integer.valueOf(Integer.parseInt(formId)));

				// update formEndDate and formLateEndDate in Data Form Details
				// formDetailsForLateFee.setFormLateEndDate(toEndDate);

				// update lateFeeStartDate, lateFeeEndDate, lateFeeAmount, lateFeeType in
				// DataLateFee
				log.info("form id is fetched by db ::::::: " + formDetailsForLateFee.getId()
						+ " :::::: form Name ::::: " + formDetailsForLateFee.getFormName());
				feeDetailsForNewAdd = formDetailsForLateFee.getFormFee();

				setLateFee = feeDetailsForNewAdd.getLatefeeset();

				Iterator<BeanLateFee> itr = setLateFee.iterator();

				while (itr.hasNext()) {
					lateFeeBean = itr.next();
					if (lateFeeId == lateFeeBean.getId()) {

						lateFeeBean.setLatefeeAmount(Double.parseDouble(feeAmount));
						lateFeeBean.setLatefeeStartdate(formStartDate);
						lateFeeBean.setLatefeeEnddate(toEndDate);

						if (null != feeType || "" != feeType || !feeType.equals("")) {
							lateFeeBean.setLatefeeType(feeType);
						}
						try {
							lateFeeBean = daoFieldLookupService.saveLateFee(lateFeeBean);
							log.info("Latefee data for updation is =======> " + lateFeeBean.toString());
						} catch (Exception e) {
							e.printStackTrace();
						}
					} else {
						log.info("latefeeid is :: " + lateFeeId
								+ " is not matched with :: LatefeeId by fetched bean is =======> "
								+ lateFeeBean.getId());
					}
				}

				request.setAttribute("msg", "Late Fee is updated successfully!");
				// request.setAttribute("link", "window.close()");
				return "successPopup";
			} else {
				return "SessionTerminated";
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return "errorPage";
		}
	}

	public ArrayList<BeanFieldLookup> getFields() {
		return fields;
	}

	public void setFields(ArrayList<BeanFieldLookup> fields) {
		this.fields = fields;
	}

	public ArrayList<BeanFeeLookup> getFees() {
		return fees;
	}

	public void setFees(ArrayList<BeanFeeLookup> fees) {
		this.fees = fees;
	}

	public ArrayList<String> getSelectedFields() {
		return selectedFields;
	}

	public void setSelectedFields(ArrayList<String> selectedFields) {
		this.selectedFields = selectedFields;
	}

	public ArrayList<String> getSelectedFees() {
		return selectedFees;
	}

	public void setSelectedFees(ArrayList<String> selectedFees) {
		this.selectedFees = selectedFees;
	}

	public ArrayList<BeanFieldLookup> getRenderLookups() {
		return renderLookups;
	}

	public void setRenderLookups(ArrayList<BeanFieldLookup> renderLookups) {
		this.renderLookups = renderLookups;
	}

	public Map<Integer, List<String>> getOptionsMap() {
		return optionsMap;
	}

	public void setOptionsMap(Map<Integer, List<String>> optionsMap) {
		this.optionsMap = optionsMap;
	}

	public ArrayList<BeanPayerType> getPayers() {
		return payers;
	}

	public void setPayers(ArrayList<BeanPayerType> payers) {
		this.payers = payers;
	}

	public BeanFeeDetails getFee() {
		return fee;
	}

	public void setFee(BeanFeeDetails fee) {
		this.fee = fee;
	}

	public BeanLateFee getLatefee() {
		return latefee;
	}

	public void setLatefee(BeanLateFee latefee) {
		this.latefee = latefee;
	}

	public List<BeanFormDetails> getForms() {
		return forms;
	}

	public void setForms(List<BeanFormDetails> forms) {
		this.forms = forms;
	}

	public Map<Integer, List<String>> getOptionsMap2() {
		return optionsMap2;
	}

	public void setOptionsMap2(Map<Integer, List<String>> optionsMap2) {
		this.optionsMap2 = optionsMap2;
	}

	public BeanFieldLookup getField() {
		return field;
	}

	public void setField(BeanFieldLookup field) {
		this.field = field;
	}

	public List<CollegeBean> getColleges() {
		return colleges;
	}

	public void setColleges(List<CollegeBean> colleges) {
		this.colleges = colleges;
	}

	public LoginBean getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(LoginBean loginUser) {
		this.loginUser = loginUser;
	}

	public List<SubInstitute> getSubcolleges() {
		return subcolleges;
	}

	public void setSubcolleges(List<SubInstitute> subcolleges) {
		this.subcolleges = subcolleges;
	}

	public BeanPayerType getBeanPayerType() {
		return beanPayerType;
	}

	public void setBeanPayerType(BeanPayerType beanPayerType) {
		this.beanPayerType = beanPayerType;
	}

	public CollegeBean getCollegeBean() {
		return collegeBean;
	}

	public void setCollegeBean(CollegeBean collegeBean) {
		this.collegeBean = collegeBean;
	}

	public ClientMappingCodeOfSabPaisa getClientMappingCodeOfSabPaisa() {
		return clientMappingCodeOfSabPaisa;
	}

	public void setClientMappingCodeOfSabPaisa(ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa) {
		this.clientMappingCodeOfSabPaisa = clientMappingCodeOfSabPaisa;
	}

	public File getLandingPage() {
		return landingPage;
	}

	public void setLandingPage(File landingPage) {
		this.landingPage = landingPage;
	}

	public String getReqFormId() {
		return reqFormId;
	}

	public void setReqFormId(String reqFormId) {
		this.reqFormId = reqFormId;
	}

	public Map<Integer, String> getPayerFormDataMap() {
		return payerFormDataMap;
	}

	public void setPayerFormDataMap(Map<Integer, String> payerFormDataMap) {
		this.payerFormDataMap = payerFormDataMap;
	}

	public SampleFormBean getSampleFormBean() {
		return sampleFormBean;
	}

	public void setSampleFormBean(SampleFormBean sampleFormBean) {
		this.sampleFormBean = sampleFormBean;
	}

	public CollegeService getCollegeService() {
		return collegeService;
	}

	public void setCollegeService(CollegeService collegeService) {
		this.collegeService = collegeService;
	}

	public DaoFeeService getDaoFeeService() {
		return daoFeeService;
	}

	public void setDaoFeeService(DaoFeeService daoFeeService) {
		this.daoFeeService = daoFeeService;
	}

	public DaoFieldLookupService getDaoFieldLookupService() {
		return daoFieldLookupService;
	}

	public void setDaoFieldLookupService(DaoFieldLookupService daoFieldLookupService) {
		this.daoFieldLookupService = daoFieldLookupService;
	}

	public SampleFormService getSampleFormService() {
		return sampleFormService;
	}

	public void setSampleFormService(SampleFormService sampleFormService) {
		this.sampleFormService = sampleFormService;
	}

	public BeanFormDetails getForm() {
		return form;
	}

	public void setForm(BeanFormDetails form) {
		this.form = form;
	}

	public AppPropertiesConfig getAppProperties() {
		return appProperties;
	}

	public void setAppProperties(AppPropertiesConfig appProperties) {
		this.appProperties = appProperties;
	}

	public String getFormLinkImgFloderPath() {
		return formLinkImgFloderPath;
	}

	public void setFormLinkImgFloderPath(String formLinkImgFloderPath) {
		this.formLinkImgFloderPath = formLinkImgFloderPath;
	}

	public void setFileInputStream(InputStream fileInputStream) {
		this.fileInputStream = fileInputStream;
	}

	public InputStream getFileInputStream() {
		return fileInputStream;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public File getUserImage() {
		return userImage;
	}

	public void setUserImage(File userImage) {
		this.userImage = userImage;
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

	public SubInstitute getSubInstitutebean() {
		return subInstitutebean;
	}

	public void setSubInstitutebean(SubInstitute subInstitutebean) {
		this.subInstitutebean = subInstitutebean;
	}

	public FormFileBean getFormfile() {
		return formfile;
	}

	public void setFormfile(FormFileBean formfile) {
		this.formfile = formfile;
	}

	public List<BeanFormDetails> getInstructionList() {
		return instructionList;
	}

	public void setInstructionList(List<BeanFormDetails> instructionList) {
		this.instructionList = instructionList;
	}

	public ArrayList<Integer> getExcelFieldList() {
		return excelFieldList;
	}

	public void setExcelFieldList(ArrayList<Integer> excelFieldList) {
		this.excelFieldList = excelFieldList;
	}

	public ArrayList<Integer> getFieldIds() {
		return fieldIds;
	}

	public void setFieldIds(ArrayList<Integer> fieldIds) {
		this.fieldIds = fieldIds;
	}

}