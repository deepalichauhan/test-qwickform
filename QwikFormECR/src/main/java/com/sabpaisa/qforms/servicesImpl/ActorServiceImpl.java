package com.sabpaisa.qforms.servicesImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.dao.ActorDao;
import com.sabpaisa.qforms.services.ActorService;

@Service
public class ActorServiceImpl implements ActorService {

	@Autowired
	ActorDao actorDao;
	
	@Override
	public ActorBean getActors(Integer actor_id) {
		// TODO Auto-generated method stub
		return actorDao.getActors(actor_id);
	}

	@Override
	public List<ActorBean> getActors(String key, Object value) {
		// TODO Auto-generated method stub
		return actorDao.getActors(key, value);
	}

	@Override
	public ActorBean saveActor(ActorBean saveData) {
		// TODO Auto-generated method stub
		return actorDao.saveActor(saveData);
	}

	@Override
	public boolean checkActorAlias(String actor_alias) {
		// TODO Auto-generated method stub
		return actorDao.checkActorAlias(actor_alias);
	}

	@Override
	public boolean checkActorEmail(String email) {
		// TODO Auto-generated method stub
		return actorDao.checkActorEmail(email);
	}

}
