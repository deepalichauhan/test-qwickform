package com.sabpaisa.qforms.daoImpl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.dao.WhiteLevalDao;

@Repository("whiteLevalDao")
public class WhiteLevalDaoImpl implements WhiteLevalDao {
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("WhiteLevalDaoImpl.class");

	
	@Override
    public List<CollegeBean> getCollegeListOfBank(int bid) {
    	log.info("called getCollegeList "+bid);
        Session session = factory.openSession();
        List<CollegeBean> collegelist = new ArrayList<CollegeBean>();
        try {
            if (bid == 0) {
                collegelist = session.createCriteria(CollegeBean.class).list();
            } else {
            	
                BankDetailsBean bankDetailsBean = (BankDetailsBean)session.get(BankDetailsBean.class, (Serializable)Integer.valueOf(bid));
                //log.info("bank detail bean is "+bankDetailsBean.getBankname() + "  "+bankDetailsBean.getListOfColleges().size());
                collegelist =(bankDetailsBean.getListOfColleges());
                log.info("college list is "+collegelist.size());
            }
            List<CollegeBean> arrayList = collegelist;
            return arrayList;
        }
        catch (NullPointerException ex) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)ex);
            return null;
        }
        catch (Exception e) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)e);
            return null;
        }
        finally {
            session.close();
        }
    }
	
	@Override
    public  List<StateBean> getStateList() {
        ArrayList<StateBean> StatesListBean;
        Session session = factory.openSession();
        StatesListBean = new ArrayList<>();
        try {
            try {
                StatesListBean = (ArrayList<StateBean>) session.createCriteria(StateBean.class).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return StatesListBean;
    }
	
	@Override
    public  List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId) {
        ArrayList<CollegeBean> CollegeBeanDetailsBean;
        Session session = factory.openSession();
        CollegeBeanDetailsBean = new ArrayList<>();
        try {
            try {
                //CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"stateBean.stateId", (Object)stateId)).add((Criterion)Restrictions.eq((String)"serviceBean.serviceId", (Object)serviceId)).add((Criterion)Restrictions.eq((String)"bankDetailsOTM.bankId", (Object)bankId)).list();
                CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"stateBean.stateId", (Object)stateId)).add((Criterion)Restrictions.eq((String)"bankDetailsOTM.bankId", (Object)bankId)).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return CollegeBeanDetailsBean;
    }
	
	
	/*@Override
    public List<StateBean> getListOfStateByBankId(int bid) {
    	log.info("called getCollegeList "+bid);
        Session session = factory.openSession();
        List<StateBean> stateBean = new ArrayList<StateBean>();
        try {
            if (bid == 0) {
            	stateBean = session.createCriteria(StateBean.class).list();
            } else {
            	
            	CollegeBean collegeBean = (CollegeBean)session.get(CollegeBean.class, (Serializable)Integer.valueOf(bid));
                log.info("bank detail bean is "+collegeBean.getState() + "  "+collegeBean.gets.size());
                stateBean =(bankDetailsBean.getListOfColleges());
                log.info("college list is "+stateBean.size());
            }
            List<StateBean> stateList = stateBean;
            return stateList;
        }
        catch (NullPointerException ex) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)ex);
            return null;
        }
        catch (Exception e) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)e);
            return null;
        }
        finally {
            session.close();
        }
    }*/
	

}
