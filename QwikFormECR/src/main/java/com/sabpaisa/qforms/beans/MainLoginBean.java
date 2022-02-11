package com.sabpaisa.qforms.beans;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;



@Entity
@Table(name = "login_master")
public class MainLoginBean implements java.io.Serializable{

private static final long serialVersionUID = 1L;
	
@GenericGenerator(name = "g1", strategy = "increment")
@Id
@GeneratedValue(generator = "g1")
	private Integer loginId;
	private String name;
	private String contact;
	private String email;
	private String password;
	private String userName;
	private String profile;
	
	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name = "role_Id_Fk", referencedColumnName = "roleId")
	private LookupRoleBean lookupRoleBean;
	
	public LookupRoleBean getLookupRoleBean() {
		return lookupRoleBean;
	}

	public void setLookupRoleBean(LookupRoleBean lookupRoleBean) {
		this.lookupRoleBean = lookupRoleBean;
	}

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "parent_client_Id_Fk", referencedColumnName = "id")
	private CompanyBean companyBean;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "client_Id_Fk", referencedColumnName = "collegeId")
	private CollegeBean collgBean;
	
	@OneToOne(cascade = CascadeType.ALL, targetEntity = OperatorBean.class)
	@JoinColumn(name = "operator_Id_Fk", referencedColumnName = "operatorId")
	private OperatorBean operatorBean;
	
	@OneToOne(cascade = CascadeType.ALL, targetEntity = ActorBean.class)
	@JoinColumn(name = "actor_Id_Fk", referencedColumnName = "actor_Id")
	private ActorBean actorBean;

	public Integer getLoginId() {
		return loginId;
	}

	public void setLoginId(Integer loginId) {
		this.loginId = loginId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public CompanyBean getCompanyBean() {
		return companyBean;
	}

	public void setCompanyBean(CompanyBean companyBean) {
		this.companyBean = companyBean;
	}

	public CollegeBean getCollgBean() {
		return collgBean;
	}

	public void setCollgBean(CollegeBean collgBean) {
		this.collgBean = collgBean;
	}

	public OperatorBean getOperatorBean() {
		return operatorBean;
	}

	public void setOperatorBean(OperatorBean operatorBean) {
		this.operatorBean = operatorBean;
	}

	public ActorBean getActorBean() {
		return actorBean;
	}

	public void setActorBean(ActorBean actorBean) {
		this.actorBean = actorBean;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

		
}
