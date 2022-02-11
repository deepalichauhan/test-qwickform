package com.sabpaisa.qforms.beans;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.Pattern;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "college_master")
public class CollegeBean {
	
	@Id
	private Integer collegeId;
	private String collegeCode;
	private Integer eGFDays;
	private String collegeName, contact, emailId, address, state, collegeLogo,collegeURL;
	private File collegeFile;
	private String idForCob;
	private String clientImagePath;
	private String isRefundEnabled;
	private String authIV;
	private String authKey;
	private String userName;
	private String userPassword;
	
	@OneToMany(cascade = {CascadeType.ALL}, orphanRemoval = true,fetch = FetchType.EAGER)
	@Fetch(FetchMode.SUBSELECT) 
	@JoinTable(name = "college_master_client_actors", uniqueConstraints = @UniqueConstraint(columnNames = "actors_actor_id"), joinColumns = {
	@JoinColumn(name = "college_master_collegeId", nullable = false, updatable = false) }, inverseJoinColumns = {
	@JoinColumn(name = "actors_actor_id", unique = true, nullable = false, updatable = false) })
	private Set<ActorBean> actors;
	
	@Lob
	@Column(name = "CollegeImage", columnDefinition = "mediumblob")
	private byte[] CollegeImage;

	public byte[] getCollegeImage() {
		return CollegeImage;
	}

	public void setCollegeImage(byte[] collegeImage) {
		CollegeImage = collegeImage;
	}

	@ManyToOne(cascade = {CascadeType.ALL})
	private BankDetailsBean bankDetailsOTM;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name = "stateId_Fk")
	private StateBean stateBean;
	
	@ManyToOne(cascade = {CascadeType.ALL})
	@JoinColumn(name = "serviceId_Fk", referencedColumnName = "serviceId")
	private ServicesBean serviceBean;
	
	
	@ManyToOne(cascade = {CascadeType.ALL})
	@JoinColumn(name = "comp_id_fk", referencedColumnName = "id")
	private CompanyBean companyBean;
	
	public CompanyBean getCompanyBean() {
		return companyBean;
	}

	public void setCompanyBean(CompanyBean companyBean) {
		this.companyBean = companyBean;
	}

	@OneToOne(cascade = {CascadeType.ALL}, mappedBy = "collgBean")
	LoginBean loginBean;
	
	public List<SubInstitute> getListOfSubInstitute() {
		return listOfSubInstitute;
	}

	public StateBean getStateBean() {
		return stateBean;
	}

	public void setStateBean(StateBean stateBean) {
		this.stateBean = stateBean;
	}
	public ServicesBean getServiceBean() {
		return serviceBean;
	}



	public void setServiceBean(ServicesBean serviceBean) {
		this.serviceBean = serviceBean;
	}

	public void setListOfSubInstitute(List<SubInstitute> listOfSubInstitute) {
		this.listOfSubInstitute = listOfSubInstitute;
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "clientTargetMappingToCollegeBean")
	List<PayeerTargetMappingToClient> listOfPayeerTargetMappingToClient = new ArrayList<PayeerTargetMappingToClient>();

	public List<PayeerTargetMappingToClient> getListOfPayeerTargetMappingToClient() {
		return listOfPayeerTargetMappingToClient;
	}

	public void setListOfPayeerTargetMappingToClient(
			List<PayeerTargetMappingToClient> listOfPayeerTargetMappingToClient) {
		this.listOfPayeerTargetMappingToClient = listOfPayeerTargetMappingToClient;
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "headCollegeBean")
	List<SubInstitute> listOfSubInstitute = new ArrayList<SubInstitute>();

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "collegeBeanMappingToSabPaisaClient")
	List<ClientMappingCodeOfSabPaisa> listOfColMappingSClient = new ArrayList<ClientMappingCodeOfSabPaisa>();

	public List<ClientMappingCodeOfSabPaisa> getListOfColMappingSClient() {
		return listOfColMappingSClient;
	}

	public void setListOfColMappingSClient(List<ClientMappingCodeOfSabPaisa> listOfColMappingSClient) {
		this.listOfColMappingSClient = listOfColMappingSClient;
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "CollegeBean_fk")
	List<OperatorBean> listOfOperatorBean = new ArrayList<OperatorBean>();

	public List<OperatorBean> getListOfOperatorBean() {
		return listOfOperatorBean;
	}

	public void setListOfOperatorBean(List<OperatorBean> listOfOperatorBean) {
		this.listOfOperatorBean = listOfOperatorBean;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	//one college can have multiple transaction managing relationship for that
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "collegeBean")
	@OrderBy("transDate DESC")
	Set<SampleTransBean> transactions;

	public Integer getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}

	@Pattern(regexp = "[0-9 a-z A-Z]*", message = "ID has invalid characters")
	public String getCollegeCode() {
		return collegeCode;
	}

	public void setCollegeCode(String collegeCode) {
		this.collegeCode = collegeCode;
	}

	/*@Pattern(regexp = "[a-zA-Z][a-zA-Z ]*", message = "Name has invalid characters")*/
	public String getCollegeName() {
		return collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	public BankDetailsBean getBankDetailsOTM() {
		return bankDetailsOTM;
	}

	public void setBankDetailsOTM(BankDetailsBean bankDetailsOTM) {
		this.bankDetailsOTM = bankDetailsOTM;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Set<SampleTransBean> getTransactions() {
		return transactions;
	}

	public void setTransactions(Set<SampleTransBean> transactions) {
		this.transactions = transactions;
	}

	public String getCollegeLogo() {
		return collegeLogo;
	}

	public void setCollegeLogo(String collegeLogo) {
		this.collegeLogo = collegeLogo;
	}

	@Pattern(regexp = "[0-9]*", message = "Number has invalid characters" )
	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

    @Pattern(regexp = "^[0-9a-zA-Z_.#@]*$", message = "Email Address has invalid characters")
	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}


    /*@Pattern(regexp = "^[0-9a-zA-Z_,/.'#@]*$", message = "Address has invalid characters")*/
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer geteGFDays() {
		return eGFDays;
	}

	public void seteGFDays(Integer eGFDays) {
		this.eGFDays = eGFDays;
	}

	public Set<ActorBean> getActors() {
		return actors;
	}

	public void setActors(Set<ActorBean> actors) {
		this.actors = actors;
	}

	public File getCollegeFile() {
		return collegeFile;
	}

	public void setCollegeFile(File collegeFile) {
		this.collegeFile = collegeFile;
	}

	public String getCollegeURL() {
		return collegeURL;
	}

	public void setCollegeURL(String collegeURL) {
		this.collegeURL = collegeURL;
	}

	public String getIdForCob() {
		return idForCob;
	}

	public void setIdForCob(String idForCob) {
		this.idForCob = idForCob;
	}
	
	public String getIsRefundEnabled() {
		return isRefundEnabled;
	}

	public void setIsRefundEnabled(String isRefundEnabled) {
		this.isRefundEnabled = isRefundEnabled;
	}

	public String getAuthIV() {
		return authIV;
	}

	public void setAuthIV(String authIV) {
		this.authIV = authIV;
	}

	public String getAuthKey() {
		return authKey;
	}

	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}

	public String getClientImagePath() {
		return clientImagePath;
	}

	public void setClientImagePath(String clientImagePath) {
		this.clientImagePath = clientImagePath;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	@Override
	public String toString() {
		return "CollegeBean [collegeCode=" + collegeCode + ", collegeName=" + collegeName 
				+ ", contact=" + contact + ", emailId=" + emailId + ", address="
				+ address + "]";
	}

}

