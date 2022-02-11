package com.sabpaisa.qforms.services;

import java.util.List;

import com.sabpaisa.qforms.beans.ActorBean;

public interface ActorService {

	public ActorBean getActors(Integer actor_id);
	public List<ActorBean> getActors(String key, Object value);
	public ActorBean saveActor(ActorBean saveData);
	public boolean checkActorAlias(String actor_alias);
	public boolean checkActorEmail(String email);
}
