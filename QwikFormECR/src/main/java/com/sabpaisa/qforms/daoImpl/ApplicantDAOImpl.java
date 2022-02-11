package com.sabpaisa.qforms.daoImpl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.ApplicantDAO;

@Repository
public class ApplicantDAOImpl implements ApplicantDAO {
//	public static SessionFactory factoryReportsDB = ConnectionClass.getSessionFactoryfactoryReportsDB();
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/*public static SessionFactory factory = ConnectionClass.getFactory();*/
	static Logger log = Logger.getLogger(ApplicantDAOImpl.class.getName());
@Override
	public List<String> getAllAplicantDetails() {
        Session session = factory.openSession();
        Criteria criteria = session.createCriteria(SampleFormBean.class);
        criteria.setProjection((Projection)Projections.property((String)"formData"));
        List applicantDetails = criteria.list();
		session.close();
		
        return applicantDetails;
    }

@Override
    public List<SampleFormBean> getAllAplicantDetails1() {
        Session session = factory.openSession();
        Criteria criteria = session.createCriteria(SampleFormBean.class);
        criteria.setProjection((Projection)Projections.property((String)"formData"));
        List applicantDetails = criteria.list();
        session.close();
        return applicantDetails;
    }

@Override
    public List<SampleFormBean> getSuccessTransAplicantDetailsOfParticularClient(String feeType, String key, Object value) {
        List applicantDetails;
        applicantDetails = new ArrayList<SampleFormBean>();
        if (key != null && key.contentEquals("transIds")) {
            Session session = factory.openSession();
            try {
                try {
                    Criteria criteria = session.createCriteria(SampleFormBean.class).add((Criterion)Restrictions.eq((String)"formFeeName", (Object)feeType));
                    if (key != null && key.contentEquals("transIds")) {
                        criteria.add(Restrictions.in((String)"formTransId", (Collection)((List)value)));
                    }
                    applicantDetails = criteria.list();
                    log.debug((Object)("applicantDetails:" + applicantDetails.size()));
                }
                catch (Exception ex) {
                    ex.printStackTrace();
                    ArrayList<SampleFormBean> arrayList = (ArrayList<SampleFormBean>) applicantDetails;
                    session.close();
                    return arrayList;
                }
            }
            finally {
                session.close();
            }
        }
        return applicantDetails;
    }

@Override
    public List<Object[]> getSuccessTransAplicantDetailsOfParticularClientLatest(String feeType, String key, Object value, String cid) {
        List SuccessTransAplicantDetails;
        SuccessTransAplicantDetails = new ArrayList<Object[]>();
        Session session = factory.openSession();
        try {
            try {
                String query = "SELECT cd.formdata ,txn.transId,txn.spTransId,txn.transStatus FROM qcollect.data_form cd left join qcollect.data_transactions txn on cd.formTransId=txn.transId where txn.cid=:cid and txn.transStatus='SUCCESS' and txn.feeName=:feeName";
                SQLQuery sqlQuery = session.createSQLQuery(query);
                sqlQuery.setParameter("feeName", (Object)feeType);
                sqlQuery.setParameter("cid", (Object)cid);
                SuccessTransAplicantDetails = sqlQuery.list();
            }
            catch (Exception exception) {
                log.debug((Object)("SuccessTransAplicantDetails:-----:size=" + SuccessTransAplicantDetails.size()));
                ArrayList<Object[]> arrayList = (ArrayList<Object[]>) SuccessTransAplicantDetails;
                session.close();
                return arrayList;
            }
        }
        finally {
            session.close();
        }
        log.debug((Object)("SuccessTransAplicantDetails:-----:size=" + SuccessTransAplicantDetails.size()));
        return SuccessTransAplicantDetails;
    }

    @Override
    public List<String> getAllAplicantDetailsOfParticularClient(Integer collegeId, String feeType) {
        Session session = factory.openSession();
        List applicantDetails = new ArrayList();
        String strCollegeId = "" + collegeId;
        //log.info((Object)("college id in dao:" + strCollegeId));
        System.out.println("the given values of cid and feename:" + collegeId + " " + feeType);
        Criteria criteria = session.createCriteria(SampleFormBean.class).add((Criterion)Restrictions.eq((String)"formClientId", (Object)strCollegeId)).add((Criterion)Restrictions.eq((String)"formFeeName", (Object)feeType));
        criteria.setProjection((Projection)Projections.property((String)"formData"));
        applicantDetails = criteria.list();
        log.debug((Object)("applicantDetails:" + applicantDetails.size()));
        session.close();
        return applicantDetails;
    }

    @Override
    public List<String> getAllAplicantDetailsOfParticularClientForExcelDownlods(Integer collegeId) {
        Session session = factory.openSession();
        List applicantDetails = new ArrayList<String>();
        String strCollegeId = ""+collegeId;
        log.debug((Object)("college id in dao:" + strCollegeId));
        try {
            Criteria criteria = session.createCriteria(SampleFormBean.class).add((Criterion)Restrictions.eq((String)"formClientId", (Object)strCollegeId));
            criteria.setProjection((Projection)Projections.property((String)"formData"));
            applicantDetails = criteria.list();
            log.debug((Object)("applicantDetails:" + applicantDetails.size()));
            return applicantDetails;
        }
        catch (Exception ex) {
            return applicantDetails;
        }finally {
        	session.close();
		}
    }
}
