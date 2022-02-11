package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "subject_detail")
public class SheetFillingBeanForBu {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer sid;
    private Integer subject_id;
    private Integer client_id;
    private Integer subject_max_seat;
    private Integer subject_filled_seat;
    private String College_Category;
    private String paymentUrl;
    
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(Integer subject_id) {
		this.subject_id = subject_id;
	}
	public Integer getClient_id() {
		return client_id;
	}
	public void setClient_id(Integer client_id) {
		this.client_id = client_id;
	}
	public Integer getSubject_max_seat() {
		return subject_max_seat;
	}
	public void setSubject_max_seat(Integer subject_max_seat) {
		this.subject_max_seat = subject_max_seat;
	}
	public Integer getSubject_filled_seat() {
		return subject_filled_seat;
	}
	public void setSubject_filled_seat(Integer subject_filled_seat) {
		this.subject_filled_seat = subject_filled_seat;
	}
	
	public String getPaymentUrl() {
		return paymentUrl;
	}
	public void setPaymentUrl(String paymentUrl) {
		this.paymentUrl = paymentUrl;
	}
	
	public String getCollege_Category() {
		return College_Category;
	}
	public void setCollege_Category(String college_Category) {
		College_Category = college_Category;
	}
	
	@Override
	public String toString() {
		return "SheetFillingBeanForBu [sid=" + sid + ", subject_id=" + subject_id + ", client_id=" + client_id
				+ ", subject_max_seat=" + subject_max_seat + ", subject_filled_seat=" + subject_filled_seat 
				+ ", paymentUrl=" + paymentUrl +"]";
	}
	
}
