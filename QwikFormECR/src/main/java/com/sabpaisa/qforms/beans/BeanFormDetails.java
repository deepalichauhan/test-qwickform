package com.sabpaisa.qforms.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "data_form_details")
public class BeanFormDetails {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
    private Integer id;
    @Column(unique=true)
    private String formName;
    private Date formDate;
    private Date formStartDate;
    private Date formEndDate;
    private Date formLateEndDate;
    private Integer formOwnerId;
    private Integer validityflag;
    private String status;
    private String formOwnerName;
    private String saComment;
    private String image;
    private String jsEnabled;
    private String js_name;
    
    //@Column(name = "life_cycle")
    private String life_cycle;
    private String landingpage_srcPath;
    private String hasInstructions;
    private String fileLabel;
    private String file_ext;
    private String file_actu_name;
    private String isAadhaarVerified;
    private String isPANVerified;
    private String verificationFlag;
    private String validateFieldOfExcel;
    
    @Lob
    @Column(name="instructions", columnDefinition="mediumblob")
    private byte[] instructions;
    @Transient
    private String fromDateStr;
    @Transient
    private String toDateStr;
    @Transient
    private String toLateDateStr;
        
    private Integer status_by;
    private Integer payer_type;
    private Integer target_actor;
    
    @OneToMany(cascade={CascadeType.ALL}, orphanRemoval=true, fetch=FetchType.EAGER)
    @Fetch(FetchMode.SUBSELECT) 
    @JoinTable(name = "data_form_details_data_form_structure", uniqueConstraints = @UniqueConstraint(columnNames = "formStructure_id"), joinColumns = {
    		@JoinColumn(name = "data_form_details_id", nullable = false, updatable = false) }, inverseJoinColumns = {
    		@JoinColumn(name = "formStructure_id", unique = true, nullable = false, updatable = false) })
    private Set<BeanFormStructure> formStructure;
    
    @OneToOne(cascade={CascadeType.ALL})
    private BeanFeeDetails formFee;
    
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "beanFormDetail")
	ResultBean resultBean;
    
    @Transient
    private List<BeanFormStructure> structureList;
    
    @OneToMany(cascade={CascadeType.ALL}, orphanRemoval=true, fetch=FetchType.EAGER)
    @Fetch(FetchMode.SUBSELECT) 
    @JoinTable(name = "data_form_details_form_life_cycles", uniqueConstraints = @UniqueConstraint(columnNames = "formcycles_id"), joinColumns = {
	@JoinColumn(name = "data_form_details_id", nullable = false, updatable = false) }, inverseJoinColumns = {
	@JoinColumn(name = "formcycles_id", unique = true, nullable = false, updatable = false) })
    private Set<FormLifeCycleBean> formcycles;
    
    @ManyToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="comp_id_fk", referencedColumnName="id")
    private CompanyBean companyBean;
    
    @Transient
    private ArrayList<String> selectedFees = new ArrayList<String>();
    private String moveToPg;
    private String formResponseUrl;
    
    public String getMoveToPg() {
		return moveToPg;
	}

	public void setMoveToPg(String moveToPg) {
		this.moveToPg = moveToPg;
	}

	public String getFormResponseUrl() {
		return formResponseUrl;
	}

	public void setFormResponseUrl(String formResponseUrl) {
		this.formResponseUrl = formResponseUrl;
	}

	public ArrayList<String> getSelectedFees() {
		return selectedFees;
	}
	 
	public void setSelectedFees(ArrayList<String> selectedFees) {
		this.selectedFees = selectedFees;
	}
    
	public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFormName() {
        return this.formName;
    }

    public void setFormName(String formName) {
        this.formName = formName;
    }

    public Date getFormDate() {
        return this.formDate;
    }

    public void setFormDate(Date formDate) {
        this.formDate = formDate;
    }

    public Integer getFormOwnerId() {
        return this.formOwnerId;
    }

    public void setFormOwnerId(Integer formOwnerId) {
        this.formOwnerId = formOwnerId;
    }

    public Set<BeanFormStructure> getFormStructure() {
        return this.formStructure;
    }

    public void setFormStructure(Set<BeanFormStructure> formStructure) {
        this.formStructure = formStructure;
    }

    public BeanFeeDetails getFormFee() {
        return this.formFee;
    }

    public void setFormFee(BeanFeeDetails formFee) {
        this.formFee = formFee;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getStatus_by() {
        return this.status_by;
    }

    public void setStatus_by(Integer status_by) {
        this.status_by = status_by;
    }

    public Integer getPayer_type() {
        return this.payer_type;
    }

    public void setPayer_type(Integer payer_type) {
        this.payer_type = payer_type;
    }

    public Date getFormStartDate() {
        return this.formStartDate;
    }

    public void setFormStartDate(Date formStartDate) {
        this.formStartDate = formStartDate;
    }

    public Date getFormEndDate() {
        return this.formEndDate;
    }

    public void setFormEndDate(Date formEndDate) {
        this.formEndDate = formEndDate;
    }

    public String getFromDateStr() {
        return this.fromDateStr;
    }

    public void setFromDateStr(String fromDateStr) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.formStartDate = formatter.parse(fromDateStr);
        }
        catch (ParseException parseException) {
            // empty catch block
        }
        this.fromDateStr = fromDateStr;
    }

    public String getToDateStr() {
        return this.toDateStr;
    }

    public void setToDateStr(String toDateStr) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.formEndDate = formatter.parse(toDateStr);
        }
        catch (ParseException parseException) {
            // empty catch block
        }
        this.toDateStr = toDateStr;
    }

    public Date getFormLateEndDate() {
        return this.formLateEndDate;
    }

    public void setFormLateEndDate(Date formLateEndDate) {
        this.formLateEndDate = formLateEndDate;
    }

    public String getToLateDateStr() {
        return this.toLateDateStr;
    }

    public void setToLateDateStr(String toLateDateStr) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.formLateEndDate = formatter.parse(toLateDateStr);
        }
        catch (ParseException parseException) {
            // empty catch block
        }
        this.toLateDateStr = toLateDateStr;
    }

    public String getFormOwnerName() {
        return this.formOwnerName;
    }

    public void setFormOwnerName(String formOwnerName) {
        this.formOwnerName = formOwnerName;
    }

    public String getSaComment() {
        return this.saComment;
    }

    public void setSaComment(String saComment) {
        this.saComment = saComment;
    }

    public List<BeanFormStructure> getStructureList() {
        return this.structureList;
    }

    public void setStructureList(List<BeanFormStructure> structureList) {
        this.structureList = structureList;
    }

    public Integer getValidityflag() {
        return this.validityflag;
    }

    public void setValidityflag(Integer validityflag) {
        this.validityflag = validityflag;
    }

    public String getJsEnabled() {
        return this.jsEnabled;
    }

    public void setJsEnabled(String jsEnabled) {
        this.jsEnabled = jsEnabled;
    }

    public Set<FormLifeCycleBean> getFormcycles() {
        return this.formcycles;
    }

    public void setFormcycles(Set<FormLifeCycleBean> formcycles) {
        this.formcycles = formcycles;
    }

    public Integer getTarget_actor() {
        return this.target_actor;
    }

    public void setTarget_actor(Integer target_actor) {
        this.target_actor = target_actor;
    }

    public String getLife_cycle() {
		return life_cycle;
	}

	public void setLife_cycle(String life_cycle) {
		this.life_cycle = life_cycle;
	}

	public String getLandingpage_srcPath() {
        return this.landingpage_srcPath;
    }

    public void setLandingpage_srcPath(String landingpage_srcPath) {
        this.landingpage_srcPath = landingpage_srcPath;
    }

    public String getHasInstructions() {
        return this.hasInstructions;
    }

    public void setHasInstructions(String hasInstructions) {
        this.hasInstructions = hasInstructions;
    }

    public byte[] getInstructions() {
        return this.instructions;
    }

    public void setInstructions(byte[] instructions) {
        this.instructions = instructions;
    }

    public String getFileLabel() {
        return this.fileLabel;
    }

    public void setFileLabel(String fileLabel) {
        this.fileLabel = fileLabel;
    }

    public String getFile_ext() {
        return this.file_ext;
    }

    public void setFile_ext(String file_ext) {
        this.file_ext = file_ext;
    }

    public void setImage(String userImageFileName) {
    }

    public String getImage() {
        return this.image;
    }

    
    
    public String getFile_actu_name() {
		return file_actu_name;
	}

	public void setFile_actu_name(String file_actu_name) {
		this.file_actu_name = file_actu_name;
	}

	public CompanyBean getCompanyBean() {
        return this.companyBean;
    }

    public void setCompanyBean(CompanyBean companyBean) {
        this.companyBean = companyBean;
    }

    public String getJs_name() {
        return this.js_name;
    }

    public void setJs_name(String js_name) {
        this.js_name = js_name;
    }

    public String getIsAadhaarVerified() {
        return this.isAadhaarVerified;
    }

    public void setIsAadhaarVerified(String isAadhaarVerified) {
        this.isAadhaarVerified = isAadhaarVerified;
    }

    public String getIsPANVerified() {
        return this.isPANVerified;
    }

    public void setIsPANVerified(String isPANVerified) {
        this.isPANVerified = isPANVerified;
    }

    public String getVerificationFlag() {
        return this.verificationFlag;
    }

    public void setVerificationFlag(String verificationFlag) {
        this.verificationFlag = verificationFlag;
    }

	public String getValidateFieldOfExcel() {
		return validateFieldOfExcel;
	}

	public void setValidateFieldOfExcel(String validateFieldOfExcel) {
		this.validateFieldOfExcel = validateFieldOfExcel;
	}

	public ResultBean getResultBean() {
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean) {
		this.resultBean = resultBean;
	}
}
