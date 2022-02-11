package com.sabpaisa.qforms.controller;

import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@CrossOrigin
@Controller
@RequestMapping
public class HomeController {
	
	static Logger log = LogManager.getLogger(HomeController.class.getName());
	
		@CrossOrigin
	 	@RequestMapping(value = { "/","/index"  }, method = RequestMethod.GET)
		public ModelAndView showLogin(HttpServletRequest request,HttpSession ses) {
			
			
			//System.out.println("session Id :"+ ses.getId()+" request session id : "+request.getSession().getId());
			
		    ModelAndView mav = new ModelAndView("home");
		    mav.addObject("showLog","LoginPageOpen");

		    return mav;
		}
	     
	 	@RequestMapping(value = "/dataFetch", method = RequestMethod.GET)
		public ModelAndView fetchData(HttpServletRequest request, HttpServletResponse response) {

		    ModelAndView mav = new ModelAndView("/login/homeTest");
		    //mav.addObject("showLog","LoginPageOpen");

		    return mav;
		  }
	 	
	 	@RequestMapping(value="/success")
	    public String next(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "Success";
	    }
	 	
	 	@RequestMapping(value= {"/logout","/saLogout"},method=RequestMethod.GET)
	      public String logout(HttpSession session) {
	        session.invalidate();
	        return "home";
	      }
	 	
	 	@RequestMapping(value="/paySessionOut")
	    public String paySessionOut(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "PaySessionOut";
	    }
	 	
	 	@RequestMapping(value="/testtingFile")
	    public String testtingFile(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "Testingfile";
	    }
	 	
	 	@RequestMapping(value="/PayerFileUploadGeneral")
	    public String payerFileUploadGeneral(Map<String, Object> model) {
	 		model.put("message", "You are in new page !!");   // documentFileUploadGeneral
	        return "PayerFileUploadGeneral";
	    }
	 	
	 	@RequestMapping(value="/PayerFileUpload")
	    public String PayerFileUpload(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "PayerFileUpload";
	    }
	 	
	 	@RequestMapping(value="/TermsAndConditions")
	    public String termsAndConditions(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "TermsAndConditions";
	    }
	 	
	 	@RequestMapping(value="/sessionFailurePage")
	    public String sessionFailurePage(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "sessionFailurePage";
	        //SessionTerminated
	    }
	 	
	 	@RequestMapping(value="/sessionTerminated")
	    public String sessionTerminated(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "SessionTerminated";
	        //
	    }
	 	
	 	@RequestMapping(value="/index_NITJ")
	    public String index_NITJ(Map<String, Object> model) {
	        model.put("message", "You are in new page !!");
	        return "index_NITJ";
	    }
	 	
	 	@RequestMapping(value="/timeIntervalPage")
		public ModelAndView timeIntervalPage(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
			
			ModelAndView mav = new ModelAndView("TimeIntervalPage");
			
			return mav;
		}
	 	
	 	@RequestMapping(value="/FormInstructionUplo")
		public ModelAndView formInstructionUpload(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
			
			ModelAndView mav = new ModelAndView("FormInstructionUpload");
			
			return mav;
		}
	 	
	 	@RequestMapping(value="/ContactUs")
		public ModelAndView contactUs(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
			
			ModelAndView mav = new ModelAndView("ContactUs");
			
			return mav;
		}
	 	
	 	@RequestMapping(value="/PrivacyPolicy")
		public ModelAndView privacyPolicy(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
			
			ModelAndView mav = new ModelAndView("PrivacyPolicy");
			
			return mav;
		}
	 	@RequestMapping(value="/Disclaimer")
		public ModelAndView disclaimer(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
			
			ModelAndView mav = new ModelAndView("Disclaimer");
			
			return mav;
		}
	 	
}
