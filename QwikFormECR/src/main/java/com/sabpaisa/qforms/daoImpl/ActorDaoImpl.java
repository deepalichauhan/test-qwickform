package com.sabpaisa.qforms.daoImpl;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.ActorBean;
import com.sabpaisa.qforms.dao.ActorDao;

@Repository
public class ActorDaoImpl implements ActorDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	//public static SessionFactory factory = ConnectionClass.getFactory();
	private static Logger log = LogManager.getLogger(ActorDaoImpl.class.getName());

	@Override
	public ActorBean getActors(Integer actor_id) {
		// Declarations
		ActorBean actor = new ActorBean();
		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(ActorBean.class);
			cr.add(Restrictions.eq("actor_id", actor_id));
			actor = new ArrayList<ActorBean>(cr.list()).get(0);

			return actor;

		} catch (Exception e) {
			e.printStackTrace();
			return actor;

		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public List<ActorBean> getActors(String key, Object value) {
		log.debug("start of getActors() methods, key >> "+key+", client_id >>"+value.toString()+", profile >> PAYER");
		
		  	System.out.println("actor id for actor "+key+ "  "+value);
		    List<ActorBean> actors =null;
		    
		    Session session = factory.openSession();
		    try {
		      Criteria cr = session.createCriteria(ActorBean.class);
		      actors = new ArrayList<ActorBean>();
		      if (key.contentEquals("client_id")) {
		        cr.add(Restrictions.eq("client_id", (Integer)value));
		        actors =(List<ActorBean>) cr.list();
		        //return actors;
		      }
		      else if (key.contentEquals("payers")) {
		        cr.add(Restrictions.eq("client_id", (Integer)value));
		        cr.add(Restrictions.eq("profile", "PAYER"));
		        actors =(List<ActorBean>) cr.list();
		        //return actors;
		      }
		     else if (key.contentEquals("actors")) {
		          cr.add(Restrictions.eq("client_id", (Integer)value));
		          cr.add(Restrictions.eq("profile", "Actor"));
		          actors =(List<ActorBean>) cr.list();
		         // return actors;
		        }
		     else if (key.contentEquals("REVIEWER")) {
		         cr.add(Restrictions.eq("client_id", (Integer)value));
		         cr.add(Restrictions.eq("profile", "REVIEWER"));
		         actors =(List<ActorBean>) cr.list();
		         log.debug("size is "+actors.size());
		       //  return actors;
		       }
		        
		    /*  log.info("actor is "+cr.list());
		      actors = new ArrayList<ActorBean>(cr.list());*/
		      log.debug("size of actors "+actors.size());
		      
		      
		      return actors;
		    } catch (Exception e) {
		      List<ActorBean> localList1;
		      e.printStackTrace();
		      return actors;
		    }
		    finally
		    {
		      session.close();
		    }
		
		
		
		
		
		
		
		
		// Declarations
		/*List<ActorBean> actors = new ArrayList<ActorBean>();
		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(ActorBean.class);
			if (key.contentEquals("client_id")) {
				cr.add(Restrictions.eq("client_id", (Integer) value));
			}
			else if (key.contentEquals("payers")) {
				cr.add(Restrictions.eq("client_id", (Integer) value));
				cr.add(Restrictions.eq("profile","PAYER"));
			}

			actors = new ArrayList<ActorBean>(cr.list());
			log.info("start of getActors() methods, returning actors ");
			return actors;

		} catch (Exception e) {
			e.printStackTrace();
			return actors;

		} finally {
			// close session
			session.close();
		}*/
	}

	@Override
	public ActorBean saveActor(ActorBean saveData) {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(saveData);
			session.getTransaction().commit();
			return saveData;

		} catch (Exception e) {
			e.printStackTrace();
			return saveData;

		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public boolean checkActorAlias(String actor_alias) {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(ActorBean.class);
			cr.add(Restrictions.eq("actor_alias", actor_alias));

			if (cr.list().size() > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return true;

		} finally {
			// close session
			session.close();
		}
	}
	
	@Override
	public boolean checkActorEmail(String email) {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(ActorBean.class);
			cr.add(Restrictions.eq("email", email));

			if (cr.list().size() > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return true;

		} finally {
			// close session
			session.close();
		}
	}
}
