package com.sabpaisa.qforms.beans;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "data_fee_details")
public class BeanFeeDetails {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer id;
	private Date feeStartDate;
	private Date feeEndDate;
	private Date feeLateEndDate;
	private Double feeBaseAmount;
	private Integer isLatefeeApplicable;
	
	/*@OneToOne(cascade={javax.persistence.CascadeType.ALL}, orphanRemoval=true)
	private BeanLateFee latefee;*/
	 

	@OneToMany(cascade = { CascadeType.ALL }, orphanRemoval = true, fetch = FetchType.EAGER)
	@Fetch(FetchMode.SUBSELECT)
	@JoinTable(name = "data_fee_details_data_latefee", uniqueConstraints = @UniqueConstraint(columnNames = "data_latefee_id"), joinColumns = {
			@JoinColumn(name = "data_fee_details_id", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "data_latefee_id", unique = true, nullable = false, updatable = false) })
	private Set<BeanLateFee> latefeeset;

	@Transient
    private List<BeanLateFee> listOfLateFee;
	
	@OneToOne(cascade = { javax.persistence.CascadeType.ALL }, orphanRemoval = true)
	private BeanFeeLookup feeLookup;

	public Set<BeanLateFee> getLatefeeset() {
		return latefeeset;
	}

	public void setLatefeeset(Set<BeanLateFee> latefeeset) {
		this.latefeeset = latefeeset;
	}

	public List<BeanLateFee> getListOfLateFee() {
		return listOfLateFee;
	}

	public void setListOfLateFee(List<BeanLateFee> listOfLateFee) {
		this.listOfLateFee = listOfLateFee;
	}

	public BeanFeeDetails() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getFeeStartDate() {
		return feeStartDate;
	}

	public void setFeeStartDate(Date feeStartDate) {
		this.feeStartDate = feeStartDate;
	}

	public Date getFeeEndDate() {
		return feeEndDate;
	}

	public void setFeeEndDate(Date feeEndDate) {
		this.feeEndDate = feeEndDate;
	}

	public Date getFeeLateEndDate() {
		return feeLateEndDate;
	}

	public void setFeeLateEndDate(Date feeLateEndDate) {
		this.feeLateEndDate = feeLateEndDate;
	}

	public Double getFeeBaseAmount() {
		return feeBaseAmount;
	}

	public void setFeeBaseAmount(Double feeBaseAmount) {
		this.feeBaseAmount = feeBaseAmount;
	}

	public Integer getIsLatefeeApplicable() {
		return isLatefeeApplicable;
	}

	public void setIsLatefeeApplicable(Integer isLatefeeApplicable) {
		this.isLatefeeApplicable = isLatefeeApplicable;
	}

	public BeanFeeLookup getFeeLookup() {
		return feeLookup;
	}

	public void setFeeLookup(BeanFeeLookup feeLookup) {
		this.feeLookup = feeLookup;
	}
}
