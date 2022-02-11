package com.sabpaisa.qforms.beans;

import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@javax.persistence.Entity
@javax.persistence.Table(name="result_detail")
public class ResultBean {
  @org.hibernate.annotations.GenericGenerator(name="g1", strategy="increment")
  @javax.persistence.Id
  @GeneratedValue(generator="g1")
  private Integer id;
  private Integer rank;
  private String mobileNumberList;
  private String emailList;
  
  @OneToOne(cascade={javax.persistence.CascadeType.ALL})
  @JoinColumn(name="formId", referencedColumnName="id")
  private BeanFormDetails beanFormDetail;
  
  
  
  
  public ResultBean() {}
  
  public Integer getId() {
    return id;
  }
  
  public void setId(Integer id) { this.id = id; }

public BeanFormDetails getBeanFormDetail() {
	return beanFormDetail;
}

public void setBeanFormDetail(BeanFormDetails beanFormDetail) {
	this.beanFormDetail = beanFormDetail;
}

public Integer getRank() {
	return rank;
}

public void setRank(Integer rank) {
	this.rank = rank;
}

public String getMobileNumberList() {
	return mobileNumberList;
}

public void setMobileNumberList(String mobileNumberList) {
	this.mobileNumberList = mobileNumberList;
}

public String getEmailList() {
	return emailList;
}

public void setEmailList(String emailList) {
	this.emailList = emailList;
}
  
 
}

