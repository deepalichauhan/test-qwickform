package com.sabpaisa.qforms.beans;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "login_master")
public class LoginBean implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer loginId;
	  private String userName;
	  private String password;
	  private String profile;
	  
	  @OneToOne(cascade={CascadeType.ALL}, orphanRemoval = true)
	  @JoinColumn(name="collegeId_Fk", referencedColumnName="collegeId")
	  private CollegeBean collgBean;
	  
	  @OneToOne(cascade={CascadeType.ALL}, orphanRemoval = true, targetEntity=OperatorBean.class)
	  @JoinColumn(name="operatorId_Id_Fk", referencedColumnName="operatorId")
	  private OperatorBean operatorBean;
	  
	  @OneToOne(cascade={CascadeType.ALL}, orphanRemoval = true, targetEntity=SuperAdminBean.class)
	  @JoinColumn(name="id_Fk", referencedColumnName="id")
	  private SuperAdminBean superAdmin;
	  
	  @OneToOne(cascade={CascadeType.ALL}, orphanRemoval = true, targetEntity=ActorBean.class)
	  @JoinColumn(name="actor_Id_Fk", referencedColumnName="actor_id")
	  private ActorBean actorBean;
	  
	  public LoginBean() {}
	  
	  public SuperAdminBean getSuperAdmin()
	  {
	    return superAdmin;
	  }
	  
	  public void setSuperAdmin(SuperAdminBean superAdmin) {
	    this.superAdmin = superAdmin;
	  }
	  
	  public static long getSerialversionuid() {
	    return 1L;
	  }
	  
	  public CollegeBean getCollgBean()
	  {
	    return collgBean;
	  }
	  
	  public void setCollgBean(CollegeBean collgBean) {
	    this.collgBean = collgBean;
	  }
	  
	  public String getProfile() {
	    return profile;
	  }
	  
	  public void setProfile(String profile) {
	    this.profile = profile;
	  }
	  
	  public Integer getLoginId() {
	    return loginId;
	  }
	  
	  public void setLoginId(Integer loginId) {
	    this.loginId = loginId;
	  }
	  
	  public String getUserName() {
	    return userName;
	  }
	  
	  public void setUserName(String userName) {
	    this.userName = userName;
	  }
	  
	  public String getPassword() {
	    return password;
	  }
	  
	  public void setPassword(String password) {
	    this.password = password;
	  }
	  

	  public OperatorBean getOperatorBean()
	  {
	    return operatorBean;
	  }
	  
	  public void setOperatorBean(OperatorBean operatorBean) {
	    this.operatorBean = operatorBean;
	  }
	  

	  public ActorBean getActorBean()
	  {
	    return actorBean;
	  }
	  
	  public void setActorBean(ActorBean actorBean) {
	    this.actorBean = actorBean;
	  }
}