package com.sabpaisa.qforms.beans;

import java.util.Date;

import javax.ws.rs.DefaultValue;

public class FetchTransactionDetails {

	private String txnId;
	private String clientTxnId;
	private String challanNo;
	private String bankTxnId;
	private String payeeAmount;
	private String PGName;
	private String PGPayMode;
	private Date transDate;
	private Date transCompleteDate;
	private String status;
	private String payeeFirstName;
	private String payeeLstName;
	private String payeeMob;
	private String regNumber;
	private String payeeEmail;
	private String clientName;
	private String paymentMode;

	public FetchTransactionDetails(String txnId, String clientTxnId, String challanNo, String payeeAmount,
			Date transDate, Date transCompleteDate, String status, String payeeFirstName, String payeeLstName,
			String payeeMob, String payeeEmail, String clientName, String paymentMode, String bankTxnId, String PGName, String PGPayMode) {
		super();
		this.txnId = txnId;
		this.paymentMode = paymentMode;
		this.clientTxnId = clientTxnId;
		this.clientName = clientName;
		this.challanNo = challanNo;
		this.transDate = transDate;
		this.transCompleteDate = transCompleteDate;
		this.status = status;
		this.payeeFirstName = payeeFirstName;
		this.payeeLstName = payeeLstName;
		this.payeeMob = payeeMob;
		this.payeeEmail = payeeEmail;
		this.payeeAmount = payeeAmount;
		this.bankTxnId=bankTxnId;
		this.PGName=PGName;
		this.PGPayMode=PGPayMode;
	}

	public FetchTransactionDetails() {
		super();
	}

	public String getTxnId() {
		return txnId;
	}

	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}

	public String getClientTxnId() {
		return clientTxnId;
	}

	public void setClientTxnId(String clientTxnId) {
		this.clientTxnId = clientTxnId;
	}

	@DefaultValue("NA")
	public String getChallanNo() {
		return challanNo;
	}
	@DefaultValue("NA")
	public void setChallanNo(String challanNo) {
		this.challanNo = challanNo;
	}
	@DefaultValue("NA")
	public String getBankTxnId() {
		return bankTxnId;
	}
	@DefaultValue("NA")
	public void setBankTxnId(String bankTxnId) {
		this.bankTxnId = bankTxnId;
	}

	public String getPayeeAmount() {
		return payeeAmount;
	}

	public void setPayeeAmount(String payeeAmount) {
		this.payeeAmount = payeeAmount;
	}
	@DefaultValue("NA")
	public String getPGName() {
		return PGName;
	}
	@DefaultValue("NA")
	public void setPGName(String pGName) {
		PGName = pGName;
	}
	@DefaultValue("NA")
	public String getPGPayMode() {
		return PGPayMode;
	}
	@DefaultValue("NA")
	public void setPGPayMode(String pGPayMode) {
		PGPayMode = pGPayMode;
	}

	public Date getTransDate() {
		return transDate;
	}

	public void setTransDate(Date transDate) {
		this.transDate = transDate;
	}

	public Date getTransCompleteDate() {
		return transCompleteDate;
	}

	public void setTransCompleteDate(Date transCompleteDate) {
		this.transCompleteDate = transCompleteDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPayeeFirstName() {
		return payeeFirstName;
	}

	public void setPayeeFirstName(String payeeFirstName) {
		this.payeeFirstName = payeeFirstName;
	}

	public String getPayeeLstName() {
		return payeeLstName;
	}

	public void setPayeeLstName(String payeeLstName) {
		this.payeeLstName = payeeLstName;
	}

	public String getPayeeMob() {
		return payeeMob;
	}

	public void setPayeeMob(String payeeMob) {
		this.payeeMob = payeeMob;
	}

	public String getRegNumber() {
		return regNumber;
	}

	public void setRegNumber(String regNumber) {
		this.regNumber = regNumber;
	}

	public String getPayeeEmail() {
		return payeeEmail;
	}

	public void setPayeeEmail(String payeeEmail) {
		this.payeeEmail = payeeEmail;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	@Override
	public String toString() {
		return "FetchTransactionDetails [txnId=" + txnId + ", clientTxnId=" + clientTxnId + ", challanNo=" + challanNo
				+ ", bankTxnId=" + bankTxnId + ", payeeAmount=" + payeeAmount + ", PGName=" + PGName + ", PGPayMode="
				+ PGPayMode + ", transDate=" + transDate + ", transCompleteDate=" + transCompleteDate + ", status="
				+ status + ", payeeFirstName=" + payeeFirstName + ", payeeLstName=" + payeeLstName + ", payeeMob="
				+ payeeMob + ", regNumber=" + regNumber + ", payeeEmail=" + payeeEmail + ", clientName=" + clientName
				+ ", paymentMode=" + paymentMode + "]";
	}
	
}
