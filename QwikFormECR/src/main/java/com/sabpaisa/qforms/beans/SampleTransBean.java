package com.sabpaisa.qforms.beans;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity  
@Table(name = "data_transactions")
public class SampleTransBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	private Integer id;
    private String transId;
    private String transStatus;
    private String transPaymode;
    //private String transIdExt;
    @Temporal(value=TemporalType.TIMESTAMP)
    private Date transDate;
    @Temporal(value=TemporalType.TIMESTAMP)
    private Date txncloseDate;
    private Double transAmount;
    private Double transOgAmount;
    private Double transOtherChrg;
    private Double actAmount;
    private String name;
    private String email;
    private String contact;
    private String bid;
    private String cid;    
    private String challanNo;
    //private Date dob;
    //private String issuerRefNo;
    private String pgTransId;
    private String spRespCode;
    private String pgRespCode;
    private String payerID;
    private String feeName;
    private String transCharges;
    private String refundJob;
    private String refundId;
    private String refundSubmitDate;    
    private String refundCloseDate;    
    private String refundAmount;
    private Integer formId;
    
    @ManyToOne(targetEntity=CollegeBean.class)
    @JoinColumn(name="college_Id_fk", referencedColumnName="collegeId")
    private CollegeBean collegeBean;
    @OneToOne(cascade={CascadeType.ALL}, orphanRemoval=true)
    private SampleFormBean transForm;
    @Column(unique=true)
    private String spTransId;
    @Transient
    private String transCreationErrorFlag;

    public Integer getId() {
        return this.id;
    }

    public String getTransCreationErrorFlag() {
        return this.transCreationErrorFlag;
    }

    public void setTransCreationErrorFlag(String transCreationErrorFlag) {
        this.transCreationErrorFlag = transCreationErrorFlag;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTransId() {
        return this.transId;
    }

    public void setTransId(String transId) {
        this.transId = transId;
    }

    public String getTransStatus() {
        return this.transStatus;
    }

    public void setTransStatus(String transStatus) {
        this.transStatus = transStatus;
    }

    public String getTransPaymode() {
        return this.transPaymode;
    }

    public void setTransPaymode(String transPaymode) {
        this.transPaymode = transPaymode;
    }

    public Date getTransDate() {
        return this.transDate;
    }

    public void setTransDate(Date transDate) {
        this.transDate = transDate;
    }

    public SampleFormBean getTransForm() {
        return this.transForm;
    }

    public void setTransForm(SampleFormBean transForm) {
        this.transForm = transForm;
    }

    /*public String getTransIdExt() {
        return this.transIdExt;
    }

    public void setTransIdExt(String transIdExt) {
        this.transIdExt = transIdExt;
    }*/

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

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return this.contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    /*public Date getDob() {
        return this.dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getIssuerRefNo() {
        return this.issuerRefNo;
    }

    public void setIssuerRefNo(String issuerRefNo) {
        this.issuerRefNo = issuerRefNo;
    }*/

    public String getSpTransId() {
        return this.spTransId;
    }

    public void setSpTransId(String spTransId) {
        this.spTransId = spTransId;
    }

    public String getPgTransId() {
        return this.pgTransId;
    }

    public void setPgTransId(String pgTransId) {
        this.pgTransId = pgTransId;
    }

    public String getSpRespCode() {
        return this.spRespCode;
    }

    public void setSpRespCode(String spRespCode) {
        this.spRespCode = spRespCode;
    }

    public String getPgRespCode() {
        return this.pgRespCode;
    }

    public void setPgRespCode(String pgRespCode) {
        this.pgRespCode = pgRespCode;
    }

    public CollegeBean getCollegeBean() {
        return this.collegeBean;
    }

    public void setCollegeBean(CollegeBean collegeBean) {
        this.collegeBean = collegeBean;
    }

    public String getPayerID() {
        return this.payerID;
    }

    public void setPayerID(String payerID) {
        this.payerID = payerID;
    }

    public String getFeeName() {
        return this.feeName;
    }

    public void setFeeName(String feeName) {
        this.feeName = feeName;
    }

    public String getBid() {
        return this.bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public String getCid() {
        return this.cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getTransCharges() {
        return this.transCharges;
    }

    public void setTransCharges(String transCharges) {
        this.transCharges = transCharges;
    }

    public Double getTransOgAmount() {
        return this.transOgAmount;
    }

    public void setTransOgAmount(Double transOgAmount) {
        this.transOgAmount = transOgAmount;
    }

    public Double getTransOtherChrg() {
        return this.transOtherChrg;
    }

    public void setTransOtherChrg(Double transOtherChrg) {
        this.transOtherChrg = transOtherChrg;
    }

    public Double getActAmount() {
        return this.actAmount;
    }

    public void setActAmount(Double actAmount) {
        this.actAmount = actAmount;
    }

    public String getRefundJob() {
        return this.refundJob;
    }

    public void setRefundJob(String refundJob) {
        this.refundJob = refundJob;
    }

    public Date getTxncloseDate() {
        return this.txncloseDate;
    }

    public void setTxncloseDate(Date txncloseDate) {
        this.txncloseDate = txncloseDate;
    }

    public String getChallanNo() {
        return this.challanNo;
    }

    public void setChallanNo(String challanNo) {
        this.challanNo = challanNo;
    }

    public String getRefundId() {
		return refundId;
	}

	public void setRefundId(String refundId) {
		this.refundId = refundId;
	}

	public String getRefundSubmitDate() {
		return refundSubmitDate;
	}

	public void setRefundSubmitDate(String refundSubmitDate) {
		this.refundSubmitDate = refundSubmitDate;
	}

	public String getRefundCloseDate() {
		return refundCloseDate;
	}

	public void setRefundCloseDate(String refundCloseDate) {
		this.refundCloseDate = refundCloseDate;
	}

	public String getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(String refundAmount) {
		this.refundAmount = refundAmount;
	}

	public Integer getFormId() {
        return this.formId;
    }

    public void setFormId(Integer formId) {
        this.formId = formId;
    }
}
