package com.sabpaisa.qforms.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.services.DaoFeeService;

@CrossOrigin
@Controller
@RequestMapping
public class ActionsFeeController{

	@Autowired
	private DaoFeeService daoFeeService;
	
	
	private static Logger log = LogManager.getLogger(ActionsFeeController.class.getName());
	
	private BeanFeeLookup feeLookup=new BeanFeeLookup();
	
	
	@RequestMapping(value="/formPageBreak",method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView formPageBreak(HttpServletRequest request, HttpServletResponse response,HttpSession ses){
		
		ModelAndView mav = new ModelAndView("formPageBreak");
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/formFee",method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView formFee(){
		
		ModelAndView mav = new ModelAndView("formFee");
		
		return mav;
	}
	
	@RequestMapping(value="/saveFeeLookup",method = {RequestMethod.GET,RequestMethod.POST})
	public String saveFeeLookup(HttpServletRequest request, @ModelAttribute("saveFeeLookup") BeanFeeLookup beanfee){
		 	
			log.debug("Saving Fee");
		    BeanFeeLookup beanFeeLU = new BeanFeeLookup();
		    try
		    {
		    	/*String newFeeName=beanfee.getFeeName();
		    	log.debug("value of newFeeName is ::::::::: "+newFeeName.toString());*/
		    	
		    	beanFeeLU.setFeeName(beanfee.getFeeName());
		    	log.info("value of beanFeeLU.setFeeName(newFeeName) is ::::::::: "+beanFeeLU.getFeeName());
		    	//log.debug("value of BeanFeeLookup String is is ::::::::: "+beanFeeLU.toString());
		    	
		    	beanFeeLU = daoFeeService.saveFeeLookup(beanFeeLU);
		    	log.debug("value of beanFeeLU.getFeeName() is in Controller ::::::::: "+beanFeeLU.getFeeName());
		    	
		      
		      if (beanFeeLU.getId() != null)
		      {
		        log.debug("Fee Successfully Saved with ID: " + beanFeeLU.getId());
		        request.setAttribute("msg", "Fee Saved Successfully");
		        request.setAttribute("link", "window.close()");
		      }
		      else
		      {
		        //log.debug("Fee NOT saved!");
		        log.error("Fee NOT saved!");
		      }
		      return "successPopup";
		    }
		    catch (Exception e)
		    {
		      log.error("Duplicate Fee Name");
		      e.printStackTrace();
		      request.setAttribute("msg", "Duplicate Fee Name");
		      request.setAttribute("link", "window.location='formFee'"); 
		     }
		    return "successPopup";
	}

	public BeanFeeLookup getFeeLookup() {
		return feeLookup;
	}

	public void setFeeLookup(BeanFeeLookup feeLookup) {
		this.feeLookup = feeLookup;
	}
}
