package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "users_sa_data")
public class BeanSA {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	  private Integer saId;
	  private String saName;
	  @OneToOne(cascade={javax.persistence.CascadeType.ALL})
	  private LoginBean loginBean;
	  
	  public BeanSA() {}
	  
	  public Integer getSaId()
	  {
	    return saId;
	  }
	  
	  public void setSaId(Integer saId) { this.saId = saId; }
	  
	  public String getSaName() {
	    return saName;
	  }
	  
	  public void setSaName(String saName) { this.saName = saName; }
	  
	  public LoginBean getLoginBean() {
	    return loginBean;
	  }
	  
	  public void setLoginBean(LoginBean loginBean) { this.loginBean = loginBean; }
}
