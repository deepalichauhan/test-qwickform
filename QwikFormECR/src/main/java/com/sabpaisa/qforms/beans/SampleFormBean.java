package com.sabpaisa.qforms.beans;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "data_form" )
public class SampleFormBean {
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
    private Integer formId;
    
	@Type(type="text")
    private String formData;
    private Integer formTemplateId;
    @Column(unique=true)
    private String formTransId;
    private String formClientId;
    private Date formDate;
    private Integer formInstId;
    private Integer formApplicantId;
    private Integer formFeeId;
    private Double transAmount;
    private String name;
    private String contact;
    private String email;
    private String formFeeName;
    private String formStartDate;
    private String formEndDate;
    private String code;
    private String payerID;
    private String payerAadhaar;
    private String payerPAN;
    private String form_status;
    @Column(unique=true)
    private String formNumber;
    private String photo_ext;
    private String signature_ext;
	private String file_Path1, file_Path2, file_Path3, file_Path4, file_Path5, file_Path6, file_Path7, file_Path8,
			file_Path9, file_Path10;
    
    @OneToMany(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
    @Fetch(FetchMode.SUBSELECT) 
	@JoinTable(name = "data_form_file_uploads", uniqueConstraints = @UniqueConstraint(columnNames = "uploadedFiles_file_id"), joinColumns = {
	@JoinColumn(name = "data_form_formId", nullable = false, updatable = false) }, inverseJoinColumns = {
	@JoinColumn(name = "uploadedFiles_file_id", unique = true, nullable = false, updatable = false) })
    private Set<FormFileBean> uploadedFiles;
    
    @Lob
    @Column(name="photograph", columnDefinition="mediumblob")
    private byte[] photograph;
    @Lob
    @Column(name="signature", columnDefinition="mediumblob")
    private byte[] signature;
    @OneToOne(cascade={CascadeType.ALL}, orphanRemoval=true)
    private FormStateBean formstate;
    private Date dobDate;
    
    @Transient
    private String dob;

    public String getPayerID() {
        return this.payerID;
    }

    public String getPayerAadhaar() {
        return this.payerAadhaar;
    }

    public void setPayerAadhaar(String payerAadhaar) {
        this.payerAadhaar = payerAadhaar;
    }

    public String getPayerPAN() {
        return this.payerPAN;
    }

    public void setPayerPAN(String payerPAN) {
        this.payerPAN = payerPAN;
    }

    public void setPayerID(String payerID) {
        this.payerID = payerID;
    }

    public String getFormNumber() {
        return this.formNumber;
    }

    public void setFormNumber(String formNumber) {
        this.formNumber = formNumber;
    }

    public String getForm_status() {
        return this.form_status;
    }

    public void setForm_status(String form_status) {
        this.form_status = form_status;
    }

    public FormStateBean getFormstate() {
        return this.formstate;
    }

    public void setFormstate(FormStateBean formstate) {
        this.formstate = formstate;
    }

    public String getFormClientId() {
        return this.formClientId;
    }

    public void setFormClientId(String formClientId) {
        this.formClientId = formClientId;
    }

    public String getFormFeeName() {
        return this.formFeeName;
    }

    public void setFormFeeName(String formFeeName) {
        this.formFeeName = formFeeName;
    }

    public Integer getFormId() {
        return this.formId;
    }

    public void setFormId(Integer formId) {
        this.formId = formId;
    }

    public String getFormData() {
        return this.formData;
    }

    public void setFormData(String formData) {
        this.formData = formData;
    }

    public Integer getFormTemplateId() {
        return this.formTemplateId;
    }

    public void setFormTemplateId(Integer formTemplateId) {
        this.formTemplateId = formTemplateId;
    }

    public String getFormTransId() {
        return this.formTransId;
    }

    public void setFormTransId(String formTransId) {
        this.formTransId = formTransId;
    }

    public Date getFormDate() {
        return this.formDate;
    }

    public void setFormDate(Date formDate) {
        this.formDate = formDate;
    }

    public Integer getFormInstId() {
        return this.formInstId;
    }

    public void setFormInstId(Integer formInstId) {
        this.formInstId = formInstId;
    }

    public Integer getFormApplicantId() {
        return this.formApplicantId;
    }

    public void setFormApplicantId(Integer formApplicantId) {
        this.formApplicantId = formApplicantId;
    }

    public Integer getFormFeeId() {
        return this.formFeeId;
    }

    public void setFormFeeId(Integer formFeeId) {
        this.formFeeId = formFeeId;
    }

    //SampleFormBean(formData, formTemplateId, formSubmitDate, formInstId, formApplicantId, formFeeId, amount, formFeeName, startDate, endDate, payerID, formNumber)
    
    public SampleFormBean(String formData, Integer formTemplateId, Date formDate, Integer formInstId, Integer formApplicantId, Integer formFeeId, Double amount, String formFeeName, String startDate, String endDate, String payerID, String appFormNumber) {
        this.formData = formData;
        this.formTemplateId = formTemplateId;
        this.formDate = formDate;
        this.formInstId = formInstId;
        this.formApplicantId = formApplicantId;
        this.formFeeId = formFeeId;
        this.transAmount = amount;
        this.formFeeName = formFeeName;
        this.formStartDate = startDate;
        this.formEndDate = endDate;
        this.payerID = payerID;
        this.formNumber = appFormNumber;
    }
    
    public SampleFormBean(String formData, Integer formTemplateId, Date formDate, Integer formInstId, Integer formApplicantId, Integer formFeeId, String name, Date dob, String email, String contact, Double amount, String formFeeName, String startDate, String endDate, String code, String payerID, String appFormNumber) {
        this.formData = formData;
        this.formTemplateId = formTemplateId;
        this.formDate = formDate;
        this.formInstId = formInstId;
        this.formApplicantId = formApplicantId;
        this.formFeeId = formFeeId;
        this.name = name;
        this.dobDate = dob;
        this.contact = contact;
        this.email = email;
        this.transAmount = amount;
        this.formFeeName = formFeeName;
        this.formStartDate = startDate;
        this.formEndDate = endDate;
        this.code = code;
        this.payerID = payerID;
        this.formNumber = appFormNumber;
    }

    public SampleFormBean() {
    }

    public Double getTransAmount() {
        return this.transAmount;
    }

    public void setTransAmount(Double transAmount) {
        this.transAmount = transAmount;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContact() {
        return this.contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getDob() {
        return this.dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDobDate() {
        return this.dobDate;
    }

    public void setDobDate(Date dobDate) {
        this.dobDate = dobDate;
    }

    public String getFormStartDate() {
        return this.formStartDate;
    }

    public void setFormStartDate(String formStartDate) {
        this.formStartDate = formStartDate;
    }

    public String getFormEndDate() {
        return this.formEndDate;
    }

    public void setFormEndDate(String formEndDate) {
        this.formEndDate = formEndDate;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public byte[] getPhotograph() {
        return this.photograph;
    }

    public void setPhotograph(byte[] photograph) {
        this.photograph = photograph;
    }

    public byte[] getSignature() {
        return this.signature;
    }

    public void setSignature(byte[] signature) {
        this.signature = signature;
    }

    public Set<FormFileBean> getUploadedFiles() {
        return this.uploadedFiles;
    }

    public void setUploadedFiles(Set<FormFileBean> uploadedFiles) {
        this.uploadedFiles = uploadedFiles;
    }

    public String getPhoto_ext() {
        return this.photo_ext;
    }

    public void setPhoto_ext(String photo_ext) {
        this.photo_ext = photo_ext;
    }

    public String getSignature_ext() {
        return this.signature_ext;
    }

    public void setSignature_ext(String signature_ext) {
        this.signature_ext = signature_ext;
    }

	public String getFile_Path1() {
		return file_Path1;
	}

	public void setFile_Path1(String file_Path1) {
		this.file_Path1 = file_Path1;
	}

	public String getFile_Path2() {
		return file_Path2;
	}

	public void setFile_Path2(String file_Path2) {
		this.file_Path2 = file_Path2;
	}

	public String getFile_Path3() {
		return file_Path3;
	}

	public void setFile_Path3(String file_Path3) {
		this.file_Path3 = file_Path3;
	}

	public String getFile_Path4() {
		return file_Path4;
	}

	public void setFile_Path4(String file_Path4) {
		this.file_Path4 = file_Path4;
	}

	public String getFile_Path5() {
		return file_Path5;
	}

	public void setFile_Path5(String file_Path5) {
		this.file_Path5 = file_Path5;
	}

	public String getFile_Path6() {
		return file_Path6;
	}

	public void setFile_Path6(String file_Path6) {
		this.file_Path6 = file_Path6;
	}

	public String getFile_Path7() {
		return file_Path7;
	}

	public void setFile_Path7(String file_Path7) {
		this.file_Path7 = file_Path7;
	}

	public String getFile_Path8() {
		return file_Path8;
	}

	public void setFile_Path8(String file_Path8) {
		this.file_Path8 = file_Path8;
	}

	public String getFile_Path9() {
		return file_Path9;
	}

	public void setFile_Path9(String file_Path9) {
		this.file_Path9 = file_Path9;
	}

	public String getFile_Path10() {
		return file_Path10;
	}

	public void setFile_Path10(String file_Path10) {
		this.file_Path10 = file_Path10;
	}

	@Override
	public String toString() {
		return "SampleFormBean [formId=" + formId + ", formData=" + formData + ", formTemplateId=" + formTemplateId
				+ ", formTransId=" + formTransId + ", formClientId=" + formClientId + ", formDate=" + formDate
				+ ", formInstId=" + formInstId + ", formApplicantId=" + formApplicantId + ", formFeeId=" + formFeeId
				+ ", transAmount=" + transAmount + ", name=" + name + ", contact=" + contact + ", email=" + email
				+ ", formFeeName=" + formFeeName + ", formStartDate=" + formStartDate + ", formEndDate=" + formEndDate
				+ ", code=" + code + ", payerID=" + payerID + ", formNumber=" + formNumber + ", photo_ext=" + photo_ext
				+ ", signature_ext=" + signature_ext + ", file_Path=" + file_Path1 + ", formstate=" + formstate
				+ ", dobDate=" + dobDate + ", dob=" + dob + "]";
	}
	
	
}