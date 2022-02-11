package com.sabpaisa.qforms.daoImpl;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.FeedbackBean;
import com.sabpaisa.qforms.dao.FeedbackDetailsDao;

@Repository
public class FeedbackDetailsDaoImpl implements FeedbackDetailsDao{

	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("FeedbackDetailsDaoImpl.class");	
	  
	  @Override
	  public void saveFeedbackDetailsDao(FeedbackBean feedbackBean) {
	    Session session = factory.openSession();
	    Transaction tx = session.beginTransaction();
	    session.saveOrUpdate(feedbackBean);
	    tx.commit();
	    session.close();
	  }
}
