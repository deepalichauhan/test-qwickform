package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "whitelable_master")
public class WhiteLableTempBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer whitelblId;
	private Integer bankId;
	private Integer serviceId;
	private Integer stateId;
	private String clientName;
	private String linkURL;
	private String flagLpClient;
	public String getFlagLpClient() {
		return flagLpClient;
	}
	public void setFlagLpClient(String flagLpClient) {
		this.flagLpClient = flagLpClient;
	}
	public String getLinkURL() {
		return linkURL;
	}
	public void setLinkURL(String linkURL) {
		this.linkURL = linkURL;
	}
	public Integer getWhitelblId() {
		return whitelblId;
	}
	public void setWhitelblId(Integer whitelblId) {
		this.whitelblId = whitelblId;
	}
	public Integer getServiceId() {
		return serviceId;
	}
	public void setServiceId(Integer serviceId) {
		this.serviceId = serviceId;
	}
	public Integer getStateId() {
		return stateId;
	}
	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public Integer getBankId() {
		return bankId;
	}
	public void setBankId(Integer bankId) {
		this.bankId = bankId;
	}
}
