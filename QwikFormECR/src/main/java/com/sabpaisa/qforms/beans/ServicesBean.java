package com.sabpaisa.qforms.beans;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "lookup_services")
public class ServicesBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	 private Integer serviceId;
	  private String serviceName;
	  @OneToMany(mappedBy="serviceBean")
	  List<CollegeBean> collegeBeanList;
	  
	  public ServicesBean() {}
	  
	  public Integer getServiceId()
	  {
	    return serviceId;
	  }
	  
	  public void setServiceId(Integer serviceId) { this.serviceId = serviceId; }
	  
	  public String getServiceName() {
	    return serviceName;
	  }
	  
	  public void setServiceName(String serviceName) { this.serviceName = serviceName; }
	  
	  public List<CollegeBean> getCollegeBeanList() {
	    return collegeBeanList;
	  }
	  
	  public void setCollegeBeanList(List<CollegeBean> collegeBeanList) { this.collegeBeanList = collegeBeanList; }
}
