package com.sabpaisa.qforms.daoImpl;

import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFeeLookup;
import com.sabpaisa.qforms.dao.DaoFee;

@Repository
public class DaoFeeImpl implements DaoFee{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("DaoFeeImpl.class");
	
	@Override
	public ArrayList<BeanFeeLookup> getFeeLookups(String key,Object value)
	{
		// Declarations
		ArrayList<BeanFeeLookup>feeLookupList=new ArrayList<BeanFeeLookup>();
		//log.info("From getFeeLookups K,V "+key+"  "+value);
		Session session = factory.openSession();
		try {
			// Open session from session factory
			
			Criteria cr=session.createCriteria(BeanFeeLookup.class);
			if(key.contentEquals("feeid"))
			{
				Integer feeid=(Integer)value;
				cr.add(Restrictions.eq("id", value));
			}
			feeLookupList=new ArrayList<BeanFeeLookup>(cr.list());
			
			return feeLookupList;

		} catch (Exception e) {
			e.printStackTrace();
			return feeLookupList;

		} finally {
			// close session
			session.close();
		}
	}
	
	@Override
	public BeanFeeDetails getFeeDetails(String key,Object value)
	{
		// Declarations
		ArrayList<BeanFeeDetails>feeLookupList=new ArrayList<BeanFeeDetails>();
		BeanFeeDetails fee=new BeanFeeDetails();
		Session session = factory.openSession();
		try {
			// Open session from session factory
			
			Criteria cr=session.createCriteria(BeanFeeDetails.class);
			if(key.contentEquals("feeid"))
			{
				Integer feeid=(Integer)value;
				cr.add(Restrictions.eq("id", value));
			}
			feeLookupList=new ArrayList<BeanFeeDetails>(cr.list());
			if(feeLookupList.size()>0)
			{
				fee=feeLookupList.get(0);
			}
			return fee;

		} catch (Exception e) {
			e.printStackTrace();
			return fee;

		} finally {
			// close session
			session.close();
		}
	}
	
	@Override
	public BeanFeeLookup saveFeeLookup(BeanFeeLookup lookupData) throws org.hibernate.exception.ConstraintViolationException
	{
		// Declarations

		// Open session from session factory
		log.info("Open saveFeeLookup() Method is in Daofeeimpl");
		log.debug("value of BeanFeeLookup String is in DaoImpl ::::::::: "+lookupData.toString());
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.save(lookupData);
			session.getTransaction().commit();
		
			return lookupData;

		} finally {
			log.debug("Close saveFeeLookup() Method is in Daofeeimpl");
			// close session
			session.close();
		}
	}
	
	//for local development
	@Override
	public Boolean checkFee(BeanFeeLookup lookupData)
			throws org.hibernate.exception.ConstraintViolationException {
		// Declarations
	    
	    boolean checkFee =false;
	  
		log.debug("look up Fee name  "+lookupData.getFeeName());
		
		// Open session from session factory
		log.debug("checking duplicate fee ");
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			Criteria criteria = session.createCriteria(BeanFeeLookup.class);
			criteria.add(Restrictions.eq("feeName", lookupData.getFeeName()));
		    criteria.setProjection(Projections.rowCount());
		    long count = (Long) criteria.uniqueResult();
		    session.getTransaction().commit();
		    log.debug("total row set count "+count);
		    if(count != 0){
		    	checkFee=true;
			      }
			   else{
				   checkFee = false;
			   }

		} finally {
			// close session
			session.close();
		}
		 return checkFee;
	}
}
