package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="client_mapping_code")
public class ClientMappingCodeOfSabPaisa implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer cMCId;
	  private String cMCode;
	  private String cMProfile;
	  private String cid;
	  private String bid;
	  private String clientUrl;
	  @ManyToOne(cascade={javax.persistence.CascadeType.ALL})
	  private CollegeBean collegeBeanMappingToSabPaisaClient;
	  
	  public ClientMappingCodeOfSabPaisa() {}
	  
	  public Integer getCMCId()
	  {
	    return cMCId;
	  }
	  
	  public void setCMCId(Integer cMCId) {
	    this.cMCId = cMCId;
	  }
	  
	  public String getCMCode()
	  {
	    return cMCode;
	  }
	  
	  public void setCMCode(String cMCode) {
	    this.cMCode = cMCode;
	  }
	  
	  public String getCMProfile()
	  {
	    return cMProfile;
	  }
	  
	  public void setCMProfile(String cMProfile) {
	    this.cMProfile = cMProfile;
	  }
	  
	  public String getClientUrl()
	  {
	    return clientUrl;
	  }
	  
	  public void setClientUrl(String clientUrl) {
	    this.clientUrl = clientUrl;
	  }

	  public CollegeBean getCollegeBeanMappingToSabPaisaClient()
	  {
	    return collegeBeanMappingToSabPaisaClient;
	  }
	  
	  public void setCollegeBeanMappingToSabPaisaClient(CollegeBean collegeBeanMappingToSabPaisaClient) { this.collegeBeanMappingToSabPaisaClient = collegeBeanMappingToSabPaisaClient; }
	  
	  public String getCid()
	  {
	    return cid;
	  }
	  
	  public void setCid(String cid) { this.cid = cid; }
	  
	  public String getBid() {
	    return bid;
	  }
	  
	  public void setBid(String bid) { this.bid = bid; }
}
