package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "admit_card")
public class BeanAdmitCard {
	
	@org.hibernate.annotations.GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String subject, candidate_name, centerTest, date_written_test, cwe, reporting_time_we;
	private String duration_test, venue_viva_voce, date_viva_voce, cvve, reporting_time_vve, declaration;

	public BeanAdmitCard() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getCandidate_name() {
		return candidate_name;
	}

	public void setCandidate_name(String candidate_name) {
		this.candidate_name = candidate_name;
	}

	public String getCenterTest() {
		return centerTest;
	}

	public void setCenterTest(String centerTest) {
		this.centerTest = centerTest;
	}

	public String getDate_written_test() {
		return date_written_test;
	}

	public void setDate_written_test(String date_written_test) {
		this.date_written_test = date_written_test;
	}

	public String getCwe() {
		return cwe;
	}

	public void setCwe(String cwe) {
		this.cwe = cwe;
	}

	public String getReporting_time_we() {
		return reporting_time_we;
	}

	public void setReporting_time_we(String reporting_time_we) {
		this.reporting_time_we = reporting_time_we;
	}

	public String getDuration_test() {
		return duration_test;
	}

	public void setDuration_test(String duration_test) {
		this.duration_test = duration_test;
	}

	public String getVenue_viva_voce() {
		return venue_viva_voce;
	}

	public void setVenue_viva_voce(String venue_viva_voce) {
		this.venue_viva_voce = venue_viva_voce;
	}

	public String getDate_viva_voce() {
		return date_viva_voce;
	}

	public void setDate_viva_voce(String date_viva_voce) {
		this.date_viva_voce = date_viva_voce;
	}

	public String getCvve() {
		return cvve;
	}

	public void setCvve(String cvve) {
		this.cvve = cvve;
	}

	public String getReporting_time_vve() {
		return reporting_time_vve;
	}

	public void setReporting_time_vve(String reporting_time_vve) {
		this.reporting_time_vve = reporting_time_vve;
	}

	public String getDeclaration() {
		return declaration;
	}

	public void setDeclaration(String declaration) {
		this.declaration = declaration;
	}

}
