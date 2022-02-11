package com.sabpaisa.qforms.daoImpl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.FormActionsBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.FormStateHistoryBean;
import com.sabpaisa.qforms.dao.LifeCycleDAO;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class LifeCycleDAOImpl implements LifeCycleDAO{
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;

	private static Logger log = LogManager.getLogger(LifeCycleDAOImpl.class.getName());

	DBConnection connection = new DBConnection();	
	
	@Override
	public ArrayList<BeanFieldLookup> getFieldLookups() {
        ArrayList<BeanFieldLookup> lookupList = new ArrayList<BeanFieldLookup>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFieldLookup.class);
            ArrayList<BeanFieldLookup> arrayList = lookupList = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanFieldLookup> arrayList = lookupList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<FormActionsBean> getFormActions() {
		log.debug("Open getFormActions() method is in LifeCycleDaoImpl");
        ArrayList<FormActionsBean> lookupList = new ArrayList<FormActionsBean>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormActionsBean.class);
            ArrayList<FormActionsBean> arrayList = lookupList = new ArrayList(cr.list());
            
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<FormActionsBean> arrayList = lookupList;
            return arrayList;
        }
        finally {
        	log.debug("End getFormActions() method is in LifeCycleDaoImpl");
            session.close();
        }
    }

	@Override
    public FormActionsBean getFormAction(String action_name) {
        FormActionsBean actionBean = new FormActionsBean();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormActionsBean.class);
            log.debug((Object)("action_name is::" + action_name));
            cr.add((Criterion)Restrictions.eq((String)"action_name", (Object)action_name));
            FormActionsBean formActionsBean = actionBean = (FormActionsBean)new ArrayList(cr.list()).get(0);
            return formActionsBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            FormActionsBean formActionsBean = actionBean;
            return formActionsBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public FormLifeCycleBean getFormCycle(Integer stageNo, Integer formId) {
        FormLifeCycleBean cyclebean = new FormLifeCycleBean();
        Session session = factory.openSession();
        try {
            log.debug((Object)("getting form cycle details for stage number " + stageNo));
            Criteria cr = session.createCriteria(FormLifeCycleBean.class);
            cr.add((Criterion)Restrictions.eq((String)"form_id", (Object)formId));
            cr.add((Criterion)Restrictions.eq((String)"stage_number", (Object)stageNo));
            FormLifeCycleBean formLifeCycleBean = cyclebean = (FormLifeCycleBean)new ArrayList(cr.list()).get(0);
            return formLifeCycleBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            FormLifeCycleBean formLifeCycleBean = cyclebean;
            return formLifeCycleBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public FormStateBean getLatestState(Integer formInstanceId) {
        FormStateBean statebean = new FormStateBean();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormStateBean.class);
            cr.add((Criterion)Restrictions.eq((String)"form_instance_id", (Object)formInstanceId));
            FormStateBean formStateBean = statebean = (FormStateBean)new ArrayList(cr.list()).get(0);
            return formStateBean;
        }
        catch (Exception e) {
            FormStateBean formStateBean = statebean;
            return formStateBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public FormStateBean getFormState(Integer stateId) {
        FormStateBean statebean = new FormStateBean();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormStateBean.class);
            cr.add((Criterion)Restrictions.eq((String)"state_id", (Object)stateId));
            FormStateBean formStateBean = statebean = (FormStateBean)new ArrayList(cr.list()).get(0);
            return formStateBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            FormStateBean formStateBean = statebean;
            return formStateBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public FormStateBean saveFormState(FormStateBean saveData) {
        Session session = factory.openSession();
        try {
            session.beginTransaction();
            session.saveOrUpdate((Object)saveData);
            session.getTransaction().commit();
            FormStateBean formStateBean = saveData;
            return formStateBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            FormStateBean formStateBean = saveData;
            return formStateBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public FormStateHistoryBean archiveFormState(FormStateHistoryBean saveData) {
        Session session = factory.openSession();
        try {
            session.beginTransaction();
            session.saveOrUpdate((Object)saveData);
            session.getTransaction().commit();
            FormStateHistoryBean formStateHistoryBean = saveData;
            return formStateHistoryBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            FormStateHistoryBean formStateHistoryBean = saveData;
            return formStateHistoryBean;
        }
        finally {
            session.close();
        }
    }

	@Override
	public Boolean checkTableExit(String tempTableName) throws SQLException {
		
		Boolean CreateDBflag = Boolean.valueOf(false);
		
		
		Integer sheetNo = 1;
		Connection con = null;
		con = connection.getConnectionApp();
		try {
			DatabaseMetaData meta = con.getMetaData();
			ResultSet res = meta.getTables(null, null, tempTableName, null);
			//log.debug("No of Column is ==" + res.getRow());
			if (!res.next()) {
				CreateDBflag = Boolean.valueOf(true);
				log.info("Table Not Exists");
			} else {
				log.info("Table Exist");
				CreateDBflag = Boolean.valueOf(false);
				sheetNo = getSheetCounter(tempTableName);
				sheetNo = sheetNo + 1;
				//log.debug("After increment Sheet No = " + sheetNo);
			}
		} catch (Exception localException) {

		} finally {
			con.close();
		}
		
		return CreateDBflag;
	}
	
	public Integer getSheetCounter(String tempTableName) {
		Integer sheetNo = 0;
		Connection conn = null;
		Statement stmt = null;
		try {

			conn = connection.getConnectionApp();
			stmt = conn.createStatement();

			String sql = "SELECT form_Name FROM " + tempTableName;
			ResultSet rs = stmt.executeQuery(sql);
			// STEP 5: Extract data from result set
			while (rs.next()) {
				// Retrieve by column name
				int id = rs.getInt("form_Name");
				log.debug(" id is = " + id);
				sheetNo = id;
			}
			rs.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException see) {
					see.printStackTrace();
				}

			}
		}
		return sheetNo;
	}
}
