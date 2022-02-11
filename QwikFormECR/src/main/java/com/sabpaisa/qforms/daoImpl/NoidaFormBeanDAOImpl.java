package com.sabpaisa.qforms.daoImpl;

import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.NoidaFormBean;
import com.sabpaisa.qforms.dao.NoidaFormBeanDAO;

@Repository
public class NoidaFormBeanDAOImpl implements NoidaFormBeanDAO{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("SuperAdminLoginDaoImpl.class");
	
	/*public static SessionFactory factory = ConnectionClass.getFactory();
	static Logger log = Logger.getLogger(OperatorDao.class.getName());*/
	
	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<NoidaFormBean> getDetailsOfDataSumaryAnd(Integer clientId) {
		Session session = factory.openSession();
		ArrayList<NoidaFormBean> beanslist = (ArrayList)session.createCriteria(NoidaFormBean.class).add(Restrictions.eq("nAClientId", clientId)).list();
		session.close();
		
		return beanslist;
	}
}
