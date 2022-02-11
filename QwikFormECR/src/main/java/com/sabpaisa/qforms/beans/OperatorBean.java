package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name = "operator_table")
public class OperatorBean implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer operatorId;
	  private String operatorName;
	  private String operatorLstName;
	  private String operatorAddress;
	  private String operatorContactSec;
	  private String operatorEmail;
	  private String operatorContact;
	  private String gender;
	  @OneToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, orphanRemoval = true)
	  LoginBean loginBean;
	  @ManyToOne
	  private CollegeBean CollegeBean_fk;
	  
	  public OperatorBean() {}
	  
	  public CollegeBean getCollegeBean_fk()
	  {
	    return CollegeBean_fk;
	  }
	  
	  public void setCollegeBean_fk(CollegeBean collegeBean_fk) {
	    CollegeBean_fk = collegeBean_fk;
	  }
	  
	  public Integer getOperatorId() {
	    return operatorId;
	  }
	  
	  public void setOperatorId(Integer operatorId) {
	    this.operatorId = operatorId;
	  }
	  
	  @NotNull(message="Name is compulsory")
	  @NotBlank(message="Name is compulsory")
	  @Pattern(regexp="[a-z-A-Z]*", message="Name has invalid characters")
	  public String getOperatorName()
	  {
	    return operatorName;
	  }
	  
	  public void setOperatorName(String operatorName) {
	    this.operatorName = operatorName;
	  }
	  

	  public String getOperatorAddress()
	  {
	    return operatorAddress;
	  }
	  
	  public void setOperatorAddress(String operatorAddress) {
	    this.operatorAddress = operatorAddress;
	  }
	  

	  public String getOperatorEmail()
	  {
	    return operatorEmail;
	  }
	  
	  public void setOperatorEmail(String operatorEmail) {
	    this.operatorEmail = operatorEmail;
	  }
	  
	  public String getOperatorContact() {
	    return operatorContact;
	  }
	  
	  public void setOperatorContact(String operatorContact) {
	    this.operatorContact = operatorContact;
	  }
	  
	  public LoginBean getLoginBean() {
	    return loginBean;
	  }
	  
	  public void setLoginBean(LoginBean loginBean) {
	    this.loginBean = loginBean;
	  }
	  
	  public String getOperatorLstName() {
	    return operatorLstName;
	  }
	  
	  public void setOperatorLstName(String operatorLstName) {
	    this.operatorLstName = operatorLstName;
	  }
	  
	  public String getOperatorContactSec() {
	    return operatorContactSec;
	  }
	  
	  public void setOperatorContactSec(String operatorContactSec) {
	    this.operatorContactSec = operatorContactSec;
	  }
	  
	  public String getGender() {
	    return gender;
	  }
	  
	  public void setGender(String gender) {
	    this.gender = gender;
	  }
}
