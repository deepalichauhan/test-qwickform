package com.sabpaisa.qforms.dao;

import java.util.List;

import com.sabpaisa.qforms.beans.ActorBean;

public interface ActorDao1 {

	public ActorBean getActors(Integer actor_Id);
	public List<ActorBean> getActors(String key, Object value);
	public ActorBean saveActor(ActorBean saveData);
	public boolean checkActorAlias(String actor_alias);
	public boolean checkActorEmail(String email);
}