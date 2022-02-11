package com.sabpaisa.qforms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.MediaType;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.services.WhiteLevalService;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.multipart.FormDataMultiPart;

@CrossOrigin
@Controller
@RequestMapping
public class WhiteLevalController {
	
	@Autowired
	private WhiteLevalService whiteLevalService;
	
	private static Logger log = LogManager.getLogger(WhiteLevalController.class.getName());
	private String clientBankId;
	
	/*List<CollegeBean> collegelst = new ArrayList<>();
	List<StateBean> stateList = new ArrayList<>();*/
		
	/**************For Testing Start************/
	@RequestMapping(value = "/testBanks/{bid}", method = RequestMethod.GET)
	public String getWhiteLevalHomesss(ModelMap model, @PathVariable("bid") String bid) {
		
		log.info("Start of getWhiteLevalHome() method bid >> "+bid);		
		model.addAttribute("bid", bid);
				
		return "/BanksWhiteLeval/index";		
	}
	/**************For Testing End************/
	
	@RequestMapping(value = "/banks", method = RequestMethod.GET)
	public ModelAndView fetchDatas(HttpServletRequest request, 
			HttpServletResponse response,  @RequestParam String bid) {

	    ModelAndView mav = new ModelAndView("/BanksWhiteLeval/index");
	    mav.addObject("bid", bid);
	    //mav.addObject("showLog","LoginPageOpen");

	    return mav;
	  }
	
	
	
	@RequestMapping(value = "/bankClients", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBankClientList(ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, HttpSession ses){
		
		List<CollegeBean> collegelst = new ArrayList<>();
		List<StateBean> stateList = new ArrayList<>();
		  
		clientBankId = request.getParameter("bid");
		log.info("BankId is >> "+clientBankId);
	    if (clientBankId.equalsIgnoreCase("ALL")) {
	      clientBankId = "0";
	    }
	    ses.setAttribute("BID", clientBankId);
	    
	    collegelst = whiteLevalService.getCollegeListOfBank(Integer.parseInt(clientBankId));
	    log.info("Size of collegelst >> "+collegelst.size());
	    request.setAttribute("collegeList", collegelst);
	    
	    stateList = whiteLevalService.getStateList(collegelst);
	    
	    //model = new ModelAndView("/Banks/whiteLevelBank");
	    model.put("stateList",stateList);
	    
	    log.info("State List Size is:::::::::" + stateList.size());
	    
	    return "/BanksWhiteLeval/whiteLevelBank";
	  }
	
		
	@RequestMapping(value = "/bankClientbysid", method = RequestMethod.GET)
	public String getBankClientListByBidStateId(ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, HttpSession ses){
		
		List<CollegeBean> collegelst = new ArrayList<>();
	    Integer bid = Integer.valueOf(Integer.parseInt(ses.getAttribute("BID").toString()));
	    Integer stateId = Integer.valueOf(Integer.parseInt(request.getParameter("stateId")));
	    Integer bankId = Integer.valueOf(Integer.parseInt(request.getParameter("bid")));
	    log.info("bankId >>>>>>> "+bankId);
	    log.info("Bid is >> "+bid+", State Id is >> " + stateId);
	    collegelst = whiteLevalService.getCollegeDetailsBasedOnStateId(stateId, bid);
	    log.info("College List Size:::" + collegelst.size());
	    
	    //model = new ModelAndView("/Banks/collegeListAjax");
	    model.put("collegelst", collegelst);
	    
	    return "/BanksWhiteLeval/collegeListAjax";
	  }

	@RequestMapping(value = "/raiseTicket", method = RequestMethod.GET)
	public @ResponseBody String mailForRaiseTicket(HttpServletRequest request, 
			HttpServletResponse response, HttpSession ses,  @RequestParam(required = true) String fromMail,
			@RequestParam(required = true) String toMail, @RequestParam String nameOfUser,
			@RequestParam String mailBodyContent,@RequestParam String businessType,
			@RequestParam String userMobile,@RequestParam String bankHodMailId,			
			@RequestParam String bankName) {
				
		log.info("tomail "+toMail+", from "+fromMail+", name "+nameOfUser+", body "+mailBodyContent+", businessType >> "+businessType);
		
		String mailSubject ="Fee Collection Module - User has Raised a Ticket";
		String mailMessage = "<html><body><p>Dear <strong><em><u>"
				+bankName+"</u></em></strong> Team,</p><p>We would like to avail the online fee collection system from <strong><em><u>"
				+bankName+"</u></em></strong><u>.</u> Our details are as following.</p><p>&nbsp;</p><p>Name: <strong><em><u>"
				+nameOfUser+"</u></em></strong>&nbsp;&nbsp;&nbsp;</p><p>Business Type: <strong><em><u>"
				+businessType+"</u></em></strong></p><p>Phone Number: <strong><em><u>"
				+userMobile+"</u></em></strong></p><p>Email: <strong><em><u>"
				+fromMail+"</u></em></strong></p><p>Other details:</p><p><strong><em><u>"
				+mailBodyContent+"</u></em></strong></p><p>&nbsp;</p><p><strong><em>Regards </em></strong></p><p><strong><em><u>"
				+nameOfUser+"</u></em></strong></p></body></html>";
		
		log.info("Going to send mail to >> "+toMail+", from >> "+fromMail);		
		sendMailByMailGun(toMail,bankHodMailId,fromMail,mailSubject,mailMessage);
		System.out.println("We have successfully sent your enquiry");	
		
		//return "{\"status\":\"" + "success" + "\", \"response\": \"" + "We have successfully Raise a Ticket" + "\"}";
		return "We have successfully Raise a Ticket";
	  }//raiseTicket
	
	@RequestMapping(value = "/callBackEnquery", method = RequestMethod.GET)
	public @ResponseBody String mailForCallBackEnquery(HttpServletRequest request, 
			HttpServletResponse response, HttpSession ses,  @RequestParam(required = true) String fromMail,
			@RequestParam(required = true) String toMail, @RequestParam String nameOfUser,
			@RequestParam String userMobile, @RequestParam String mailBodyContent,
			@RequestParam String bankHodMailId, @RequestParam String bankName) {
		
		log.info("tomail "+toMail+", from "+fromMail+", name "+nameOfUser+", body "+mailBodyContent);
		
		String mailSubject ="Reply: Fee Collection Module - User has reached out for Enquiry";
		String mailMessage = "<html><body><p>Dear <strong><em><u>"
				+bankName+"</u></em></strong> Team,</p><p>We would like to avail the online fee collection system from <strong><em><u>"
				+bankName+"</u></em></strong><u>.</u> Our details are as following.</p><p>&nbsp;</p><p>Name: <strong><em><u>"
				+nameOfUser+"</u></em></strong>&nbsp;&nbsp;&nbsp;</p><p>Phone Number: <strong><em><u>"
				+userMobile+"</u></em></strong></p><p>Email: <strong><em><u>"
				+fromMail+"</u></em></strong></p><p>Other details:</p><p><strong><em><u>"
				+mailBodyContent+"</u></em></strong></p><p>&nbsp;</p><p><strong><em>Regards </em></strong></p><p><strong><em><u>"
				+nameOfUser+"</u></em></strong></p></body></html>";
		
		log.info("Going to send mail to >> "+toMail+", from >> "+fromMail);		
		sendMailByMailGun(toMail,bankHodMailId,fromMail,mailSubject,mailMessage);
		System.out.println("We have successfully sent your enquiry");	
		
		//return "{\"status\":\"" + "success" + "\", \"response\": \"" + "We have successfully Raise a Ticket" + "\"}";
		return "We have successfully sent your enquiry";
	  }//mailForCallBackEnquery
	
	@RequestMapping(value = "/sendReplyMailRequest", method = RequestMethod.GET)
	public @ResponseBody String sendReplyMailRequest(HttpServletRequest request, 
			HttpServletResponse response, HttpSession ses,  @RequestParam(required = true) String fromMail,
			@RequestParam(required = true) String toMail, @RequestParam String bankName) {
				
		log.info("tomail "+toMail+", from "+fromMail);
		
		String mailSubject ="Reply: Fee Collection Module - User has reached out for Enquiry";
		String mailMessage = "<html><body><p>Dear Sir/Madam,</p><p>Thank you for your interest in <strong><em><u>"
				+bankName+"</u></em></strong> Online Fee Collection Solution. Our representative will soon contact you.</p><p>Thanking You.</p><p><strong><em><u>"
				+bankName+"</u></em></strong> Marketing Team</p></body></html>";
		
		log.info("Going to send mail to >> "+toMail+", from >> "+fromMail);		
		sendMailByMailGun(toMail,fromMail,mailSubject,mailMessage);
		System.out.println("We have successfully sent your enquiry");	
		
		//return "{\"status\":\"" + "success" + "\", \"response\": \"" + "We have successfully Raise a Ticket" + "\"}";
		return "Your enquiry has been successfully submitted!!";
	  }//sendReplyMailRequest
	
	public void sendMailByMailGun(String toMail,String bankHodMailId, String fromMail,
			String mailSubject,String mailMessage) {		
		
		Client client = Client.create();
		client.addFilter(new HTTPBasicAuthFilter("api", "key-0b34cd5b749afc6281003b1fe447eed7"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		form.field("from", fromMail);
		form.field("to", toMail);
		form.field("to", bankHodMailId);
		//form.field("cc", bankHodMailId);
		
		form.field("html", mailMessage);			
		form.field("subject", mailSubject);
		webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);			
		
	}
	
	public void sendMailByMailGun(String toMail, String fromMail,
			String mailSubject,String mailMessage) {		
		
		Client client = Client.create();
		client.addFilter(new HTTPBasicAuthFilter("api", "key-0b34cd5b749afc6281003b1fe447eed7"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		form.field("from", fromMail);
		form.field("to", toMail);
		//form.field("cc", bankHodMailId);
		
		form.field("html", mailMessage);			
		form.field("subject", mailSubject);
		webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);			
		
	}
	
/*	public String getClientBankId() {
		return clientBankId;
	}

	public void setClientBankId(String clientBankId) {
		this.clientBankId = clientBankId;
	}

	public List<CollegeBean> getCollegelst() {
		return collegelst;
	}

	public void setCollegelst(List<CollegeBean> collegelst) {
		this.collegelst = collegelst;
	}

	public List<StateBean> getStateList() {
		return stateList;
	}

	public void setStateList(List<StateBean> stateList) {
		this.stateList = stateList;
	}
*/
}
