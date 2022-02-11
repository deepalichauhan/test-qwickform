package com.sabpaisa.qforms.beans;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "lookup_state" )
public class StateBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer stateId;
	  private String stateCode;
	  private String stateName;
	  
	 /* @OneToMany(mappedBy="stateBean")
	  List<CollegeBean> collegeBeanList;*/
	  
	  @OneToMany(mappedBy = "stateBean", cascade = { CascadeType.ALL }, fetch = FetchType.EAGER)
	  private List<CollegeBean> collegeBeanList;
	  
	  public StateBean() {}
	  
	  public Integer getStateId()
	  {
	    return stateId;
	  }
	  
	  public void setStateId(Integer stateId) { this.stateId = stateId; }
	  
	  public String getStateCode() {
	    return stateCode;
	  }
	  
	  public void setStateCode(String stateCode) { this.stateCode = stateCode; }
	  
	  public String getStateName() {
	    return stateName;
	  }
	  
	  public List<CollegeBean> getCollegeBeanList() { return collegeBeanList; }
	  
	  public void setCollegeBeanList(List<CollegeBean> collegeBeanList) {
	    this.collegeBeanList = collegeBeanList;
	  }
	  
	  public void setStateName(String stateName) { this.stateName = stateName; }
}
