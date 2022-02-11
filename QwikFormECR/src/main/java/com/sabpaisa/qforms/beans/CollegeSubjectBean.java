package com.sabpaisa.qforms.beans;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "subject_detail_1")
public class CollegeSubjectBean {
    @GenericGenerator(name="g1", strategy="increment")
    @Id
    @GeneratedValue(generator="g1")
	private Integer sid;
	private Integer subject_max_seat;
	private String subject_code;
	private Integer subject_filled_seat;
	
	@OneToOne(cascade={CascadeType.ALL}, orphanRemoval=true, fetch=FetchType.EAGER)
    private BeanSubjectLookup subjectBean;

	public CollegeSubjectBean() {}

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Integer getSubject_max_seat() {
		return subject_max_seat;
	}

	public void setSubject_max_seat(Integer subject_max_seat) {
		this.subject_max_seat = subject_max_seat;
	}

	public String getSubject_code() {
		return subject_code;
	}

	public void setSubject_code(String subject_code) {
		this.subject_code = subject_code;
	}

	public Integer getSubject_filled_seat() {
		return subject_filled_seat;
	}

	public void setSubject_filled_seat(Integer subject_filled_seat) {
		this.subject_filled_seat = subject_filled_seat;
	}
	
	public BeanSubjectLookup getSubjectBean() {
		return subjectBean;
	}

	public void setSubjectBean(BeanSubjectLookup subjectBean) {
		this.subjectBean = subjectBean;
	}
}