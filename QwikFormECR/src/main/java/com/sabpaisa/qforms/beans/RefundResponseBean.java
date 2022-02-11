package com.sabpaisa.qforms.beans;

public class RefundResponseBean {

	private String refundId;
	private String amount;
	private String clientCode;
	private String clientId;
	private String clientTxnId;
	private String spTxnId;
	private String refundInitDate;
	private String refundCompleteDate;	
	private String message;
	public String getRefundId() {
		return refundId;
	}
	public void setRefundId(String refundId) {
		this.refundId = refundId;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getClientCode() {
		return clientCode;
	}
	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientTxnId() {
		return clientTxnId;
	}
	public void setClientTxnId(String clientTxnId) {
		this.clientTxnId = clientTxnId;
	}
	public String getSpTxnId() {
		return spTxnId;
	}
	public void setSpTxnId(String spTxnId) {
		this.spTxnId = spTxnId;
	}
	public String getRefundInitDate() {
		return refundInitDate;
	}
	public void setRefundInitDate(String refundInitDate) {
		this.refundInitDate = refundInitDate;
	}
	public String getRefundCompleteDate() {
		return refundCompleteDate;
	}
	public void setRefundCompleteDate(String refundCompleteDate) {
		this.refundCompleteDate = refundCompleteDate;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
