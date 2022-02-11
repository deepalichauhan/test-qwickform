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
@Table(name = "lookup_role")
public class LookupRoleBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer roleId;
	private String roleName;
	
	@OneToMany(mappedBy = "lookupRole")
	List<SuperAdminBean> superAdminBean;
	
	@OneToMany(mappedBy = "lookupRoleBean")
	List<MainLoginBean> mainLoginBean;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<SuperAdminBean> getSuperAdminBean() {
		return superAdminBean;
	}

	public void setSuperAdminBean(List<SuperAdminBean> superAdminBean) {
		this.superAdminBean = superAdminBean;
	}
	
	public List<MainLoginBean> getMainLoginBean() {
		return mainLoginBean;
	}

	public void setMainLoginBean(List<MainLoginBean> mainLoginBean) {
		this.mainLoginBean = mainLoginBean;
	}
}
