package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="noidaFormBean")
public class NoidaFormBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	 private Integer nformId;
	  private String financialYear;
	  private String department;
	  private String bidderID;
	  private String TenderReferenceNo;
	  private String paymentType;
	  private String tenderType;
	  private String firstName;
	  private String mobileNumber;
	  private String nameofTheBank;
	  
	  public NoidaFormBean() {}
	  private String bankBranch;
	  private String bankaccountNo;
	  private String iFSCode;
	  private String amount;
	  public Integer getNformId() { return nformId; }
	  private String clientCode;
	  
	  public void setNformId(Integer nformId) { this.nformId = nformId; }
	  private String merchantTransactionID;
	  
	  public String getFinancialYear() { return financialYear; }
	  private String atomTransactionID;
	  
	  public void setFinancialYear(String financialYear) { this.financialYear = financialYear; }
	  private String date;
	  
	  public String getDepartment() { return department; }
	  private String enrollmentNumber;
	  
	  public void setDepartment(String department) { this.department = department; }
	  

	  public String getBidderID() { return bidderID; }
	  
	  private String nAClientId;
	  public void setBidderID(String bidderID) { this.bidderID = bidderID; }
	  
	  public String getTenderReferenceNo() {
	    return TenderReferenceNo;
	  }
	  
	  public void setTenderReferenceNo(String tenderReferenceNo) { TenderReferenceNo = tenderReferenceNo; }
	  
	  public String getPaymentType() {
	    return paymentType;
	  }
	  
	  public void setPaymentType(String paymentType) { this.paymentType = paymentType; }
	  
	  public String getTenderType() {
	    return tenderType;
	  }
	  
	  public void setTenderType(String tenderType) { this.tenderType = tenderType; }
	  
	  public String getFirstName() {
	    return firstName;
	  }
	  
	  public void setFirstName(String firstName) { this.firstName = firstName; }
	  
	  public String getMobileNumber() {
	    return mobileNumber;
	  }
	  
	  public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
	  
	  public String getNameofTheBank() {
	    return nameofTheBank;
	  }
	  
	  public void setNameofTheBank(String nameofTheBank) { this.nameofTheBank = nameofTheBank; }
	  
	  public String getBankBranch() {
	    return bankBranch;
	  }
	  
	  public void setBankBranch(String bankBranch) { this.bankBranch = bankBranch; }
	  
	  public String getBankaccountNo() {
	    return bankaccountNo;
	  }
	  
	  public void setBankaccountNo(String bankaccountNo) { this.bankaccountNo = bankaccountNo; }
	  
	  public String getiFSCode() {
	    return iFSCode;
	  }
	  
	  public void setiFSCode(String iFSCode) { this.iFSCode = iFSCode; }
	  
	  public String getAmount() {
	    return amount;
	  }
	  
	  public void setAmount(String amount) { this.amount = amount; }
	  
	  public String getClientCode() {
	    return clientCode;
	  }
	  
	  public void setClientCode(String clientCode) { this.clientCode = clientCode; }
	  
	  public String getMerchantTransactionID() {
	    return merchantTransactionID;
	  }
	  
	  public void setMerchantTransactionID(String merchantTransactionID) { this.merchantTransactionID = merchantTransactionID; }
	  
	  public String getAtomTransactionID() {
	    return atomTransactionID;
	  }
	  
	  public void setAtomTransactionID(String atomTransactionID) { this.atomTransactionID = atomTransactionID; }
	  
	  public String getDate() {
	    return date;
	  }
	  
	  public void setDate(String date) { this.date = date; }
	  
	  public String getEnrollmentNumber() {
	    return enrollmentNumber;
	  }
	  
	  public void setEnrollmentNumber(String enrollmentNumber) { this.enrollmentNumber = enrollmentNumber; }
	  
	  public String getnAClientId() {
	    return nAClientId;
	  }
	  
	  public void setnAClientId(String nAClientId) { this.nAClientId = nAClientId; }
	
}
