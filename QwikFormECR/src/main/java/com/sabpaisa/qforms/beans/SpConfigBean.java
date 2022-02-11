package com.sabpaisa.qforms.beans;

public class SpConfigBean {

	private String spAuthKey;
	private String spAuthIV;
	private String spUserName;
	private String spUserPassword;
	private String clientCode;

	public String getClientCode() {
		return clientCode;
	}

	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}

	public String getSpAuthKey() {
		return spAuthKey;
	}
	
	public void setSpAuthKey(String spAuthKey) {
		this.spAuthKey = spAuthKey;
	}

	public String getSpAuthIV() {
		return spAuthIV;
	}

	public void setSpAuthIV(String spAuthIV) {
		this.spAuthIV = spAuthIV;
	}

	public String getSpUserName() {
		return spUserName;
	}

	public void setSpUserName(String spUserName) {
		this.spUserName = spUserName;
	}

	public String getSpUserPassword() {
		return spUserPassword;
	}

	public void setSpUserPassword(String spUserPassword) {
		this.spUserPassword = spUserPassword;
	}

	@Override
	public String toString() {
		return "SpConfigBean [spId=" + "spId" + ", spAuthKey=" + spAuthKey + ", spAuthIV=" + spAuthIV + ", spUserName="
				+ spUserName + ", spUserPassword=" + spUserPassword + "]";
	}

}

