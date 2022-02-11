package com.sabpaisa.qforms.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "lookup_form_fields")
public class BeanFieldLookup {

	
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
    private Integer lookup_id;
    
	@Column(unique=true)
    private String lookup_name;
    
	private String lookup_type;
    private String lookup_subtype;
    private Integer isPredefined;
    private String validation_expression;
    
    @Type(type="text")
    private String notification_content;
    
    private Integer isVisible;
    
    @Transient
    private Integer isMandatory;
    
    @Transient
    private Integer fieldOrder;

    @Transient
    private Integer isMandFieldForSp;
    
    public Integer getLookup_id() {
        return this.lookup_id;
    }

    public void setLookup_id(Integer lookup_id) {
        this.lookup_id = lookup_id;
    }

    public String getLookup_name() {
        return this.lookup_name;
    }

    public void setLookup_name(String lookup_name) {
        this.lookup_name = lookup_name;
    }

    public String getLookup_type() {
        return this.lookup_type;
    }

    public void setLookup_type(String lookup_type) {
        this.lookup_type = lookup_type;
    }

    public Integer getIsPredefined() {
        return this.isPredefined;
    }

    public void setIsPredefined(Integer isPredefined) {
        this.isPredefined = isPredefined;
    }

    public String getLookup_subtype() {
        return this.lookup_subtype;
    }

    public void setLookup_subtype(String lookup_subtype) {
        this.lookup_subtype = lookup_subtype;
    }

    public Integer getIsMandatory() {
        return this.isMandatory;
    }

    public void setIsMandatory(Integer isMandatory) {
        this.isMandatory = isMandatory;
    }

    public Integer getFieldOrder() {
        return this.fieldOrder;
    }

    public void setFieldOrder(Integer fieldOrder) {
        this.fieldOrder = fieldOrder;
    }

    public String getValidation_expression() {
        return this.validation_expression;
    }

    public void setValidation_expression(String validation_expression) {
        this.validation_expression = validation_expression;
    }

    public String getNotification_content() {
        return this.notification_content;
    }

    public void setNotification_content(String notification_content) {
        this.notification_content = notification_content;
    }

    public Integer getIsVisible() {
        return this.isVisible;
    }

    public void setIsVisible(Integer isVisible) {
        this.isVisible = isVisible;
    }

	public Integer getIsMandFieldForSp() {
		return isMandFieldForSp;
	}

	public void setIsMandFieldForSp(Integer isMandFieldForSp) {
		this.isMandFieldForSp = isMandFieldForSp;
	}
    
}
