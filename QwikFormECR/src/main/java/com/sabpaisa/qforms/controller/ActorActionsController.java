package com.sabpaisa.qforms.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.formLifeCycleDTO;
import com.sabpaisa.qforms.communication.EmailSessionBean;
import com.sabpaisa.qforms.services.ActorService;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.MainLoginService;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.RandomPasswordGenerator;

@CrossOrigin
@Controller
@RequestMapping
public class ActorActionsController {

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	@Autowired
	private CollegeService collegeService;

	@Autowired
	private MainLoginService mainLoginService;

	@Autowired
	private DaoFieldLookupService formdao;

	@Autowired
	private ActorService actdao;

	List<FormLifeCycleBean> formCycles = new ArrayList<FormLifeCycleBean>();

	public CollegeService getCollegeDao() {
		return collegeService;
	}

	public void setCollegeDao(CollegeService collegeDao) {
		this.collegeService = collegeDao;
	}

	public DaoFieldLookupService getFormdao() {
		return formdao;
	}

	public void setFormdao(DaoFieldLookupService formdao) {
		this.formdao = formdao;
	}

	public ActorService getActdao() {
		return actdao;
	}

	public void setActdao(ActorService actdao) {
		this.actdao = actdao;
	}

	public LoginDAOService getLoginDAOService() {
		return loginDAOService;
	}

	public void setLoginDAOService(LoginDAOService loginDAOService) {
		this.loginDAOService = loginDAOService;
	}

	@Autowired
	private LoginDAOService loginDAOService;

	private static Logger log = LogManager.getLogger(ActorActionsController.class.getName());

	public Integer sel_client_id;
	public Integer sel_actor_id;
	String actor_profile;

	private List<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
	private List<FormStateBean> forms_from_instance = new ArrayList<FormStateBean>();
	private List<SampleFormBean> formsdata = new ArrayList<SampleFormBean>();
	private List<ActorBean> actors = new ArrayList<ActorBean>();
	private ActorBean actor;

	private ClientMappingCodeOfSabPaisa clientMappingBean = new ClientMappingCodeOfSabPaisa();

	public ClientMappingCodeOfSabPaisa getClientMappingBean() {
		return clientMappingBean;
	}

	public void setClientMappingBean(ClientMappingCodeOfSabPaisa clientMappingBean) {
		this.clientMappingBean = clientMappingBean;
	}

	@RequestMapping(value = "/actorform", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actorform(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		ModelAndView mav = new ModelAndView("ActorForm");

		return mav;
	}

	@RequestMapping(value = "/getClientActors", method = { RequestMethod.GET, RequestMethod.POST })
	public String getClientActors(Model model, HttpSession ses) {

		CollegeBean clientBean = (CollegeBean) ses.getAttribute("CollegeBean");
		String returnVal = "";
		// LDFGJDFDJFVXDFVZDFV
		if (null != clientBean) {
			actors = GetCurrentClientActors(ses);
			ses.setAttribute("actors", actors);
			returnVal = "clientActors";
		} else {
			returnVal = "SessionTerminated";
		}
		return returnVal;
	}

	@RequestMapping(value = "/saveActor", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveActor(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@ModelAttribute("actor") ActorBean actors) {

		CollegeBean clientBean = new CollegeBean();
		try {

			log.debug("profile of actor  is :::::::::: " + actors.getProfile() + " alias ::::::::: "
					+ actors.getActor_alias() + " email ::::::::: " + actors.getEmail());
			if (actors.getProfile().contentEquals("REVIEWER")) {
				/*
				 * if (actdao.checkActorAlias(actor.getActor_alias())) {
				 * request.setAttribute("msg",
				 * "Actor name is already used.. please select an alias for this user!");
				 * request.setAttribute("link", "window.history.back()"); return "error"; } if
				 * (actdao.checkActorEmail(actor.getEmail())) { request.setAttribute("msg",
				 * "Email already in use!"); request.setAttribute("link",
				 * "window.history.back()"); return "error"; }
				 */
				if (loginDAOService.checkUsername(actors.getEmail())) {
					request.setAttribute("msg", "Username already in use!");
					request.setAttribute("link", "window.history.back()");
					return "error";
				}

				LoginBean creds = new LoginBean();
				creds.setActorBean(actors);
				log.debug("loginbean is in ActorActionController as actor ::::::: " + creds.getActorBean());
				String pass = String.valueOf(RandomPasswordGenerator.generatePswd(8, 15, 1, 1, 1));
				log.debug("password is in ActorActionController for actor ::::::: " + pass.toString());

				PasswordEncryption.encrypt(pass);
				String encryptedPwd = PasswordEncryption.encStr;
				log.debug(
						"PasswordEncryption is in ActorActionController for actor ::::::: " + encryptedPwd.toString());
				creds.setUserName(actors.getEmail());
				creds.setPassword(encryptedPwd);
				creds.setProfile("actors");
				log.debug("loginbean detail as username= ::: " + creds.getUserName() + " and password= ::::"
						+ creds.getPassword() + " and profile is= :::: " + creds.getProfile());

				loginDAOService.saveCreds(creds);

				EmailSessionBean mailSender = new EmailSessionBean();
				mailSender.sendEEmail(actors.getEmail(), "QForms Login Credentials", actors.getEmail(), pass,
						actors.getActor_alias());
			}
			clientBean = (CollegeBean) ses.getAttribute("CollegeBean");
			log.debug("Adding actor to client id " + clientBean.getCollegeId());
			clientBean = collegeService.viewInstDetail(clientBean.getCollegeId());
			log.debug("clientBean is :::::::::: " + clientBean.toString() + " and College id is ::::: "
					+ clientBean.getCollegeId());

			actors.setClient_id(clientBean.getCollegeId());
			actor = actors;

			clientBean.getActors().add(actor);
			// clientBean = collegeService.registerClientDetailsDao(clientBean);
			clientBean = collegeService.saveClientDetails(clientBean);

			clientMappingBean.setCMCode(clientBean.getCollegeCode());
			clientMappingBean.setCMProfile(actor.getActor_id() + "$actor");

			try {
				collegeService.saveSabPaisaClientMappingDetailsDao(clientBean, clientMappingBean);
			} catch (Exception ex) {
				log.error("Client mapping is not saved properly");
				ex.printStackTrace();
			}

			request.setAttribute("msg", "Actor successfully added to system!");
			request.setAttribute("link", "window.close()");
			return "successPopup";
		} catch (Exception e) {
			log.error("Actor Detail is not saved as per given client.");
			e.printStackTrace();
		}
		return "successPopup";
	}

	@RequestMapping(value = "/LoginActor", method = { RequestMethod.GET, RequestMethod.POST })
	public String getPendingTasks(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		String payerUsername = " ";
		try {
			payerUsername = (String) ses.getAttribute("PayerUsername");
			ActorBean actorbean = (ActorBean) ses.getAttribute("ActorBean");
			CollegeBean clientbean = new CollegeBean();
			clientbean = collegeService.getClientDetailsBasedOnId(actorbean.getClient_id().intValue());
			ses.setAttribute("CollegeBean", clientbean);
			ses.setAttribute("BankId", clientbean.getBankDetailsOTM().getBankId());
			ses.setAttribute("CollegeId", clientbean.getCollegeId());
			if (actorbean.getProfile().contentEquals("PAYER")) {
				forms_from_instance = formdao.getPendingFormsFromInstance(actorbean.getActor_id(), payerUsername);
			} else {
				forms = formdao.getPendingFormsFromTemplate(actorbean.getActor_id());
				forms_from_instance = formdao.getPendingFormsFromInstance(actorbean.getActor_id());
			}

			return "actor_pending_calist";
		} catch (Exception e) {
			log.error("Client details is not matched.");
			e.printStackTrace();
		}
		return "error";
	}

	public List<ActorBean> GetCurrentClientActors(HttpSession ses) {
		log.debug("open GetCurrentClientActors() method");
		List<ActorBean> actorsList = new ArrayList<ActorBean>();
		CollegeBean clientBean = (CollegeBean) ses.getAttribute("CollegeBean");
		log.debug("College Baen is ::::::::: " + clientBean.toString());
		Integer client_id = clientBean.getCollegeId();
		try {
			log.info("Getting actors for client id " + client_id);
			actorsList = actdao.getActors("REVIEWER", client_id);
			log.debug("Got " + actorsList.size() + " actors for client id " + client_id);
		} catch (Exception e) {
			log.error("actors detail is not find for this client id " + client_id);
			e.printStackTrace();
		}
		log.debug("End GetCurrentClientActors() method");
		return actorsList;
	}

	public List<ActorBean> GetCurrentClientActorss(Integer client_id) {
		List<ActorBean> actorsList = new ArrayList<ActorBean>();

		try {
			// CollegeBean clientBean = (CollegeBean)ses.getAttribute("CollegeBean");
			// Integer client_id = clientBean.getCollegeId();
			log.info("Getting actors for client id " + client_id);
			actorsList = actdao.getActors("REVIEWER", client_id);
			if (null != actorsList) {
				log.debug("Got " + actorsList.size() + " actors for client id " + client_id);
			}
		} catch (Exception e) {
			log.error("actors detail is not find for this client id " + client_id);
			e.printStackTrace();
		}
		return actorsList;
	}

	public String verifyUser(HttpServletRequest request, HttpSession ses) {
		try {
			Integer actorId = Integer.valueOf(Integer.parseInt(request.getParameter("actid").trim()));
			ses.setAttribute("verifyUserId", actorId);
			return "success";
		} catch (Exception e) {
		}
		return "error";
	}

	@RequestMapping(value = "/saveFormLifeCycle", method = RequestMethod.POST)
	public String saveFormLifeCycle(HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@ModelAttribute("formCycles") formLifeCycleDTO flcBeanDto) {
		formCycles = new ArrayList<FormLifeCycleBean>();
		formCycles = flcBeanDto.getFlcBean();
		log.debug((Object) ("Number of Form Stages : " + formCycles.size()));
		Integer formid = (Integer) ses.getAttribute("sesFormId");
		log.debug("formid is >>>>>> " + formid);
		BeanFormDetails form = daoFieldLookupService.getFormDetails(formid);
		form.setFormcycles(new HashSet<FormLifeCycleBean>(formCycles));
		int j = 0;
		while (j < formCycles.size()) {
			formCycles.get(j).setForm_id(formid);
			formCycles.get(j).setForm_status("PENDING");
			if (j == formCycles.size() - 1) {
				formCycles.get(j).setForm_status("COMPLETE");
			}
			++j;
		}
		form.setStatus("NEW");
		daoFieldLookupService.updateForm(formid, form.getStatus());
		request.setAttribute("msg", (Object) "Life Cycle successfully configured!");
		request.setAttribute("link", (Object) "window.close()");
		return "successPopup";
	}

	public DaoFieldLookupService getDaoFieldLookupService() {
		return daoFieldLookupService;
	}

	public void setDaoFieldLookupService(DaoFieldLookupService daoFieldLookupService) {
		this.daoFieldLookupService = daoFieldLookupService;
	}

	public CollegeService getCollegeService() {
		return collegeService;
	}

	public void setCollegeService(CollegeService collegeService) {
		this.collegeService = collegeService;
	}

	public MainLoginService getMainLoginService() {
		return mainLoginService;
	}

	public void setMainLoginService(MainLoginService mainLoginService) {
		this.mainLoginService = mainLoginService;
	}

	public List<FormLifeCycleBean> getFormCycles() {
		return formCycles;
	}

	public void setFormCycles(List<FormLifeCycleBean> formCycles) {
		this.formCycles = formCycles;
	}

	public Integer getSel_client_id() {
		return sel_client_id;
	}

	public void setSel_client_id(Integer sel_client_id) {
		this.sel_client_id = sel_client_id;
	}

	public Integer getSel_actor_id() {
		return sel_actor_id;
	}

	public void setSel_actor_id(Integer sel_actor_id) {
		this.sel_actor_id = sel_actor_id;
	}

	public List<BeanFormDetails> getForms() {
		return forms;
	}

	public void setForms(List<BeanFormDetails> forms) {
		this.forms = forms;
	}

	public String getActor_profile() {
		return actor_profile;
	}

	public void setActor_profile(String actor_profile) {
		this.actor_profile = actor_profile;
	}

	public List<SampleFormBean> getFormsdata() {
		return formsdata;
	}

	public void setFormsdata(List<SampleFormBean> formsdata) {
		this.formsdata = formsdata;
	}

	public List<ActorBean> getActors() {
		return actors;
	}

	public void setActors(List<ActorBean> actors) {
		this.actors = actors;
	}

	public ActorBean getActor() {
		return actor;
	}

	public void setActor(ActorBean actor) {
		this.actor = actor;
	}

	public List<FormStateBean> getForms_from_instance() {
		return forms_from_instance;
	}

	public void setForms_from_instance(List<FormStateBean> forms_from_instance) {
		this.forms_from_instance = forms_from_instance;
	}
}
