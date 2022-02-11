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
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.OperatorBean;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.LoginDAO;
import com.sabpaisa.qforms.util.PasswordEncryption;

@Repository
public class LoginDAOImpl implements LoginDAO{

	AppPropertiesConfig appProp = new AppPropertiesConfig();
    Properties properties = this.appProp.getPropValues();
    String dbName = this.properties.getProperty("dbName");
    
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;

	private static final Logger log = LogManager.getLogger("LoginDaoImpl.class");
    
    
	@Override
    public String getDetailsOfSuperAdmin(SuperAdminBean superAdmin) {
        String profile = null;
        log.debug((Object)"finding profile");
        Session session = factory.openSession();
        try {
            String query = "select * from " + this.dbName + ".super_admin_master_details where userName=:userName and password=:pass";
            SQLQuery sqlQuery = session.createSQLQuery(query);
            sqlQuery.setParameter("userName", (Object)superAdmin.getUserName());
            sqlQuery.setParameter("pass", (Object)superAdmin.getPass());
            String string = profile = (String)sqlQuery.list().get(0);
            return string;
        }
        catch (NoSuchElementException ex) {
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<CompanyBean> getcompanyList1() {
        ArrayList<CompanyBean> companyListBean;
        Session session = factory.openSession();
        companyListBean = new ArrayList();
        try {
            try {
                companyListBean = (ArrayList<CompanyBean>) session.createCriteria(CompanyBean.class).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return companyListBean;
    }

	@Override
    public CompanyBean getcompanyList(Integer id) {
        CompanyBean companyList;
        Session session = factory.openSession();
        companyList = new CompanyBean();
        try {
            try {
                companyList = (CompanyBean)session.get(CompanyBean.class, (Serializable)id);
            }
            catch (NullPointerException ex) {
                CompanyBean companyBean = companyList;
                session.close();
                return companyBean;
            }
        }
        finally {
            session.close();
        }
        return companyList;
    }

	@Override
    public SuperAdminBean getLogin(String UserId, String Password) {
        SuperAdminBean sBean = null;
        log.debug("UserId and Password in getLogin() method "+UserId.toString()+" "+Password.toString());
        log.debug((Object)"finding profile");
        Session session = factory.openSession();
        log.debug((Object)("UserId " + UserId));
        log.debug((Object)("Password " + Password));
        try {
            Criteria cr = session.createCriteria(SuperAdminBean.class);
            SimpleExpression uname = Restrictions.eq((String)"userName", (Object)UserId);
            SimpleExpression passw = Restrictions.eq((String)"pass", (Object)Password);
            LogicalExpression andExp = Restrictions.and((Criterion)uname, (Criterion)passw);
            cr.add((Criterion)andExp);
            if (cr.list().size() == 0) {
                return null;
            }
            log.debug((Object)("Size " + cr.list().size()));
            sBean = (SuperAdminBean)cr.list().get(0);
            log.debug((Object)("sBean " + (Object)sBean));
            log.debug((Object)("sBean " + sBean.getName()));
            SuperAdminBean superAdminBean = sBean;
            return superAdminBean;
        }
        catch (NoSuchElementException ex) {
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public void EditSupeAdminDetails(SuperAdminBean superAdmin) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        SuperAdminBean bean = new SuperAdminBean();
        log.debug((Object)("id val:" + superAdmin.getId()));
        try {
            try {
                bean = (SuperAdminBean)session.get(SuperAdminBean.class, (Serializable)superAdmin.getId());
                log.debug((Object)("id:" + bean.getId()));
                bean.setUserName(superAdmin.getUserName());
                String encryptedPwd = null;
                PasswordEncryption.encrypt((String)String.valueOf(superAdmin.getPass()));
                encryptedPwd = PasswordEncryption.encStr;
                superAdmin.setPass(encryptedPwd);
                log.debug((Object)("testing :" + encryptedPwd));
                bean.setPass(superAdmin.getPass());
                bean.setContact(superAdmin.getContact());
                bean.setEmail(superAdmin.getEmail());
                bean.setName(superAdmin.getName());
                session.merge((Object)bean);
                tx.commit();
            }
            catch (Exception ex) {
                ex.printStackTrace();
                session.close();
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public SuperAdminBean saveUser(SuperAdminBean superAdmin) {
        Session session = factory.openSession();
        log.debug((Object)("credentails:" + superAdmin.getPass() + " " + superAdmin.getUserName()));
        try {
            try {
                String encryptedPwd = null;
                PasswordEncryption.encrypt((String)String.valueOf(superAdmin.getPass()));
                encryptedPwd = PasswordEncryption.encStr;
                superAdmin.setPass(encryptedPwd);
                log.debug((Object)("testing :" + encryptedPwd));
                session.beginTransaction();
                session.save((Object)superAdmin);
                session.getTransaction().commit();
            }
            catch (Exception e) {
                e.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
        return superAdmin;
    }
	
	@Override
    public SuperAdminBean getSuperAdminDetailsBasedOnId(String id) {
        SuperAdminBean bean;
        Session session = factory.openSession();
        bean = new SuperAdminBean();
        System.out.println("id:" + id);
        try {
            try {
                bean = (SuperAdminBean)session.createCriteria(SuperAdminBean.class).add((Criterion)Restrictions.eq((String)"id", (Object)Integer.parseInt(id))).list().get(0);
            }
            catch (NullPointerException ex) {
                SuperAdminBean superAdminBean = bean;
                session.close();
                return superAdminBean;
            }
        }
        finally {
            session.close();
        }
        return bean;
    }

	@Override
    public String getLoginDetails(LoginBean loginBean) {
        Session session = factory.openSession();
        String profile = null;
        try {
            log.debug((Object)"Get Login Details ");
            String query = "select profile from " + this.dbName + ".login_master where userName=:userName and password=:pass";
            SQLQuery sqlQuery = session.createSQLQuery(query);
            sqlQuery.setParameter("userName", (Object)loginBean.getUserName());
            sqlQuery.setParameter("pass", (Object)loginBean.getPassword());
            profile = (String)sqlQuery.list().get(0);
            log.debug((Object)("pwd" + (String)sqlQuery.list().get(1)));
            String string = profile;
            return string;
        }
        catch (IndexOutOfBoundsException aioub) {
            String string = profile;
            return string;
        }
        finally {
            log.debug((Object)"finally Block");
            session.close();
        }
    }

	@Override
    public List<SuperAdminBean> getAllSuperAdminDetails(String comId) {
		log.debug("start of getAllSuperAdminDetails() method for fetching list of superadminbean");
        Session session = factory.openSession();
        List<SuperAdminBean> sAdminlist = new ArrayList<SuperAdminBean>();
        try {
            sAdminlist = session.createCriteria(SuperAdminBean.class).add((Criterion)Restrictions.eq((String)"companyBean.id", (Object)Integer.parseInt(comId))).list();
            log.debug("sAdminlist is in logindaoimpl is: >>>>>>>>>>>> "+sAdminlist.toString());
            return sAdminlist;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<SuperAdminBean> arrayList = (ArrayList<SuperAdminBean>) sAdminlist;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public OperatorBean getDetailsOfCollegeOperator(String operatorUserName) {
        Session session = factory.openSession();
        LoginBean bean = new LoginBean();
        try {
            bean = (LoginBean)session.createCriteria(LoginBean.class).add((Criterion)Restrictions.eq((String)"userName", (Object)operatorUserName));
            OperatorBean operatorBean = bean.getOperatorBean();
            return operatorBean;
        }
        catch (NullPointerException e) {
            OperatorBean operatorBean = bean.getOperatorBean();
            return operatorBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public LoginBean getLoginUserDetail(String id, String profile) {
        Integer loginId = Integer.parseInt(id);
        Session session = factory.openSession();
        try {
            LoginBean loginBean;
            LoginBean loginBean2 = loginBean = (LoginBean)session.get(LoginBean.class, (Serializable)loginId);
            return loginBean2;
        }
        finally {
            session.close();
        }
    }

	@Override
    public CollegeBean getInstDetail(Integer instId) {
        Session session = factory.openSession();
        try {
            CollegeBean affBean;
            CollegeBean collegeBean = affBean = (CollegeBean)session.get(CollegeBean.class, (Serializable)instId);
            return collegeBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public OperatorBean getOperatorDetail(Integer operatorId) {
        Session session = factory.openSession();
        try {
            OperatorBean opBean;
            OperatorBean operatorBean = opBean = (OperatorBean)session.get(OperatorBean.class, (Serializable)operatorId);
            return operatorBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public void updateChangePwdDetails(LoginBean creds, String newPwd) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
        Session session = factory.openSession();
        String password = newPwd;
        log.debug((Object)("Password  is changed:" + password));
        PasswordEncryption.encrypt((String)password);
        String userEncryptedPwd = PasswordEncryption.encStr;
        LoginBean bean = (LoginBean)session.get(LoginBean.class, (Serializable)creds.getLoginId());
        bean.setPassword(userEncryptedPwd);
        Transaction tx = session.beginTransaction();
        session.merge((Object)bean);
        tx.commit();
        session.close();
    }

	@Override
    public Object getIdOFLoginUser(String profile, LoginBean bean) {
        Object loginUserId = null;
        Session session = factory.openSession();
        try {
            Criteria criteria = session.createCriteria(LoginBean.class);
            criteria.add((Criterion)Restrictions.eq((String)"password", (Object)bean.getPassword()));
            criteria.add((Criterion)Restrictions.eq((String)"userName", (Object)bean.getUserName()));
            if (profile.contentEquals("Institute")) {
                criteria.setProjection((Projection)Projections.property((String)"collgBean.collegeId"));
            } else if (profile.contentEquals("SuperAdmin")) {
                criteria.setProjection((Projection)Projections.property((String)"saBean.saId"));
            } else if (profile.contentEquals("Operator")) {
                criteria.setProjection((Projection)Projections.property((String)"operatorBean.operatorId"));
            } else if (profile.contentEquals("Actor")) {
                criteria.setProjection((Projection)Projections.property((String)"actorBean.actor_id"));
            }
            loginUserId = criteria.list().get(0);
            log.debug((Object)("Id got from Data BAse " + loginUserId));
            Object var7_6 = loginUserId;
            return var7_6;
        }
        finally {
            session.close();
        }
    }

	@Override
    public String getDetailsOfLoginUser(LoginBean loginBean) {
        String profile = null;
        log.info((Object)"finding profile");
        Session session = factory.openSession();
        try {
            log.debug((Object)("Password is ::::::" + loginBean.getPassword()));
            String query = "select profile from " + this.dbName + ".login_master where userName=:userName and password=:pass";
            SQLQuery sqlQuery = session.createSQLQuery(query);
            sqlQuery.setParameter("userName", (Object)loginBean.getUserName());
            sqlQuery.setParameter("pass", (Object)loginBean.getPassword());
            String string = profile = (String)sqlQuery.list().get(0);
            return string;
        }
        catch (NoSuchElementException ex) {
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public boolean checkUsername(String username) {
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(LoginBean.class);
            cr.add((Criterion)Restrictions.eq((String)"userName", (Object)username));
            if (cr.list().size() > 0) {
                return true;
            }
            return false;
        }
        catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        finally {
            session.close();
        }
    }

	@Override
    public LoginBean saveCreds(LoginBean saveData) {
		
		log.info("Open LoginBean saveCreds() method in LoginDaoImpl");
        Session session = factory.openSession();
        try {
            session.beginTransaction();
            session.saveOrUpdate((Object)saveData);
            session.getTransaction().commit();
            LoginBean loginBean = saveData;
            return loginBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            LoginBean loginBean = saveData;
            return loginBean;
        }
        finally {
        	log.info("End LoginBean saveCreds() method in LoginDaoImpl");
        	session.close();
        }
    }
}
