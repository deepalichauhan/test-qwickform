package com.sabpaisa.qforms.beans;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "super_admin_master_details")
public class SuperAdminBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	@Column(name = "id", unique = true, nullable = false)
	  private Integer id;
	  private String name;
	  private String contact;
	  private String email;
	  private String pass;
	  private String userName;
	  @ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	  @JoinColumn(name="companyId_Fk", referencedColumnName="id")
	  private CompanyBean companyBean;
	  
	  @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.EAGER)
	  @JoinColumn(name = "role_Id_Fk", referencedColumnName = "roleId")
	  private LookupRoleBean lookupRole;
		
	  public SuperAdminBean() {
		}

		public SuperAdminBean(int id) {
			this.id = id;
		}

		public SuperAdminBean(int id, CompanyBean companyMaster, String contact, String email, String name,
				String pass, String userName) {
			this.id = id;
			this.companyBean = companyMaster;
			this.contact = contact;
			this.email = email;
			this.name = name;
			this.pass = pass;
			this.userName = userName;
		}
	  
	  public LookupRoleBean getLookupRole() {
			return lookupRole;
	  }

	  public void setLookupRole(LookupRoleBean lookupRole) {
			this.lookupRole = lookupRole;
	  }
		
	  public CompanyBean getCompanyBean()
	  {
	    return companyBean;
	  }
	  
	  public void setCompanyBean(CompanyBean companyBean) {
	    this.companyBean = companyBean;
	  }
	  
	  public String getName()
	  {
	    return name;
	  }
	  
	 /* @Pattern(regexp="[a-z-A-Z]*", message="Name has invalid characters")*/
	  public void setName(String name) { this.name = name; }
	  
	  public String getContact()
	  {
	    return contact;
	  }
	  
	 /* @Pattern(regexp="[0-9]*", message="Phone number has invalid characters")*/
	  public void setContact(String contact) { this.contact = contact; }
	  
	  public String getEmail()
	  {
	    return email;
	  }
	  
	  public void setEmail(String email) {
	    this.email = email;
	  }
	  
	  public String getPass() {
	    return pass;
	  }
	  
	  /*@Pattern(regexp="^[0-9a-zA-Z_,/.'#@]*$", message="Password has invalid characters")*/
	  public void setPass(String pass) {
	    this.pass = pass;
	  }
	  
	  public String getUserName() {
	    return userName;
	  }
	  
	  /*@Pattern(regexp="[0-9a-z-A-Z]*", message="Name has invalid characters")*/
	  public void setUserName(String userName) { this.userName = userName; }
	  

	  public Integer getId()
	  {
	    return id;
	  }
	  
	  public void setId(Integer id) {
	    this.id = id;
	  }
}
