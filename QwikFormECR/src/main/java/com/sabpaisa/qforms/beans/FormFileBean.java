package com.sabpaisa.qforms.beans;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "file_uploads")
public class FormFileBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	 private Integer file_id;
	  @Lob
	  @Column(name="file_data", columnDefinition="mediumblob")
	  private byte[] file_data;
	  private Integer field_id;
	  private String file_description;
	  private String file_extension;
	  private String file_img;
	  private String file_path;
	  @ManyToMany(fetch = FetchType.EAGER)
	  @JoinTable(name = "data_form_file_uploads", uniqueConstraints = @UniqueConstraint(columnNames = "uploadedFiles_file_id"), joinColumns = {
	  @JoinColumn(name = "uploadedFiles_file_id", unique = true, nullable = false, updatable = false) }, inverseJoinColumns = {
	  @JoinColumn(name = "data_form_formId", nullable = false, updatable = false) })
	  private Set<SampleFormBean> dataForms = new HashSet<SampleFormBean>(0);
	  
	  public FormFileBean() {}
	  
	  
	  
    public String getFile_path() {
 		return file_path;
    }
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public Integer getFile_id()
	  {
	    return file_id;
	  }
	  
	  public void setFile_id(Integer file_id) {
	    this.file_id = file_id;
	  }
	  
	  public byte[] getFile_data() {
	    return file_data;
	  }
	  
	  public void setFile_data(byte[] file_data) {
	    this.file_data = file_data;
	  }
	  
	  public Integer getField_id() {
	    return field_id;
	  }
	  
	  public void setField_id(Integer field_id) {
	    this.field_id = field_id;
	  }
	  
	  public String getFile_description() {
	    return file_description;
	  }
	  
	  public void setFile_description(String file_description) {
	    this.file_description = file_description;
	  }
	  
	  public String getFile_extension() {
	    return file_extension;
	  }
	  
	  public void setFile_extension(String file_extension) {
	    this.file_extension = file_extension;
	  }
	  

	  public String getFile_img()
	  {
	    return file_img;
	  }
	  
	  public void setFile_img(String file_img) {
	    this.file_img = file_img;
	  }

	public Set<SampleFormBean> getDataForms() {
		return dataForms;
	}

	public void setDataForms(Set<SampleFormBean> dataForms) {
		this.dataForms = dataForms;
	}
}
