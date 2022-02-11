package com.sabpaisa.qforms.servicesImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.dao.ActorDao;
import com.sabpaisa.qforms.services.ActorService1;

@Service
public class ActorServiceImpl1 implements ActorService1{

	@Autowired
	ActorDao actorDAO; 
	
	@Override
	public ActorBean getActors(Integer actorId) {
		
		return actorDAO.getActors(actorId);
	}

	@Override
	public List<ActorBean> getActors(String key, Object value) {
		
		return actorDAO.getActors(key, value);
	}

	@Override
	public ActorBean saveActor(ActorBean saveData) {
		
		return actorDAO.saveActor(saveData);
	}

	@Override
	public boolean checkActorAlias(String actor_alias) {
		
		return actorDAO.checkActorAlias(actor_alias);
	}

	@Override
	public boolean checkActorEmail(String email) {

		return actorDAO.checkActorEmail(email);
	}

}