package com.sabpaisa.qforms.daoImpl;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.sql.DataSource;
import javax.validation.ConstraintViolationException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.dao.OperatorDao;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.qforms.util.RandomPasswordGenerator;
import com.sabpaisa.qforms.util.SendMail;

@Repository
public class OperatorDaoImpl implements OperatorDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("OperatorDaoImpl.class");

	@Override
	   public String registerCollegeOperatorDao(OperatorBean operatorBean) {
	        Session session = factory.openSession();
	        String value = "true";
	        try {
	            Transaction transaction = session.beginTransaction();
	            session.saveOrUpdate((Object)operatorBean);
	            transaction.commit();
	            session.close();
	        }
	        catch (ConstraintViolationException e) {
	            e.printStackTrace();
	            value = "false";
	        }finally {
	        	session.close();
	        }
	        return value;
	    }

	@Override
	    public List<OperatorBean> getAllRecordsOfCollegeOperator(Integer cid) {
	        Session session = factory.openSession();
	        ArrayList<OperatorBean> listOfOptrRecords = new ArrayList();
	        try {
	            Criteria criteria = session.createCriteria(OperatorBean.class);
	            criteria.add((Criterion)Restrictions.eq((String)"CollegeBean_fk.collegeId", (Object)cid));
	            criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
	            ArrayList<OperatorBean> arrayList = listOfOptrRecords = (ArrayList<OperatorBean>) criteria.list();
	            return arrayList;
	        }
	        finally {
	            session.close();
	        }
	    }

	@Override
	    public Integer getRowCount() {
	        Session session = factory.openSession();
	        try {
	            Criteria c = session.createCriteria(OperatorBean.class);
	            c.addOrder(Order.desc((String)"operatorId"));
	            c.setMaxResults(1);
	            OperatorBean temp = (OperatorBean)c.uniqueResult();
	            Integer n = temp.getOperatorId() + 1;
	            return n;
	        }
	        finally {
	            session.close();
	        }
	    }

	@Override
	    public OperatorBean validateTheForgetPwdDetails(String profile, String emailId) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
	        Session session = factory.openSession();
	        try {
	            OperatorBean bean = (OperatorBean)session.createCriteria(OperatorBean.class).add((Criterion)Restrictions.eq((String)"operatorEmail", (Object)emailId)).list().iterator().next();
	            if (bean != null) {
	                LoginBean loginDetailsOfOperator = (LoginBean)session.get(LoginBean.class, (Serializable)bean.getLoginBean().getLoginId());
	                String password = RandomPasswordGenerator.generatePswd((int)6, (int)8, (int)1, (int)2, (int)0);
	                log.debug((Object)("Password Generated is " + password));
	                log.debug((Object)("User Name is " + bean.getLoginBean().getUserName()));
	                PasswordEncryption.encrypt((String)password);
	                String encryptedPwd = PasswordEncryption.encStr;
	                loginDetailsOfOperator.setPassword(encryptedPwd);
	                Transaction tx = session.beginTransaction();
	                session.saveOrUpdate((Object)loginDetailsOfOperator);
	                tx.commit();
	                String emailContent = "Welcome to the QwiCollect portal of " + bean.getCollegeBean_fk().getCollegeName();
	                SendMail email = new SendMail();
	                email.sendRegMail("Welcome To QForms !", bean.getOperatorEmail(), bean.getLoginBean().getUserName(), password, emailContent, String.valueOf(bean.getOperatorName()) + " " + bean.getOperatorLstName());
	                log.debug((Object)("password :" + password));
	            }
	            OperatorBean operatorBean = bean;
	            return operatorBean;
	        }
	        catch (NoSuchElementException ex) {
	            return null;
	        }
	        finally {
	            session.close();
	        }
	    }

	@Override
	    public Integer getCollegeIdOfOperator(Integer operatorId) {
	        Session session = factory.openSession();
	        Criteria criteria = session.createCriteria(OperatorBean.class);
	        criteria.add((Criterion)Restrictions.eq((String)"operatorId", (Object)operatorId));
	        criteria.setProjection((Projection)Projections.property((String)"affBean.instId"));
	        Integer collegeId = (Integer)criteria.list().iterator().next();
	        session.close();
	        return collegeId;
	    }

	@Override
	    public void updatePersonalRecordOfCollegeOperatorDetail(OperatorBean operatorBean) {
	        Session session = factory.openSession();
	        OperatorBean operatorBean2 = (OperatorBean)session.get(OperatorBean.class, (Serializable)operatorBean.getOperatorId());
	        operatorBean2.setOperatorName(operatorBean.getOperatorName());
	        operatorBean2.setOperatorAddress(operatorBean.getOperatorAddress());
	        operatorBean2.setOperatorLstName(operatorBean.getOperatorLstName());
	        operatorBean2.setOperatorEmail(operatorBean.getOperatorEmail());
	        operatorBean2.setOperatorContact(operatorBean.getOperatorContact());
	        operatorBean2.setOperatorContactSec(operatorBean.getOperatorContactSec());
	        Transaction transaction = session.beginTransaction();
	        session.merge((Object)operatorBean2);
	        transaction.commit();
	        session.close();
	    }

	@Override
	    public OperatorBean getOperatorDetails(int id) {
	        Session session = factory.openSession();
	        OperatorBean bean = (OperatorBean)session.createCriteria(OperatorBean.class).add((Criterion)Restrictions.eq((String)"operatorId", (Object)id)).list().iterator().next();
	        session.close();
	        return bean;
	    }

	@Override
	    public void deleteOperatorDetails(int parseInt) {
	        Session session = factory.openSession();
	        OperatorBean operatorBean2 = (OperatorBean)session.get(OperatorBean.class, (Serializable)Integer.valueOf(parseInt));
	        Transaction transaction = session.beginTransaction();
	        session.delete((Object)operatorBean2);
	        transaction.commit();
	        session.close();
	    }

	@Override
	    public OperatorBean viewOperatorDetail(int loginId) {
	        Session session = factory.openSession();
	        log.info((Object)"after creating session");
	        OperatorBean bean = (OperatorBean)session.get(OperatorBean.class, (Serializable)Integer.valueOf(loginId));
	        log.info((Object)"after fetching bean");
	        session.close();
	        return bean;
	    }
}

