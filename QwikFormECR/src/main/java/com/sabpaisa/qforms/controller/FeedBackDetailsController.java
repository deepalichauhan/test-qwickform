package com.sabpaisa.qforms.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.FeedbackBean;
import com.sabpaisa.qforms.services.FeedbackDetailsService;

@CrossOrigin
@Controller
@RequestMapping
public class FeedBackDetailsController {

	@Autowired
	FeedbackDetailsService feedbackDetailsService;
	
	  private static final Logger log = LogManager.getLogger("FeedbackDetailsDaoImpl.class");	
	  
	  private FeedbackBean feedbackBean = new FeedbackBean();
	  ArrayList<String> dpList = new ArrayList();
	  
	  public ArrayList<String> getDpList() { return dpList; }
	  
	  public void setDpList(ArrayList<String> dpList)
	  {
	    this.dpList = dpList;
	  }
	  
	  @RequestMapping(value="/GetDropdownValuesOfFBDAction",method = RequestMethod.POST)
	  public String getDropdownValuesOfFB(HttpServletRequest request, Model model)
	  {
	    String category = request.getParameter("id");
	    
	    if (category.contains("Suggestion"))
	    {
	      dpList.add("Suggestion");
	      
	      request.setAttribute("category", "Suggestion");
	      return "feedbackPage";
	    }
	    
	    if (category.contains("Feedback"))
	    {
	      dpList.add("User Experience");
	      dpList.add("Application Flow");
	      dpList.add("Payment Experience");
	      request.setAttribute("category", "Feedback");
	      return "feedbackPage";
	    }
	    if (category.contains("Complaint"))
	    {
	      dpList.add("Cannot Do Transation");
	      dpList.add("Dues not appearing properly");
	      dpList.add("Did not get Transaction Receipt");
	      dpList.add("Did not get Transaction Notification");
	      request.setAttribute("category", "Complaint");
	      return "feedbackPage";
	    }
	    
	    return "feedbackPage";
	  }
	  
	  @RequestMapping(value="/saveFeedbackDetails",method = RequestMethod.POST)
	  public String saveFeedbackDetailsAction(HttpServletRequest request)
	  {
		  feedbackDetailsService.saveFeedbackDetailsDao(feedbackBean);
	    
	    request.setAttribute("msg", "Your Feedback is Successfully noted...");
	    
	    return "Success";
	  }
	  
	  public FeedbackBean getFeedbackBean() {
	    return feedbackBean;
	  }
	  
	  public void setFeedbackBean(FeedbackBean feedbackBean) {
	    this.feedbackBean = feedbackBean;
	  }

	public FeedbackDetailsService getFeedbackDetailsService() {
		return feedbackDetailsService;
	}

	public void setFeedbackDetailsService(FeedbackDetailsService feedbackDetailsService) {
		this.feedbackDetailsService = feedbackDetailsService;
	}
	  
	  
}
