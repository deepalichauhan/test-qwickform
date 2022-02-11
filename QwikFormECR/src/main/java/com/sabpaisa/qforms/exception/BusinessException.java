package com.sabpaisa.qforms.exception;

import java.util.List;

import com.sabpaisa.qforms.util.CommonsUtil;



public class BusinessException extends Exception {
	

	private static final long serialVersionUID = -9046588951532319094L;
	private String errorCode;
	private List<String> errorCodeList;
	private String messageStr;

	public BusinessException(String errorCode, String message) {
		super(errorCode + message);
		this.errorCode = errorCode;
		this.messageStr = message;
	}

	public BusinessException(String errorCode, Throwable cause) {
		super(errorCode, cause);
		this.errorCode = errorCode;
	}

	public BusinessException(String errorCode) {
		super(errorCode);
		this.errorCode = errorCode;
	}
	
	// For sending back multiple issues in a single shot
	public BusinessException(List<String> errorCodeList) {
		this.errorCodeList = errorCodeList;
	}

	public BusinessException(Throwable cause) {
		super(cause);
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getMessageStr() {
		return messageStr;
	}
	
	public void setMessageStr(String messageStr) {
		this.messageStr = messageStr;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("");
		if (!CommonsUtil.checkBlank(this.getErrorCode())) {
			builder.append("Error Code: " + this.getErrorCode());
		}
		
		if (!CommonsUtil.checkBlank(this.getMessageStr())) {
			builder.append(" Error Message: " + this.getMessageStr());
		}
		
		return builder.toString();
	}

	public List<String> getErrorCodeList() {
		return errorCodeList;
	}

	public void setErrorCodeList(List<String> errorCodeList) {
		this.errorCodeList = errorCodeList;
	}

}
