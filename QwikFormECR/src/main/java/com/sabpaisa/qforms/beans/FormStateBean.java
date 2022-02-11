package com.sabpaisa.qforms.beans;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "form_state")
public class FormStateBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	 private Integer state_id;
	  private Integer form_id;
	  private Integer form_instance_id;
	  private String form_status;
	  private Date submission_date;
	  private Integer form_stage;
	  private String username;
	  private Integer actor_id;
	  private String actor_action;
	  private String form_action;
	  private Integer next_actor_id;
	  private Integer sequence_no;
	  @Transient
	  private BeanFormDetails formdetails;
	  
	  public FormStateBean() {}
	  
	  public Integer getState_id()
	  {
	    return state_id;
	  }
	  
	  public void setState_id(Integer state_id) { this.state_id = state_id; }
	  
	  public String getForm_status() {
	    return form_status;
	  }
	  
	  public void setForm_status(String form_status) { this.form_status = form_status; }
	  
	  public Date getSubmission_date() {
	    return submission_date;
	  }
	  
	  public void setSubmission_date(Date submission_date) { this.submission_date = submission_date; }
	  
	  public Integer getForm_stage() {
	    return form_stage;
	  }
	  
	  public void setForm_stage(Integer form_stage) { this.form_stage = form_stage; }
	  
	  public String getUsername() {
	    return username;
	  }
	  
	  public void setUsername(String username) { this.username = username; }
	  
	  public Integer getActor_id() {
	    return actor_id;
	  }
	  
	  public void setActor_id(Integer actor_id) { this.actor_id = actor_id; }
	  
	  public String getActor_action() {
	    return actor_action;
	  }
	  
	  public void setActor_action(String actor_action) { this.actor_action = actor_action; }
	  
	  public Integer getNext_actor_id() {
	    return next_actor_id;
	  }
	  
	  public void setNext_actor_id(Integer next_actor_id) { this.next_actor_id = next_actor_id; }
	  
	  public Integer getForm_id() {
	    return form_id;
	  }
	  
	  public void setForm_id(Integer form_id) { this.form_id = form_id; }
	  
	  public Integer getForm_instance_id() {
	    return form_instance_id;
	  }
	  
	  public void setForm_instance_id(Integer form_instance_id) { this.form_instance_id = form_instance_id; }
	  
	  public Integer getSequence_no() {
	    return sequence_no;
	  }
	  
	  public void setSequence_no(Integer sequence_no) { this.sequence_no = sequence_no; }
	  
	  public String getForm_action() {
	    return form_action;
	  }
	  
	  public void setForm_action(String form_action) { this.form_action = form_action; }
	  
	  public BeanFormDetails getFormdetails() {
	    return formdetails;
	  }
	  
	  public void setFormdetails(BeanFormDetails formdetails) { this.formdetails = formdetails; }
}
