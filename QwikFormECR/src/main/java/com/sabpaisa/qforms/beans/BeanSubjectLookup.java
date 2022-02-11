package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "lookup_subjects")
public class BeanSubjectLookup {

	
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
    private Integer id;
    
	//@Column(unique=true)
    private String subject_name;
    
	private String subject_Code;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSubject_name() {
		return subject_name;
	}

	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

	public String getSubject_Code() {
		return subject_Code;
	}

	public void setSubject_Code(String subject_Code) {
		this.subject_Code = subject_Code;
	}
   
}
