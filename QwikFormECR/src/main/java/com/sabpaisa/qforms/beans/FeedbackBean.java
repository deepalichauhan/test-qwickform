package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="feedback_details")
public class FeedbackBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	 private Integer fbId;
	  private String contact;
	  private String emailId;
	  private String category;
	  private String area;
	  private String userMessage;
	  
	  public FeedbackBean() {}
	  
	  public Integer getFbId()
	  {
	    return fbId;
	  }
	  
	  public void setFbId(Integer fbId) { this.fbId = fbId; }
	  
	  public String getContact() {
	    return contact;
	  }
	  
	  public void setContact(String contact) { this.contact = contact; }
	  
	  public String getEmailId() {
	    return emailId;
	  }
	  
	  public void setEmailId(String emailId) { this.emailId = emailId; }
	  
	  public String getCategory() {
	    return category;
	  }
	  
	  public void setCategory(String category) { this.category = category; }
	  
	  public String getArea() {
	    return area;
	  }
	  
	  public void setArea(String area) { this.area = area; }
	  
	  public String getUserMessage() {
	    return userMessage;
	  }
	  
	  public void setUserMessage(String userMessage) { this.userMessage = userMessage; }
}
