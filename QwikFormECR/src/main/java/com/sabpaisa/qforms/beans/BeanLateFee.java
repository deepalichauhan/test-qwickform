package com.sabpaisa.qforms.beans;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "data_latefee")
public class BeanLateFee implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer id;
	private String latefeeType;
	private Double latefeeAmount;
	private String latefeeFormula;
	private Date latefeeStartdate;
	private Date latefeeEnddate;

	public BeanLateFee() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLatefeeType() {
		return latefeeType;
	}

	public void setLatefeeType(String latefeeType) {
		this.latefeeType = latefeeType;
	}

	public Double getLatefeeAmount() {
		return latefeeAmount;
	}

	public void setLatefeeAmount(Double latefeeAmount) {
		this.latefeeAmount = latefeeAmount;
	}

	public String getLatefeeFormula() {
		return latefeeFormula;
	}

	public void setLatefeeFormula(String latefeeFormula) {
		this.latefeeFormula = latefeeFormula;
	}

	public Date getLatefeeStartdate() {
		return latefeeStartdate;
	}

	public void setLatefeeStartdate(Date latefeeStartdate) {
		this.latefeeStartdate = latefeeStartdate;
	}

	public Date getLatefeeEnddate() {
		return latefeeEnddate;
	}

	public void setLatefeeEnddate(Date latefeeEnddate) {
		this.latefeeEnddate = latefeeEnddate;
	}

	@Override
	public String toString() {
		return "BeanLateFee [id=" + id + ", latefeeType=" + latefeeType + ", latefeeAmount=" + latefeeAmount
				+ ", latefeeFormula=" + latefeeFormula + ", latefeeStartdate=" + latefeeStartdate + ", latefeeEnddate="
				+ latefeeEnddate + "]";
	}
	
}
