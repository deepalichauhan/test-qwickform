package com.sabpaisa.qforms.daoImpl;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.ResultBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.DaoFieldLookup;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.SendMail;

@Repository
public class DaoFieldLookupImpl implements DaoFieldLookup{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("DaoFieldLookupImpl.class");

	DBConnection connection = new DBConnection();
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	
	
	@Override
	public ArrayList<BeanFieldLookup> getFieldLookups() {
        ArrayList lookupList = new ArrayList<BeanFieldLookup>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFieldLookup.class);
            cr.add((Criterion)Restrictions.eq((String)"isVisible", (Object)1));
            ArrayList arrayList = lookupList = new ArrayList(cr.list());
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
	public List<BeanFormDetails> fetchAllFomsByClientCode(String clientCode) {
		Session session=factory.openSession();
		List<BeanFormDetails> listOfFormDetail=new ArrayList<BeanFormDetails>();
		try {
			Criteria cr=session.createCriteria(BeanFormDetails.class);
			listOfFormDetail=cr.add((Criterion)Restrictions.eq("formOwnerName", clientCode)).list();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listOfFormDetail;
	}
	
	@Override
    public BeanFormDetails getInstructionDetailsBasedOnId(String id) {
        BeanFormDetails form;
        Session session = factory.openSession();
        form = new BeanFormDetails();
        System.out.println("formId :" + id);
        try {
            try {
                form = (BeanFormDetails)session.createCriteria(BeanFormDetails.class).add((Criterion)Restrictions.eq((String)"id", (Object)Integer.parseInt(id))).list().get(0);
            }
            catch (NullPointerException ex) {
                BeanFormDetails beanFormDetails = form;
                session.close();
                return beanFormDetails;
            }
        }
        finally {
            session.close();
        }
        return form;
    }
    
	//for testing
	@Override
    public BeanFormDetails getInstructionDetailsBasedOnIds(Integer id) {
        BeanFormDetails form;
        Session session = factory.openSession();
        form = new BeanFormDetails();
        System.out.println("comp_id_fk :" + id);
        try {
            try {
                form = (BeanFormDetails)session.createCriteria(BeanFormDetails.class).add((Criterion)Restrictions.eq((String)"comp_id_fk", (Object)(id))).list().get(0);
            }
            catch (NullPointerException ex) {
                BeanFormDetails beanFormDetails = form;
                session.close();
                return beanFormDetails;
            }
        }
        finally {
            session.close();
        }
        return form;
    }

	@Override
    public ArrayList<BeanPayerType> getPayerLookups(LoginBean loginUser) {
        ArrayList lookupList = new ArrayList<BeanPayerType>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanPayerType.class).add((Criterion)Restrictions.eq((String)"bid", (Object)loginUser.getCollgBean().getBankDetailsOTM().getBankId().toString())).add((Criterion)Restrictions.eq((String)"cid", (Object)loginUser.getCollgBean().getCollegeId().toString())).add((Criterion)Restrictions.eq((String)"clientName", (Object)loginUser.getCollgBean().getCollegeName()));
            ArrayList arrayList = lookupList = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanPayerType> arrayList = lookupList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public void saveInstructionDetailsDao(BeanFormDetails form) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        BeanFormDetails bean = null;
        log.debug((Object)("id val:" + form.getId()));
        try {
            try {
                bean = (BeanFormDetails)session.get(BeanFormDetails.class, (Serializable)form.getId());
                log.debug((Object)("instruction Id :" + bean.getId()));
                bean.setInstructions(form.getInstructions());
                bean.setHasInstructions(form.getHasInstructions());
                session.merge((Object)bean);
                tx.commit();
            }
            catch (Exception ex) {
                ex.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<BeanFormDetails> getPendingFormsFromTemplate(Integer actor_id) {
        ArrayList formsList = new ArrayList<BeanFormDetails>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            cr.add((Criterion)Restrictions.eq((String)"target_actor", (Object)actor_id));
            ArrayList arrayList = formsList = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanFormDetails> arrayList = formsList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<FormStateBean> getPendingFormsFromInstance(Integer actor_id) {
        ArrayList formsList = new ArrayList<FormStateBean>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormStateBean.class);
            cr.add((Criterion)Restrictions.eq((String)"next_actor_id", (Object)actor_id));
            formsList = new ArrayList(cr.list());
            int i = 0;
            while (i < formsList.size()) {
                ((FormStateBean)formsList.get(i)).setFormdetails(this.getFormDetails(((FormStateBean)formsList.get(i)).getForm_id()));
                ++i;
            }
            ArrayList arrayList = formsList;
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<FormStateBean> arrayList = formsList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<FormStateBean> getPendingFormsFromInstance(Integer actor_id, String Username) {
        ArrayList formsList = new ArrayList<FormStateBean>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(FormStateBean.class);
            cr.add((Criterion)Restrictions.eq((String)"next_actor_id", (Object)actor_id));
            cr.add((Criterion)Restrictions.eq((String)"username", (Object)Username));
            formsList = new ArrayList(cr.list());
            int i = 0;
            while (i < formsList.size()) {
                ((FormStateBean)formsList.get(i)).setFormdetails(this.getFormDetails(((FormStateBean)formsList.get(i)).getForm_id()));
                ++i;
            }
            ArrayList arrayList = formsList;
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<FormStateBean> arrayList = formsList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<SampleFormBean> getPendingFormsData(List<Integer> formIds) {
        ArrayList formsList = new ArrayList<SampleFormBean>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(SampleFormBean.class);
            cr.add(Restrictions.in((String)"formTemplateId", formIds));
            ArrayList arrayList = formsList = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<SampleFormBean> arrayList = formsList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public BeanPayerType getPayerLookups(String payerName) {
        BeanPayerType payer = new BeanPayerType();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanPayerType.class);
            cr.add((Criterion)Restrictions.eq((String)"payer_type", (Object)payerName));
            BeanPayerType beanPayerType = payer = (BeanPayerType)new ArrayList(cr.list()).get(0);
            return beanPayerType;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanPayerType beanPayerType = payer;
            return beanPayerType;
        }
        finally {
            session.close();
        }
    }
	
	@Override
	public BeanPayerType getPayerLookupsById(Integer payerId) {
        BeanPayerType payer = new BeanPayerType();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanPayerType.class);
            cr.add((Criterion)Restrictions.eq("payer_id", payerId));
            BeanPayerType beanPayerType = payer = (BeanPayerType)new ArrayList(cr.list()).get(0);
            return beanPayerType;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanPayerType beanPayerType = payer;
            return beanPayerType;
        }
        finally {
            session.close();
        }
    }

	@Override
    public ArrayList<BeanFieldLookup> getFieldLookups(ArrayList<Integer> lookupIds) {
		log.info("Open getFieldLookups() method in Dao fieldlookupimpl");
		//log.info("LookupIds as FieldIds is ::::::::::::: "+lookupIds.toString());
		
        ArrayList<BeanFieldLookup> lookupList = new ArrayList<BeanFieldLookup>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFieldLookup.class);
            cr.add(Restrictions.in((String)"lookup_id", lookupIds));
            ArrayList<BeanFieldLookup> arrayList = lookupList = new ArrayList<BeanFieldLookup>(cr.list());
            //log.info("arrayList is in daoimpl ::::::::: "+arrayList.toString());
            log.info("End getFieldLookups() method in Dao fieldlookupimpl");
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
    public BeanFormDetails getFormDetails(Integer formId) {
    	log.info("Start getFormDetails() method,  in DaoFieldLookupImpl for fetching formdata, formId is > "+formId);
        BeanFormDetails result = new BeanFormDetails();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            cr.add((Criterion)Restrictions.eq("id", formId));
            Iterator it = cr.list().iterator();
            if (it.hasNext()) {
                result = (BeanFormDetails)it.next();
            }
            BeanFormDetails beanFormDetails = result;
            log.info("value of beanformdetails is :::::::::>>>>>>>>>>>:::::::::: "+beanFormDetails.toString());
            
            return beanFormDetails;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanFormDetails beanFormDetails = result;
            return beanFormDetails;
        }
        finally {
            session.close();
        }
    }
	
	@Override
    public Map<Integer, String> getFormDataAsCollegeCode(String ccode) throws SQLException {
    	log.info("Start getFormDetails() method in DaoFieldLookupImpl for fetching formdata ");
    	Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		Map<Integer,String> formMap = new HashMap<Integer,String>();
		String form="";
		Integer formId=null;
		
		if(null!=ccode) {
			log.debug("colBean ::::: "+ccode.toString());
			try {
				String query = "select * from "+dbName+".data_form_details where formOwnerName='"+ccode+"'";
				
				stmt = con.createStatement();
				rs = stmt.executeQuery(query);
	
				while (rs.next()) {
	
					form=rs.getString("formName");
					formId=rs.getInt("id");
					//System.out.println(code);
					//formList.add(form);
					formMap.put(formId, form);
				}
			//	System.out.println(formMap.toString());
				
			} catch (Exception e) {
				e.printStackTrace();
				
			} finally {
				
				con.close();
			}
		}
			return formMap;
    }

	@Override
    public BeanFormDetails getFormDetails(String formid) {
        BeanFormDetails result = new BeanFormDetails();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            cr.add((Criterion)Restrictions.eq((String)"id", (Object)formid));
            Iterator it = cr.list().iterator();
            if (it.hasNext()) {
                result = (BeanFormDetails)it.next();
            }
            BeanFormDetails beanFormDetails = result;
            return beanFormDetails;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanFormDetails beanFormDetails = result;
            return beanFormDetails;
        }
        finally {
            session.close();
        }
    }

	@Override
    public BeanFormDetails saveForm(BeanFormDetails saveData) {
		log.info("open saveform() method in daofieldlookupimpl......");
        
		log.debug("start of saveForm() method,, saving form to data_form_details table >> "+saveData.toString());
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(saveData);
			session.getTransaction().commit();
			log.debug("end of saveForm() method");
			 //log.info("beanFormDetails is ::::::: "+beanFormDetails.toString());
	            log.info("end dao method with beanFormDetails");
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
    public void updateForm(Integer id, String status) {
		log.info("open updateform() method in daofieldlookupimpl......");
        
		log.debug("update form to data_form_details table status >> "+status+" , ID is >>> "+id);
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			try {
				Transaction tx = session.beginTransaction();
				session.createSQLQuery("UPDATE data_form_details SET status='" + status+"' WHERE id="+id).executeUpdate();
				tx.commit();
			} catch (Exception e) {
				session.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
			

		} finally {
			// close session
			session.close();
		}
    }

	@Override
    public BeanFieldLookup saveField(BeanFieldLookup saveData) throws ConstraintViolationException {
		log.debug("Storable Lookup_NAme :: "+saveData.getLookup_name()+" :: lookup_type :: "+saveData.getLookup_type()+" :: Lookup_Subtype :: "+saveData.getLookup_subtype());
        Session session = factory.openSession();
        try {
            session.beginTransaction();
            session.save((Object)saveData);
            session.getTransaction().commit();
            BeanFieldLookup beanFieldLookup = saveData;

            return beanFieldLookup;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> fetchFormDetailsAsListByPayerId(Integer payerId,String collegeCode) {
		log.info("Start getForms() method ini DaoFieldLookupImpl");
		
        ArrayList<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
        Session session = factory.openSession();
//        try {
//            Criteria cr = session.createCriteria(BeanFormDetails.class);
//            if (key.contentEquals("status")) {
//                cr.add((Criterion)Restrictions.eq((String)"status", (Object)value.toString()));
//            } else if (key.contentEquals("ownerId")) {
//                cr.add((Criterion)Restrictions.eq((String)"formOwnerId", (Object)value.toString()));
//            } else if (key.contentEquals("relevant")) {
//                Date today = new Date();
//                Calendar cal = Calendar.getInstance();
//                cal.setTime(today);
//                cal.set(11, 0);
//                today = cal.getTime();
//                ArrayList<BeanFormDetails> filters = (ArrayList<BeanFormDetails>)value;
//                //log.info("value of fileters is :::::::::::::::::::::::::: "+filters.toString() );
//                
//                cr.add((Criterion)Restrictions.eq((String)"formOwnerId", filters.get(0)));
//                cr.add((Criterion)Restrictions.eq((String)"payer_type", filters.get(1)));
//                cr.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
//                
//                SimpleExpression rest1 = Restrictions.eq((String)"validityflag", (Object)0);
//                SimpleExpression rest2a = Restrictions.eq((String)"validityflag", (Object)1);
//                SimpleExpression rest2b = Restrictions.le((String)"formStartDate", (Object)today);
//                SimpleExpression rest2c = Restrictions.ge((String)"formLateEndDate", (Object)today);
//                
//                Conjunction rest2 = Restrictions.and((Criterion[])new Criterion[]{rest2a, rest2b, rest2c});
//                cr.add((Criterion)Restrictions.or((Criterion)rest1, (Criterion)rest2));
//            
//            } else if (key.contentEquals("formIds")) {
//                List<BeanFormDetails> ids = (List<BeanFormDetails>)value;
//                cr.add(Restrictions.in((String)"id", (Collection)ids));
//            }
//            ArrayList<BeanFormDetails> arrayList = forms = new ArrayList<BeanFormDetails>(cr.list());
//            log.info("Size of ArrayList is ::::::::::::::::::::::: "+arrayList.size());
//            
//            return arrayList;
//        }
//        catch (Exception e) {
//            e.printStackTrace();
//            ArrayList<BeanFormDetails> arrayList = forms;
//            return arrayList;
//        }
//        finally {
//            session.close();
//        }
        return null;
    }
	
	@Override
    public List<BeanFormDetails> getForms(String key, Object value) {
		log.info("Start getForms() method ini DaoFieldLookupImpl");
		
        ArrayList<BeanFormDetails> forms = new ArrayList<BeanFormDetails>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            if (key.contentEquals("status")) {
                cr.add((Criterion)Restrictions.eq((String)"status", (Object)value.toString()));
            } else if (key.contentEquals("ownerId")) {
                cr.add((Criterion)Restrictions.eq((String)"formOwnerId", (Object)value.toString()));
            } else if (key.contentEquals("relevant")) {
                Date today = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(today);
                cal.set(11, 0);
                today = cal.getTime();
                ArrayList<BeanFormDetails> filters = (ArrayList<BeanFormDetails>)value;
                //log.info("value of fileters is :::::::::::::::::::::::::: "+filters.toString() );
                
                cr.add((Criterion)Restrictions.eq((String)"formOwnerId", filters.get(0)));
                cr.add((Criterion)Restrictions.eq((String)"payer_type", filters.get(1)));
                cr.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
                
                SimpleExpression rest1 = Restrictions.eq((String)"validityflag", (Object)0);
                SimpleExpression rest2a = Restrictions.eq((String)"validityflag", (Object)1);
                SimpleExpression rest2b = Restrictions.le((String)"formStartDate", (Object)today);
                SimpleExpression rest2c = Restrictions.ge((String)"formLateEndDate", (Object)today);
                
                Conjunction rest2 = Restrictions.and((Criterion[])new Criterion[]{rest2a, rest2b, rest2c});
                cr.add((Criterion)Restrictions.or((Criterion)rest1, (Criterion)rest2));
            
            } else if (key.contentEquals("formIds")) {
                List<BeanFormDetails> ids = (List<BeanFormDetails>)value;
                cr.add(Restrictions.in((String)"id", (Collection)ids));
            }
            ArrayList<BeanFormDetails> arrayList = forms = new ArrayList<BeanFormDetails>(cr.list());
            log.info("Size of ArrayList is ::::::::::::::::::::::: "+arrayList.size());
            
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanFormDetails> arrayList = forms;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> getFormsForActors(String key, Object value) {
		log.info("Start of getFormsForActors() method");
		
        ArrayList forms = new ArrayList<BeanFormDetails>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            if (key.contentEquals("status")) {
                cr.add((Criterion)Restrictions.eq((String)"status", (Object)value.toString()));
            } else if (key.contentEquals("ownerId")) {
                cr.add((Criterion)Restrictions.eq((String)"formOwnerId", (Object)value.toString()));
            } else if (key.contentEquals("relevant")) {
                Date today = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(today);
                cal.set(11, 0);
                today = cal.getTime();
                ArrayList filters = (ArrayList)value;
                cr.add((Criterion)Restrictions.eq((String)"target_actor", filters.get(1)));
                cr.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
                SimpleExpression rest1 = Restrictions.eq((String)"validityflag", (Object)0);
                SimpleExpression rest2a = Restrictions.eq((String)"validityflag", (Object)1);
                SimpleExpression rest2b = Restrictions.le((String)"formStartDate", (Object)today);
                SimpleExpression rest2c = Restrictions.ge((String)"formLateEndDate", (Object)today);
                Conjunction rest2 = Restrictions.and((Criterion[])new Criterion[]{rest2a, rest2b, rest2c});
                cr.add((Criterion)Restrictions.or((Criterion)rest1, (Criterion)rest2));
            } else if (key.contentEquals("formIds")) {
                List ids = (List)value;
                cr.add(Restrictions.in((String)"id", (Collection)ids));
            }
            ArrayList arrayList = forms = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanFormDetails> arrayList = forms;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> getApprovedFormDetails(LoginBean loginBean) {
        Session session = factory.openSession();
        List FormList = new ArrayList<BeanFormDetails>();
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            if (loginBean.getProfile().contentEquals("Institute")) {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getCollgBean().getCollegeName()));
            } else {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getOperatorBean().getCollegeBean_fk().getCollegeName()));
            }
            criteria.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
            criteria.add((Criterion)Restrictions.eq((String)"validityflag", (Object)1));
            List list = FormList = criteria.list();
            return list;
        }
        catch (Exception ex) {
            ArrayList<BeanFormDetails> arrayList = (ArrayList<BeanFormDetails>) FormList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClient(LoginBean loginBean) {
		log.info("Start getAllApprovedFormDetailsBasedOnClient() method");
        Session session = factory.openSession();
        List FormList = new ArrayList<BeanFormDetails>();
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            if (loginBean.getProfile().contentEquals("Institute")) {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getCollgBean().getCollegeCode()));
            } else {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getOperatorBean().getCollegeBean_fk().getCollegeCode()));
            }
            criteria.add((Criterion)Restrictions.in((String)"status", "APPROVED","REPORT"));
            //criteria.add((Criterion)Restrictions.eq((String)"status", (Object)"REPORT"));
            List list = FormList = criteria.list();
           // log.info("formlist is :::::::: "+list.toString());
            return list;
        }
        catch (Exception ex) {
            ArrayList<BeanFormDetails> arrayList = (ArrayList<BeanFormDetails>) FormList;
            return arrayList;
        }
        finally {
        	log.info("End getAllApprovedFormDetailsBasedOnClient() method.");
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> getAllApprovedFormDetailsBasedOnClientForChallanMIS(LoginBean loginBean) {
        Session session = factory.openSession();
        List FormList = new ArrayList<BeanFormDetails>();
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            if (loginBean.getProfile().contentEquals("Institute")) {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getCollgBean().getCollegeCode()));
            } else {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getOperatorBean().getCollegeBean_fk().getCollegeCode()));
            }
            criteria.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
            List list = FormList = criteria.list();
            return list;
        }
        catch (Exception ex) {
            ArrayList<BeanFormDetails> arrayList = (ArrayList<BeanFormDetails>) FormList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanFormDetails> getAllPendingDetailstForSpotCash(LoginBean loginBean) {
        Session session = factory.openSession();
        List FormList = new ArrayList<BeanFormDetails>();
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            if (loginBean.getProfile().contentEquals("Institute")) {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getCollgBean().getCollegeCode()));
            } else {
                criteria.add((Criterion)Restrictions.eq((String)"formOwnerName", (Object)loginBean.getOperatorBean().getCollegeBean_fk().getCollegeCode()));
            }
            criteria.add((Criterion)Restrictions.eq((String)"status", (Object)"APPROVED"));
            List list = FormList = criteria.list();
            return list;
        }
        catch (Exception ex) {
            ArrayList<BeanFormDetails> arrayList = (ArrayList<BeanFormDetails>) FormList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<BeanPayerType> getPayerDetails(CollegeBean collegeBean, Integer bid) {
		log.info("Start of getPayerDetails() method in DaoFieldLookupImpl");
		
        ArrayList lookupList = new ArrayList<BeanPayerType>();
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(BeanPayerType.class);
            cr.add((Criterion)Restrictions.eq((String)"bid", (Object)bid.toString()));
            cr.add((Criterion)Restrictions.eq((String)"cid", (Object)collegeBean.getCollegeId().toString()));
            cr.add((Criterion)Restrictions.eq((String)"clientName", (Object)collegeBean.getCollegeName()));
            log.info("bid,cid and client name is "+(Object)bid.toString()+ "  "+(Object)collegeBean.getCollegeId().toString() 
            		+ " "+(Object)collegeBean.getCollegeName());
            ArrayList arrayList = lookupList = new ArrayList(cr.list());
            return arrayList;
        }
        catch (Exception e) {
            e.printStackTrace();
            ArrayList<BeanPayerType> arrayList = lookupList;
            return arrayList;
        }
        finally {
            session.close();
        }
	}
    
	@Override
    public BeanPayerType getPayerLookupsBasedOnClient(String payer, CollegeBean college) {
		log.info("Start getPayerLookupsBasedOnClient() method in DaoFieldLookupImpl");
		
        BeanPayerType payerBean = new BeanPayerType();
        Session session = factory.openSession();
        log.debug((Object)("payer received is::" + payer));
        try {
            Criteria cr = session.createCriteria(BeanPayerType.class);
            cr.add((Criterion)Restrictions.eq((String)"payer_type", (Object)payer)).add((Criterion)Restrictions.eq((String)"bid", (Object)college.getBankDetailsOTM().getBankId().toString())).add((Criterion)Restrictions.eq((String)"cid", (Object)college.getCollegeId().toString()));
            BeanPayerType beanPayerType = payerBean = (BeanPayerType)new ArrayList(cr.list()).get(0);
            return beanPayerType;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanPayerType beanPayerType = payerBean;
            return beanPayerType;
        }
        finally {
            session.close();
        }
    }

	@Override
    public CollegeBean getClientDetailsBasedOnClientCode(String formOwnerName) {
        Session session = factory.openSession();
        CollegeBean clientBean = null;
        try {
            CollegeBean collegeBean = clientBean = (CollegeBean)session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"collegeCode", (Object)formOwnerName)).list().get(0);
            return collegeBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            CollegeBean collegeBean = clientBean;
            return collegeBean;
        }
        finally {
            session.close();
        }
    }

	@Override
    public BeanPayerType getPayerLookupsBasedOnPayerId(Integer payer_type) {
		log.info("Start getPayerLookupsBasedOnPayerId() method in DaoFieldLookupImpl");
		
        Session session = factory.openSession();
        
        BeanPayerType bean = null;
        try {
            BeanPayerType beanPayerType = bean = (BeanPayerType)session.get(BeanPayerType.class, (Serializable)payer_type);
            return beanPayerType;
        }
        catch (Exception e) {
            BeanPayerType beanPayerType = bean;
            return beanPayerType;
        }
        finally {
            session.close();
        }
    }
	
	@Override
	public Boolean creatDynamicTable(String dynSQL,String clientTable) {
		log.info("Start creatDynamicTable() method in DaoFieldLookupImpl");
		//log.info("Dynamic SQL ");
		Boolean tableCreationError = Boolean.valueOf(false);
		Session session = factory.openSession();
		try {
			String sql = "CREATE TABLE  " + clientTable
					+ " (id int(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,transId varchar(255),transStatus varchar(255),transPaymode varchar(255),transDate varchar(255),transAmount varchar(255),challanNo varchar(255),spTransId varchar(255) UNIQUE, pgTransId varchar(255), modifiedDate DATETIME, updateByJob varchar(5),"
					+ dynSQL + ",form_Name varchar(255))";
			//log.info("SQL  query  =  " + sql);
			session.createSQLQuery(sql).executeUpdate();
			//log.info("Table is created by the name of :::: zz_client_user_data_"+formIds);
		} catch (RuntimeException e) {
			log.info("It is in Catch Block ");
			SendMail email = new SendMail();
			email.sendConflictMail("Issue in creating table " + clientTable,
					"praveenkumar01nov@gmail.com", "praveenkumar@srslive.in", "8171017095", "Praveen Kumar",
					e.getMessage());
			tableCreationError = Boolean.valueOf(true);
		} finally {
			//log.info("End getPayerLookupsBasedOnPayerId() method in DaoFieldLookupImpl");
			session.close();
		}
		return tableCreationError;
	}

	@Override
	public Boolean creatDynamicTableForOfflineForm(String dynSQL,String clientTable) {
		log.info("Start creatDynamicTable() method in DaoFieldLookupImpl");
		//log.info("Dynamic SQL ");
		Boolean tableCreationError = Boolean.valueOf(false);
		Session session = factory.openSession();
		try {
			String sql = "CREATE TABLE  " + clientTable
					+ " (id int(5) NOT NULL PRIMARY KEY AUTO_INCREMENT, fileUploadDate DATETIME NULL, unique_Key varchar(255) UNIQUE,"
					+ dynSQL + ",form_Name varchar(255))";
			//log.info("SQL  query  =  " + sql);
			session.createSQLQuery(sql).executeUpdate();
			//log.info("Table is created by the name of  :::: zz_client_user_data_"+formIds);
		} catch (RuntimeException e) {
			log.info("It is in Catch Block ");
			SendMail email = new SendMail();
			email.sendConflictMail("Issue in creating table " + clientTable,
					"praveenkumar01nov@gmail.com", "praveenkumar@srslive.in", "8171017095", "Praveen Kumar",
					e.getMessage());
			tableCreationError = Boolean.valueOf(true);
		} finally {
			//log.info("End getPayerLookupsBasedOnPayerId() method in DaoFieldLookupImpl");
			session.close();
		}
		return tableCreationError;
	}
	
	@Override
	public ResultBean saveEmilMobileList(ResultBean resultBean) {
		log.info("open saveEmilMobileList() method in daofieldlookupimpl......");
        
		log.debug("start of saveEmilMobileList() method,, saving form to resultBean table >> "+resultBean.toString());
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(resultBean);
			session.getTransaction().commit();
			log.debug("end of saveForm() method");
			 //log.info("beanFormDetails is ::::::: "+beanFormDetails.toString());
	            //log.info("end dao method with beanFormDetails");
			return resultBean;

		} catch (Exception e) {
			e.printStackTrace();
			return resultBean;

		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public BeanLateFee saveLateFee(BeanLateFee lateFeeData) {
		       
		log.info("start of saveLateFee() method, saving form to data_form_details table >> "+lateFeeData.toString());
		
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.update(lateFeeData);
			session.getTransaction().commit();
	        log.info("end dao method with beanFormDetails");
			return lateFeeData;
		} catch (Exception e) {
			e.printStackTrace();
			return lateFeeData;
		} finally {
			// close session
			session.close();
		}
    }

	@Override
	public BeanLateFee getLateFeeOnId(Integer feeId) {
		log.info("Open Dao layer of getLateFeeOnId() method");
		BeanLateFee lateFee=new BeanLateFee();
		Session session=factory.openSession();
		try {
			lateFee = (BeanLateFee)session.createCriteria(BeanLateFee.class)
					 .add((Criterion)Restrictions.eq("id", feeId)).list().get(0);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
	            session.close();
	    }
		log.info("End of getLateFeeOnId()");
		return lateFee;
	}
	
}