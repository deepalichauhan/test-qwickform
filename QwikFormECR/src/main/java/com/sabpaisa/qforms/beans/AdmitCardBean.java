package com.sabpaisa.qforms.beans;

import javax.persistence.GeneratedValue;

@javax.persistence.Entity
@javax.persistence.Table(name = "admitcard")
public class AdmitCardBean {
	@org.hibernate.annotations.GenericGenerator(name = "g1", strategy = "increment")
	@javax.persistence.Id
	@GeneratedValue(generator = "g1")
	private Integer id;
	private String name;
	private String father_name;
	private String dob;
	private String roll_number;
	private String reg_number;
	private String center;
	private String applied_course;
	private String category;
	private String gender;
	private String toe;
	private String doe;

	public AdmitCardBean() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFather_name() {
		return father_name;
	}

	public void setFather_name(String father_name) {
		this.father_name = father_name;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getRoll_number() {
		return roll_number;
	}

	public void setRoll_number(String roll_number) {
		this.roll_number = roll_number;
	}

	public String getReg_number() {
		return reg_number;
	}

	public void setReg_number(String reg_number) {
		this.reg_number = reg_number;
	}

	public String getApplied_course() {
		return applied_course;
	}

	public void setApplied_course(String applied_course) {
		this.applied_course = applied_course;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCenter() {
		return center;
	}

	public void setCenter(String center) {
		this.center = center;
	}

	public String getDoe() {
		return doe;
	}

	public void setDoe(String doe) {
		this.doe = doe;
	}

	public String getToe() {
		return toe;
	}

	public void setToe(String toe) {
		this.toe = toe;
	}

	@Override
	public String toString() {
		return "AdmitCardBean [id=" + id + ", name=" + name + ", father_name=" + father_name + ", dob=" + dob
				+ ", roll_number=" + roll_number + ", reg_number=" + reg_number + ", center=" + center
				+ ", applied_course=" + applied_course + ", category=" + category + ", gender=" + gender + ", toe="
				+ toe + ", doe=" + doe + "]";
	}

}
