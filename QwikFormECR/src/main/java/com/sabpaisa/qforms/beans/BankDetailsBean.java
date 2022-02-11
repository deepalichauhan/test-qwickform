package com.sabpaisa.qforms.beans;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;

@Entity
@Table(name = "bank_details_bean")
public class BankDetailsBean {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	 private Integer bankId;
	  private String bankname;
	  private String branch;
	  private String contactPerson;
	  private String emailId;
	  private String bankLogo;
	  private String address;
	  private String bankLink;
	  private Long contactNumber;
	  @javax.persistence.Lob
	  @Column(name="bankImage", columnDefinition="mediumblob")
	  private byte[] bankImage;
	  @javax.persistence.ManyToOne(cascade={javax.persistence.CascadeType.ALL})
	  @javax.persistence.JoinColumn(name="comp_id_fk", referencedColumnName="id")
	  private CompanyBean companyBean;
	  
	  public BankDetailsBean() {}
	  
	  public byte[] getBankImage()
	  {
	    return bankImage;
	  }
	  
	  public void setBankImage(byte[] bankImage) {
	    this.bankImage = bankImage;
	  }
	  

	  public CompanyBean getCompanyBean()
	  {
	    return companyBean;
	  }
	  
	  public void setCompanyBean(CompanyBean companyBean) {
	    this.companyBean = companyBean;
	  }
	  
	  @javax.persistence.OneToMany(cascade={javax.persistence.CascadeType.ALL}, mappedBy="bankDetailsOTM")
	  List<CollegeBean> listOfColleges = new ArrayList();
	  
	  public List<CollegeBean> getListOfColleges() {
	    return listOfColleges;
	  }
	  
	  public void setListOfColleges(List<CollegeBean> listOfColleges) {
	    this.listOfColleges = listOfColleges;
	  }
	  
	  public Integer getBankId() {
	    return bankId;
	  }
	  
	  public void setBankId(Integer bankId) {
	    this.bankId = bankId;
	  }
	  
	  @Pattern(regexp="[a-zA-Z][a-zA-Z ]*", message="Name has invalid characters")
	  public String getBankname()
	  {
	    return bankname;
	  }
	  
	  public void setBankname(String bankname) {
	    this.bankname = bankname;
	  }
	  
	  @Pattern(regexp="[a-zA-Z][a-zA-Z ]*", message="Name has invalid characters")
	  public String getBranch() { return branch; }
	  
	  public void setBranch(String branch)
	  {
	    this.branch = branch;
	  }
	  
	  @Pattern(regexp="[a-zA-Z][a-zA-Z ]*", message="Name has invalid characters")
	  public String getContactPerson() { return contactPerson; }
	  
	  public void setContactPerson(String contactPerson)
	  {
	    this.contactPerson = contactPerson;
	  }
	  
	  @Pattern(regexp="^[0-9a-zA-Z_,/.'#@]*$", message="Email has invalid characters")
	  public String getEmailId() { return emailId; }
	  
	  public void setEmailId(String emailId)
	  {
	    this.emailId = emailId;
	  }
	  
	  public Long getContactNumber() {
	    return contactNumber;
	  }
	  
	  public void setContactNumber(Long contactNumber) {
	    this.contactNumber = contactNumber;
	  }
	  
	  public String getBankLogo() {
	    return bankLogo;
	  }
	  
	  public void setBankLogo(String bankLogo) {
	    this.bankLogo = bankLogo;
	  }
	  
	  public String getAddress() {
	    return address;
	  }
	  
	  public void setAddress(String address) {
	    this.address = address;
	  }
	  
	  public String getBankLink() {
	    return bankLink;
	  }
	  
	  public void setBankLink(String bankLink) {
	    this.bankLink = bankLink;
	  }

	@Override
	public String toString() {
		return "BankDetailsBean [bankId=" + bankId + ", bankname=" + bankname + ", branch=" + branch
				+ ", contactPerson=" + contactPerson + ", emailId=" + emailId + ", bankLogo=" + bankLogo + ", address="
				+ address + ", bankLink=" + bankLink + ", contactNumber=" + contactNumber + ", companyBean=" + companyBean 
				+ ", listOfColleges=" + listOfColleges + "]";
	}
	  
	  
}
