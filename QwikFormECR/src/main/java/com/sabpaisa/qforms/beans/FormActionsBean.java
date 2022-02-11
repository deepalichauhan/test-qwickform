package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "form_actions_lookup")
public class FormActionsBean {

	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
	   private Integer action_id;
    private String action_name;
    private String action_type;

    public Integer getAction_id() {
        return this.action_id;
    }

    public void setAction_id(Integer action_id) {
        this.action_id = action_id;
    }

    public String getAction_name() {
        return this.action_name;
    }

    public void setAction_name(String action_name) {
        this.action_name = action_name;
    }

    public String getAction_type() {
        return this.action_type;
    }

    public void setAction_type(String action_type) {
        this.action_type = action_type;
    }
}
