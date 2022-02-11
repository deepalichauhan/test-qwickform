package com.sabpaisa.qforms.beans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "client_actors")
public class ActorBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer actor_id;
	  private Integer client_id;
	  private String profile;
	  private String actor_alias;
	  private String email;
	  private Integer operatorId;
	  
	  public ActorBean() {}
	  
	  public Integer getActor_id()
	  {
	    return actor_id;
	  }
	  
	  public void setActor_id(Integer actor_id) { this.actor_id = actor_id; }
	  
	  public Integer getClient_id() {
	    return client_id;
	  }
	  
	  public void setClient_id(Integer client_id) { this.client_id = client_id; }
	  
	  public String getProfile() {
	    return profile;
	  }
	  
	  public void setProfile(String profile) { this.profile = profile; }
	  
	  public String getActor_alias() {
	    return actor_alias;
	  }
	  
	  public void setActor_alias(String actor_alias) { this.actor_alias = actor_alias; }
	  
	  public String getEmail() {
	    return email;
	  }
	  
	  	public void setEmail(String email) { this.email = email; }

		public Integer getOperatorId() {
			return operatorId;
		}
		
		public void setOperatorId(Integer operatorId) {
			this.operatorId = operatorId;
		}
}