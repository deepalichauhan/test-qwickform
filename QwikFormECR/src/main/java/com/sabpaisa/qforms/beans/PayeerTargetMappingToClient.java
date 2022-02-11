package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="payeer_target_mapping_to_client")

public class PayeerTargetMappingToClient implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	  private Integer payeeTMCId;
	  private String clientUserName;
	  private String clientPwd;
	  private String clientIV;
	  private String clientKey;
	  private String clientCode;
	  private String cid;
	  private String bid;
	  private String profileType;
	  @javax.persistence.ManyToOne(cascade={javax.persistence.CascadeType.ALL})
	  private CollegeBean clientTargetMappingToCollegeBean;
	  
	  public PayeerTargetMappingToClient() {}
	  
	  public Integer getPayeeTMCId()
	  {
	    return payeeTMCId;
	  }
	  
	  public void setPayeeTMCId(Integer payeeTMCId) { this.payeeTMCId = payeeTMCId; }
	  
	  public String getClientUserName() {
	    return clientUserName;
	  }
	  
	  public CollegeBean getClientTargetMappingToCollegeBean() { return clientTargetMappingToCollegeBean; }
	  
	  public void setClientTargetMappingToCollegeBean(CollegeBean clientTargetMappingToCollegeBean) {
	    this.clientTargetMappingToCollegeBean = clientTargetMappingToCollegeBean;
	  }
	  
	  public void setClientUserName(String clientUserName) { this.clientUserName = clientUserName; }
	  
	  public String getClientPwd() {
	    return clientPwd;
	  }
	  
	  public void setClientPwd(String clientPwd) { this.clientPwd = clientPwd; }
	  
	  public String getClientIV() {
	    return clientIV;
	  }
	  
	  public void setClientIV(String clientIV) { this.clientIV = clientIV; }
	  
	  public String getClientKey() {
	    return clientKey;
	  }
	  
	  public void setClientKey(String clientKey) { this.clientKey = clientKey; }
	  
	  public String getClientCode() {
	    return clientCode;
	  }
	  
	  public void setClientCode(String clientCode) { this.clientCode = clientCode; }
	  
	  public String getCid() {
	    return cid;
	  }
	  
	  public void setCid(String cid) { this.cid = cid; }
	  
	  public String getBid() {
	    return bid;
	  }
	  
	  public void setBid(String bid) { this.bid = bid; }
	  
	  public String getProfileType() {
	    return profileType;
	  }
	  
	  public void setProfileType(String profileType) { this.profileType = profileType; }
}
