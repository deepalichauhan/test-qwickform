package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "lookup_form_payers")
public class PayerTypeBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer payer_id;
	private String payer_type,bid,cid,clientName;
	public Integer getPayer_id() {
		return payer_id;
	}
	public void setPayer_id(Integer payer_id) {
		this.payer_id = payer_id;
	}
	public String getPayer_type() {
		return payer_type;
	}
	public void setPayer_type(String payer_type) {
		this.payer_type = payer_type;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
}
