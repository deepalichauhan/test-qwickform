package com.sabpaisa.qforms.beans;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;



@Entity
@Table(name="data_form_structure")
public class BeanFormStructure
implements Comparable<BeanFormStructure> {
    @GenericGenerator(name="g1", strategy="increment")
    @Id
    @GeneratedValue(generator="g1")
    private Integer id;
    private Integer isMandatory;
    private String fieldValues;
    private Integer fieldOrder;
    private String jsEnabled;
    private String triggerEvent;
    private String jsFunction;
    private Integer isMandName;
    private Integer isMandMobileNumber;
    private Integer isMandEmail;
    private Integer isMandAmount;
    @OneToOne(cascade={CascadeType.ALL}, orphanRemoval=true, fetch=FetchType.EAGER)
    private BeanFieldLookup formField;
    
    @ManyToOne()

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIsMandatory() {
        return this.isMandatory;
    }

    public void setIsMandatory(Integer isMandatory) {
        this.isMandatory = isMandatory;
    }

    /*@Column(name = "fieldValues")*/
	public String getFieldValues() {
		return this.fieldValues;
	}

	public void setFieldValues(String fieldValues) {
		this.fieldValues = fieldValues;
	}
	
    public BeanFieldLookup getFormField() {
        return this.formField;
    }

    public void setFormField(BeanFieldLookup formField) {
        this.formField = formField;
    }

    public Integer getFieldOrder() {
        return this.fieldOrder;
    }

    public void setFieldOrder(Integer fieldOrder) {
        this.fieldOrder = fieldOrder;
    }

    public String getJsEnabled() {
        return this.jsEnabled;
    }

    public void setJsEnabled(String jsEnabled) {
        this.jsEnabled = jsEnabled;
    }

    public String getTriggerEvent() {
        return this.triggerEvent;
    }

    public void setTriggerEvent(String triggerEvent) {
        this.triggerEvent = triggerEvent;
    }

    public String getJsFunction() {
        return this.jsFunction;
    }

    public void setJsFunction(String jsFunction) {
        this.jsFunction = jsFunction;
    }

    public Integer getIsMandName() {
		return isMandName;
	}

	public void setIsMandName(Integer isMandName) {
		this.isMandName = isMandName;
	}

	public Integer getIsMandMobileNumber() {
		return isMandMobileNumber;
	}

	public void setIsMandMobileNumber(Integer isMandMobileNumber) {
		this.isMandMobileNumber = isMandMobileNumber;
	}

	public Integer getIsMandEmail() {
		return isMandEmail;
	}

	public void setIsMandEmail(Integer isMandEmail) {
		this.isMandEmail = isMandEmail;
	}

	public Integer getIsMandAmount() {
		return isMandAmount;
	}

	public void setIsMandAmount(Integer isMandAmount) {
		this.isMandAmount = isMandAmount;
	}

	@Override
    public int compareTo(BeanFormStructure o) {
        int compareorder = o.getFieldOrder();
        return this.fieldOrder - compareorder;
    }
}
