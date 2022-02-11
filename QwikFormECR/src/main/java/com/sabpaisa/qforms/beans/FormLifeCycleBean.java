package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "form_life_cycles")
public class FormLifeCycleBean {
	
	@GenericGenerator(name = "g1", strategy = "increment")
	@Id
	@GeneratedValue(generator = "g1")
    private Integer id;
    private Integer form_id;
    private Integer stage_number;
    private String actor_action;
    private String form_action;
    private String form_status;
    private Integer actor_id;
    private String isEditable;
    @Transient
    private ActorBean actor;

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getForm_id() {
        return this.form_id;
    }

    public void setForm_id(Integer form_id) {
        this.form_id = form_id;
    }

    public Integer getStage_number() {
        return this.stage_number;
    }

    public void setStage_number(Integer stage_number) {
        this.stage_number = stage_number;
    }

    public String getActor_action() {
        return this.actor_action;
    }

    public void setActor_action(String actor_action) {
        this.actor_action = actor_action;
    }

    public String getForm_action() {
        return this.form_action;
    }

    public void setForm_action(String form_action) {
        this.form_action = form_action;
    }

    public String getForm_status() {
        return this.form_status;
    }

    public void setForm_status(String form_status) {
        this.form_status = form_status;
    }

    public Integer getActor_id() {
        return this.actor_id;
    }

    public void setActor_id(Integer actor_id) {
        this.actor_id = actor_id;
    }

    public ActorBean getActor() {
        return this.actor;
    }

    public void setActor(ActorBean actor) {
        this.actor = actor;
    }

    public String getIsEditable() {
        return this.isEditable;
    }

    public void setIsEditable(String isEditable) {
        this.isEditable = isEditable;
    }
}
