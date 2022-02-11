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
@Table(name="sub_institute_master")
public class SubInstitute implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	  private Integer instituteId;
	  private String instituteCode;
	  private String instituteName;
	  private String address;
	  private String parentInstituteCode;
	  private String instituteType;
	  @ManyToOne(cascade={javax.persistence.CascadeType.ALL})
	  private CollegeBean headCollegeBean;
	  
	  public SubInstitute() {}
	  
	  public Integer getInstituteId()
	  {
	    return instituteId;
	  }
	  

	  public void setInstituteId(Integer instituteId)
	  {
	    this.instituteId = instituteId;
	  }
	  

	  public String getInstituteCode()
	  {
	    return instituteCode;
	  }
	  

	  public void setInstituteCode(String instituteCode)
	  {
	    this.instituteCode = instituteCode;
	  }
	  

	  public String getInstituteName()
	  {
	    return instituteName;
	  }
	  

	  public void setInstituteName(String instituteName)
	  {
	    this.instituteName = instituteName;
	  }
	  

	  public String getAddress()
	  {
	    return address;
	  }
	  

	  public void setAddress(String address)
	  {
	    this.address = address;
	  }
	  

	  public CollegeBean getHeadCollegeBean()
	  {
	    return headCollegeBean;
	  }
	  

	  public void setHeadCollegeBean(CollegeBean headCollegeBean)
	  {
	    this.headCollegeBean = headCollegeBean;
	  }
	  

	  public String getParentInstituteCode()
	  {
	    return parentInstituteCode;
	  }
	  

	  public void setParentInstituteCode(String parentInstituteCode)
	  {
	    this.parentInstituteCode = parentInstituteCode;
	  }
	  

	  public String getInstituteType()
	  {
	    return instituteType;
	  }
	  

	  public void setInstituteType(String instituteType)
	  {
	    this.instituteType = instituteType;
	  }

}
