package com.sabpaisa.qforms.beans;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "company_master")
public class CompanyBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer id;
	  private String companyName;
	  private String companyCode;
	  @OneToMany(mappedBy="companyBean")
	  List<SuperAdminBean> superAdminBeanList;
	  @OneToMany(mappedBy="companyBean")
	  List<CollegeBean> collegeBeanList;
	  
	  @OneToMany(mappedBy="companyBean")
	  List<BeanFormDetails> beanFormDetailsList;
	  
	  @OneToMany(mappedBy="companyBean")
	  List<BankDetailsBean> bankDetailsBeanList;
	  
	  public CompanyBean() {}
	  
	  public List<BankDetailsBean> getBankDetailsBeanList()
	  {
	    return bankDetailsBeanList;
	  }
	  
	  public void setBankDetailsBeanList(List<BankDetailsBean> bankDetailsBeanList) {
	    this.bankDetailsBeanList = bankDetailsBeanList;
	  }
	  
	  public List<CollegeBean> getCollegeBeanList() {
	    return collegeBeanList;
	  }
	  
	  public void setCollegeBeanList(List<CollegeBean> collegeBeanList) {
	    this.collegeBeanList = collegeBeanList;
	  }
	  
	  public List<SuperAdminBean> getSuperAdminBeanList() {
	    return superAdminBeanList;
	  }
	  
	  public void setSuperAdminBeanList(List<SuperAdminBean> superAdminBeanList) {
	    this.superAdminBeanList = superAdminBeanList;
	  }
	  
	  public Integer getId() {
	    return id;
	  }
	  
	  public void setId(Integer id) {
	    this.id = id;
	  }
	  
	  public String getCompanyName() {
	    return companyName;
	  }
	  
	  public void setCompanyName(String companyName) {
	    this.companyName = companyName;
	  }
	  
	  public String getCompanyCode() {
	    return companyCode;
	  }
	  
	  public void setCompanyCode(String companyCode) {
	    this.companyCode = companyCode;
	  }
	  
	  public List<BeanFormDetails> getBeanFormDetailsList() {
	    return beanFormDetailsList;
	  }
	  
	  public void setBeanFormDetailsList(List<BeanFormDetails> beanFormDetailsList) {
	    this.beanFormDetailsList = beanFormDetailsList;
	  }
	
}
