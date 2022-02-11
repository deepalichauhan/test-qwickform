package com.sabpaisa.qforms.daoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.dao.MainLoginDao;

@Repository
public class MainLoginDaoImpl implements MainLoginDao{
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("SuperAdminLoginDaoImpl.class");
	
	@Override
	public SuperAdminBean getLogin(/*SuperAdminBean sLogin*/String UserId,String Password, int roleId) throws HibernateException{
		
		log.info("Start of getLogin() in MainLoginDaoImpl" ); 
		
		log.debug("inside getLogin(), finding profile for userId {"+UserId+"} ,finding profile for password {"+Password+"} ");

		SuperAdminBean sBean = null;
		log.debug("inside getLogin(), finding profile for user {"+UserId+"}");
		Session session = factory.openSession();
		log.debug("UserId for superAdmin : "+UserId);
		log.debug("Password ::::: "+Password);
		log.debug("RoleId ::::: "+roleId);
		try {
							
				Criteria cr = session.createCriteria(SuperAdminBean.class);
				
				Criterion uname = Restrictions.eq("userName", UserId);
				Criterion passw = Restrictions.eq("pass",Password);
				Criterion roleIds = Restrictions.eq("role_Id_Fk",roleId);
				
				log.debug("UserId for superAdmin : "+uname);
				log.debug("Password ::::: "+passw);
				log.debug("User Role Type Id ::::: "+roleIds);
				
				LogicalExpression andExp = Restrictions.and(uname, passw);
				
				log.debug("value of andExp is in DaoImpl "+andExp);
				
				//LogicalExpression andExp1=Restrictions.and(andExp, roleIds);
				//andExp=Restrictions.and(andExp, roleIds);
				//log.debug("value of andExp is in DaoImpl "+andExp1);
				cr.add(andExp);
				log.debug("value of cr is "+cr.toString());

				if(cr.list().size()==0)
				{
					return null;
					
				}
				log.debug("Size "+cr.list().size());
				sBean = (SuperAdminBean) cr.list().iterator().next();			
				
				log.debug("sBean "+sBean.toString());
				log.debug("sBean "+sBean.getName());
				
				
				return sBean;
			} catch (java.util.NoSuchElementException ex) {
			return null;
		} finally {
			session.close();
		}		
	}
	
	@Override
	public SuperAdminBean getLogin(SuperAdminBean sLogin) {
		
		log.info("it is in getLogin() in LoginDaoImpl" ); 
		
		String sql="SELECT * FROM super_admin_master_details where username='"+sLogin.getUserName()+"' && pass='"+sLogin.getPass()+"'";
		List<SuperAdminBean> list=jdbcTemplate.query(sql, new SuperAdminBeanMapper());
		return list.size() > 0 ? list.get(0) : null;
		
		/*log.debug("inside getLogin(), finding profile for userId {"+UserId+"} ,finding profile for password {"+Password+"} ");

		SuperAdminBean criteria = null;
	
		Session session = factory.openSession();
		Transaction tx=session.beginTransaction();
		log.debug("UserId for superAdmin : "+UserId);
		log.debug("Password ::::: "+Password);
		try {
			
			
			//Criteria cr = session.createCriteria(SuperAdminBean.class);
						
			//Criterion uname = Restrictions.eq("userName", UserId);
			//Criterion passw = Restrictions.eq("pass",Password);
			//LogicalExpression andExp = Restrictions.and(uname, passw);
			criteria = (SuperAdminBean) getSession().createCriteria(SuperAdminBean.class)
					.add(Restrictions.ilike("userName", UserId)).add(Restrictions.ilike("pass", Password)).uniqueResult();
			//cr.add(andExp);
			if(criteria..size()==0)
			{
				return null;
				
			}
			log.debug("Size "+cr.list().size());
			sBean =(SuperAdminBean) cr.list().get(0);			
			
			log.debug("sBean "+sBean);
			log.debug("sBean "+sBean.getName());
			
			tx.commit();
			return criteria;
			
		} catch (java.util.NoSuchElementException ex) {
			tx.rollback();
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return criteria;*/
		
	}
	
	@Override
	public SuperAdminBean getLoginforCob(String UserId,String Password) throws HibernateException{
		
		log.info("Start of getLogin() in MainLoginDaoImpl" ); 
		
		log.debug("inside getLogin(), finding profile for userId {"+UserId+"} ,finding profile for password {"+Password+"} ");

		SuperAdminBean sBean = null;
		log.debug("inside getLogin(), finding profile for user {"+UserId+"}");
		Session session = factory.openSession();
		log.debug("UserId for superAdmin : "+UserId);
		log.debug("Password ::::: "+Password);
		
		try {
							
				Criteria cr = session.createCriteria(SuperAdminBean.class);
				
				Criterion uname = Restrictions.eq("userName", UserId);
				Criterion passw = Restrictions.eq("pass",Password);
				
				
				log.debug("UserId for superAdmin : "+uname);
				log.debug("Password ::::: "+passw);
				
				
				LogicalExpression andExp = Restrictions.and(uname, passw);
				
				log.debug("value of andExp is in DaoImpl "+andExp);
				
				//LogicalExpression andExp1=Restrictions.and(andExp, roleIds);
				//andExp=Restrictions.and(andExp, roleIds);
				//log.debug("value of andExp is in DaoImpl "+andExp1);
				cr.add(andExp);
				log.debug("value of cr is "+cr.toString());

				if(cr.list().size()==0)
				{
					return null;
					
				}
				log.debug("Size "+cr.list().size());
				sBean = (SuperAdminBean) cr.list().iterator().next();			
				
				log.debug("sBean "+sBean.toString());
				log.debug("sBean "+sBean.getName());
				
				
				return sBean;
			} catch (java.util.NoSuchElementException ex) {
			return null;
		} finally {
			session.close();
		}		
	}
	
	class SuperAdminBeanMapper implements RowMapper<SuperAdminBean> {
			
		@Override
		public SuperAdminBean mapRow(ResultSet rs, int rowNum) throws SQLException {

			SuperAdminBean sAdminBean = new SuperAdminBean();
		    sAdminBean.setId(rs.getInt("id"));
		    sAdminBean.setContact("contact");
		    sAdminBean.setEmail("email");
		    sAdminBean.setName("name");
		    sAdminBean.setPass("pass");
		    sAdminBean.setUserName("userName");
		    return sAdminBean;

		  }
	}
	
	public SessionFactory getFactory() {
		return factory;
	}

	public void setFactory(SessionFactory factory) {
		this.factory = factory;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	
}
