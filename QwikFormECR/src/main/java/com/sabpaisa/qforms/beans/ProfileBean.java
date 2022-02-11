package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "profile_lookups")
public class ProfileBean {
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	 private Integer profile_id;
	  private String profile_name;
	  
	  public ProfileBean() {}
	  
	  public Integer getProfile_id()
	  {
	    return profile_id;
	  }
	  
	  public void setProfile_id(Integer profile_id) {
	    this.profile_id = profile_id;
	  }
	  
	  public String getProfile_name() {
	    return profile_name;
	  }
	  
	  public void setProfile_name(String profile_name) {
	    this.profile_name = profile_name;
	  }
	
}
