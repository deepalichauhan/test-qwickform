package com.sabpaisa.qforms.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "form_data_master")
public class FormData {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	  private Integer id;
	  private String rollNo;
	  private String studentName;
	  private String fatherName;
	  private String email;
	  private String mobile;
	  private String address;
	  private String branch;
	  private String semester;
	  private String paymentCat;
	  private String remarks;
	  
	  public FormData() {}
	  private String dob;
	  @Column(unique=true)
	  private Long transId;
	  
	  public Integer getId() { return id; }
	  private Double tuitionfee;
	  private Double hostelfee;
	  
	  public void setId(Integer id) { this.id = id; }
	  
	  private Double busfee;
	  
	  public String getStudentName() { return studentName; }
	  
	  private Double txnAmount;
	  
	  public void setStudentName(String studentName) { this.studentName = studentName; }
	  
	  private String txnStatus;
	  
	  public String getFatherName() { return fatherName; }
	  
	  private String txnPayMode;
	  
	  public void setFatherName(String fatherName) { this.fatherName = fatherName; }
	  
	  private Date txnDate;
	  
	  public String getEmail() { return email; }
	  
	  private String name2;
	  private String form_status;
	  public void setEmail(String email) { this.email = email; }
	  
	  public String getMobile()
	  {
	    return mobile;
	  }
	  
	  public void setMobile(String mobile) {
	    this.mobile = mobile;
	  }
	  
	  public String getAddress() {
	    return address;
	  }
	  
	  public void setAddress(String address) {
	    this.address = address;
	  }
	  
	  public String getBranch() {
	    return branch;
	  }
	  
	  public void setBranch(String branch) {
	    this.branch = branch;
	  }
	  
	  public String getSemester() {
	    return semester;
	  }
	  
	  public void setSemester(String semester) {
	    this.semester = semester;
	  }
	  
	  public String getPaymentCat() {
	    return paymentCat;
	  }
	  
	  public void setPaymentCat(String paymentCat) {
	    this.paymentCat = paymentCat;
	  }
	  
	  public String getRemarks() {
	    return remarks;
	  }
	  
	  public void setRemarks(String remarks) {
	    this.remarks = remarks;
	  }
	  
	  public String getDob() {
	    return dob;
	  }
	  
	  public void setDob(String dob) {
	    this.dob = dob;
	  }
	  
	  public Long getTransId() {
	    return transId;
	  }
	  
	  public void setTransId(Long transId) {
	    this.transId = transId;
	  }
	  
	  public Double getTuitionfee() {
	    return tuitionfee;
	  }
	  
	  public void setTuitionfee(Double tuitionfee) {
	    this.tuitionfee = tuitionfee;
	  }
	  
	  public Double getHostelfee() {
	    return hostelfee;
	  }
	  
	  public void setHostelfee(Double hostelfee) {
	    this.hostelfee = hostelfee;
	  }
	  
	  public Double getBusfee() {
	    return busfee;
	  }
	  
	  public void setBusfee(Double busfee) {
	    this.busfee = busfee;
	  }
	  
	  public Double getTxnAmount() {
	    return txnAmount;
	  }
	  
	  public void setTxnAmount(Double txnAmount) {
	    this.txnAmount = txnAmount;
	  }
	  
	  public String getTxnStatus() {
	    return txnStatus;
	  }
	  
	  public void setTxnStatus(String txnStatus) {
	    this.txnStatus = txnStatus;
	  }
	  
	  public Date getTxnDate() {
	    return txnDate;
	  }
	  
	  public void setTxnDate(Date txnDate) {
	    this.txnDate = txnDate;
	  }
	  
	  public String getRollNo() {
	    return rollNo;
	  }
	  
	  public void setRollNo(String rollNo) {
	    this.rollNo = rollNo;
	  }
	  
	  public String getName2() {
	    return name2;
	  }
	  
	  public void setName2(String name2) {
	    this.name2 = name2;
	  }
	  
	  public String getTxnPayMode() {
	    return txnPayMode;
	  }
	  
	  public void setTxnPayMode(String txnPayMode) {
	    this.txnPayMode = txnPayMode;
	  }
	  
	  public String getForm_status() {
	    return form_status;
	  }
	  
	  public void setForm_status(String form_status) {
	    this.form_status = form_status;
	  }
}
