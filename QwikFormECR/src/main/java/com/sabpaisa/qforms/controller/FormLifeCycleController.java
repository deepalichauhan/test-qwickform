package com.sabpaisa.qforms.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormActionsBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.beans.formLifeCycleDTO;
import com.sabpaisa.qforms.services.ActorService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LifeCycleService;
import com.sabpaisa.qforms.services.OffLineFormService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.util.DBConnection;

@CrossOrigin
@Controller
@RequestMapping
public class FormLifeCycleController {

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;
	
	@Autowired
	private LifeCycleService lifeCycleService;
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private SampleFormService sampleFormService;
	
	@Autowired
	private CollegeService collegeService;
	
	@Autowired
	private OffLineFormService offLineFormService; 
	
	@Autowired
	SessionFactory factory;
	
	private static Logger log = LogManager.getLogger(FormLifeCycleController.class.getName());
	private ArrayList<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	List<FormLifeCycleBean> formCycles=new ArrayList<FormLifeCycleBean>();
	List<ActorBean>actors=new ArrayList<ActorBean>();
	List<FormActionsBean>formactions=new ArrayList<FormActionsBean>();
	DBConnection connection = new DBConnection();	
	Integer stageCount;
		
	private BeanFormDetails form;
	
	@RequestMapping(value="/getLifeCycleForm",method = RequestMethod.GET)
	public String prepareLifeCycleForm(Model modelm, HttpServletRequest request, HttpServletResponse response, HttpSession ses)
	{
		log.info("Open getlifecycleforms method:::::::::::::::: ");
		Integer formId = Integer.parseInt(request.getParameter("reqFormId"));
		log.debug("formId is in method :::::::::::: "+formId.toString());
		
        ses.setAttribute("sesFormId", formId);
        
        List<ActorBean> actorsList = new ArrayList<ActorBean> ();
	    
	    try
	    {
	      CollegeBean clientBean = (CollegeBean)ses.getAttribute("CollegeBean");
	      log.debug("College Baen is ::::::::: "+clientBean.toString());
	      Integer client_id = clientBean.getCollegeId();
	      log.debug("Getting actors for client id " + client_id);
	      actorsList = actorService.getActors("REVIEWER", client_id);
	      log.debug("Got " + actorsList.size() + " actors for client id " + client_id);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }

        actors = actorsList;
        log.debug("a "+actors.size());
        log.debug("Now actors List is ::::::::: "+actors.toString());
        
        formactions = lifeCycleService.getFormActions();
        log.debug("Now formactions List is ::::::::: "+formactions.toString());
        
        ses.setAttribute("actors", actors);
        ses.setAttribute("formactions", formactions);
        this.stageCount = 1;
		return "LifeCycleForm";
	}
	
	@RequestMapping(value="/addStageToLifeCycleForm",method = RequestMethod.GET)
	public String addStage(Model model,HttpServletRequest request, HttpServletResponse response, HttpSession ses)
	{
		actors = (List)ses.getAttribute("actorList");
        formactions = (List)ses.getAttribute("formactions");
        stageCount = Integer.parseInt(request.getParameter("reqStageCount"));
        log.debug("Requested stage count is ::::::::: "+stageCount.toString());
        ses.setAttribute("stageCount", stageCount);
        
		return "LifeCycleFormStage";
	}
	
	@RequestMapping(value="/getFormCycle",method = {RequestMethod.GET,RequestMethod.POST})
	public String getFormCycle(HttpServletRequest request, HttpServletResponse response, HttpSession ses)
	{
		try {
            Integer formid = Integer.parseInt(request.getParameter("reqFormId").trim());
            log.debug("get form life cycle is "+formid);
            form = daoFieldLookupService.getFormDetails(formid);
            List<FormLifeCycleBean> cycles_with_actors = new ArrayList<FormLifeCycleBean>(this.form.getFormcycles());
            cycles_with_actors = getActorsForCycles(cycles_with_actors);
            log.debug("cycles_with_actors size "+cycles_with_actors.size());
            form.setFormcycles(new HashSet<FormLifeCycleBean>(cycles_with_actors));
            
            ses.setAttribute("form", form);
			return "FormLifeCycleDetails";
		}
		catch(Exception e)
		{
			return "error";
		}
	}
	
	@RequestMapping(value="/showFormData",method = RequestMethod.POST)
	public String showFormForReview(HttpServletRequest request, HttpServletResponse response, HttpSession ses)
	{
		 FormStateBean statebean = new FormStateBean();
	        try {
	            Integer stateid = Integer.parseInt(request.getParameter("reqStateId").trim());
	            statebean = lifeCycleService.getFormState(stateid);
	            SampleFormBean formdata = sampleFormService.getFormData(statebean.getForm_instance_id());
	            ses.setAttribute("sesFormStateBean", statebean);
	            ses.setAttribute("sesFormDataBean", formdata);
			return "formDetails-Actor";
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return "ERROR";
		}
	}
	
	public List<FormLifeCycleBean> getActorsForCycles(List<FormLifeCycleBean> cycles)
	{
		int i = 0;
        while (i < cycles.size()) {
        	log.debug("actor id while fetching is "+cycles.get(i).getActor_id());
            cycles.get(i).setActor(this.actorService.getActors(cycles.get(i).getActor_id()));
            ++i;
        }
        return cycles;
	}

	@RequestMapping(value = { "/GetPendingForms" }, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView GetPendingForms(HttpServletRequest request, SuperAdminBean superAdmin) {
		
		HttpSession ses=request.getSession();
		ModelAndView mav = null;
		String key = "";
		superAdmin = ((SuperAdminBean) ses.getAttribute("sABean"));
		Integer compID = (Integer) ses.getAttribute("sesCID");
		
		
		if(null== superAdmin || superAdmin.equals(null) ||superAdmin.equals("") ||superAdmin.equals("null")) {
			mav = new ModelAndView("SessionTerminated");
		}else {
			forms = new ArrayList(daoFieldLookupService.getForms("status", "NEW"));
			if (null != forms) {
				//log.debug("value of forms in list as : >>>>>>>>>>>>>>>>>>>>>>" + forms.toString());
				mav = new ModelAndView("saPortalPendingForms");
				mav.addObject("pendingFormsList", forms);
			}
			
		}
		return mav;
		
	}
	
	@RequestMapping(value = { "/getAllForms" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String GetAllForms(HttpServletRequest request, HttpSession ses, ModelMap model) {
		SuperAdminBean superAdmin=null;
		ArrayList<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
		String returnVal="";
		try {
			superAdmin = ((SuperAdminBean) ses.getAttribute("sABean"));
			Integer compID = (Integer) ses.getAttribute("sesCID");
			
			if(null== superAdmin || superAdmin.equals(null) ||superAdmin.equals("") ||superAdmin.equals("null")) {
				returnVal="SessionTerminated";
			}else {
				log.info("Comp Id is in else block" + compID);
				//log.debug("superadminbean is in else block:: "+superAdmin.toString());
				
				forms = new ArrayList(daoFieldLookupService.getForms("ALL", null));
				
				ses.setAttribute("allForms", forms);
				returnVal="saPortal-AllForms";
			}
			
		} catch (NullPointerException ex) {
			log.debug("exception in getting forms::" + ex);
			return "invalid_token";
		}
		return returnVal;
	}

	@RequestMapping(value = { "/approveform", "/approveForm2" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String ApproveForm(HttpServletRequest request, HttpServletResponse response, HttpSession ses, Model model)
			throws Exception {
		log.info("Open ApproveForm() Method in MainLoginController");
		log.debug("form id is = " + request.getParameter("formid"));
		ArrayList<String> columnListOfFirstRow=new ArrayList<String>();
		
		columnListOfFirstRow=(ArrayList<String>) ses.getAttribute("columnListOfFirstRow");
				
		String formIds = request.getParameter("formid");
		String formOwnerName;
		String uploadFlag="";
		String formName="";
		Connection con = null;
		try {
			Integer id = Integer.valueOf(Integer.parseInt(request.getParameter("formid").trim()));
			BeanFormDetails form = new BeanFormDetails();
			form = daoFieldLookupService.getFormDetails(id);
			
			form.setStatus("APPROVED");
			form.setStatus_by(Integer.valueOf(-1));
			
			log.debug("during approving the form " + form.getCompanyBean().getId());
			log.info("getFormOwnerName " + form.getFormOwnerName());
			
			formOwnerName = form.getFormOwnerName();
			
			//log.debug("getFormOwnerName-- " + formOwnerName);
			//log.debug("getLife_cycle()-- " + form.getLife_cycle());
			
			if (form.getLife_cycle().contentEquals("yes")) {
				FormLifeCycleBean firstCycle = lifeCycleService.getFormCycle(Integer.valueOf(0), form.getId());
				form.setTarget_actor(firstCycle.getActor_id());
			}

			String tempTableName = "zz_client_user_data_" + form.getId();
			log.info("Table Name is =" + tempTableName);
			
			Boolean CreateDBflag = Boolean.valueOf(false);
			
			CreateDBflag=lifeCycleService.checkTableExit(tempTableName);
			
			log.debug("CreateDBflag is ::::::: "+CreateDBflag.toString());
			 
			Boolean tableCreationError = Boolean.valueOf(false);
			
			if (CreateDBflag.booleanValue()) {
				FormBuilderController actionsFormBuilder = new FormBuilderController();
				actionsFormBuilder.SetOptionsMap(form,ses);
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
					log.debug("generate column names ::" + string2);

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
				
				log.info("generated all column names ::" + dynSQL);
				tableCreationError=daoFieldLookupService.creatDynamicTable(dynSQL, tempTableName);
				log.debug("tableCreationError ::::: "+tableCreationError.toString());
			}
			formName=form.getFormName();
			log.debug("formName is for creating new table is ::::::: "+formName);
			
			if (tableCreationError.booleanValue()) {
				request.setAttribute("errorMsg",
						"There were some issues with the fields defintions in the form, so the form could not be approved, please review the fields or contact your administrator!!");
				log.info(
						"There were some issues with the fields defintions int he form, so the form could not be approved, please review the fields or contact your administrator!!");
				return "errorPage";
			}
			
			if(columnListOfFirstRow!=null && !form.getValidateFieldOfExcel().isEmpty() 
					&& !form.getValidateFieldOfExcel().equals(null) && form.getValidateFieldOfExcel()!="") {
				log.debug("columnListOfFirstRow id is = " + columnListOfFirstRow.toString());
				log.debug("columnListOfFirstRow size is = " + columnListOfFirstRow.size());
				uploadFlag = offLineFormService.generateTempTable(columnListOfFirstRow, tempTableName, ses, formName, form.getFormOwnerName());
				ses.removeAttribute("columnListOfFirstRow");
			}
			form = daoFieldLookupService.saveForm(form);
			List<CollegeBean> collegeBeans = new ArrayList<>();
			collegeBeans = collegeService.getCollegeDetailsBasedOnCode(form.getFormOwnerName());
			log.debug("colleage bean is "
					+ collegeBeans.get(0).getCollegeId());
			Boolean sendUrlTOCob = false;
			
			log.debug("send url to cob " + sendUrlTOCob);
			
			log.info("finished calling sendurltocob ");
			log.debug("UploadFlag value is :::::::::: "+uploadFlag);
			
			if (uploadFlag == "tableCreationError" || uploadFlag == "paymentCycleError" || uploadFlag == "excelError"
					|| uploadFlag == "fail") {
				request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
				return "OffLineFormUpload";
			}
			
			if (uploadFlag == "dbError") {

				request.setAttribute("msg", "Data is not correct in file, please try again.");
				log.debug("End of addBulkRecord() method , File Upload Status is >> dbError failure");
				return "OffLineFormUpload";

			} else if(uploadFlag==""){
				request.setAttribute("msg", "Record Uploaded Successfully");
				
					log.debug("End of addBulkRecord() method , File Upload Status is >> setup");
					return "Success";
			}else {
				request.setAttribute("msg", "Record Uploaded Successfully");
				
				log.debug("ReturnMSG " + ses.getAttribute("fieldValidationFlag") + "\\\\" + uploadFlag);
				if (ses.getAttribute("fieldValidationFlag").equals("Y") && uploadFlag.equals("success")) {
					log.debug("End of addBulkRecord() method , File Upload Status is >> setup");
					return "Success";
				}
				log.debug("End of addBulkRecord() method , File Upload Status is >> SUCCESS");
				return "OffLineFormUpload";
			}
			
		} catch (NumberFormatException e) {
			log.debug("Could not parse form id from request");
		}
		finally {
			
		}
		return "errorPage";
	}
	
	@RequestMapping(value = { "/disapproveForm", "/disapproveForm2" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String DisapproveForm(HttpServletRequest request, ModelMap model) {
		log.info("Open DisapprovedForm() method");
		try {
			Integer id = Integer.valueOf(Integer.parseInt(request.getParameter("formid").trim()));
			String comm = request.getParameter("comment");
			BeanFormDetails form = new BeanFormDetails();
			form = daoFieldLookupService.getFormDetails(id);
			form.setStatus("DISAPPROVED");
			form.setStatus_by(Integer.valueOf(-1));
			form.setSaComment(comm);
			form = daoFieldLookupService.saveForm(form);
			return "Success";
		} catch (NumberFormatException e) {
			log.info("Could not parse form id from request");
		}
		return "error";
	}
	
	@RequestMapping(value = { "/reportCheckingOnDisapprovedForm"}, method = { RequestMethod.GET, RequestMethod.POST })
	public String reportCheckingOnDisapprovedForm(HttpServletRequest request, ModelMap model) {
		log.info("Open reportCheckingOnDisapprovedForm() method ");
		try {
			Integer id = Integer.valueOf(Integer.parseInt(request.getParameter("formid").trim()));
			String comm = request.getParameter("comment");
			log.info("finded form id is :- "+id+" and comment is :- "+comm);
			BeanFormDetails form = new BeanFormDetails();
			form = daoFieldLookupService.getFormDetails(id);
			form.setStatus("REPORT");
			form.setStatus_by(Integer.valueOf(-1));
			form.setSaComment(comm);
			form = daoFieldLookupService.saveForm(form);
			return "Success";
		} catch (NumberFormatException e) {
			log.info("Could not parse form id from request");
		}
		return "error";
	}
	
	public Integer getSheetCounter(String tempTableName) {
		Integer sheetNo = 0;
		Connection conn = null;
		Statement stmt = null;
		try {

			conn = connection.getConnectionApp();
			stmt = conn.createStatement();

			String sql = "SELECT form_Name FROM " + tempTableName;
			ResultSet rs = stmt.executeQuery(sql);
			// STEP 5: Extract data from result set
			while (rs.next()) {
				// Retrieve by column name
				int id = rs.getInt("form_Name");
				log.debug(" id is = " + id);
				sheetNo = id;
			}
			rs.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException see) {
					see.printStackTrace();
				}

			}
		}
		return sheetNo;
	}
	
	public List<FormLifeCycleBean> getFormCycles() {
		return formCycles;
	}

	public void setFormCycles(List<FormLifeCycleBean> formCycles) {
		this.formCycles = formCycles;
	}

	public List<ActorBean> getActors() {
		return actors;
	}

	public void setActors(List<ActorBean> actors) {
		this.actors = actors;
	}

	public List<FormActionsBean> getFormactions() {
		return formactions;
	}

	public void setFormactions(List<FormActionsBean> formactions) {
		this.formactions = formactions;
	}

	public Integer getStageCount() {
		return stageCount;
	}

	public void setStageCount(Integer stageCount) {
		this.stageCount = stageCount;
	}

	public BeanFormDetails getForm() {
		return form;
	}

	public void setForm(BeanFormDetails form) {
		this.form = form;
	}

	public DaoFieldLookupService getDaoFieldLookupService() {
		return daoFieldLookupService;
	}

	public void setDaoFieldLookupService(DaoFieldLookupService daoFieldLookupService) {
		this.daoFieldLookupService = daoFieldLookupService;
	}

	public LifeCycleService getLifeCycleService() {
		return lifeCycleService;
	}

	public void setLifeCycleService(LifeCycleService lifeCycleService) {
		this.lifeCycleService = lifeCycleService;
	}

	public ActorService getActorService() {
		return actorService;
	}

	public void setActorService(ActorService actorService) {
		this.actorService = actorService;
	}

	public SampleFormService getSampleFormService() {
		return sampleFormService;
	}

	public void setSampleFormService(SampleFormService sampleFormService) {
		this.sampleFormService = sampleFormService;
	}

}
